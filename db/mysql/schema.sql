CREATE TABLE estudiantes (
    estudiante_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    direccion VARCHAR(255),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE profesores (
    profesor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE cursos (
    curso_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE clases (
    clase_id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT NOT NULL,
    profesor_id INT NOT NULL,
    horario VARCHAR(50),
    FOREIGN KEY (curso_id) REFERENCES cursos(curso_id),
    FOREIGN KEY (profesor_id) REFERENCES profesores(profesor_id)
);

CREATE TABLE inscripciones (
    inscripcion_id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT NOT NULL,
    clase_id INT NOT NULL,
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(estudiante_id),
    FOREIGN KEY (clase_id) REFERENCES clases(clase_id),
    UNIQUE (estudiante_id, clase_id)
);

CREATE TABLE notas (
    nota_id INT AUTO_INCREMENT PRIMARY KEY,
    inscripcion_id INT NOT NULL,
    nota DECIMAL(5, 2),
    comentarios TEXT,
    FOREIGN KEY (inscripcion_id) REFERENCES inscripciones(inscripcion_id)
);