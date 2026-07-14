Portfólio de SQL: Análise de Dados do Catálogo da Netflix

Objetivo do Projeto
Este projeto demonstra a aplicação prática de habilidades em Extração, Transformação e Carga (ETL) e Análise Exploratória de Dados utilizando SQL. O objetivo principal foi higienizar um conjunto de dados brutos e extrair insights estratégicos de negócios sobre o catálogo e a audiência da plataforma, focando em responder perguntas que direcionam ações de marketing e aquisição de conteúdo.

Ferramentas e Técnicas Utilizadas
Sistema de Gerenciamento de Banco de Dados: MySQL

Técnicas de SQL Aplicadas:

Criação e modelagem de tabelas (CREATE TABLE AS SELECT).

Tratamento e limpeza de strings (REPLACE, UPDATE).

Funções de Agregação (COUNT, SUM, AVG, ROUND).

Agrupamento e Ordenação (GROUP BY, ORDER BY).

Subconsultas (Subqueries matemáticas).

Funções de Janela / Window Functions de nível avançado (ROW_NUMBER() OVER).

🧹 Etapa 1: ETL e Limpeza de Dados (Data Cleaning)
Na vida real, bases de dados raramente vêm perfeitas. O dataset original apresentava ruídos de importação, como a string [source: X] mesclada aos títulos e a letra s grudada nos IDs numéricos.

Para garantir a integridade das análises, executei um processo de limpeza na tabela recém-criada (netflix_titles_cleaned), desativando travas de segurança temporárias do banco para padronizar as colunas cruciais:

SQL
-- Desativação do modo seguro e limpeza de strings indesejadas nos IDs e Títulos
SET SQL_SAFE_UPDATES = 0;

UPDATE netflix_titles_cleaned SET show_id = REPLACE(show_id, 's', '');
UPDATE netflix_titles_cleaned SET title = REPLACE(title, '[source: 1] ', '');
UPDATE netflix_titles_cleaned SET title = REPLACE(title, '[source: 2] ', '');
UPDATE netflix_titles_cleaned SET title = REPLACE(title, '[source: 3] ', '');

SET SQL_SAFE_UPDATES = 1;
Etapa 2: Consultas Analíticas e Insights de Negócio
Pergunta 1: Qual é a distribuição estratégica do catálogo entre Filmes e Séries?
Para entender a composição do produto oferecido pela plataforma, calculei o volume total e a fatia de mercado de cada formato.

SQL
SELECT 
    type AS formato,
    COUNT(*) AS total_titulos,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles_cleaned), 2) AS percentual
FROM netflix_titles_cleaned
GROUP BY type;
Insight: O catálogo apresenta um mix equilibrado, com uma ligeira predominância em longa-metragens (Filmes). Isso sugere uma estratégia mista de retenção (séries) e aquisição rápida (filmes).

Pergunta 2: Onde está a maior audiência? (Análise por Gênero)
Cruzei a quantidade de títulos de cada gênero com o total de visualizações para descobrir não apenas os gêneros mais assistidos, mas também a eficiência de cada um (média de visualizações por título).

SQL
SELECT 
    genre AS genero,
    COUNT(*) AS total_titulos,
    SUM(views_millions) AS visualizacoes_totais_milhoes,
    ROUND(AVG(views_millions), 2) AS media_visualizacoes_milhoes
FROM netflix_titles_cleaned
GROUP BY genre
ORDER BY visualizacoes_totais_milhoes DESC;
Insight: Observou-se uma altíssima média de engajamento nos gêneros de Documentários e Ficção Científica (Sci-Fi). Para um estrategista de tráfego e marketing, este é um dado de ouro: indica que campanhas direcionadas (Ads) promovendo títulos desses nichos têm maior probabilidade de converter cliques em retenção prolongada.

Pergunta 3: Qual é o "Top 3" de títulos mais valiosos de cada formato?
Utilizei Window Functions para criar um ranking isolado para Filmes e outro para Séries, exibindo apenas o pódio de cada categoria com base nas visualizações absolutas.

SQL
WITH RankingVisualizacoes AS (
    SELECT 
        type AS formato,
        title AS titulo,
        genre AS genero,
        views_millions AS visualizacoes,
        ROW_NUMBER() OVER(PARTITION BY type ORDER BY views_millions DESC) AS posicao
    FROM netflix_titles_cleaned
)
SELECT formato, posicao, titulo, genero, visualizacoes
FROM RankingVisualizacoes
WHERE posicao <= 3;
Insight: Isolar o "Top 3" ajuda a equipe de negócios a entender quais são os produtos âncora da plataforma. São esses títulos que devem protagonizar as campanhas de geração de leads e as landing pages principais de conversão.
