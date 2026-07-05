#import "../../components.typ": *
#import "../../packages.typ": *


= Fundamentação teórica <capítulo:fundamentação>

== Alíneas

Alíneas são uma forma de dividir um parágrafo em diferentes itens em uma lista.
A @abnt determina que o texto anterior a uma alínea, que apresenta o seu contexto, deve ser finalizado com o sinal de "dois pontos", `:`.

A forma mais simples de utilizar alíneas é digitar o símbolo `+` antes de cada uma das linhas, como apresentado a seguir:

+ as alíneas devem ser iniciadas em letra minúscula;
+ cada linha deve ser finalizada em "ponto e vírgula";
+ este é um exemplo de uma alínea muito longa; o texto das próximas linhas que se formam fica alinhado exatamente abaixo da primeira letra do texto da linha superior;
+ A última linha deve ser finalizada em "ponto final".

Uma linha pode apresentar subalíneas.
A alínea que apresentará o contexto da subalínea deve finalizar em "dois pontos", como mostrado a seguir:

+ alínea 1:
  + subalínea 1;
  + subalínea 2;
+ alínea 2.


== Glossário

A @abnt define três tipos de listas de termos, cada uma com sua finalidade específica.
Todas são opcionais.
A primeira delas é a de abreviaturas e siglas, que deve constar nos elementos pré-textuais.
A segunda é a de símbolos, que também deve constar nos elementos pré-textuais.
A terceira é a lista de termos e definições, que deve constar nos elementos pós-textuais.

Caso um termo tenha uma forma curta e uma longa, a biblioteca irá expandir as duas formas na primeira vez em que você utilizar esse termo.
Nas seguintes, apenas as formas curtas aparecerão.

Você pode definir os elementos dessas listas no arquivo `/data/glossary.typ`.

=== Lista de abreviaturas e siglas

Observe exemplos de termos que representam abreviaturas ou siglas.

#list(
  [@abnt],
  [@ibge],
  [@bi],
)

=== Lista de símbolos

Observe exemplos de  termos que representam símbolos.
É recomendado que eles apresentem uma entrada de descrição, que será exibida no glossário.

#list(
  [@emptyset],
)

=== Lista de termos e definições no glossário

Observe exemplos de demais termos registrados no glossário.

#list(
  [@firewall],
  [@aprendizado_maquina],
  [@fitness],
)

=== Lista de termos simples, não adicionados ao glossário

Caso você utilize bastante algum termo, mas não deseja que ele seja colocado em nenhuma lista de glossário, você pode defini-lo como um termo útil.

Para isso, inclua-os no arquivo `/data/terms.typ`.
Então, você pode inseri-los no texto com o comando `get_term`.

Você também pode definir formas no plural e com letras maiúsculas.se caso, utilize os atributos `plural` e `capitalize` para acessá-las.

#list(
  [#get_term("script")],
  [#get_term("software")],
  [#get_term("web")],
  [#get_term("link")],
  [#get_term("link", capitalize: true)],
  [#get_term("link", plural: true)],
  [#get_term("link", capitalize: true, plural: true)],
)


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

Nesse caso, é recomendado utilizar o comando `cite_prose` para incluir uma referência da bibliografia no formato de texto-livre.

Veja o exemplo da @figura:quadrado_preto_com_fonte.
Seu texto designativo aparece no texto junto com sua numeração.

#describe_figure(
  sticky: true,
  source: [#cite_prose(<dumont:1918:o_que_eu_vi_o_que_nos_veremos>).],
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

#note_from_gabriel(note: todo_note)[
  Nota de afazeres do Gabriel.
]

#note_from_gabriel(note: progress_note)[
  Nota em progresso do Gabriel.
]

#note_from_gabriel(note: done_note)[
  Nota concluída do Gabriel.
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

  #note_from_gabriel(note: done_note)[
    Comentário.
  ]

]

#open_discussion_note[
  #note_from_gabriel(note: todo_note)[
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
