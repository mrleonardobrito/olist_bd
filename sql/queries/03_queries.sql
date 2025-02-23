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

-- Essa consulta identifica os 5 produtos mais vendidos dentro de um período específico,
-- ordenando-os pela quantidade total de unidades vendidas. A informação vem da tabela
-- order_item, relacionando produtos e pedidos.

-- Essa consulta retorna os 10 pedidos com maior atraso na entrega dentro de um período,
-- comparando a data de entrega estimada com a data real de entrega.

-- Essa consulta identifica os 10 clientes que mais gastaram na plataforma, somando o total
-- de pagamentos feitos por cada cliente.

-- Essa consulta identifica os 10 clientes que mais gastaram na plataforma, somando o total
-- de pagamentos feitos por cada cliente.

-- Essa consulta identifica os 10 clientes que mais gastaram na plataforma, somando o total
-- de pagamentos feitos por cada cliente.