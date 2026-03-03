#!/usr/bin/env python3
"""
Generates bibliography_style_prose.csl from bibliography_style.csl.

The prose variant differs from the parenthetic variant only in:
  - <info> metadata (title, id, summary)
  - names-citation macro: uses and="text", delimiter=", ", delimiter-precedes-last="never"
  - <citation> layout: wraps year in parens for narrative form

Run from the workspace root:
    python3 scripts/gen-prose-csl.py
"""

import re
from pathlib import Path

_HERE = Path(__file__).resolve().parent
SRC = _HERE.parent / "src/common/style/bibliography_style.csl"
DST = _HERE.parent / "src/common/style/bibliography_style_prose.csl"


def transform(text: str) -> str:
    # ------------------------------------------------------------------ #
    # File-level comment block
    # ------------------------------------------------------------------ #
    text = text.replace(
        "    Estilo CSL — ABNT\n"
        "    NBR 6023:2025 (referências bibliográficas)\n"
        "    NBR 10520:2023 (citações em documentos)\n"
        "    Sistema: autor-data\n"
        "\n"
        "    Para citações em prosa (\"Silva, Souza e Oliveira (2023)\"), use o arquivo\n"
        "    bibliography_style_prose.csl em conjunto com cite(form: \"prose\") no Typst.",
        "    Estilo CSL — ABNT (variante para citações em prosa)\n"
        "    NBR 6023:2025 (referências bibliográficas)\n"
        "    NBR 10520:2023 (citações em documentos)\n"
        "    Sistema: autor-data\n"
        "\n"
        "    Este arquivo é idêntico a bibliography_style.csl com uma única diferença:\n"
        "    a macro names-citation usa and=\"text\" e delimiter=\", \" para gerar o formato\n"
        "    \"Silva, Souza e Oliveira (2023)\" em vez de \"Silva; Souza; Oliveira (2023)\".\n"
        "\n"
        "    Uso no Typst (via cite_prose):\n"
        "        cite(key, form: \"prose\", style: \"../style/bibliography_style_prose.csl\")",
    )

    # ------------------------------------------------------------------ #
    # <info> metadata
    # ------------------------------------------------------------------ #
    text = text.replace(
        "        <title>ABNT — NBR 6023:2025 (Português - Brasil)</title>\n"
        "        <title-short>ABNT</title-short>\n"
        "        <id>https://gabdumal.com/csl/abnt-nbr6023-2025</id>\n"
        "        <link href=\"https://gabdumal.com/csl/abnt-nbr6023-2025\" rel=\"self\" />",
        "        <title>ABNT — NBR 6023:2025 — Prosa (Português - Brasil)</title>\n"
        "        <title-short>ABNT Prosa</title-short>\n"
        "        <id>https://gabdumal.com/csl/abnt-nbr6023-2025-prose</id>\n"
        "        <link href=\"https://gabdumal.com/csl/abnt-nbr6023-2025-prose\" rel=\"self\" />",
    )

    text = text.replace(
        "        <summary>Estilo ABNT conforme NBR 10520:2023 (citações) e NBR 6023:2025\n"
        "            (referências). Sistema autor-data. Para citações em prosa, use\n"
        "            bibliography_style_prose.csl com cite(form: \"prose\") no Typst.</summary>",
        "        <summary>Variante do estilo ABNT para citações em prosa: \"Silva, Souza e\n"
        "            Oliveira (2023)\". Use com cite(form: \"prose\") no Typst. Para citações\n"
        "            parentéticas, use bibliography_style.csl.</summary>",
    )

    # ------------------------------------------------------------------ #
    # names-citation macro — comment
    # ------------------------------------------------------------------ #
    text = text.replace(
        "        `names-citation`: autores para citação parentética no corpo do texto.\n"
        "        Formato: Sobrenome; Sobrenome2 — NBR 10520:2023.\n"
        "        A partir de 4 autores: primeiro + et al. (itálico), conforme <citation>.\n"
        "        Fallback: editor → tradutor → título.",
        "        `names-citation` (variante prosa): autores para citação narrativa.\n"
        "        Formato: \"Silva, Souza e Oliveira\" — NBR 10520:2023 6.1.\n"
        "        A partir de 4 autores: primeiro + et al. (itálico), conforme <citation>.\n"
        "        Fallback: editor → tradutor → título.",
    )

    # ------------------------------------------------------------------ #
    # names-citation macro — name element: add and="text", fix delimiter
    # ------------------------------------------------------------------ #
    text = text.replace(
        "            <name\n"
        "                form=\"short\"\n"
        "                name-as-sort-order=\"all\"\n"
        "                sort-separator=\", \"\n"
        "                initialize=\"false\"\n"
        "                initialize-with=\". \"\n"
        "                delimiter=\"; \"\n"
        "                delimiter-precedes-last=\"always\"\n"
        "            >",
        "            <name\n"
        "                form=\"short\"\n"
        "                and=\"text\"\n"
        "                name-as-sort-order=\"all\"\n"
        "                sort-separator=\", \"\n"
        "                initialize=\"false\"\n"
        "                initialize-with=\". \"\n"
        "                delimiter=\", \"\n"
        "                delimiter-precedes-last=\"never\"\n"
        "            >",
    )

    # ------------------------------------------------------------------ #
    # citation-locator comment
    # ------------------------------------------------------------------ #
    text = text.replace(
        "        Sufixo da citação parentética: (Autor, Ano, p. N).",
        "        Sufixo da citação em prosa: Silva (2023, p. N).",
    )

    # ------------------------------------------------------------------ #
    # Citation section header comment
    # ------------------------------------------------------------------ #
    text = text.replace(
        "        CITAÇÃO PARENTÉTICA — NBR 10520:2023.\n"
        "        A partir de 4 autores: exibe apenas o primeiro + et al. (itálico).\n"
        "        Ordenação: sobrenome do primeiro autor, depois ano.",
        "        CITAÇÃO EM PROSA — NBR 10520:2023.\n"
        "        Formato: Silva, Souza e Oliveira (2023, p. N)\n"
        "        A partir de 4 autores: exibe apenas o primeiro + et al. (itálico).",
    )

    # ------------------------------------------------------------------ #
    # <citation> layout: parenthetic → narrative
    # (Silva; Souza, 2023) → Silva, Souza e Oliveira (2023)
    # ------------------------------------------------------------------ #
    text = text.replace(
        "        <layout prefix=\"(\" suffix=\")\" delimiter=\"; \">\n"
        "            <group>\n"
        "                <text macro=\"names-citation\" suffix=\", \" />\n"
        "                <text macro=\"date-year\" />\n"
        "                <text macro=\"citation-locator\" prefix=\", \" />\n"
        "            </group>\n"
        "        </layout>",
        "        <layout prefix=\"\" suffix=\"\" delimiter=\"; \">\n"
        "            <group>\n"
        "                <text macro=\"names-citation\" suffix=\" (\" />\n"
        "                <text macro=\"date-year\" />\n"
        "                <text macro=\"citation-locator\" prefix=\", \" />\n"
        "                <text value=\")\" />\n"
        "            </group>\n"
        "        </layout>",
    )

    return text


def main() -> None:
    original = SRC.read_text(encoding="utf-8")
    prose = transform(original)

    if prose == original:
        print("ERROR: no substitutions were applied — check the script.", flush=True)
        raise SystemExit(1)

    DST.write_text(prose, encoding="utf-8")
    print(f"Generated {DST}", flush=True)


if __name__ == "__main__":
    main()
