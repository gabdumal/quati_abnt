// # Footnotes. Notas de rodapé.
// NBR 14724:2024 5.2.1

#import "../common/style.typ": (
  font_size_for_smaller_text, simple_leading_for_smaller_text, simple_spacing_for_smaller_text,
)
#import "../common/components/font_family.typ": base_font_size_state


// ## Template. Modelo.
#let template(
  doc,
  //
  // Base font size.
  base_font_size: none,
  //
) = {
  set footnote.entry(
    gap: simple_leading_for_smaller_text,
    clearance: simple_spacing_for_smaller_text,
    separator: line(length: 5cm),
    indent: 0em,
  )

  show footnote.entry: it => context {
    let number = numbering(
      it.note.numbering,
      ..counter(
        footnote,
      ).at(
        it.note.location(),
      ),
    )
    let prefix = link(
      it.note.location(),
      number,
    )
    let body = it.note.body

    let footnote_block = block(
      inset: (left: it.indent),
      grid(
        columns: (auto, 1fr),
        gutter: 0.25em,
        prefix, body,
      ),
    )

    if base_font_size != none {
      set text(size: base_font_size_state.get())
      set text(size: font_size_for_smaller_text)
      footnote_block
    } else {
      footnote_block
    }
  }

  doc
}
