USE sakila;


-- Categorias e filmes --
SELECT
	FC.film_id,
	F.title,
    FC.category_id,
    C.name
  
FROM film_category AS FC
INNER JOIN film AS F ON F.film_id = FC.film_id
INNER JOIN category AS C ON C.category_id = FC.category_id
ORDER BY 1 ASC;


-- TOTAL DE ALUGUEIS AO LOGNO DO TEMPO
SELECT
	YEAR(P.payment_date) ANO,
    MONTH(P.payment_date) MES,
	SUM(P.amount) AS PAGAMENTOS
FROM payment AS P
GROUP BY YEAR(P.payment_date), MONTH(P.payment_date)
ORDER BY ANO, MES;

-- ALUGUEIS POR CATEGORIA
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

-- DESEMPENHO POR LOJA 
SELECT
	S.store_id,
    SUM(P.amount) TOTALALUGUEIS
FROM store as S
INNER JOIN staff AS SF ON SF.store_id = S.store_id 
INNER JOIN payment AS P ON P.staff_id = SF.staff_id
GROUP BY S.store_id
ORDER BY S.store_id;

-- DESEMPENHO POR FUNCIONARIO 
SELECT
	SF.staff_id,
    SF.first_name,
    SUM(P.amount) TOTALALUGUEIS
FROM Staff AS SF
INNER JOIN payment AS P ON P.staff_id = SF.staff_id
GROUP BY SF.staff_id, SF.first_name;


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
LIMIT 10





