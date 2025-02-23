CREATE USER 'bi_user'@'%' IDENTIFIED BY 'senhaBI';
SELECT user, host FROM mysql.user;
GRANT SELECT ON olist.order TO 'bi_user'@'%';
GRANT SELECT ON olist.product TO 'bi_user'@'%';
GRANT SELECT ON olist.customer TO 'bi_user'@'%';
GRANT SELECT ON olist.order_payment TO 'bi_user'@'%';
GRANT SELECT ON olist.seller TO 'bi_user'@'%';
GRANT SELECT ON olist.geo_location TO 'bi_user'@'%';
SHOW GRANTS FOR bi_user;