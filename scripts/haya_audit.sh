#!/usr/bin/env bash
# Audits a .bib file for common issues that cause silent failures in hayagriva.
#
# Checks performed:
#   Static  1 — bare 'page' field (should be 'pages')
#   Static  2 — 'organization' field (no CSL mapping; use 'publisher')
#   Static  3 — standalone 'month =' without 'date =' (fragile parsing; use 'date = {YYYY-MM}')
#   Dynamic 4 — date-drop detection: entries where hayagriva lost the month from the source
#   Info    5 — full type mapping: every entry key → hayagriva type
#
# Usage: haya_audit.sh <bib-file> [input-format=biblatex]
set -euo pipefail

SCRIPT_DIR="$( cd "$(dirname "$0")" && pwd )"
HAYA_ENTRY="$SCRIPT_DIR/haya_inspect.sh"

RED='\033[0;31m'
YEL='\033[0;33m'
GRN='\033[0;32m'
DIM='\033[2m'
RST='\033[0m'

sep() { printf '%s\n' "────────────────────────────────────────────────────────────"; }
ok()  { echo -e "  ${GRN}✓${RST}  no issues found"; }

if ! command -v hayagriva >/dev/null 2>&1; then
  echo "hayagriva not found in PATH" >&2; exit 1
fi

if [ "$#" -lt 1 ]; then
  echo "Usage: $(basename "$0") <bib-file> [input-format=biblatex]" >&2; exit 1
fi

bibfile=$1
input_fmt=${2:-biblatex}

if [ ! -f "$bibfile" ]; then
  echo "Input file not found: $bibfile" >&2; exit 1
fi

total=$(grep -c '^@' "$bibfile" || true)
echo ""
echo -e "Auditing ${DIM}$bibfile${RST}  (${total} entries)"
sep

# ---------------------------------------------------------------------------
# STATIC 1 — bare 'page =' field
# ---------------------------------------------------------------------------
echo ""
echo -e "${YEL}[Static 1]${RST} bare 'page =' field  ${DIM}(should be 'pages')${RST}"

hits=$(awk '
  /^@[A-Za-z]/ { split($0, a, /[{,]/); key = a[2] }
  /^[ \t]+page[ \t]*=/ { print "  " key }
' "$bibfile")

if [ -z "$hits" ]; then ok; else echo -e "${RED}$hits${RST}"; fi

# ---------------------------------------------------------------------------
# STATIC 2 — 'organization =' field
# ---------------------------------------------------------------------------
echo ""
echo -e "${YEL}[Static 2]${RST} 'organization =' field  ${DIM}(no CSL mapping; use 'publisher')${RST}"

hits=$(awk '
  /^@[A-Za-z]/ { split($0, a, /[{,]/); key = a[2] }
  /^[ \t]+organization[ \t]*=/ { print "  " key }
' "$bibfile")

if [ -z "$hits" ]; then ok; else echo -e "${RED}$hits${RST}"; fi

# ---------------------------------------------------------------------------
# STATIC 3 — standalone 'month =' without 'date ='
# ---------------------------------------------------------------------------
echo ""
echo -e "${YEL}[Static 3]${RST} standalone 'month =' without 'date ='  ${DIM}(use 'date = {YYYY-MM}' instead)${RST}"

hits=$(awk '
  /^@[A-Za-z]/ {
    if (key && has_month && !has_date) print "  " key
    split($0, a, /[{,]/); key = a[2]
    has_month = 0; has_date = 0
  }
  /^[ \t]+month[ \t]*=/ { has_month = 1 }
  /^[ \t]+date[ \t]*=/  { has_date  = 1 }
  END { if (key && has_month && !has_date) print "  " key }
' "$bibfile")

if [ -z "$hits" ]; then ok; else echo -e "${RED}$hits${RST}"; fi

# ---------------------------------------------------------------------------
# DYNAMIC 4 — date-drop detection
# Run hayagriva on every entry that has 'month =' (no 'date =') in source
# and check whether the parsed date retained its month component.
# ---------------------------------------------------------------------------
echo ""
echo -e "${YEL}[Dynamic 4]${RST} date-drop detection  ${DIM}(hayagriva silently dropped the month)${RST}"

# Collect keys with standalone month
month_entries=$(awk '
  /^@[A-Za-z]/ {
    if (key && has_month && !has_date) print key
    split($0, a, /[{,]/); key = a[2]
    has_month = 0; has_date = 0
  }
  /^[ \t]+month[ \t]*=/ { has_month = 1 }
  /^[ \t]+date[ \t]*=/  { has_date  = 1 }
  END { if (key && has_month && !has_date) print key }
' "$bibfile")

if [ -z "$month_entries" ]; then
  ok
else
  dropped=""
  while IFS= read -r key; do
    parsed=$(hayagriva --format "$input_fmt" --key "$key" "$bibfile" 2>/dev/null)
    # Look for entry-level date line (2-space indent, not inside url or parent)
    entry_date=$(printf '%s\n' "$parsed" | awk '/^  date:/{print $2; exit}')
    if [ -z "$entry_date" ]; then
      dropped="$dropped\n  ${RED}$key${RST}  (no date at all)"
    elif [[ "$entry_date" != *-* ]]; then
      # Source month value for display
      src_month=$(grep -A20 "^@.*{$key," "$bibfile" | grep -m1 'month\s*=' | sed "s/.*=\s*{\(.*\)}.*/\1/")
      dropped="$dropped\n  ${RED}$key${RST}  ${DIM}(month dropped — source had: month = {$src_month})${RST}"
    fi
  done <<< "$month_entries"

  if [ -z "$dropped" ]; then
    ok
  else
    echo -e "$dropped"
  fi
fi

# ---------------------------------------------------------------------------
# INFO 5 — full type mapping
# ---------------------------------------------------------------------------
echo ""
echo -e "${YEL}[Info 5]${RST} entry type mapping  ${DIM}(BibTeX key → hayagriva type)${RST}"
echo ""

hayagriva --format "$input_fmt" "$bibfile" 2>/dev/null | awk '
  /^[^ ]/ { key = substr($0, 1, length($0)-1) }
  /^  type: / {
    type = $2
    printf "  %-52s %s\n", key, type
  }
'

sep
echo ""
