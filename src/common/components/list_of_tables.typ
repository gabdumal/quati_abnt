// # List of tables. Lista de tabelas.
// NBR 14724:2024 4.2.1.10

#import "../style/style.typ": font_family_sans
#import "entry_on_outline_lists.typ": format_outline_entry

#let list_of_tables() = {
  set text(
    font: font_family_sans,
  )

  show outline.entry: format_outline_entry

  outline(
    title: "Lista de tabelas",
    target: figure.where(kind: table),
  )
}
