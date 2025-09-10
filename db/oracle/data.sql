SET SERVEROUTPUT ON;

DECLARE
    v_estudiante_id NUMBER;
    v_profesor_id NUMBER;
    v_curso_id NUMBER;
    v_clase_id NUMBER;
    v_inscripcion_id NUMBER;
    existe NUMBER;
BEGIN
    -- Insertar estudiantes (20 registros)
    FOR i IN 1..20 LOOP
        INSERT INTO estudiantes (estudiante_id, nombre, apellido, fecha_nacimiento, direccion, email) VALUES
        (
            estudiantes_seq.NEXTVAL,
            'Estudiante' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE * 1000) + 1),
            'Apellido' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE * 1000) + 1),
            SYSDATE - (TRUNC(DBMS_RANDOM.VALUE * 365 * 5) + 365 * 18),
            'Calle ' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE * 100) + 1),
            'estudiante' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE * 1000) + 1) || '@colegio.com'
        );
    END LOOP;

    -- Insertar profesores (5 registros)
    FOR i IN 1..5 LOOP
        INSERT INTO profesores (profesor_id, nombre, apellido, email) VALUES
        (
            profesores_seq.NEXTVAL,
            'Profesor' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE * 100) + 1),
            'ProfesorApellido' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE * 100) + 1),
            'profesor' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE * 100) + 1) || '@colegio.com'
        );
    END LOOP;

    -- Insertar cursos (5 registros)
    INSERT INTO cursos (curso_id, nombre) VALUES (cursos_seq.NEXTVAL, 'Matemáticas');
    INSERT INTO cursos (curso_id, nombre) VALUES (cursos_seq.NEXTVAL, 'Historia');
    INSERT INTO cursos (curso_id, nombre) VALUES (cursos_seq.NEXTVAL, 'Ciencias');
    INSERT INTO cursos (curso_id, nombre) VALUES (cursos_seq.NEXTVAL, 'Literatura');
    INSERT INTO cursos (curso_id, nombre) VALUES (cursos_seq.NEXTVAL, 'Física');

    -- Insertar clases (10 registros)
    FOR i IN 1..10 LOOP
        SELECT profesor_id INTO v_profesor_id FROM (SELECT profesor_id FROM profesores ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
        SELECT curso_id INTO v_curso_id FROM (SELECT curso_id FROM cursos ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
        
        INSERT INTO clases (clase_id, curso_id, profesor_id, horario) VALUES
        (clases_seq.NEXTVAL, v_curso_id, v_profesor_id, 'Lunes y Miercoles ' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE * 5) + 8) || ':00');
    END LOOP;

    -- Insertar inscripciones (40 registros)
    FOR i IN 1..40 LOOP
        BEGIN
            SELECT estudiante_id INTO v_estudiante_id FROM (SELECT estudiante_id FROM estudiantes ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;
            SELECT clase_id INTO v_clase_id FROM (SELECT clase_id FROM clases ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM = 1;

            INSERT INTO inscripciones (inscripcion_id, estudiante_id, clase_id) VALUES (inscripciones_seq.NEXTVAL, v_estudiante_id, v_clase_id);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                -- Si hay un duplicado, simplemente se ignora y no se inserta
                NULL;
        END;
    END LOOP;

    -- Insertar notas
    INSERT INTO notas (nota_id, inscripcion_id, nota, comentarios)
    SELECT
        notas_seq.NEXTVAL,
        inscripcion_id,
        ROUND(DBMS_RANDOM.VALUE(0, 5), 2),
        'Nota generada aleatoriamente: ' || TO_CHAR(inscripcion_id)
    FROM inscripciones;

    -- Confirmar la transacción
    COMMIT;
END;
/