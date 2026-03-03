#!/usr/bin/env bash
# Renders one or more bibliography entries through a CSL style file.
#
# Usage:
#   haya_render.sh <bib-file> <key[,key2,...]|all> [csl-file] [input-format]
#
# Arguments:
#   bib-file      Path to the .bib file
#   key(s)        Comma-separated list of entry keys, or 'all' to render every entry
#   csl-file      Path to a .csl file (default: src/common/style/bibliography_style.csl)
#   input-format  bibtex | biblatex | yaml  (default: biblatex)
#
# Examples:
#   haya_render.sh bib.bib araki:2020:testes_de_software
#   haya_render.sh bib.bib araki:2020,britannica:2023:go
#   haya_render.sh bib.bib all
#   haya_render.sh bib.bib araki:2020 /path/to/custom.csl
set -euo pipefail

SCRIPT_DIR="$( cd "$(dirname "$0")" && pwd )"
DEFAULT_CSL="$SCRIPT_DIR/../src/common/style/bibliography_style.csl"

if ! command -v hayagriva >/dev/null 2>&1; then
  echo "hayagriva not found in PATH" >&2
  exit 1
fi

if [ "$#" -lt 2 ]; then
  echo "Usage: $(basename "$0") <bib-file> <key[,key2,...]|all> [csl-file] [input-format=biblatex]" >&2
  exit 1
fi

bibfile=$1
keys=$2
csl=${3:-$DEFAULT_CSL}
input_fmt=${4:-biblatex}

if [ ! -f "$bibfile" ]; then
  echo "Input file not found: $bibfile" >&2
  exit 1
fi

if [ ! -f "$csl" ]; then
  echo "CSL file not found: $csl" >&2
  exit 1
fi

key_args=()
if [ "$keys" != "all" ]; then
  key_args=(--key "$keys")
fi

hayagriva --format "$input_fmt" "${key_args[@]}" "$bibfile" reference --csl "$csl" -n
