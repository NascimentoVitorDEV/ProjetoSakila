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

### 🧠 Etapas do Projeto

#### 1. 🔍 Análises com SQL

As primeiras etapas envolveram a exploração da base via MySQL. Foram desenvolvidas várias consultas para entender o comportamento dos dados, gerar métricas de negócio e facilitar a construção do modelo no Power BI. Entre as principais análises:

*   Total de receita por mês e por ano.
*   Receita por categoria de filme.
*   Top 10 filmes mais alugados.
*   Desempenho por loja (faturamento).
*   Desempenho por funcionário (valores recebidos).
*   Clientes mais ativos (por valor e quantidade de alugueis).
*   Valor médio pago por cliente.

Essas queries ajudaram na identificação dos principais KPIs e nas decisões de modelagem.

#### 2. 🧹 Modelagem de Dados no Power BI

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

#### 3. 📊 Construção do Dashboard

O dashboard foi construído com foco em interatividade, clareza e apoio à decisão. Algumas das funcionalidades implementadas:

*   Evolução da Receita no Tempo: análise mensal e anual.
*   Top Categorias e Filmes: filtros cruzados com métricas.
*   Performance de Lojas e Funcionários: comparativo de receita.
*   Perfil dos Clientes Mais Ativos: análise de comportamento.
*   Drill Through por Cliente: análise detalhada ao clicar em um cliente.
*   Filtros Flutuantes: seleção por ano, mês, loja, categoria etc.
*   Tooltips customizados: insights adicionais ao passar o cursor.
