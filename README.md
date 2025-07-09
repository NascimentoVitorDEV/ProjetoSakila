 ## 🎥 Análise de Aluguéis de Filmes com Power BI e MySQL — Base Sakila

### 🔖 Visão Geral do Projeto

Este projeto tem como objetivo aplicar técnicas de Business Intelligence utilizando MySQL e Power BI sobre a base de dados relacional Sakila, que simula o funcionamento de uma locadora de filmes. Através dessa base, foi possível realizar uma série de consultas SQL e criar métricas relevantes para análise de desempenho operacional, preferências dos clientes, categorias mais lucrativas e performance por loja.

### 🗃️ Base de Dados: Sakila

A base Sakila é amplamente utilizada para fins educacionais e representa uma locadora de filmes fictícia. Ela possui diversas tabelas inter-relacionadas que simulam um cenário real de negócio.

**Principais tabelas utilizadas:**

*   `film`: informações dos filmes disponíveis.
*   `category`: categorias dos filmes.
*   `film_category`: associação entre filmes e categorias.
*   `inventory`: controle do inventário de filmes por loja.
*   `rental`: registros de alugueis realizados.
*   `payment`: pagamentos realizados pelos clientes.
*   `customer`: dados dos clientes.
*   `staff`: dados dos funcionários.
*   `store`: lojas da locadora.

### Etapas do Projeto

#### 1. Análises com SQL

As primeiras etapas envolveram a exploração da base via MySQL. Foram desenvolvidas várias consultas para entender o comportamento dos dados, gerar métricas de negócio e facilitar a construção do modelo no Power BI. Entre as principais análises:

*   Total de receita por mês e por ano.
*   Receita por categoria de filme.
*   Top 10 filmes mais alugados.
*   Desempenho por loja (faturamento).
*   Desempenho por funcionário (valores recebidos).
*   Clientes mais ativos (por valor e quantidade de alugueis).
*   Valor médio pago por cliente.

Essas queries ajudaram na identificação dos principais KPIs e nas decisões de modelagem.

#### 2. Modelagem de Dados no Power BI

Com os dados importados, foi feito o tratamento e modelagem no Power BI, respeitando os relacionamentos e utilizando algumas transformações:

*   **Relacionamentos ativos e inativos:** controle com `USERELATIONSHIP` para ativar ligações específicas entre tabelas como `film` e `rental`.

**Medidas criadas com DAX:**

*   Receita Total
*   Quantidade de Aluguéis
*   Ticket Médio
*   Filmes Mais Alugados
*   Categorias com Maior Receita
*   Receita por Loja
*   Receita por Funcionário
*   Média de Pagamento por Cliente

Também foram criadas colunas calculadas para facilitar o uso de datas e filtros.

#### 3. Construção do Dashboard

O dashboard foi construído com foco em interatividade, clareza e apoio à decisão. Algumas das funcionalidades implementadas:

*   Evolução da Receita no Tempo: análise mensal e anual.
*   Top Categorias e Filmes: filtros cruzados com métricas.
*   Performance de Lojas e Funcionários: comparativo de receita.
*   Perfil dos Clientes Mais Ativos: análise de comportamento.
*   Drill Through por Cliente: análise detalhada ao clicar em um cliente.
*   Filtros Flutuantes: seleção por ano, mês, loja, categoria etc.
*   Tooltips customizados: insights adicionais ao passar o cursor.

### Análises

##### Desempenho por Loja e por Funcionário

```sql
-- DESEMPENHO POR LOJA
SELECT
S.store_id,
Sum(P.amount) TOTALALUGUEIS
FROM store AS S
INNER JOIN staff AS SF ON SF.store_id = S.store_id
INNER JOIN payment AS P ON P.staff_id = SF.staff_id
GROUP BY S.store_id
ORDER BY S.store_id;

-- DESEMPENHO POR FUNCIONARIO
SELECT
SF.staff_id,
SF.first_name,
SUM(P.amount) TOTALALUGUEIS
FROM staff AS SF
INNER JOIN payment AS P ON P.staff_id = SF.staff_id
GROUP BY SF.staff_id, SF.first_name;
```

![Desempenho por Loja e por Funcionário](https://github.com/NascimentoVitorDEV/ProjetoSakila/blob/main/Imagens/DesempenhoPorFuncion%C3%A1rio.png)
![Desempenho por Funcionário](https://github.com/NascimentoVitorDEV/ProjetoSakila/blob/main/Imagens/DesempenhoPorLoja.png)

##### Top 10 Filmes Mais Alugados e Clientes que Mais Alugam

```sql
-- TOP 10 FILMES MAIS ALUGADOS
SELECT
F.film_id,
F.title,
COUNT(R.rental_id) QUANTIDADE_ALUGUEL
FROM film AS F
INNER JOIN inventory AS I ON I.film_id = F.film_id
INNER JOIN rental AS R ON R.inventory_id = I.inventory_id
GROUP BY F.film_id, F.title
ORDER BY QUANTIDADE_ALUGUEL DESC
LIMIT 10;

-- Clientes que mais alugam FILMES
SELECT
C.customer_id,
C.first_name,
COUNT(R.rental_id) QUANTIDADEALUGUEIS
FROM rental AS R
INNER JOIN customer AS C ON C.customer_id = R.customer_id
GROUP BY C.customer_id, C.first_name
ORDER BY QUANTIDADEALUGUEIS DESC
LIMIT 10;
```

![Top 10 Filmes Mais Alugados e Clientes que Mais Alugam](https://github.com/NascimentoVitorDEV/ProjetoSakila/blob/main/Imagens/Top10Filmes%20MaisAlugados.png)
![Top 10 Filmes Mais Alugados e Clientes que Mais Alugam](https://github.com/NascimentoVitorDEV/ProjetoSakila/blob/main/Imagens/ClientesMaisAtivos.png)

##### Clientes que Mais Pagaram Aluguel

```sql
-- clientes que mais pagaram aluguel
SELECT
C.customer_id,
C.first_name,
SUM(P.amount) TOTALALUGUEIS
FROM payment AS P
INNER JOIN customer AS C ON C.customer_id = P.customer_id
ORDER BY TOTALALUGUEIS DESC
LIMIT 10;

```

![Clientes que Mais Pagaram Aluguel e Região com Maior Número de Aluguéis](https://github.com/NascimentoVitorDEV/ProjetoSakila/blob/main/Imagens/ClientesMaisPagaram.png)

##### Lojas que Geram Mais Receita e Onde Estão Localizadas

```sql
-- Lojas que geram mais receita e onde estão localizadas
SELECT
S.store_id,
CI.city,
CO.country,
SUM(P.amount) AS TOTAL_RECEITA,
COUNT(R.rental_id) AS QTD_ALUGUEIS,
AVG(P.amount) AS TICKET_MEDIO
FROM payment AS P
JOIN rental AS R ON R.rental_id = P.rental_id
JOIN inventory AS I ON I.inventory_id = R.inventory_id
JOIN store AS S ON S.store_id = I.store_id
JOIN address AS A ON S.address_id = A.address_id
JOIN city AS CI ON A.city_id = CI.city_id
JOIN country AS CO ON CI.country_id = CO.country_id
GROUP BY S.store_id, CI.city, CO.country
ORDER BY TOTAL_RECEITA DESC;
```

![Lojas que Geram Mais Receita e Onde Estão Localizadas](https://github.com/NascimentoVitorDEV/ProjetoSakila/blob/main/Imagens/Regia%C3%A3o.png)

##### Categorias com Maior Rendimento

```sql
SELECT

    FC.category_id,
    C.name,
    SUM(P.amount) TOTAL_ALUGUEIS
    
FROM film  AS F
INNER JOIN film_category AS FC ON FC.film_id = F.film_id
INNER JOIN category AS C ON C.category_id = FC.category_id
INNER JOIN inventory AS I ON I.film_id = F.film_id
INNER JOIN rental AS R ON R.inventory_id = I.inventory_id
INNER JOIN payment AS P ON P.rental_id = R.rental_id
GROUP BY  FC.category_id, C.name
ORDER BY  FC.category_id ASC;

```

![Categorias que mais alugam](https://github.com/NascimentoVitorDEV/ProjetoSakila/blob/main/Imagens/CategoriasComMaiorRendimento.png)


