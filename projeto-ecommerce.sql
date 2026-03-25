CREATE TABLE projeto_ecommerce.pedidos (
  pedido_id STRING,
  cliente_id STRING,
  data_pedido DATE,
  valor_total FLOAT64,
  status STRING,
  regiao STRING
)
PARTITION BY data_pedido
OPTIONS (
  description = 'Tabela de pedidos do e-commerce particionada por data',
  partition_expiration_days = 365,
  require_partition_filter = true
);

SELECT 
  regiao,
  COUNT(*) AS total_pedidos,
  SUM(valor_total) AS soma_valor,
  AVG(valor_total) AS ticket_medio
FROM projeto_ecommerce.pedidos
WHERE data_pedido >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
GROUP BY regiao
ORDER BY soma_valor DESC;