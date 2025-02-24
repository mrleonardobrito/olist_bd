-- Essa consulta retorna o total faturado por cada vendedor, permitindo identificar quais
-- vendedores geram mais receita na plataforma. O cálculo é feito somando o valor das
-- vendas associadas a cada id do seller.

SELECT s.seller_id, COALESCE(sum(oi.price), 0) as total_billed
FROM seller s
    LEFT JOIN order_item oi ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
ORDER BY total_billed DESC;

-- Essa consulta busca os clientes que mais realizaram compras, seja pelo número total de
-- pedidos ou pelo valor total gasto. Pode-se agrupar os dados pelo customer_unique_id para
-- consolidar informações sobre clientes recorrentes.

SELECT c.customer_id, count(o.order_id) as num_orders
FROM customer c 
    LEFT JOIN olist.order o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY num_orders DESC;

-- Essa consulta calcula a média das avaliações que os clientes deram para cada vendedor. O
-- cálculo é feito a partir das avaliações registradas na olist_order_reviews_dataset,
-- associando-as aos pedidos de cada vendedor.

SELECT 
    oi.seller_id, 
    COUNT(DISTINCT oi.order_id) AS num_orders, 
    COALESCE(AVG(orw.review_score), NULL) AS seller_score
FROM order_item oi
LEFT JOIN (
    SELECT DISTINCT order_id, review_score
    FROM order_review
) orw ON oi.order_id = orw.order_id
GROUP BY oi.seller_id
ORDER BY seller_score DESC, num_orders DESC;

-- Essa consulta retorna todos os pedidos feitos dentro de um período específico, utilizando
-- um filtro de datas na tabela order. Pode incluir detalhes como cliente, status do pedido e
-- total pago.

SELECT o.order_id as order_id,
       o.customer_id as customer, 
       o.order_status as status, 
       sum(oi.price + oi.freight_value) as total_payed
FROM olist.order o 
    INNER JOIN order_item oi ON o.order_id = oi.order_id
WHERE o.order_approved_at BETWEEN '2010-10-12' AND '2017-10-12'
GROUP BY o.order_id
ORDER BY o.order_approved_at ASC;

-- Essa consulta identifica os 5 produtos mais vendidos dentro de um período específico,
-- ordenando-os pela quantidade total de unidades vendidas. A informação vem da tabela
-- order_item, relacionando produtos e pedidos.

SELECT oi.product_id as product,
       count(oi.product_id) as quant
FROM order_item oi
GROUP BY oi.product_id
ORDER BY quant DESC
LIMIT 5;

-- Essa consulta retorna os 10 pedidos com maior atraso na entrega dentro de um período,
-- comparando a data de entrega estimada com a data real de entrega.

SELECT 
    o.order_id AS order_id,
    DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS order_delay_days
FROM olist.order o
ORDER BY order_delay_days DESC
LIMIT 10;

-- Essa consulta identifica os 10 clientes que mais gastaram na plataforma, somando o total
-- de pagamentos feitos por cada cliente.

SELECT o.customer_id, sum(p.payment_value) as client_spenses
FROM olist.order o 
    INNER JOIN order_payment p ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY client_spenses DESC
LIMIT 10;

-- Essa consulta calcula o tempo médio de entrega dos pedidos para cada estado,
-- comparando a data de envio com a data de entrega efetiva.

SELECT c.customer_state, 
    AVG(DATEDIFF(o.order_delivered_customer_date, o.order_delivered_carrier_date)) AS average_time
FROM olist.order o 
    INNER JOIN customer c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL 
AND o.order_delivered_carrier_date IS NOT NULL
GROUP BY c.customer_state;

-- Dado um cliente, através da sua localização (latitude e longitude), encontrar todos os
-- vendedores dentro de um raio (ex.: 50 km) de um cliente. Para calcular a distância entre
-- dois pontos com latitude e longitude você pode usar a fórmula de Haversine.
-- Será que este cálculo poderíamos deixar ele separado e chamar em cada consulta que
-- vamos utilizar?

CREATE FUNCTION calc_distance(lat1 FLOAT, lng1 FLOAT, lat2 FLOAT, lng2 FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE earth_radius FLOAT DEFAULT 6371;
    DECLARE dLat FLOAT;
    DECLARE dLng FLOAT;
    DECLARE a FLOAT;
    DECLARE c FLOAT;
    DECLARE distance FLOAT;

    SET dLat = RADIANS(lat2 - lat1);
    SET dLng = RADIANS(lng2 - lng1);
    SET a = SIN(dLat / 2) * SIN(dLat / 2) + COS(RADIANS(lat1)) * COS(RADIANS(lat2)) * SIN(dLng / 2) * SIN(dLng / 2);
    SET c = 2 * ATAN2(SQRT(a), SQRT(1 - a));
    SET distance = earth_radius * c;
    RETURN distance;
END;

WITH customers_lat_lng AS (
    SELECT gl.geolocation_lat, gl.geolocation_lng
    FROM customer c
    INNER JOIN geo_location gl ON c.customer_zip_code_prefix = gl.geolocation_zip_code_prefix  -- Alias 'gl' para geolocation
    WHERE c.customer_id = '2c07700e1621617464d6252aaca9f1a6'
)
SELECT s.*
FROM seller s
INNER JOIN geo_location gl ON s.seller_zip_code_prefix = gl.geolocation_zip_code_prefix
CROSS JOIN customers_lat_lng AS cliente_loc
WHERE calc_distance(
    cliente_loc.geolocation_lat,
    cliente_loc.geolocation_lng,
    gl.geolocation_lat, 
    gl.geolocation_lng  
) <= 50;