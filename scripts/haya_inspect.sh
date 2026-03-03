#!/usr/bin/env bash
# Shows the parsed YAML representation of a single bibliography entry as
# hayagriva interprets it — useful for diagnosing field mapping issues,
# silent drops (month, organization, page), and type assignments.
#
# Usage:
#   haya_inspect.sh <bib-file> <key> [input-format=biblatex]
#
# Arguments:
#   bib-file      Path to the .bib file
#   key           Entry key to inspect (e.g. silver:2018:general_reinforcement)
#   input-format  bibtex | biblatex | yaml  (default: biblatex)
#
# Examples:
#   haya_inspect.sh bib.bib silver:2018:general_reinforcement_learning_algorithm
#   haya_inspect.sh bib.bib araki:2020:testes_de_software bibtex
set -euo pipefail

if ! command -v hayagriva >/dev/null 2>&1; then
  echo "hayagriva not found in PATH" >&2
  exit 1
fi

if [ "$#" -lt 2 ]; then
  echo "Usage: $(basename "$0") <bib-file> <key> [input-format=biblatex]" >&2
  echo "  input-format: bibtex | biblatex | yaml" >&2
  exit 1
fi

bibfile=$1
key=$2
input_fmt=${3:-biblatex}

if [ ! -f "$bibfile" ]; then
  echo "Input file not found: $bibfile" >&2
  exit 1
fi

# --key filters before output, so only the requested entry is emitted.
output=$(hayagriva --format "$input_fmt" --key "$key" "$bibfile" 2>/dev/null)

if [ -z "$output" ] || [ "$output" = "{}" ]; then
  echo "Key not found in $bibfile: $key" >&2
  exit 1
fi

printf '%s\n' "$output"
