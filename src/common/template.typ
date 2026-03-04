#import "./components/bibliography.typ": format_bibliography
#import "./components/editor_note.typ": should_display_editor_notes as should_display_editor_notes_state
#import "./components/figure.typ": figure_with_spacing_around
#import "./components/footnote.typ": format_footnote_entry
#import "./components/heading.typ": format_heading
#import "./components/page.typ": (
  consider_only_odd_pages as consider_only_odd_pages_state, format_header, should_count_this_page,
  should_number_this_page,
)
#import "./components/quote.typ": format_quote
#import "./packages.typ": subpar
#import "./style/style.typ": (
  font_family_math, font_family_mono, font_family_sans, font_family_serif, font_size_for_common_text,
  font_size_for_smaller_text, indentation_for_paragraphs, indentation_for_subparagraphs, leading_for_common_text,
  margin_bottom, margin_end, margin_start, margin_top, paper_size, simple_leading_for_smaller_text,
  simple_spacing_for_smaller_text, spacing_for_common_text,
)

#let template(
  doc,
  // Color to format links.
  color_of_links: none,
  // Whether to print content on the back of pages.
  consider_only_odd_pages: true,
  // Whether to number pages and print its number on the header.
  number_pages: false,
  // Whether to display editor notes.
  should_display_editor_notes: true,
) = {
  consider_only_odd_pages_state.update(consider_only_odd_pages)
  should_display_editor_notes_state.update(should_display_editor_notes)

  // ## Page. Página.
  // NBR 14724:2024 5.1
  // When the document is printed double-sided, the inner margin should be larger than the outer margin
  let margin = if consider_only_odd_pages {
    (
      top: margin_top,
      right: margin_end,
      bottom: margin_bottom,
      left: margin_start,
    )
  } else {
    (
      top: margin_top,
      outside: margin_end,
      bottom: margin_bottom,
      inside: margin_start,
    )
  }
  set page(
    paper: paper_size,
    margin: margin,
    header: format_header(number_pages),
  )

  // ## Text. Texto.
  set text(
    lang: "pt",
    region: "br",
    font: font_family_serif,
    size: font_size_for_common_text,
    hyphenate: true,
  )
  show raw: set text(font: font_family_mono)
  show math.equation: set text(font: font_family_math)

  // ## Paragraphs. Parágrafos.
  set par(
    first-line-indent: (
      amount: indentation_for_paragraphs,
      all: true,
    ),
    leading: leading_for_common_text,
    spacing: spacing_for_common_text,
    justify: true,
  )

  // ## Lists. Listas.
  set list(
    indent: indentation_for_subparagraphs,
  )
  show list: it => {
    set list(indent: 0em)
    it
  }
  set enum(
    indent: indentation_for_subparagraphs,
    numbering: "a)",
  )
  show enum: it => {
    set enum(indent: 0em)
    it
  }

  // ## Links. Ligações.
  show link: it => {
    if (color_of_links != none) {
      set text(fill: color_of_links)
      it
    } else {
      it
    }
  }

  // ## Citations. Citações.
  show cite: it => {
    if (color_of_links != none) {
      set text(fill: color_of_links)
      it
    } else {
      it
    }
  }

  // ## References. Referências.
  show ref: it => {
    // NBR 6024:2012.
    let content = if (color_of_links != none) {
      set text(fill: color_of_links)
      it
    } else {
      it
    }

    // Cross-references must be displayed in lowercase.
    if (it.element != none) {
      let element = it.element
      let function = element.func()
      if (function == heading or function == figure or function == math.equation) {
        let fields = element.fields()
        let kind = if (fields.keys().contains("kind")) { fields.kind } else { none }
        if (kind != "glossarium_entry") {
          return lower(content)
        }
      }
    }
    content
  }

  // ## Headings. Títulos.

  // ### Numbering. Numeração.
  // NBR 14724:2024 5.2.2, NBR 6024:2012 4.1
  // Should use Arabic numerals
  // Should start at 1
  // Secondary (and following) headings should be separated by a dot after the number
  set heading(
    numbering: "1.1",
  )
  set heading(
    supplement: "Seção",
  )

  // ### Format. Formatação.
  show heading: it => {
    format_heading(
      it,
    )
  }

  // ## Figures. Figuras.
  // NBR 14724:2024 5.8
  set figure.caption(
    // The caption of a figure should be on top of the figure
    position: top,
    // The indicator and numbering of the figure should be separated by a em-dash from the following caption text
    separator: [ #sym.dash.em ],
  )

  // ## Quotes. Citações.
  // NBR 10520:2023 7.1.1
  show quote: it => {
    // Long quotes (more than 3 lines) should be blocks.
    if it.block {
      format_quote(it)
    } else {
      it
    }
  }

  // ## Footnotes. Notas de rodapé.
  // NBR 14724:2024 5.2.1
  set footnote.entry(
    gap: simple_leading_for_smaller_text,
    clearance: simple_spacing_for_smaller_text,
    separator: line(length: 5cm),
    indent: 0cm,
  )
  show footnote.entry: it => {
    format_footnote_entry(it)
  }

  // ## Bibliography. Referências.
  // NBR 6023:2025 6, NBR 14724:2024 4.2.3.1
  set bibliography(
    // The bibliography should be formatted according to the ABNT style
    style: "./style/bibliography_style.csl",
    title: "Referências",
  )
  show bibliography: it => {
    format_bibliography(it)
  }

  doc
}
