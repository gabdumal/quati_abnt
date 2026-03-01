// # List of abbreviations. Lista de abreviaturas e siglas.
// NBR 14724:2024 4.2.1.11

#import "../components/entry_on_simple_glossary_lists.typ": print_gloss
#import "./glossary.typ": include_glossary

#let include_list_of_abbreviations(
  invisible: false,
  abbreviations_entries,
) = {
  include_glossary(
    disable_back_references: true,
    invisible: invisible,
    print_gloss: print_gloss,
    title: "Lista de abreviaturas e siglas",
    abbreviations_entries,
  )
}
