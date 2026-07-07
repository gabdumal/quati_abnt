// # Bibliography. Referências.
// NBR 6023:2025 6, NBR 14724:2024 4.2.3.1

#import "../common/style.typ": leading_for_bibliography, spacing_for_bibliography


#let format_bibliography(body) = {
  set par(
    leading: leading_for_bibliography,
    spacing: spacing_for_bibliography,
  )
  body
}


// ## Prose citation. Citação em prosa.
// NBR 10520:2023.
// Esta função usa um estilo CSL dedicado que formata os autores com vírgulas e "e" antes do último (ex.: Silva, Souza e Oliveira), adequado ao corpo do texto.
#let cite_prose(
  supplement: none,
  key,
) = {
  cite(
    form: "prose",
    supplement: supplement,
    style: "./bibliography_style_prose.csl",
    key,
  )
}


// ## Template. Modelo.
#let template(
  doc,
) = {
  set bibliography(
    // The bibliography should be formatted according to the ABNT style
    style: "./bibliography_style.csl",
    title: "Referências",
  )
  show bibliography: it => format_bibliography(it)

  doc
}
