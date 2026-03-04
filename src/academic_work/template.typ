#import "../common/template.typ": template as common_template

#let template(
  doc,
  color_of_links: none,
  consider_only_odd_pages: true,
  number_pages: false,
  should_display_editor_notes: true,
) = {
  // ## Headings. Títulos.
  // NBR 6024:2012.
  show heading: set heading(
    supplement: "Subseção",
  )
  show heading.where(level: 1): set heading(supplement: "Capítulo")
  show heading.where(level: 2): set heading(supplement: "Seção")


  common_template(
    doc,
    color_of_links: color_of_links,
    consider_only_odd_pages: consider_only_odd_pages,
    number_pages: number_pages,
    should_display_editor_notes: should_display_editor_notes,
  )
}
