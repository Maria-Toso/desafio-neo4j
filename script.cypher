// Criando as regras de ID único para evitar duplicatas
CREATE CONSTRAINT user_id_unique IF NOT EXISTS FOR (u:User) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT movie_id_unique IF NOT EXISTS FOR (m:Movie) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT series_id_unique IF NOT EXISTS FOR (s:Series) REQUIRE s.id IS UNIQUE;

// Criando 10 Usuários
UNWIND range(1, 10) AS i
CREATE (:User {id: i, name: "Usuario " + i});

// Criando 5 Filmes e 5 Séries (Total 10)
CREATE (m1:Movie {id: 101, title: "Inception", year: 2010}),
       (m2:Movie {id: 102, title: "The Matrix", year: 1999}),
       (m3:Movie {id: 103, title: "Interstellar", year: 2014}),
       (m4:Movie {id: 104, title: "The Godfather", year: 1972}),
       (m5:Movie {id: 105, title: "Gladiator", year: 2000}),
       (s1:Series {id: 201, title: "Breaking Bad", seasons: 5}),
       (s2:Series {id: 202, title: "The Boys", seasons: 4}),
       (s3:Series {id: 203, title: "Dark", seasons: 3}),
       (s4:Series {id: 204, title: "Succession", seasons: 4}),
       (s5:Series {id: 205, title: "The Bear", seasons: 3});

// Criando Gêneros, Atores e Diretores
CREATE (g1:Genre {name: "Sci-Fi"}), (g2:Genre {name: "Drama"}),
       (a1:Actor {name: "Leonardo DiCaprio"}), (a2:Actor {name: "Keanu Reeves"}),
       (d1:Director {name: "Christopher Nolan"}), (d2:Director {name: "Francis Ford Coppola"});

// Criando as Conexões Reais (Exigências do Desafio)
MATCH (m1:Movie {id: 101}), (g1:Genre {name: "Sci-Fi"}), (a1:Actor {name: "Leonardo DiCaprio"}), (d1:Director {name: "Christopher Nolan"})
CREATE (a1)-[:ACTED_IN]->(m1), (d1)-[:DIRECTED]->(m1), (m1)-[:IN_GENRE]->(g1);

MATCH (m2:Movie {id: 102}), (g1:Genre {name: "Sci-Fi"}), (a2:Actor {name: "Keanu Reeves"})
CREATE (a2)-[:ACTED_IN]->(m2), (m2)-[:IN_GENRE]->(g1);

// Simulando 10 visualizações com Ratings (WATCHED)
MATCH (u:User), (m:Movie {id: 101}) WHERE u.id <= 5
CREATE (u)-[:WATCHED {rating: 5.0}]->(m);

MATCH (u:User), (s:Series {id: 201}) WHERE u.id > 5
CREATE (u)-[:WATCHED {rating: 4.5}]->(s);