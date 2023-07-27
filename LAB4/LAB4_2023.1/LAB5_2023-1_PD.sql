--PARTE DIRIGIDA
--2023.1
SET SERVEROUTPUT ON
--------------------------------------------------------------------------------
--PREGUNTA 1: elaborar un procedimiento que reciba parametro e imprima lista
--de cursos de esa unidad academica
--------------------------------------------------------------------------------
SELECT * FROM GP_CURSO;--ID_UNIDADACAD
SELECT * FROM GP_UNIDADACAD; -- ID_UNIDADACAD
/
CREATE OR REPLACE PROCEDURE PR_MOSTRAR_CURSOS_X_UNIDADACAD(D_ID_UNIDADACAD CHAR)
IS
    CURSOR C_CURSOS (P_ID_UNIDADACAD CHAR) IS
        SELECT ID_CURSO, NOMBRE
        FROM GP_CURSO
        WHERE ID_UNIDADACAD = P_ID_UNIDADACAD
        ORDER BY NOMBRE;
BEGIN
--abro el cursor
    dbms_output.put_line('    '||'CURSOS: ');
    FOR RCURSOS IN C_CURSOS(D_ID_UNIDADACAD)
    LOOP
        dbms_output.put_line('    '||RCURSOS.ID_CURSO||'-'||RCURSOS.NOMBRE);
    END LOOP;
END;
/
EXEC PR_MOSTRAR_CURSOS_X_UNIDADACAD('001');
/
--------------------------------------------------------------------------------
--PREGUNTA 2: elaborar un reporte que muestre la lista de cursos correspondientes
--a una unidad academica 
--------------------------------------------------------------------------------
SELECT * FROM GP_CURSO;--ID_UNIDADACAD
SELECT * FROM GP_UNIDADACAD; -- ID_UNIDADACAD
/
CREATE OR REPLACE PROCEDURE PR_MOSTRAR_UNIDAD_ACADEMICA
IS
    --creo cursor que me imprima datos x unidad academica
    CURSOR C_UNIDAD_ACADEMICA IS
        SELECT  ID_UNIDADACAD, NOMBRE_UNIDAD
        FROM GP_UNIDADACAD;
    P_REGISTRO C_UNIDAD_ACADEMICA%ROWTYPE;
BEGIN
--abro el cursor para que me vaya imprimiendo la primera linea
    OPEN C_UNIDAD_ACADEMICA;
    LOOP
        FETCH C_UNIDAD_ACADEMICA INTO P_REGISTRO;
        EXIT WHEN C_UNIDAD_ACADEMICA%NOTFOUND;
        dbms_output.put_line('UNIDAD ACADEMICA: '||P_REGISTRO.ID_UNIDADACAD||'-'||P_REGISTRO.NOMBRE_UNIDAD);
        dbms_output.put_line('CURSOS: ');
        --llamo a la otra funcion, para que me imprima los cursos y le paso el id
        PR_MOSTRAR_CURSOS_X_UNIDADACAD(P_REGISTRO.ID_UNIDADACAD);
    END LOOP;
    CLOSE C_UNIDAD_ACADEMICA;
END;
/
EXEC PR_MOSTRAR_UNIDAD_ACADEMICA();
/
--------------------------------------------------------------------------------
--PREGUNTA 3: elaborar un procedimiento que permita consultar los cursos 
--correspondientes a un tipo de curso dado
--------------------------------------------------------------------------------
SELECT * FROM GP_TIPOCURSO;--ID_TIPOCURSO, NOMBRE
SELECT * FROM GP_CURSO; --id_curso, nombre
/
CREATE OR REPLACE PROCEDURE PR_CONSULTAR_CURSOS(P_ID_TIPOCURSO NUMBER)
IS
    --creo un cursor que recorra la tabla curso
    CURSOR C_CURSOS (C_ID_TIPOCURSO NUMBER) IS
        SELECT ID_CURSO, NOMBRE
        FROM GP_CURSO
        WHERE ID_TIPOCURSO = C_ID_TIPOCURSO;
    P_REGISTRO C_CURSOS%ROWTYPE;
    P_NOMBRE VARCHAR2(100);
BEGIN 
    SELECT NOMBRE INTO P_NOMBRE
    FROM GP_TIPOCURSO
    WHERE ID_TIPOCURSO = P_ID_TIPOCURSO;
    dbms_output.put_line('TIPO DE CURSO: '||P_NOMBRE);
    --abro el cursor
    FOR P_REGISTRO IN C_CURSOS(P_ID_TIPOCURSO)
    LOOP
        dbms_output.put_line('  CURSO: '||P_REGISTRO.ID_CURSO|| '-'||P_REGISTRO.NOMBRE);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No se encontraron unidades académicas');
END;
/
EXEC PR_CONSULTAR_CURSOS('002');
/
--------------------------------------------------------------------------------
--PREGUNTA 4: elaborar un trigger que verifique el nmr de creditos de un curso
--antes de insertar o actualizar un curso
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_validar_creditos
BEFORE INSERT OR UPDATE ON GP_CURSO
FOR EACH ROW
DECLARE
    v_limite NUMBER := 10;
    ex_creditos_invalidos EXCEPTION;
BEGIN
    IF :NEW.NRO_CREDITOS <= 0 OR :NEW.NRO_CREDITOS > v_limite THEN 
        RAISE ex_creditos_invalidos;--hago que se diriga al exception
    END IF;
EXCEPTION
    WHEN ex_creditos_invalidos THEN
        DECLARE
        v_error_msg VARCHAR2(200) := 'El número de créditos del curso
        '|| :NEW.ID_CURSO || ' es inválido. Debe ser positivo y menor o igual a '
        || v_limite;
        BEGIN
        RAISE_APPLICATION_ERROR(-20001, v_error_msg);
        END;
END;
/
INSERT INTO GP_CURSO (ID_CURSO, NOMBRE, NRO_CREDITOS, HORAS_DICTADO,
ID_TIPOCURSO, ID_UNIDADACAD, FECHA_REGISTRO)
VALUES ('CON261', 'Contabilidad', 40, 3, '001', '001', '23/06/23');
/
--------------------------------------------------------------------------------
--PREGUNTA 5: elaborar un trigger que luego de insertar un nuevo curso,
--lo registre en la tabla GP_CURSOXPLAN segun el plan vigente de la unidad 
--academica a la que pertenece el curso
--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_cursoxplan
AFTER INSERT ON GP_CURSO
FOR EACH ROW
DECLARE
    v_id_plan CHAR(2);
BEGIN
    --como piden que sea segun la unidad academica que pertenece el curso
    --debo validar la unidad academica que ingreso y evaluarla en PLANESESTUDIO
    SELECT ID_PLAN INTO v_id_plan
    FROM GP_PLANESTUDIO
    WHERE ID_UNIDADACAD = :NEW.ID_UNIDADACAD AND IND_VIGENTE = '1';
    
    INSERT INTO GP_CURSOXPLAN (ID_CURSO, ID_PLAN, FECHA_REGISTRO)
    VALUES (:NEW.ID_CURSO, v_id_plan, :NEW.FECHA_REGISTRO);
END;
/
SELECT * FROM GP_CURSOXPLAN;
/
INSERT INTO GP_CURSO (ID_CURSO, NOMBRE, NRO_CREDITOS, HORAS_DICTADO,
ID_TIPOCURSO, ID_UNIDADACAD, FECHA_REGISTRO)
VALUES ('EST23', 'Estructuras Discretas', 3, 4, '001', '004', '23/06/23');
