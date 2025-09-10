# 👨‍💻 Sistema de Base de Datos para un Colegio

Este proyecto tiene como objetivo diseñar y gestionar las bases de datos para un sistema de información de un colegio. Se utilizan diferentes motores de bases de datos para comparar su implementación y demostrar el uso de **Docker** para la orquestación de servicios.

## 🚀 Tecnologías Utilizadas

* **Docker & Docker Compose:** Para la gestión de contenedores.
* **MySQL:** Motor de base de datos relacional.
* **PostgreSQL:** Motor de base de datos relacional.
* **OracleDB:** Motor de base de datos relacional.
* **Git & GitHub:** Para el control de versiones.


# 👨‍💻 Sistema de Base de Datos para un Colegio

Este proyecto tiene como objetivo diseñar y gestionar las bases de datos para un sistema de información de un colegio. Se utilizan diferentes motores de bases de datos para comparar su implementación y demostrar el uso de **Docker** para la orquestación de servicios.

## 🚀 Tecnologías Utilizadas

* **Docker & Docker Compose:** Para la gestión de contenedores.
* **MySQL:** Motor de base de datos relacional.
* **PostgreSQL:** Motor de base de datos relacional.
* **OracleDB:** Motor de base de datos relacional.
* **Git & GitHub:** Para el control de versiones.

# 🧠 Diseño de la Base de Datos

El diseño de la base de datos se basa en el modelo de entidad-relación (ERD) que se muestra a continuación.

### Diagrama de Entidad-Relación (ERD):

![diagrama](/assets/diagrama.png)

Descripción de las Entidades
* **Estudiantes:** Contiene información personal de los estudiantes.

* **Profesores:** Contiene información de los profesores.

* **Cursos:** Representa las materias que se imparten (e.g., Matemáticas, Historia).

* **Clases:** Representa una instancia específica de un curso, asignada a un profesor.

* **Inscripciones:** Conecta a los estudiantes con las clases en las que están inscritos.

* **Notas:** Guarda las calificaciones de los estudiantes para cada clase.



## 📁 Estructura del Proyecto

La estructura del proyecto está organizada para mantener separados los scripts de cada base de datos y la configuración de Docker.

```
├── db/
│   ├── mysql/
│   │   ├── schema.sql
│   │   └── data.sql (Opcional)
│   ├── postgres/
│   │   ├── schema.sql
│   │   └── data.sql (Opcional)
│   └── oracle/
│       ├── schema.sql
│       └── data.sql (Opcional)
├── .env.mysql
├── .env.postgres
├── .env.oracle
├── .gitignore
├── docker-compose.yml
└── README.md
```

## 🛠️ Cómo Iniciar el Proyecto

Como levantar las bases de datos en tu máquina local.

**1. Requisitos:**

Tener instalado [Docker](https://www.docker.com/) y anexo la Documentacion de [Docker Compose](https://docs.docker.com/compose/).

**2. Configuración del Entorno:**

Copia los archivos de variables de entorno de ejemplo para configurar las credenciales de cada base de datos. Estos archivos no deben ser subidos a Git.

```bash
cp .env.mysql.example .env.mysql
cp .env.postgres.example .env.postgres
cp .env.oracle.example .env.oracle
```

### Levantar los Contenedores
**Comando Bash**

``` docker-compose up -d ```

### Detener los Contenedores
**Comando Bash**

``` docker-compose down ```


