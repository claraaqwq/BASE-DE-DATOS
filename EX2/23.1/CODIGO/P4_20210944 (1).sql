--EX2 23.1
--PREGUNTA 4:

set serveroutput ON; --para imprimir
/
-----------------------------------------------------------------------------------
--a) crear una funcion con 2 parametros: nombre de la universidad y año.
--Debe devolver el sueldo promedio de los profesionales que se titularon en esa uni
--Caso el nombre no exista o si el año no es valido la funcion devuelve -1
-----------------------------------------------------------------------------------
SELECT * FROM PROFESIONAL;--IDPROFESIONAL,SUELDO
SELECT * FROM UNIVERSIDAD; --IDUNIVERSIDAD,NOMBRE
SELECT * FROM PROFESION;
SELECT * FROM TITULACION; --IDPROFESIONAL,IDUNIVERIDAD,FECHA 
SELECT * FROM TITULADOS_PUCP;
/
--primero planteo como será mi select :)
SELECT AVG(P.SUELDO)
FROM PROFESIONAL P, UNIVERSIDAD U, TITULACION T
WHERE P.IDPROFESIONAL = T.IDPROFESIONAL
AND U.IDUNIVERSIDAD = T.IDUNIVERSIDAD
AND U.NOMBRE = 'UNMSM' 
AND EXTRACT(YEAR FROM T.FECHA) = '2023';
/
CREATE OR REPLACE FUNCTION F_SUELDO_PROMEDIO(F_NOMBRE_UNIVERSIDAD VARCHAR2, F_ANIO NUMBER)
RETURN NUMBER
IS
    F_SUELDO_PROMEDIO NUMBER;
BEGIN
    SELECT AVG(P.SUELDO) INTO F_SUELDO_PROMEDIO
    FROM PROFESIONAL P, UNIVERSIDAD U, TITULACION T
    WHERE P.IDPROFESIONAL = T.IDPROFESIONAL
    AND U.IDUNIVERSIDAD = T.IDUNIVERSIDAD
    AND U.NOMBRE = F_NOMBRE_UNIVERSIDAD 
    AND EXTRACT(YEAR FROM T.FECHA) = F_ANIO;
    RETURN F_SUELDO_PROMEDIO;
    
    --AHORA VALIDO QUE EXISTA
    IF (F_SUELDO_PROMEDIO < 0) THEN
        RETURN -1;
    ELSE
        RETURN F_SUELDO_PROMEDIO;
    END IF;
    
END;
/
--Pruebo:
DECLARE
    v_nombre_universidad varchar2(10);
    v_anio number;
    v_sueldo_prom number;
BEGIN
    v_nombre_universidad := 'UNMSM';
    v_anio := 2023;
    v_sueldo_prom := F_SUELDO_PROMEDIO(v_nombre_universidad,v_anio);
    IF (v_sueldo_prom < 0) THEN
        DBMS_OUTPUT.PUT_LINE('Universidad o Año no validos');
    ELSE
        DBMS_OUTPUT.PUT_LINE('El sueldo promedio de los profesionales que se titularon en la');
        DBMS_OUTPUT.PUT_LINE(v_nombre_universidad||' el año '||v_anio||' es '||v_sueldo_prom );
    END IF;
END;
/
-----------------------------------------------------------------------------------
--b) escribir procedimiento que tenga como parametro (M o F) y que permite mostrar
--todas las profesiones de ingenieria y por cada una de ellas los nombres de las universidades
--y la cantidad de titulados en ellas. Solo considerar en el reporte el sexo puesto en el parametro
--Necesito aplicar cursores
-----------------------------------------------------------------------------------
SELECT * FROM PROFESIONAL;--IDPROFESIONAL,SEXO
SELECT * FROM TITULACION; --IDPROFESIONAL,IDUNIVERIDAD,FECHA,IDPROFESION
SELECT * FROM PROFESION; --IDPROFESION,NOMBRE 
SELECT * FROM UNIVERSIDAD; --IDUNIVERSIDAD,NOMBRE --> COUNT DE ESTO CON TITULACION
/
SELECT IDPROFESION, NOMBRE
FROM PROFESION 
WHERE NOMBRE LIKE 'Ingeniero%';
/
SELECT  COUNT(PF.IDPROFESIONAL) CANTIDAD, U.NOMBRE NOMBRE
FROM UNIVERSIDAD U, TITULACION T, PROFESIONAL PF, PROFESION P
WHERE PF.IDPROFESIONAL = T.IDPROFESIONAL
AND T.IDUNIVERSIDAD = U.IDUNIVERSIDAD
AND T.IDPROFESION = P.IDPROFESION
AND T.IDPROFESION = 6
AND PF.SEXO = 'M'
GROUP BY U.NOMBRE;
/
CREATE OR REPLACE PROCEDURE F_CANT_TITULADOS_INGENIEROS(F_SEXO CHAR)
IS
    --creo mi cursor para ingenieros
    CURSOR C_INGENIEROS IS
        SELECT IDPROFESION, NOMBRE
        FROM PROFESION 
        WHERE NOMBRE LIKE 'Ingeniero%';
    CURSOR C_UNIVERSIDAD (C_IDPROFESION NUMBER,C_SEXO CHAR) IS
        SELECT COUNT(PF.IDPROFESIONAL) CANTIDAD, U.NOMBRE NOMBRE
        FROM UNIVERSIDAD U, TITULACION T, PROFESIONAL PF
        WHERE PF.IDPROFESIONAL = T.IDPROFESIONAL
        AND T.IDUNIVERSIDAD = U.IDUNIVERSIDAD
        AND T.IDPROFESION = C_IDPROFESION
        AND PF.SEXO = C_SEXO
        GROUP BY U.NOMBRE;
    CANTIDAD NUMBER;
    NOMBRE VARCHAR2(100);
BEGIN
    dbms_output.put_line('Cantidad de ingenieros titulados de sexo '||F_SEXO);
FOR RINGENIEROS IN C_INGENIEROS
LOOP
    dbms_output.put_line(RINGENIEROS.NOMBRE);
    FOR RUNIVERSIDAD IN C_UNIVERSIDAD(RINGENIEROS.IDPROFESION,F_SEXO)
    LOOP
       dbms_output.put_line('   '||RUNIVERSIDAD.NOMBRE||' - '||RUNIVERSIDAD.CANTIDAD); 
    END LOOP;
END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Ingreso un dato no válido.');
END;
/
--Pruebo:
EXEC F_CANT_TITULADOS_INGENIEROS('M');
/
-----------------------------------------------------------------------------------
--c)
-----------------------------------------------------------------------------------
SELECT * FROM PROFESIONAL;--IDPROFESIONAL,SUELDO
SELECT * FROM UNIVERSIDAD; --IDUNIVERSIDAD,NOMBRE
SELECT * FROM PROFESION;
SELECT * FROM TITULACION; --IDPROFESIONAL,IDUNIVERIDAD,FECHA 
SELECT * FROM TITULADOS_PUCP;--PROFESION, CANTIDAD(lo tengo en la funcion)
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_TITULADOS_PUCP
AFTER INSERT ON TITULACION
FOR EACH ROW
DECLARE
    CANTIDAD NUMBER;
    NOMBRE VARCHAR2(100);
    CONTADOR NUMBER :=0;
    IDPROF NUMBER;
BEGIN
    SELECT COUNT(*) CANTIDAD, P.NOMBRE,P.IDPROFESION INTO CANTIDAD,NOMBRE,IDPROF
    FROM UNIVERSIDAD U,PROFESIONAL PF, PROFESION P
    WHERE PF.IDPROFESIONAL = :NEW.IDPROFESIONAL
    AND :NEW.IDUNIVERSIDAD = U.IDUNIVERSIDAD
    AND :NEW.IDPROFESION = P.IDPROFESION
    GROUP BY P.NOMBRE,P.IDPROFESION ;
    
    IF(CANTIDAD > 0) THEN
        IF(:NEW.IDPROFESION = :OLD.IDPROFESION) THEN
            UPDATE TITULADOS_PUCP
            SET CANTIDAD = CANTIDAD +1
            WHERE PROFESION = NOMBRE;
        ELSE
            INSERT INTO TITULADOS_PUCP VALUES (NOMBRE,CONTADOR+1);
        END IF;
    END IF;
    
END;
/
--PRUEBAS:
SELECT * FROM TITULADOS_PUCP;--PROFESION, CANTIDAD(lo tengo en la funcion)
/
insert into TITULACION
( idprofesional, idprofesion, iduniversidad, fecha )
values ( 29, 6, 2, '03/05/2023');

insert into TITULACION
( idprofesional, idprofesion, iduniversidad, fecha )
values ( 35, 6, 3, '11/05/2023');

insert into TITULACION
( idprofesional, idprofesion, iduniversidad, fecha )
values ( 42, 1, 1, '19/05/2023');