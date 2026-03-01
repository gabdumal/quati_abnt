// # List of symbols. Lista de símbolos.
// NBR 14724:2024 4.2.1.12

#import "../components/entry_on_simple_glossary_lists.typ": print_gloss
#import "./glossary.typ": include_glossary

#let include_list_of_symbols(
  invisible: false,
  symbols_entries,
) = {
  include_glossary(
    disable_back_references: true,
    invisible: invisible,
    print_gloss: print_gloss,
    title: "Lista de símbolos",
    symbols_entries,
  )
}
