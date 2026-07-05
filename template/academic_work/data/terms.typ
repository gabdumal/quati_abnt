// # Terms. Termos.

#import "../packages.typ": quati-abnt.common.components.foreign_text, quati-abnt.common.components.get_term_in_list


// ## Definition. Definição.
#let terms_entries = (
  (
    key: "script",
    short: foreign_text[script],
    plural: foreign_text[scripts],
  ),
  (
    key: "software",
    short: foreign_text[software],
  ),
  (
    key: "web",
    short: foreign_text[web],
  ),
)


// ## Access. Acesso.
#let get_term = (
  capitalize: false,
  field: "short",
  plural: false,
  term_key,
) => {
  get_term_in_list(
    capitalize: false,
    field: "short",
    plural: false,
    terms_entries: terms_entries,
    term_key,
  )
}
