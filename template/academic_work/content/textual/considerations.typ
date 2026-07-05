#import "../../components.typ": *
#import "../../packages.typ": *

= Considerações finais <capítulo:considerações>



// == Ilustração

// Para descrever uma ilustração, utilize o comando `describe_figure`.

// Por padrão, toda ilustração deve ter uma fonte, determinada pelo atributo `source`, e deve ser citada no texto.

// Nesse caso, é recomendado utilizar o comando `cite_prose` para incluir uma referência da bibliografia no formato de texto-livre.

// Veja o exemplo da @figura:quadrado_preto_com_fonte.
// Seu texto designativo aparece no texto junto com sua numeração.

// #describe_figure(
//   sticky: true,
//   source: [#cite_prose(<dumont:1918:o_que_eu_vi_o_que_nos_veremos>).],
//   [
//     #figure(
//       caption: [
//         Quadrado preto com fonte
//       ],
//       image(
//         width: 4.75cm,
//         "./../../assets/images/black_square.png",
//       ),
//     )<figura:quadrado_preto_com_fonte>
//   ],
// )

// Quando você não determinar uma fonte explicitamente, o modelo a preencherá com o texto "#source_for_content_created_by_authors()".
// Veja um exemplo na @figura:quadrado_preto_com_fonte_implícita.

// #describe_figure(
//   sticky: true,
//   [
//     #figure(
//       caption: [
//         Quadrado preto com fonte implícita
//       ],
//       image(
//         width: 4.75cm,
//         "./../../assets/images/black_square.png",
//       ),
//     )<figura:quadrado_preto_com_fonte_implícita>
//   ],
// )

// Caso você queira eliminar totalmente a descrição da fonte de uma imagem, defina o atributo `source` com o valor `false`, como na @figura:quadrado_preto_sem_fonte.
// Perceba, porém, que a @abnt exige que sempre seja  descrita a fonte.

// #describe_figure(
//   sticky: true,
//   source: false,
//   [
//     #figure(
//       caption: [
//         Quadrado preto sem descrição de fonte
//       ],
//       image(
//         width: 4.75cm,
//         "./../../assets/images/black_square.png",
//       ),
//     )<figura:quadrado_preto_sem_fonte>
//   ],
// )
