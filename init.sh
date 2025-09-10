#!/bin/bash

# Función para esperar que el servicio este arriba y listo.
wait_for_service() {
    SERVICE_NAME=$1
    echo "Esperando que el servicio $SERVICE_NAME esté listo..."
    docker-compose up -d --no-recreate $SERVICE_NAME
    while [ "$(docker inspect -f '{{.State.Health.Status}}' $SERVICE_NAME)" != "healthy" ]; do
        sleep 1;
    done
    echo "Servicio $SERVICE_NAME listo y saludable."
}

# 1. Levanta e inicializar los servicios
echo "Levantando los servicios..."
docker-compose up -d

# 2. Esperar que cada servicio esté en estado 'healthy'
wait_for_service mysql_colegio
wait_for_service postgres_colegio
wait_for_service oracle_colegio

# 3. Ejecutar los scripts de inserción de datos en cada contenedor
echo "Ejecutando scripts de inserción de datos..."

# MySQL
echo "Inyectando datos en MySQL..."
docker exec -i mysql_colegio mysql -u root -p"$MYSQL_ROOT_PASSWORD" colegio < ./db/mysql/data.sql

# PostgreSQL
echo "Inyectando datos en PostgreSQL..."
docker exec -i postgres_colegio psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f ./db/postgres/data.sql

# Oracle
echo "Inyectando datos en Oracle..."
docker exec -i oracle_colegio sqlplus system/"$ORACLE_PASSWORD"@localhost:1521/FREEPDB1 @./db/oracle/data.sql

echo "¡Proceso de inicialización completado! 🎉"