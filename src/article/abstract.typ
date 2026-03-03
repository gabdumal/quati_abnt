#import "../common/style/style.typ": font_size_for_common_text

#let include_abstract(
  keywords_title: { "Palavras-chave" },
  keywords: {
    (
      "primeira palavra-chave",
      "segunda palavra-chave",
      "terceira palavra-chave",
    )
  },
  title: { "Resumo" },
  content: { "Conteúdo do resumo." },
) = {
  set par(first-line-indent: 0cm)
  align(left)[
    #set text(
      size: font_size_for_common_text,
    )
    #text(weight: "bold")[#title.]
    #content

    #text(weight: "bold")[#keywords_title:]
    #keywords.join(". ").
  ]
}
