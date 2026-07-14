#  Portfólio de Dados: Análise Estratégica do Catálogo da Netflix

##  Resumo do Projeto
Este projeto demonstra a aplicação prática de habilidades em **Extração, Transformação e Carga (ETL)** e **Análise Exploratória de Dados**. O objetivo principal foi higienizar um conjunto de dados brutos e extrair *insights* estratégicos de negócios sobre o catálogo e a audiência da plataforma, focando em responder perguntas que direcionam ações de marketing e aquisição de conteúdo. 

*(Nota: O script SQL completo contendo os processos de limpeza e as consultas utilizadas nesta análise está disponível no arquivo `script_analise_netflix.sql` presente neste repositório).*

##  Ferramentas e Técnicas Utilizadas
* **Sistema de Gerenciamento de Banco de Dados:** MySQL
* **Técnicas de SQL Aplicadas:** Criação e modelagem de tabelas, tratamento de *strings*, funções de agregação, agrupamentos e *Window Functions* de nível avançado.

---

##  Etapa 1: ETL e Limpeza de Dados (Data Cleaning)
Na vida real, bases de dados raramente vêm prontas para análise. O dataset original apresentava ruídos de importação, como tags de texto indesejadas mescladas aos títulos e caracteres alfabéticos grudados aos IDs numéricos. 

Para garantir a integridade das análises, executei um processo rigoroso de limpeza na base de dados. Padronizei as colunas cruciais, removendo as inconsistências de digitação e garantindo que os dados estivessem perfeitamente estruturados para a extração de métricas precisas.

---

##  Etapa 2: Análises e Insights de Negócio

### 1. Qual é a distribuição estratégica do catálogo entre Filmes e Séries?
Para entender a composição do produto oferecido pela plataforma, calculei o volume total e a fatia de mercado de cada formato.

 **Insight:** O catálogo apresenta um mix equilibrado, com uma ligeira predominância em longa-metragens (Filmes). Isso sugere uma estratégia mista de retenção (através de séries, que garantem retornos recorrentes) e aquisição rápida de novos usuários (através de filmes).

### 2. Onde está a maior audiência e engajamento? (Análise por Gênero)
Cruzei a quantidade de títulos de cada gênero com o total de visualizações para descobrir não apenas os gêneros mais assistidos, mas também a eficiência de cada um calculando a média de visualizações por título.

 **Insight:** Observou-se uma altíssima média de engajamento nos gêneros de **Documentários** e **Ficção Científica (Sci-Fi)**. Pensando em estratégias de tráfego pago e marketing, este é um dado extremamente valioso: indica que campanhas direcionadas promovendo títulos desses nichos têm maior probabilidade de converter cliques em retenção prolongada e gerar leads qualificados.

### 3. Qual é o "Top 3" de títulos mais valiosos de cada formato?
Foi criado um ranking isolado para Filmes e outro para Séries, exibindo apenas o pódio de cada categoria com base nas visualizações absolutas para identificar os maiores sucessos da plataforma.

 **Insight:** Isolar o "Top 3" ajuda a equipe de negócios a entender quais são os produtos âncora da plataforma. São esses títulos que devem protagonizar as campanhas de marketing de alta performance e as *landing pages* principais de conversão da empresa.

---
