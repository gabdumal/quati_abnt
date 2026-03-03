// # Custom cataloging-in-publication. Ficha catalográfica customizada.
// NBR 14724:2024 4.2.1.1.2

#import "../../../common/components/heading.typ": not_start_on_new_page
#import "../../../common/components/page.typ": consider_only_odd_pages, not_count_page, not_number_page
#import "../../../common/style/style.typ": font_family_sans

#let include_custom_cataloging_in_publication(
  body,
) = context {
  set page(margin: 0cm)
  set text(font: font_family_sans)
  not_number_page(
    not_start_on_new_page()[
      #if consider_only_odd_pages.get() {
        not_count_page(
          body,
        )
      } else {
        body
      }
    ],
  )
}
