#import "../../components.typ": (
  cite_prose, closed_discussion_note, describe_figure, done_note, editor_note, equation, note_from_alice,
  note_from_eduardo, open_discussion_note, progress_note, source_for_content_created_by_authors, todo_note,
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

Uma nota de rodapé pode ser inserida usando o comando `footnote`.
Veja o exemplo a seguir.

Exemplo de nota de rodapé
#footnote[
  #lorem(10)
].

== Nota de editor

No arquivo `/components.typ`, você pode customizar as notas de editor com os nomes da sua equipe.

Então, importe-as no topo do arquivo em que estiver escrevendo.
Dessa forma, você pode abrir uma nota conforme o exemplo a seguir.

#note_from_alice()[
  Nota da Alice.
]

Você também pode usar o atributo `note` para determinar o tipo de nota desejado.
Também é necessário importar o tipo da note no topo do arquivo.

#note_from_eduardo(note: todo_note)[
  Nota de afazeres do Eduardo.
]

#note_from_eduardo(note: progress_note)[
  Nota em progresso do Eduardo.
]

#note_from_eduardo(note: done_note)[
  Nota concluída do Eduardo.
]

Você pode misturar e aninhar vários estilos de nota, como melhor funcionar para o seu trabalho.

#editor_note[
  Nota básica.
]

#closed_discussion_note[

  #note_from_alice[

    #progress_note[
      Progresso.
    ]

    #todo_note[
      Afazer.
    ]

  ]

  #note_from_eduardo(note: done_note)[
    Comentário.
  ]

]

#open_discussion_note[
  #note_from_eduardo(note: todo_note)[
    Sugestão.
  ]
]

== Texto mono-espaçado

Para inserir texto mono-espaçado, abra um bloco usando o caractere ``` ` ``` três vezes, como a seguir: ```` ``` ````.

```
Lorem ipsum dolor sit amet, consectetur adipiscing elit,
sed do eiusmod tempor incididunt ut labore et dolore magnam
aliquam quaerat voluptatem.
```


== Equações

Uma equação pode ser descrita ao abrir um bloco com dois símbolos de `$`.
Você pode definir um rótulo ao final de uma equação, a fim de se referir a ela no texto.
Veja o exemplo para a @equação:soma.

$ 1 + 1 = 2 $ <equação:soma>

Caso deseje inserir texto na equação, utilize o comando `equation` para abrir um bloco.

#equation(
  width: 41.82%,
)[
  $ 1 + X = 2 $
  + X tem o valor de 2.
]

Além disso, caso deseje dar mais destaque a uma equação, você pode usar os comandos `describe_figure` e `figure` para criar um esquema de equações.
Veja o exemplo do @esquema:soma.

#describe_figure()[
  #figure(
    supplement: "Esquema",
    kind: "scheme",
    caption: [
      Soma entre dois números
    ],
  )[
    #equation(
      width: 41.82%,
    )[
      $ 1 + 1 = 2 $
    ]
  ] <esquema:soma>
]

== Glossário

Você pode definir termos nos glossários no arquivo `/data/glossary.typ`.

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
