// # Footnotes. Notas de rodapé.
// NBR 14724:2024 5.2.1

#import "../common/style.typ": (
  font_size_for_smaller_text, simple_leading_for_smaller_text, simple_spacing_for_smaller_text,
)


// ## Template. Modelo.
#let template(
  doc,
) = {
  set footnote.entry(
    gap: simple_leading_for_smaller_text,
    clearance: simple_spacing_for_smaller_text,
    separator: line(length: 5cm),
    indent: 0em,
  )

  show footnote.entry: it => {
    set text(size: font_size_for_smaller_text)

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

    block(
      inset: (left: it.indent),
      grid(
        columns: (auto, 1fr),
        gutter: 0.25em,
        prefix, body,
      ),
    )
  }

  doc
}
