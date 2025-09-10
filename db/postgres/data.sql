DO $$
DECLARE
    i integer := 0;
    student_id integer;
    professor_id integer;
    course_id integer;
BEGIN
    -- Datos para estudiantes (20 registros)
    FOR i IN 1..20 LOOP
        INSERT INTO estudiantes (nombre, apellido, fecha_nacimiento, direccion, email) VALUES
        (
            'Estudiante' || (floor(random() * 1000) + 1)::text,
            'Apellido' || (floor(random() * 1000) + 1)::text,
            NOW() - (random() * (interval '5 years') + interval '18 years'),
            'Calle ' || (floor(random() * 100) + 1)::text,
            'estudiante' || (floor(random() * 1000) + 1)::text || '@colegio.com'
        );
    END LOOP;

    -- Datos para profesores (5 registros)
    FOR i IN 1..5 LOOP
        INSERT INTO profesores (nombre, apellido, email) VALUES
        (
            'Profesor' || (floor(random() * 100) + 1)::text,
            'ProfesorApellido' || (floor(random() * 100) + 1)::text,
            'profesor' || (floor(random() * 100) + 1)::text || '@colegio.com'
        );
    END LOOP;

    -- Datos para cursos (5 registros)
    INSERT INTO cursos (nombre) VALUES
    ('Matemáticas'), ('Historia'), ('Ciencias'), ('Literatura'), ('Física');

    -- Datos para clases (10 registros)
    FOR i IN 1..10 LOOP
        SELECT profesor_id FROM profesores ORDER BY RANDOM() LIMIT 1 INTO professor_id;
        SELECT curso_id FROM cursos ORDER BY RANDOM() LIMIT 1 INTO course_id;
        INSERT INTO clases (curso_id, profesor_id, horario) VALUES
        (
            course_id,
            professor_id,
            'Lunes y Miercoles ' || (floor(random() * 5) + 8)::text || ':00'
        );
    END LOOP;

    -- Datos para inscripciones (40 registros)
    FOR i IN 1..40 LOOP
        SELECT estudiante_id FROM estudiantes ORDER BY RANDOM() LIMIT 1 INTO student_id;
        SELECT clase_id FROM clases ORDER BY RANDOM() LIMIT 1 INTO course_id;
        -- Usar ON CONFLICT DO NOTHING para evitar duplicados en la llave UNIQUE
        INSERT INTO inscripciones (estudiante_id, clase_id) VALUES (student_id, course_id)
        ON CONFLICT (estudiante_id, clase_id) DO NOTHING;
    END LOOP;

    -- Datos para notas (Generar una nota para cada inscripción)
    INSERT INTO notas (inscripcion_id, nota, comentarios)
    SELECT
        inscripcion_id,
        ROUND((random() * 5)::numeric, 2),
        'Nota generada aleatoriamente: ' || inscripcion_id::text
    FROM inscripciones;

END $$;