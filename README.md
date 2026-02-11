# 🎬 Neo4j Movie Recommendation System

Este repositório contém o desafio de projeto para a criação de um sistema de recomendações de um serviço de streaming utilizando o banco de dados orientado a grafos **Neo4j**. O foco principal é explorar os relacionamentos entre usuários, conteúdos e profissionais do setor.

## 📌 Objetivo do Projeto
Modelar e implementar um grafo de conhecimento que permita conexões poderosas para algoritmos de recomendação, indo além dos sistemas tradicionais.

## 🛠️ Tecnologias Utilizadas
* **Neo4j Desktop / Sandbox**: Para execução das queries Cypher.
* **Arrows.app**: Para a modelagem visual do esquema (Diagrama).
* **Cypher Query Language (CQL)**: Para manipulação dos dados.

## 📐 Modelo de Dados (Diagrama)
O modelo foi desenhado focando nas seguintes entidades e conexões:

- **Nós (Nodes):** `User`, `Movie`, `Series`, `Genre`, `Actor`, `Director`.
- **Relacionamentos (Edges):**
    - `WATCHED`: Conecta um usuário a um filme/série (contém a propriedade `rating`).
    - `ACTED_IN`: Conecta atores aos conteúdos.
    - `DIRECTED`: Conecta diretores aos conteúdos.
    - `IN_GENRE`: Classifica os conteúdos por gênero.

> Veja o arquivo `modelo.png` para visualizar o esquema gráfico.

## 🚀 Como Executar
1. Certifique-se de ter o **Neo4j** instalado ou utilize o **Neo4j Sandbox**.
2. Execute o script contido no arquivo `script.cypher` para:
    - Criar as **Constraints** de unicidade para IDs.
    - Popular o banco com 10 usuários e 10 filmes/séries.
    - Criar os relacionamentos e avaliações de exemplo.

## 📊 Exemplo de Query de Recomendação
Para testar o poder do grafo, você pode rodar a query abaixo para sugerir filmes baseados no que outros usuários assistiram:

```cypher
MATCH (u:User)-[:WATCHED]->(m:Movie)<-[:WATCHED]-(outro:User)-[:WATCHED]->(sugestao:Movie)
WHERE u.id = 1 AND NOT (u)-[:WATCHED]->(sugestao)
RETURN sugestao.title, count(*) AS forca_recomendacao
ORDER BY forca_recomendacao DESC
LIMIT 3
