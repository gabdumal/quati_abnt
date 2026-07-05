#import "../../components.typ": *
#import "../../packages.typ": *

= Material e métodos <capítulo:método>


== Citações <seção:citações>

Para incluir uma citação direta, utilize o comando `quote`.
Ele recebe um argumento posicional.
Devemos abrir colchetes após sua chamada e escrever dentro deles a citação.

=== Citação curta

A @abnt determina que uma citação curta, de até três linhas, deve ser inclusa em texto corrido.
Para incluir uma referência nessa forma, utilize o comando `cite_prose`.

==== Exemplo

No livro "O que eu vi, o que nós veremos",
#cite_prose(supplement: [p. 49], <dumont:1918:o_que_eu_vi_o_que_nos_veremos>) escreveu
#quote[
  Perguntar-me-á o leitor porque não o construí mais cedo, ao mesmo tempo que os meus dirigíveis
].

=== Citação longa

Para citações que ocupem mais que três linhas, devemos utilizar dois argumentos na chamada do comando `quote`.
O primeiro é o argumento `block`, que deve ser definido como `true`.

Outro argumento necessário é o `attribution`, em que podemos incluir qualquer texto para descrever a fonte da citação.

Nesse argumento, podemos usar uma das referências já definidas previamente na bibliografia em sua forma parentética.
Para isso, apenas utilize o símbolo `@` antes do nome da referência.

==== Exemplo

#quote(
  attribution: [@dumont:1918:o_que_eu_vi_o_que_nos_veremos[p. 49].],
  block: true,
)[
  Perguntar-me-á o leitor porque não o construí mais cedo, ao mesmo tempo que os meus dirigíveis.
  É que o inventor, como a natureza de Linneu, não faz saltos; progride de manso, evolui.
  Comecei por fazer-me bom piloto de balão livre e só depois ataquei o problema de sua dirigibilidade.
  Fiz-me bom aeronauta no manejo dos meus dirigíveis; durante muitos anos, estudei a fundo o motor a petróleo e só quando verifiquei que o seu estado de perfeição era bastante para fazer voar, ataquei o problema do mais pesado que o ar
]


== Ilustrações <seção:ilustrações>

De acordo com a seção 5.8 da @nbr:short 14724:2024, uma ilustração se trata da
#quote(attribution: <abnt:2025:nbr_14724_2024>)[
  designação genérica de imagem, que ilustra ou elucida um texto
].
Incluem-se nessa categoria desenhos, esquemas, fluxogramas,
fotografias, gráficos, mapas, organogramas, plantas, quadros, retratos, figuras e imagens #cite(<ibge:2023:manual_elaboracao_trabalhos>).

Acima de cada ilustração deve constar uma legenda que descreva brevemente seu conteúdo, iniciada em letra maiúscula e sem finalização com ponto final.
Ela deve ser precedida do termo que melhor a descreve, como "Figura", "Quadro", "Gráfico", etc., seguido de seu número sequencial #cite(<abnt:2025:nbr_14724_2024>).
Em geral, o Typst é capaz de identificar automaticamente o tipo de ilustração e gerar a legenda correta.

Para inserir uma ilustração, deve-se utilizar o comando `figure()`.
Ele recebe como parâmetros:
+ `caption`, a legenda da ilustração;
+ `supplement`, o termo descritor, caso o Typst não seja capaz de inferi-lo;
+ `kind`, o tipo da ilustração, caso seja não trivial, e
+ seu conteúdo;
+ além de demais parâmetros opcionais.

Em seguida está um exemplo de figura.

#figure(
  caption: [
    Ilustração composta de texto
  ],
  supplement: "Texto",
  kind: "text",
  par()[
    Essa ilustração se trata de uma sequência de frases.\
    Sim, uma ilustração pode ser composta de texto.\
    Ela pode ser utilizada para ilustrar uma ideia ou conceito.
  ],
)

O conteúdo de uma ilustração pode ser uma imagem, a qual deve ser inserida com o comando `image()`.
Ele recebe como parâmetro obrigatório o caminho do arquivo.
Já como opcionais elencam-se:
+ `width`: a largura, que pode ser especificada em centímetros ou em porcentagem em relação à pagina (como `50%`); e
+ `height`: a altura, que pode ser especificada da mesma forma.

Abaixo está um exemplo de ilustração composta por uma imagem, com largura de 10cm e altura de 5cm.
Ela é importada por meio do caminho relativo `./../../assets/images/black_square.png`, que deve ser ajustado de acordo com a estrutura do projeto.

#figure(
  caption: [
    Retângulo preto
  ],
  image(
    width: 10cm,
    height: 5cm,
    "./../../assets/images/black_square.png",
  ),
)

=== Ambiente de descrição

Todas as ilustrações devem ser citadas no texto e inseridas o mais próximo possível da sua primeira citação #cite(<abnt:2025:nbr_14724_2024>).

Para isso, deve-se atribuir um rótulo à ilustração.
Pode-se fazê-lo abrindo aspas angulares (`<>`) após o comando `figure()`, da seguinte forma: `<nome_da_ilustração>`.

Para a ilustração abaixo, o rótulo é `figura:quadrado_preto_sem_fonte`.
Então, para referenciá-la no texto, deve-se utilizar o comando `ref()`, que recebe como parâmetro o rótulo da ilustração.
Alternativamente, pode-se utilizar o caractere `@` seguido do rótulo.

Essa é uma referência para a #ref(<figura:quadrado_preto_sem_fonte>).
Essa também é uma referência para a @figura:quadrado_preto_sem_fonte.
#figure(
  caption: [
    Quadrado preto
  ],
  image(
    "./../../assets/images/black_square.png",
  ),
)<figura:quadrado_preto_sem_fonte>

A @nbr:short 14724:2024 determina que todas as ilustrações apresentem sua fonte.
Elas também podem contar com uma nota explicativa.
Ambas as informações devem ser apresentadas após a ilustração e alinhadas à sua margem esquerda.
Elas também  devem ser apresentadas em fonte menor que a do texto principal e limitadas pela largura da ilustração #cite(<abnt:2025:nbr_14724_2024>).

Para cumprir essa exigência, devemos utilizar o ambiente `describe_figure()` em torno da ilustração.
Esse comando recebe como parâmetros opcionais:
+ `source`: a fonte da ilustração; e
+ `note`: uma nota sobre a ilustração.

Caso a fonte não seja informada, ela será automaticamente preenchida com o texto "#source_for_content_created_by_authors()".

A @figura:quadrado_vermelho_com_fonte_implícita mostra o uso desses parâmetros.

#describe_figure(
  [
    #figure(
      caption: [
        Quadrado vermelho com fonte implícita
      ],
      rect(
        fill: red,
        height: 5cm,
        width: 5cm,
      ),
    )<figura:quadrado_vermelho_com_fonte_implícita>
  ],
)

Caso você queira eliminar totalmente a descrição da fonte de uma imagem, defina o atributo `source` com o valor `false`, como na @figura:quadrado_vermelho_sem_fonte.
Perceba, porém, que a @abnt exige que sempre seja  descrita a fonte.

#describe_figure(
  source: false,
  [
    #figure(
      caption: [
        Quadrado vermelho sem fonte
      ],
      rect(
        fill: red,
        height: 5cm,
        width: 5cm,
      ),
    )<figura:quadrado_vermelho_sem_fonte>
  ],
)

O @texto:ismália_guimarães_1960 mostra o resultado do uso do ambiente `describe_figure()` preenchendo os parâmetros de fonte e nota.
Nesse caso, é recomendado utilizar o comando `cite_prose` para incluir uma referência da bibliografia no formato de texto-livre.

#describe_figure(
  source: [
    #cite_prose(<guimaraes:1960:ismalia>).
  ],
  note: [
    Alphonsus Guimarães foi um poeta brasileiro, conhecido por sua obra lírica e simbolista.
  ],
  [
    #figure(
      caption: [
        Ismália
      ],
      supplement: "Texto",
      kind: "text",

      text()[
        *Ismália*
        #parbreak()
        Quando Ismália enlouqueceu,\
        Pôs-se na torre a sonhar...\
        Viu uma lua no céu,\
        Viu outra lua no mar.\
        No sonho em que se perdeu,\
        Banhou-se toda em luar...\
        Queria subir ao céu,\
        Queria descer ao mar...\
        E, no desvario seu,\
        Na torre pôs-se a cantar...\
        Estava perto do céu,\
        Estava longe do mar...\
        E como um anjo pendeu\
        As asas para voar...\
        Queria a lua do céu,\
        Queria a lua do mar...\
        As asas que Deus lhe deu\
        Ruflaram de par em par...\
        Sua alma subiu ao céu,\
        Seu corpo desceu ao mar...
      ],
    )<texto:ismália_guimarães_1960>
  ],
)

Também é possível definir mais de uma nota na mesma figura.
Para isso, basta definir o parâmetro `note` como uma lista de notas.
Uma lista é representada com a abertura de parênteses, e cada item é separado com vírgula, como em: `(nota1, nota2)`.
Observe o exemplo da @figura:retângulo_vermelho_com_múltiplas_notas.

#describe_figure(
  note: (
    [
      #lorem(5)
    ],
    [
      #lorem(40)
    ],
  ),
  [
    #figure(
      caption: [
        Retângulo vermelho com múltiplas notas
      ],
      rect(
        fill: red,
        height: 5cm,
        width: 100%,
      ),
    )<figura:retângulo_vermelho_com_múltiplas_notas>
  ],
)

=== Posicionamento

Para ilustrações que ficam mal posicionadas na página, como aquelas com altura muito elevada, pode-se utilizar o parâmetro `placement: auto` no ambiente `describe_figure()`, para que o Typst escolha automaticamente uma melhor posição.

A @figura:retângulo_vermelho_alto apresenta um retângulo vermelho com largura de 100% da página e altura de 20cm, com fonte de autoria e nota geradas automaticamente para ocupar mais de uma linha.
Nela, o parâmetro `placement: auto` foi definido.

#describe_figure(
  placement: auto,
  source: [
    #lorem(20)
  ],
  note: [
    #lorem(40)
  ],
  [
    #figure(
      caption: [
        #lorem(25)
      ],
      rect(
        fill: red,
        height: 20cm,
        width: 100%,
      ),
    )<figura:retângulo_vermelho_alto>
  ],
)

=== Sub-ilustrações

Quando for necessário apresentar várias ilustrações que constituem um conteúdo único, pode-se utilizar o ambiente `subpar.super()`, que permite criar sub-ilustrações.

Esse ambiente recebe como parâmetros:
+ `label`: o rótulo da ilustração;
+ `caption`: a legenda da ilustração; e
+ `grid`, que define a grade de sub-ilustrações.
Você pode encapsular o ambiente `subpar.super()` em um `block()` com o parâmetro `sticky: true`, para que as sub-ilustrações sejam dispostas na mesma página.

A @figura:três_sub-figuras apresenta três sub-ilustrações, cada uma com sua própria legenda.
Esta é a primeira sub-ilustração: @figura:primeira_sub-figura;
esta é a segunda sub-ilustração: @figura:segunda_sub-figura; e
esta é a terceira sub-ilustração: @figura:terceira_sub-figura.

#describe_figure(
  source: [
    #lorem(20)
  ],
  note: [
    #lorem(40)
  ],
  placement: auto,

  subpar.super(
    label: <figura:três_sub-figuras>,
    caption: [Uma figura composta de três sub-figuras],

    block()[
      #grid(
        columns: (1fr, 1fr),

        grid.cell()[
          #figure(
            caption: [
              #lorem(5)
            ],
            image("./../../assets/images/black_square.png", width: 5cm),
          )<figura:primeira_sub-figura>
        ],

        grid.cell()[
          #figure(
            caption: [
              #lorem(10)
            ],
            image("./../../assets/images/black_square.png", width: 5cm),
          )<figura:segunda_sub-figura>
        ],

        grid.cell(colspan: 2)[
          #figure(
            caption: [
              #lorem(15)
            ],
            image("./../../assets/images/black_square.png", width: 10cm),
          )<figura:terceira_sub-figura>
        ],
      )
    ],
  ),
)

=== Tipos de ilustrações

A seguir estão os tipos de ilustrações mais comuns, com exemplos de cada um.

==== Figura

Uma figura deve ser inserida com o comando `image`, que recebe como parâmetro obrigatório o caminho do arquivo.

Então, ela deve ser inserida dentro do ambiente `figure`, que, por sua vez, deve ser encapsulado no ambiente `describe_figure` para que a fonte e a nota sejam apresentadas corretamente.

A @figura:quadrado_preto apresenta uma imagem importada do arquivo `./../../assets/images/black_square.png`, com largura de 10cm e altura ajustada proporcionalmente.

#describe_figure(
  [
    #figure(
      caption: [
        Quadrado preto
      ],
      image(
        width: 10cm,
        "./../../assets/images/black_square.png",
      ),
    )<figura:quadrado_preto>
  ],
)

==== Quadro

Um quadro se trata de uma tabela fechada nas extremidades.
Ele deve ter uma legenda iniciada com o termo "Quadro", seguido de seu número sequencial e do título.
Para tal, deve-se utilizar no comando `figure` o parâmetro `kind: "board"` e o parâmetro `supplement: "Quadro"`.

Então, o conteúdo da ilustração deve ser uma tabela, que pode ser criada com o comando `table`.
O @quadro:exemplo_de_quadro ilustra o uso esperado.

#describe_figure(
  [
    #figure(
      kind: "board",
      supplement: "Quadro",
      caption: [
        Exemplo de quadro
      ],

      table(
        columns: (1fr, 1fr, 1fr),
        align: center + horizon,

        table.header(
          table.cell()[#strong("Cabeçalho 1")],
          table.cell()[#strong("Cabeçalho 2")],
          table.cell()[#strong("Cabeçalho 3")],
        ),

        table.cell(
          rowspan: 2,
        )[Linhas 1 e 2, Coluna 1],
        table.cell()[Linha 1, Coluna 3],

        table.cell()[Linha 2, Coluna 1],
        table.cell()[Linha 2, Coluna 2],
        table.cell()[Linha 2, Coluna 3],

        table.cell()[Linha 3, Coluna 1],
        table.cell(
          colspan: 2,
        )[Linha 3, Colunas 2 e 3],
      ),
    )<quadro:exemplo_de_quadro>
  ],
)
