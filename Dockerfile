FROM mysql:latest

COPY ./sql/migrations/*.sql /docker-entrypoint-initdb.d/
