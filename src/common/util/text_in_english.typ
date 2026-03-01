// # Text in english. Texto em inglês.

// TODO: transform this into "foreign_text", and make english the default.

#let text_in_english = it => emph(
  text(
    lang: "en",
    region: "us",
    it,
  ),
)
