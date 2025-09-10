-- Oracle no tiene AUTO_INCREMENT como MySQL o SERIAL como PostgreSQL. Necesitamos crear secuencias (SEQUENCE) y triggers.


-- Secuencias para generar IDs
CREATE SEQUENCE estudiantes_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE profesores_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE cursos_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE clases_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE inscripciones_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE notas_seq START WITH 1 INCREMENT BY 1;

-- Tablas
CREATE TABLE estudiantes (
    estudiante_id NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    apellido VARCHAR2(100) NOT NULL,
    fecha_nacimiento DATE,
    direccion VARCHAR2(255),
    email VARCHAR2(100) UNIQUE
);

CREATE TABLE profesores (
    profesor_id NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    apellido VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE
);

CREATE TABLE cursos (
    curso_id NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE clases (
    clase_id NUMBER(10) PRIMARY KEY,
    curso_id NUMBER(10) NOT NULL,
    profesor_id NUMBER(10) NOT NULL,
    horario VARCHAR2(50),
    CONSTRAINT fk_clase_curso FOREIGN KEY (curso_id) REFERENCES cursos(curso_id),
    CONSTRAINT fk_clase_profesor FOREIGN KEY (profesor_id) REFERENCES profesores(profesor_id)
);

CREATE TABLE inscripciones (
    inscripcion_id NUMBER(10) PRIMARY KEY,
    estudiante_id NUMBER(10) NOT NULL,
    clase_id NUMBER(10) NOT NULL,
    fecha_inscripcion TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT fk_inscripcion_estudiante FOREIGN KEY (estudiante_id) REFERENCES estudiantes(estudiante_id),
    CONSTRAINT fk_inscripcion_clase FOREIGN KEY (clase_id) REFERENCES clases(clase_id),
    CONSTRAINT uk_estudiante_clase UNIQUE (estudiante_id, clase_id)
);

CREATE TABLE notas (
    nota_id NUMBER(10) PRIMARY KEY,
    inscripcion_id NUMBER(10) NOT NULL,
    nota NUMBER(5, 2),
    comentarios CLOB,
    CONSTRAINT fk_nota_inscripcion FOREIGN KEY (inscripcion_id) REFERENCES inscripciones(inscripcion_id)
);

-- Triggers para autoincrementar los IDs
CREATE OR REPLACE TRIGGER estudiantes_on_insert
BEFORE INSERT ON estudiantes
FOR EACH ROW
BEGIN
    SELECT estudiantes_seq.nextval INTO :new.estudiante_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER profesores_on_insert
BEFORE INSERT ON profesores
FOR EACH ROW
BEGIN
    SELECT profesores_seq.nextval INTO :new.profesor_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER cursos_on_insert
BEFORE INSERT ON cursos
FOR EACH ROW
BEGIN
    SELECT cursos_seq.nextval INTO :new.curso_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER clases_on_insert
BEFORE INSERT ON clases
FOR EACH ROW
BEGIN
    SELECT clases_seq.nextval INTO :new.clase_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER inscripciones_on_insert
BEFORE INSERT ON inscripciones
FOR EACH ROW
BEGIN
    SELECT inscripciones_seq.nextval INTO :new.inscripcion_id FROM dual;
END;
/

CREATE OR REPLACE TRIGGER notas_on_insert
BEFORE INSERT ON notas
FOR EACH ROW
BEGIN
    SELECT notas_seq.nextval INTO :new.nota_id FROM dual;
END;
/