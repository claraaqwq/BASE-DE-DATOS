--LAB4 2022-1
--PARTE DIRIGIDA

-----------------------------------------------------------------------------------
--EJERCICIO 1: elabora una FUNCTION (int) que recibe nombre de un distrito (municipio)
--y que devuelve la cantidad de empleados que viven en él
-----------------------------------------------------------------------------------
SELECT * FROM EMPLEADOS; -- DNI + MUNICIPIO
/
--Hago select de cant de empleados que viven en distrito X
SELECT COUNT(*) AS CANT
FROM EMPLEADOS
WHERE MUNICIPIO = 'Chorrillos';
/
CREATE OR REPLACE FUNCTION F_CONTAR_PERSONAS_X_MUNICIPIO (D_NOMBRE_DISTRITO VARCHAR2)
RETURN NUMBER
AS
    D_CANT_PERSONAS NUMBER;
BEGIN
    SELECT COUNT(*) INTO D_CANT_PERSONAS
    FROM EMPLEADOS
    WHERE MUNICIPIO = D_NOMBRE_DISTRITO; --comparo los nombres del distrito
    RETURN D_CANT_PERSONAS;
END;
/
--PRUEBO: 
SET SERVEROUTPUT ON
DECLARE
    D_NOMBRE_DISTRITO VARCHAR2(20);
    D_CANT_PERSONAS NUMBER;
BEGIN --Primero realizo esto para guiarme que cosas voy a declarar
    D_NOMBRE_DISTRITO:= 'Chorrillos';
    D_CANT_PERSONAS := F_CONTAR_PERSONAS_X_MUNICIPIO(D_NOMBRE_DISTRITO);
    --IMPRIMO: 
    dbms_output.put_line ('Hay '||D_CANT_PERSONAS||' empleados en el distrito '||D_NOMBRE_DISTRITO);
END;
/
-----------------------------------------------------------------------------------
--EJERCICIO 2:
--a) recibe como parametro una fecha y la devuelve en forma de frase.
--b) recibe una fecha de nacimiento y te devuelve la edad, para ello necesito la ant
-----------------------------------------------------------------------------------
SELECT * FROM EMPLEADOS; -- FECHA_NACIMIENTO
/
--a)
CREATE OR REPLACE FUNCTION devolver_fecha_frase (D_FECHA DATE)
RETURN VARCHAR2
IS
    --Pregunto que necesitaré y que retornaré
    --(12/05/2004) -> 12 DE MAYO DEL 2022
    D_D NUMBER;
    D_M NUMBER;
    D_A NUMBER;
    --LO PASARÉ A TEXTO
    D_DIA VARCHAR2(10);
    D_MES VARCHAR2(20);
    D_AÑO VARCHAR2(20);
    --JUNTARÉ EL TEXTO
    D_FECHA_COMPLETA VARCHAR2(50);
BEGIN
    --EXTRAIGO LOS DATOS DEL PARAMETRO
    D_D := EXTRACT(DAY FROM D_FECHA);
    D_M := EXTRACT(MONTH FROM D_FECHA);
    D_A := EXTRACT(YEAR FROM D_FECHA);
    --AHORA PASO LOS MESES A UN VARCHAR (USO CASE, PQ SON DMS)
    CASE D_M 
        WHEN 1 THEN D_MES := 'ENERO';
        WHEN 2 THEN D_MES := 'FEBRERO';
        WHEN 3 THEN D_MES := 'MARZO';
        WHEN 4 THEN D_MES := 'ABRIL';
        WHEN 5 THEN D_MES := 'MAYO';
        WHEN 6 THEN D_MES := 'JUNIO';
        WHEN 7 THEN D_MES := 'JULIO';
        WHEN 8 THEN D_MES := 'AGOSTO';
        WHEN 9 THEN D_MES := 'SETIEMBRE';
        WHEN 10 THEN D_MES := 'OCTUBRE';
        WHEN 11 THEN D_MES := 'NOVIEMBRE';
        ELSE D_MES := 'DICIEMBRE';
    END CASE;
    --AHORA PASO LOS DATOS QUE ME FALTAN A VARCHAR2
    D_DIA := TO_CHAR(D_D);
    D_AÑO := TO_CHAR(D_A);
    --AHORA JUNTO TODA LA FECHA
    D_FECHA_COMPLETA := D_DIA || ' DE '||D_MES||' DEL '||D_AÑO; --junto los datos
    RETURN D_FECHA_COMPLETA;
END;
/
--PRUEBO: 
SELECT APELLIDO1 || ' ' ||APELLIDO2|| ' ' ||NOMBRE AS EMPLEADO,
    devolver_fecha_escrita(FECHA_NAC) AS FECHA_NACIMIENTO
FROM EMPLEADOS;
/
--b)
CREATE OR REPLACE FUNCTION DEVOLVER_EDAD (D_FECHA_NACIMIENTO DATE)
RETURN NUMBER
IS
    D_MESES NUMBER;
    D_EDAD NUMBER;
BEGIN
    --PARA HALLAR EL AÑO NECESITO TENER TODOS LOS MESES QUE PASARON ENTRE 2 FECHAS
    D_MESES := MONTHS_BETWEEN(SYSDATE,D_FECHA_NACIMIENTO);
    --PARA HALLAR LA EDAD SOLO LA DIVIDO ENTRE 12, PARA TENER LOS AÑOS Q PASARON
    D_EDAD := TRUNC(D_MESES/12);
    RETURN D_EDAD;
END;
/
--PRUEBO: 
SELECT APELLIDO1 || ' ' ||APELLIDO2|| ' ' ||NOMBRE AS EMPLEADO,
    devolver_fecha_escrita(FECHA_NAC) AS FECHA_NACIMIENTO,
    devolver_edad(FECHA_NAC) as EDAD
FROM EMPLEADOS;
/
-----------------------------------------------------------------------------------
--EJERCICIO 3: elabore un PRODEDURE que recibe el nombre de la universidad y que
--muestre la cantidad de personas que han estudiado en dicha universidad.
--Si el nombre de la u no está en la base de datos, se muestra mensaje de error
-----------------------------------------------------------------------------------
SELECT * FROM ESTUDIOS; --EMPLEADO_DNI + UNIVERSIDAD (CODIGO)
SELECT * FROM UNIVERSIDADES; -- UNIV_COD + NOMBRE_UNIV;
/
--HAGO EL SELECT QUE ME DEVUELVA LOS VALORES QUE ME PIDEN: ejemplo x
SELECT COUNT(*)
FROM ESTUDIOS E, UNIVERSIDADES U
WHERE E.UNIVERSIDAD = u.univ_cod
AND U.NOMBRE_UNIV = 'Catolica del Peru';
/
CREATE OR REPLACE PROCEDURE CANT_PERSONAS_X_UNIVERSIDAD (D_NOMBRE_UNI VARCHAR2)}
IS
    CANTIDAD_PERSONAS NUMBER;
BEGIN
    --HAGO EL SELECT QUE ME DEVUELVA LOS VALORES QUE ME PIDEN: ejemplo x
    SELECT COUNT(*) INTO CANTIDAD_PERSONAS
    FROM ESTUDIOS E, UNIVERSIDADES U
    WHERE U.NOMBRE_UNIV = D_NOMBRE_UNI;
    IF CANTIDAD_PERSONAS = 0 THEN
        dbms.put
    ELSE
        SELECT COUNT(*) INTO CANTIDAD_PERSONAS
        FROM ESTUDIOS E, UNIVERSIDADES U
        WHERE E.UNIVERSIDAD = u.univ_cod
        AND U.NOMBRE_UNIV = D_NOMBRE_UNI;
        dbms_output.put_line('Hay '||CANTIDAD_PERSONAS||' en la universidad '||D_NOMBRE_UNI);
    END IF;
END;

-----------------------------------------------------------------------------------
--EJERCICIO 4:
-----------------------------------------------------------------------------------


-----------------------------------------------------------------------------------
--EJERCICIO 5:
-----------------------------------------------------------------------------------


-----------------------------------------------------------------------------------
--EJERCICIO 6:
-----------------------------------------------------------------------------------


-----------------------------------------------------------------------------------
--EJERCICIO 7:
-----------------------------------------------------------------------------------




-----------------------------------------------------------------------------------
--FINALIZADO :)
-----------------------------------------------------------------------------------
