// # Outline. Sumário.
// NBR 6027:2012, NBR 14724:2024 4.2.1.13

#import "../../../common/components/heading.typ": get_styling_for_heading, not_start_on_new_page
#import "../../../common/components/page.typ": consider_only_odd_pages, not_count_page, not_number_page
#import "../../../common/style/style.typ": font_family_sans

#let include_outline() = context {
  set text(
    font: font_family_sans,
  )
  not_number_page(
    not_start_on_new_page()[
      #page()[
        #show outline.entry: it => {
          let (
            capitalize,
            font_size,
            font_weight,
            leading_around,
            spacing_around,
            text_style,
          ) = get_styling_for_heading(it)

          set text(
            font: font_family_sans,
            size: font_size,
            weight: font_weight,
            style: text_style,
          )

          let prefix = it.prefix()
          if it.element.supplement == [Apêndice] {
            prefix = [APÊNDICE #prefix ---]
          }
          if it.element.supplement == [Anexo] {
            prefix = [ANEXO #prefix ---]
          }

          let inner = if capitalize { upper(it.inner()) } else { it.inner() }

          block(
            below: spacing_around,
          )[
            #link(
              it.element.location(),
              it.indented(
                [#prefix],
                inner,
              ),
            )
          ]
        }

        #outline(
          depth: 5,
          indent: 0cm,
        )
      ]

      #if not consider_only_odd_pages.get() {
        pagebreak(weak: true, to: "odd")
      }
    ],
  )
}
