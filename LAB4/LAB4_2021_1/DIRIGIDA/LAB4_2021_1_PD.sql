--LAB4 2021-2
--PARTE DIRIGIDA

set SERVEROUTPUT ON;

-----------------------------------------------------------------------------------
--EJERCICIO 1:
--Devolver cantidad de personas que tienen el sexo que recibirá el parametro
-----------------------------------------------------------------------------------

--HAGO EL SELECT:
SELECT * FROM PERSONA; --sexo = M o F

SELECT COUNT(*) INTO V_CANTIDAD --nombre de la variable que retornará
FROM PERSONA
WHERE SEXO = V_SEXO;
return V_CANTIDAD;

--ES COMO UN INT 
CREATE OR REPLACE FUNCTION f_contar_personas_por_sexo (V_SEXO CHAR)
RETURN NUMBER --retornará una cant de personas
AS
    V_CANTIDAD NUMBER;
BEGIN
    IF V_SEXO <> 'M' AND V_SEXO <> 'F' THEN
        RETURN -1;
    ELSE
        SELECT COUNT(*) INTO V_CANTIDAD --nombre de la variable que retornará
        FROM PERSONA
        WHERE SEXO = V_SEXO;
        return V_CANTIDAD;
    END IF;
END;

--AHORA PRUEBO EL PROGRAMA
DECLARE --declaro las variables que estoy usando
    V_CANTIDAD NUMBER; --esta porque es la variable que retorno
    V_SEXO CHAR; --esta porque es la variable que estoy pasando como parametro
BEGIN
    V_SEXO := 'F';
    V_CANTIDAD := f_contar_personas_por_sexo(V_SEXO);
    IF V_CANTIDAD <> -1 THEN --caso si encuentré la cantidad
        dbms_output.put_line('Hay '||v_cantidad||' personas de sexo '||v_sexo);
    ELSE
        dbms_output.put_line('Sexo no Valido');
    END IF;
END;
/
-----------------------------------------------------------------------------------
--EJERCICIO 2:
--a) Elaborar funcion que reciba como parametro la fecha y que la devuelva en forma escrita (INT-FUNCTION)
--b) Elaborar funcion que reciba como parametro una fecha de nacimiento y que retorne la edad (INT.FUNCTION)
-----------------------------------------------------------------------------------

--PARA LA A: 
SELECT * FROM PERSONA;
/
CREATE OR REPLACE FUNCTION devolver_fecha_escrita (V_FECHA DATE)
RETURN VARCHAR2 --como será escrito es un varchar2
IS
    --Primero te preguntas que necesitas y luego que quieres que te devuelva
    V_D NUMBER; --DIA
    V_M NUMBER; --MES
    V_A NUMBER; --ANIO
    V_DIA VARCHAR2(2); --DIA ESCRITO
    V_MES VARCHAR2(20); --MES ESCRITO
    V_AÑO VARCHAR2(4); --AÑO ESCRITO
    V_FRASE VARCHAR2(30); --COMPLETO
BEGIN
    --2DO: saco los datos a evaluar del dato que paso por parametro
    V_D := EXTRACT( DAY FROM V_FECHA);
    V_M := EXTRACT (MONTH FROM V_FECHA);
    V_A := EXTRACT (YEAR FROM V_FECHA);
    --COMO SON VARIOS DATOS PUEDO USAR UN CASE
    CASE V_M
        WHEN 1 THEN V_MES := 'ENERO';
        WHEN 2 THEN V_MES := 'FEBRERO';
        WHEN 3 THEN V_MES := 'MARZO';
        WHEN 4 THEN V_MES := 'ABRIL';
        WHEN 5 THEN V_MES := 'MAYO';
        WHEN 6 THEN V_MES := 'JUNIO';
        WHEN 7 THEN V_MES := 'JULIO';
        WHEN 8 THEN V_MES := 'AGOSTO';
        WHEN 9 THEN V_MES := 'SETIEMBRE';
        WHEN 10 THEN V_MES := 'OCTUBRE';
        WHEN 11 THEN V_MES := 'NOVIEMBRE';
        ELSE V_MES := 'DICIEMBRE';
    END CASE;
    --AHORA PASO LOS DATOS A VARCHAR2
    V_DIA := TO_CHAR (V_D); --estos los paso pq son numeros
    V_AÑO := TO_CHAR (V_A); --estos los paso pq son numeros
    V_FRASE := V_DIA || ' DE '||V_MES||' DEL '||V_AÑO; --junto los datos
    return V_FRASE; --devuelvo la frase
END;
/
--Prueba:
SELECT APELLIDO_PATERNO || ' ' ||APELLIDO_MATERNO|| ' ' ||NOMBRES AS EMPLEADO,
    devolver_fecha_escrita(FECHA_NACIMIENTO) AS FECHA_NACIMIENTO
FROM PERSONA;
/
--PARA LA B:
CREATE OR REPLACE FUNCTION f_obtener_edad (V_FECHA_NACIMIENTO date)
RETURN NUMBER
IS
    V_EDAD NUMBER;
    V_MESES NUMBER;
BEGIN 
    V_MESES := MONTHS_BETWEEN(SYSDATE,V_FECHA_NACIMIENTO);
    V_EDAD := TRUNC(V_MESES/12);
    return V_EDAD;
END;
/
--Prueba:
SELECT APELLIDO_PATERNO || ' ' ||APELLIDO_MATERNO|| ' ' ||NOMBRES AS EMPLEADO,
    devolver_fecha_escrita(FECHA_NACIMIENTO) AS FECHA_NACIMIENTO,
    f_obtener_edad(FECHA_NACIMIENTO) AS EDAD
FROM PERSONA;
/
-----------------------------------------------------------------------------------
--EJERCICIO 3: elaborar PROCEDIMIENTO (procedure) que recibe el nombre de un cargo
--y que muestre en pantalla la cantidad de personas que han tenido o tienen dicho rango
-----------------------------------------------------------------------------------
SELECT * FROM PERSONA; --NOMBRES + APELLIDO_PATERNO + APELLIDO_MATERNO + ID_PERSONA
SELECT * FROM PERSONAL; -- ID_CARGO
SELECT * FROM CARGO; --NOMBRE + ID_CARGO
/
--PRIMERO HAGO EL SELECT 
SELECT COUNT(*) 
FROM PERSONAL P, CARGO C
WHERE p.id_cargo = c.id_cargo
AND C.NOMBRE = V_NOMBRE_CARGO;
/
CREATE OR REPLACE PROCEDURE P_CANTIDAD_PERSONAS_CARGO(V_NOMBRE_CARGO VARCHAR2)
AS 
    V_CANTIDAD_CARGO NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_CANTIDAD_CARGO
    FROM PERSONAL P, CARGO C
    WHERE p.id_cargo = c.id_cargo
    AND C.NOMBRE = V_NOMBRE_CARGO;
    --QUE VA A IMPRIMIR, ES COMO UN COUT
    dbms_output.put_line('La cantidad de personas con rango '|| V_NOMBRE_CARGO ||' son: '||V_CANTIDAD_CARGO);
END;
/
--PRUEBO:
set SERVEROUTPUT ON
EXEC P_CANTIDAD_PERSONAS_CARGO('Analista Programador');
/
-----------------------------------------------------------------------------------
--EJERCICIO 4: elaborar un PROCEDIMIENTO (PROCEDURE), que recibe el apellido P, 
--apellido M, nombre; y que muestre el cargo de la persona de la empresa.
--Si la persona no existe que muestre un mensaje de error
-----------------------------------------------------------------------------------
SELECT * FROM PERSONA; --NOMBRES + APELLIDO_PATERNO + APELLIDO_MATERNO + ID_PERSONA
SELECT * FROM PERSONAL; -- ID_CARGO
SELECT * FROM CARGO; --NOMBRE + ID_CARGO
/
--PRIMERO HAGO EL SELECT 
SELECT C.NOMBRE
FROM PERSONA P, PERSONAL PS, CARGO C
WHERE ps.id_persona = p.id_persona
AND ps.id_cargo = c.id_cargo
AND APELLIDO_PATERNO = V_APELLIDOP
AND APELLIDO_MATERNO = V_APELLIDOM
AND NOMBRES = V_NOMBRE;
/
CREATE OR REPLACE PROCEDURE P_MOSTRAR_CARGO_PERSONA(V_APELLIDOP VARCHAR2, V_APELLIDOM VARCHAR2, V_NOMBRE VARCHAR2)
IS --es como el return
    V_NOMBRE_CARGO VARCHAR2(50);
BEGIN
    SELECT C.NOMBRE INTO V_NOMBRE_CARGO
    FROM PERSONA P, PERSONAL PS, CARGO C
    WHERE ps.id_persona = p.id_persona
    AND ps.id_cargo = c.id_cargo
    AND APELLIDO_PATERNO = V_APELLIDOP
    AND APELLIDO_MATERNO = V_APELLIDOM
    AND NOMBRES = V_NOMBRE;
    dbms_output.put_line(V_NOMBRE||' '||V_APELLIDOP||' '||V_APELLIDOM|| ' ' ||'tiene el cargo de '||V_NOMBRE_CARGO);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existe la persona o no tiene cargo asignado');
END;
/
--MUESTRO:
SET SERVEROUTPUT ON
EXEC P_MOSTRAR_CARGO_PERSONA('RODRIGUEZ','VERA','FRANCISCA');
EXEC P_MOSTRAR_CARGO_PERSONA('MORALES','TORRES','ELVIRA');

-----------------------------------------------------------------------------------
--EJERCICIO 5: NO SE IMPRIME NADA -> SE CAMBIA UN DATO EN LAS TABLAS
--elaborar un PROCEDIMIENTO (procedure) que recibe el nombre de un area
--de la empresa y un monto de dinero. Se debe incrementar en ese monto el sueldo basico
--al personal que perteneza a esa area cuya feha de fin de contrato sea definida
-----------------------------------------------------------------------------------
SELECT * FROM PERSONAL; --FECHA_FIN (NULL) + SUELDO_BASICO + ID_AREA
SELECT * FROM AREA; --ID_AREA

--HAGO EL SELECT: primero valido que el area exista, si existe le sumo el sueldo
SELECT ID_AREA INTO V_ID_AREA
FROM AREA
WHERE NOMBRE = V_NOMBRE_AREA;
UPDATE PERSONAL
SET SUELDO_BASICO = sueldo_basico + V_MONTO
WHERE ID_AREA = V_ID_AREA AND FECHA_FIN IS NULL;
/
CREATE OR REPLACE PROCEDURE P_INCREMENTAR_SUELDO(V_NOMBRE_AREA VARCHAR2, V_MONTO NUMBER)
IS --DECLARA VARIABLES QUE FALTAN
    V_ID_AREA NUMBER;
BEGIN
    SELECT ID_AREA INTO V_ID_AREA
    FROM AREA
    WHERE NOMBRE = V_NOMBRE_AREA;
    UPDATE PERSONAL
    SET SUELDO_BASICO = sueldo_basico + V_MONTO
    WHERE ID_AREA = V_ID_AREA AND FECHA_FIN IS NULL;
EXCEPTION   
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Area '||V_NOMBRE_AREA||' no existe');
END;
/
--ejemplo:
select * from PERSONAL where id_area = 4;
--Ejecuto el procedimiento: aumentar 200 al sueldo del area imagen xxx
EXEC P_INCREMENTAR_SUELDO('Imagen Institucional',200);
--observamos cambios:
select * from PERSONAL where id_area = 4;

-----------------------------------------------------------------------------------
--EJERCICIO 6: elaborar un PROCEDIMIENTO (procedure) que devuelva 2 valores : 
--menor sueldo basico + cant de personas que tienen ese sueldo
--Solo considerar aquellas cuyo contrato tiene una fecha de finalizacion
-----------------------------------------------------------------------------------
SELECT * FROM PERSONAL; --SUELDO_BASICO + ID_PERSONA

--HAGO EL SELECT : PRIMERO UNO PARA HALLAR EL MENOR SUELDO BASICO Y EL OTRO PARA HALLAR EL COUNT
SELECT MIN(SUELDO_BASICO) INTO V_MIN_SUELDO
FROM PERSONAL;
SELECT COUNT(*)
FROM PERSONAL
WHERE SUELDO_BASICO = V_MIN_SUELDO
AND FECHA_FIN IS NOT NULL;

/
CREATE OR REPLACE PROCEDURE P_OBTENER_MENOR_SUELDO(V_MIN_SUELDO OUT NUMBER, V_CANTIDAD_PERSONAS OUT NUMBER)
is
BEGIN
    SELECT MIN(SUELDO_BASICO) INTO V_MIN_SUELDO
    FROM PERSONAL
    WHERE FECHA_FIN IS NOT NULL;
    SELECT COUNT(*) INTO V_CANTIDAD_PERSONAS
    FROM PERSONAL
    WHERE SUELDO_BASICO = V_MIN_SUELDO
    AND FECHA_FIN IS NOT NULL;  
END;
/
--PRUEBA:
set serveroutput ON
DECLARE 
    V_MIN_SUELDO NUMBER;
    V_CANTIDAD_PERSONAS NUMBER;
BEGIN --le doy valor a las variables
    P_OBTENER_MENOR_SUELDO(V_MIN_SUELDO, V_CANTIDAD_PERSONAS);
    dbms_output.put_line('El menor sueldo basico es '||V_MIN_SUELDO);
    dbms_output.put_line('Hay '||v_CANTIDAD_PERSONAS||' personas con ese sueldo');
END;
/
--TAMBIEN SE PUEDE VERIFICAR CREANDO UNA TABLITA:
SELECT SUELDO_BASICO AS MINSUELDO, COUNT(*) AS CANTIDADPERSONAS
FROM PERSONAL
WHERE SUELDO_BASICO = (SELECT MIN(SUELDO_BASICO) AS SUELDITO
      FROM PERSONAL)
AND FECHA_FIN IS NOT NULL
GROUP BY SUELDO_BASICO;

--------------------------------------------------------------------------
--TERMINADO :)
--------------------------------------------------------------------------

