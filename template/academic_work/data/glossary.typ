// # Glossary. Glossário.

#import "../components.typ": *


// ## Abbreviations. Abreviaturas.
// NBR 14724:2024 4.2.1.11

#let abbreviations_entries = (
  (
    key: "ibge",
    short: "IBGE",
    long: "Instituto Brasileiro de Geografia e Estatística",
    group: "Normatização",
  ),
  (
    key: "abnt",
    short: "ABNT",
    long: "Associação Brasileira de Normas Técnicas",
    group: "Normatização",
  ),
  (
    key: "nbr",
    short: "NBR",
    plural: "NBRs",
    long: "Norma Brasileira",
    longplural: "Normas Brasileiras",
    group: "Normatização",
  ),
  (
    key: "ia",
    short: "IA",
    long: "Inteligência Artificial",
    group: "Computação",
  ),
  (
    key: "bi",
    short: "BI",
    long: [#foreign_text[Business Intelligence]],
    description: "Em português, Inteligência de Negócios.",
    group: "Computação",
  ),
)


// ## Glossary. Glossário.
// NBR 14724:2024 4.2.3.2

#let glossary_entries = (
  (
    key: "firewall",
    short: "firewall",
    description: "Dispositivo de segurança de rede que monitora e controla o tráfego de entrada e saída com base em regras de segurança predefinidas.",
    group: "Computação",
  ),
  (
    key: "aprendizado_maquina",
    short: [aprendizado de máquina],
    custom: foreign_text[machine learning],
    description: [Em inglês, #foreign_text[machine learning]. Área da @ia que desenvolve algoritmos capazes de aprender padrões a partir de dados sem programação explícita, melhorando seu desempenho através da experiência @geeksforgeeks:2025:machine_learning_algorithms.],
    group: "Computação",
  ),
  (
    key: "fitness",
    short: foreign_text[fitness],
    plural: foreign_text[fitnesses],
    custom: [avaliação],
    description: [Em português, avaliação. Métrica que quantifica a qualidade de uma solução em relação aos objetivos, atribuindo um valor numérico que orienta a tomada de decisão ou o processo de aprendizado.],
    group: "Computação",
  ),
  (
    key: "rn",
    short: "rede neural",
    plural: "redes neurais",
    custom: foreign_text[neural network],
    description: [Em inglês, #foreign_text[neural network]. Modelo computacional composto por camadas de unidades interligadas que aprendem padrões em dados por meio de ajustes de pesos @li:2022:survey_convolutional_neural_networks.],
    group: "Computação",
  ),
)


// ## Symbols. Símbolos.
// NBR 14724:2024 4.2.1.12

#let symbols_entries = (
  (
    key: "emptyset",
    short: $#sym.emptyset$,
    long: "Conjunto vazio",
    description: "Conjunto que não contém nenhum elemento.",
  ),
)
