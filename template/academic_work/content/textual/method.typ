#import "../../components.typ": *
#import "../../packages.typ": *

= Material e métodos <capítulo:método>


== Citações

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
