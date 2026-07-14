-- ==============================================================================
-- PORTFÓLIO DE SQL: ANÁLISE DE DADOS DO CATÁLOGO DA NETFLIX
-- Objetivo: ETL, Limpeza de Dados e Extração de Insights de Negócio
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- ETAPA 1: Limpeza de Dados (Data Cleaning)
-- ------------------------------------------------------------------------------

-- Desativação do modo seguro para permitir atualizações em massa
SET SQL_SAFE_UPDATES = 0;

-- Remoção da letra 's' grudada nos IDs numéricos
UPDATE netflix_titles_cleaned 
SET show_id = REPLACE(show_id, 's', '');

-- Remoção dos ruídos de importação nos títulos
UPDATE netflix_titles_cleaned SET title = REPLACE(title, '[source: 1] ', '');
UPDATE netflix_titles_cleaned SET title = REPLACE(title, '[source: 2] ', '');
UPDATE netflix_titles_cleaned SET title = REPLACE(title, '[source: 3] ', '');

-- Reativação do modo seguro (Boa prática de segurança)
SET SQL_SAFE_UPDATES = 1;

-- Verificação rápida dos dados limpos
SELECT * FROM netflix_titles_cleaned LIMIT 15;


-- ------------------------------------------------------------------------------
-- ETAPA 2: Consultas Analíticas e Insights de Negócio
-- ------------------------------------------------------------------------------

-- Consulta 1: Distribuição estratégica do catálogo entre Filmes e Séries
SELECT 
    type AS formato,
    COUNT(*) AS total_titulos,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles_cleaned), 2) AS percentual
FROM netflix_titles_cleaned
GROUP BY type;


-- Consulta 2: Análise de Audiência por Gênero (Onde está o maior engajamento?)
SELECT 
    genre AS genero,
    COUNT(*) AS total_titulos,
    SUM(views_millions) AS visualizacoes_totais_milhoes,
    ROUND(AVG(views_millions), 2) AS media_visualizacoes_milhoes
FROM netflix_titles_cleaned
GROUP BY genre
ORDER BY visualizacoes_totais_milhoes DESC;


-- Consulta 3: O "Top 3" de títulos mais valiosos/assistidos de cada formato (Nível Avançado)
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
