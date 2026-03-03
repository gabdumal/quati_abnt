// # Abstract. Resumo.
// NBR 14724:2024 4.2.1.7, NBR 14724:2024 4.2.1.8

#import "../../../common/components/heading.typ": not_start_on_new_page
#import "../../../common/components/page.typ": consider_only_odd_pages, not_count_page, not_number_page
#import "../../../common/style/style.typ": font_size_for_common_text

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
  body: { "Conteúdo do resumo." },
) = context {
  not_number_page(
    not_start_on_new_page()[
      #page()[
        #heading(
          numbering: none,
          outlined: false,
        )[
          #title
        ]

        #align(left)[
          #body

          // Following ABNTEX2
          #v(18pt)

          // NBR 6028:2021
          // Keywords are preceded by a title and colon.
          // Keywords are separated by semicolons and end with a period.
          // Keywords are not capitalized.
          #par(
            first-line-indent: 0cm,
          )[
            #text(weight: "bold")[#keywords_title:]
            #keywords.join("; ").
          ]
        ]
      ]

      #if not consider_only_odd_pages.get() {
        pagebreak(weak: true, to: "odd")
      }
    ],
  )
}
