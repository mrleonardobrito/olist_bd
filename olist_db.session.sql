-- CREATE VIEW vw_prefixos_cep AS
-- SELECT DISTINCT
--     SUBSTRING(l.CEP, 1, 4) AS prefixo_cep,
--     l.uf as estado,
--     l.descricao_cidade as cidade,
-- FROM
--     logradouro l;

-- drop view vw_prefixos_cep;

-- SELECT DISTINCT seller_zip_code_prefix
-- FROM seller
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM geo_location
--     WHERE seller_zip_code_prefix = geolocation_zip_code_prefix
-- );

-- create view vw_prefixos_cep_definitivo as
-- SELECT prefixo_cep, estado, cidade
-- FROM vw_prefixos_cep
-- UNION ALL
-- SELECT cep_5_digitos, estado, cidade
-- FROM vw_ceps_5_digitos;

-- select * from vw_prefixos_cep_definitivo where prefixo_cep = '13023';