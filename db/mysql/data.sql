
-- Insertar 20 estudiantes
INSERT INTO estudiantes (nombre, apellido, fecha_nacimiento, direccion, email)
SELECT 
    CONCAT('Estudiante', LPAD(FLOOR(1 + RAND() * 1000), 4, '0')),
    CONCAT('Apellido', LPAD(FLOOR(1 + RAND() * 1000), 4, '0')),
    DATE_SUB(NOW(), INTERVAL FLOOR(18 + RAND() * 5) YEAR),
    CONCAT('Calle ', FLOOR(1 + RAND() * 100)),
    CONCAT('estudiante', LPAD(FLOOR(1 + RAND() * 1000), 4, '0'), '@colegio.com')
FROM
    (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20) AS T;

-- Insertar 5 profesores
INSERT INTO profesores (nombre, apellido, email)
SELECT 
    CONCAT('Profesor', LPAD(FLOOR(1 + RAND() * 100), 3, '0')),
    CONCAT('ProfesorApellido', LPAD(FLOOR(1 + RAND() * 100), 3, '0')),
    CONCAT('profesor', LPAD(FLOOR(1 + RAND() * 100), 3, '0'), '@colegio.com')
FROM
    (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) AS T;

-- Insertar 5 cursos
INSERT INTO cursos (nombre) VALUES
('Matemáticas'), ('Historia'), ('Ciencias'), ('Literatura'), ('Física');

-- Insertar 10 clases, seleccionando IDs aleatorios de profesores y cursos
INSERT INTO clases (curso_id, profesor_id, horario)
SELECT
    (SELECT curso_id FROM cursos ORDER BY RAND() LIMIT 1),
    (SELECT profesor_id FROM profesores ORDER BY RAND() LIMIT 1),
    CONCAT('Lunes y Miercoles ', FLOOR(8 + RAND() * 5), ':00')
FROM
    (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) AS T;

-- Insertar 40 inscripciones, asegurando que las combinaciones sean únicas
INSERT INTO inscripciones (estudiante_id, clase_id, fecha_inscripcion)
SELECT
    estudiante.estudiante_id,
    clase.clase_id,
    NOW()
FROM
    (SELECT estudiante_id FROM estudiantes ORDER BY RAND() LIMIT 40) AS estudiante
JOIN
    (SELECT clase_id FROM clases ORDER BY RAND() LIMIT 40) AS clase
ON 
    RAND() < 0.5
GROUP BY estudiante.estudiante_id, clase.clase_id
LIMIT 40;

-- Insertar notas para cada inscripcion
INSERT INTO notas (inscripcion_id, nota, comentarios)
SELECT
    inscripcion_id,
    ROUND(RAND() * 5, 2),
    CONCAT('Nota generada aleatoriamente: ', inscripcion_id)
FROM inscripciones;