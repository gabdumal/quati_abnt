#import "../../components.typ": (
  cite_prose, describe_figure, equation, note_from_alice, note_from_eduardo, source_for_content_created_by_authors,
  todo_note,
)
#import "../../util.typ": get_term

= Introdução <capitulo:introdução>

Este é o @capitulo:introdução, de introdução.

= Fundamentação teórica

== Citação

#quote(
  attribution: [
    @dumont:1918:o_que_eu_vi_o_que_nos_veremos[p. 15].
  ],
  block: true,
)[
  --- Quero um balão de cem metros cúbicos.

  Grande espanto!
  Creio mesmo que pensaram que eu era doido.
  Alguns meses depois, o "Brasil", com grande espanto de todos os entendidos, atravessava Paris, lindo na sua transparência, como uma grande bola de sabão
]

== Ilustração

Para descrever uma ilustração, utilize o comando `describe_figure`.

Por padrão, toda ilustração deve ter uma fonte, determinada pelo atributo `source`, e deve ser citada no texto.

Veja o exemplo da @figura:quadrado_preto_com_fonte.
Seu texto designativo aparece no texto junto com sua numeração.

#describe_figure(
  sticky: true,
  source: cite_prose(<dumont:1918:o_que_eu_vi_o_que_nos_veremos>),
  [
    #figure(
      caption: [
        Quadrado preto com fonte
      ],
      image(
        width: 4.75cm,
        "./../../assets/images/black_square.png",
      ),
    )<figura:quadrado_preto_com_fonte>
  ],
)

Quando você não determinar uma fonte explicitamente, o modelo a preencherá com o texto "#source_for_content_created_by_authors()".
Veja um exemplo na @figura:quadrado_preto_com_fonte_implícita.

#describe_figure(
  sticky: true,
  [
    #figure(
      caption: [
        Quadrado preto com fonte implícita
      ],
      image(
        width: 4.75cm,
        "./../../assets/images/black_square.png",
      ),
    )<figura:quadrado_preto_com_fonte_implícita>
  ],
)

Caso você queira eliminar totalmente a descrição da fonte de uma imagem, defina o atributo `source` com o valor `false`, como na @figura:quadrado_preto_sem_fonte.
Perceba, porém, que a @abnt exige que sempre seja  descrita a fonte.

#describe_figure(
  sticky: true,
  source: false,
  [
    #figure(
      caption: [
        Quadrado preto sem descrição de fonte
      ],
      image(
        width: 4.75cm,
        "./../../assets/images/black_square.png",
      ),
    )<figura:quadrado_preto_sem_fonte>
  ],
)

== Nota de rodapé

Exemplo de nota de rodapé
#footnote[
  #lorem(10)
].

== Nota de editor

#note_from_alice()[
  Nota da Alice.
]

#note_from_eduardo(note: todo_note)[
  Nota de afazeres do Eduardo.
]

== Texto mono-espaçado

```
Lorem ipsum dolor sit amet, consectetur adipiscing elit,
sed do eiusmod tempor incididunt ut labore et dolore magnam
aliquam quaerat voluptatem.
```

== Equações

#describe_figure(
  // placement: auto,
)[
  #figure(
    supplement: "Esquema",
    kind: "scheme",
    caption: [
      Soma entre dois números.
    ],
  )[
    #equation(
      width: 41.82%,
    )[
      $ 1 + 1 = 2 $ <equação:soma>
    ]
  ]
]

== Glossário

Exemplo de uso de texto no glossário:
@rn.

Exemplo de uso de termo útil: #get_term("software").

= Material e métodos

= Resultados

= Considerações finais

= Título primário
== Título secundário
=== Título terciário
==== Título quaternário
===== Título quinário
