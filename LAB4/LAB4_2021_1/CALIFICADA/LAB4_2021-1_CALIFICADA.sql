--LAB4-2021-1
--PARTE CALIFICADA #TERROR

----------------------------------------------------------------------------------------------
-- PREGUNTA 1: elabore un SUBPROGRAMA (procedure o function) recibe como parametro cod evento
-- y retorna la cantidad de participantes, codigo y el nombre del responsable
-- Como me va a retornar 3 parametros, es un void -> procedure
----------------------------------------------------------------------------------------------
SELECT * FROM GE_EVENTO; -- ID_EVENTO + ID_RESPONSABLE 
SELECT * FROM GE_PERSONA_EVENTO; -- ID_EVENTO + ID_PERSONA + ASISTENCIA('A')
SELECT * FROM GE_PERSONA; -- ID_PERSONA + NOMBRES 
/
--PRIMERO CREO EL SELECT CON LO QUE ME PIDE Y LO DEJO PLANTEADO:
SELECT COUNT(*),E.ID_RESPONSABLE, P.NOMBRES||' '||P.APELLIDOS
FROM GE_EVENTO E, GE_PERSONA_EVENTO PV, GE_PERSONA P
WHERE pv.id_evento = e.id_evento
AND E.ID_RESPONSABLE = P.ID_PERSONA
AND PV.ASISTENCIA = 'A'
GROUP BY E.ID_RESPONSABLE,P.NOMBRES||' '||P.APELLIDOS;
/
CREATE OR REPLACE PROCEDURE SP_OBTENER_PARTICIPANTES_RESPONSABLE(C_ID_EVENTO NUMBER,
    C_CANTIDAD_PARTICIPANTES OUT NUMBER, C_CODIGO_RESPONSABLE OUT NUMBER, C_NOMBRE_RESPONSABLE OUT VARCHAR2)
IS --no se pone nada aca, porque va a retornar más de 1 valor y todas las variables ya estan definidas en el parametro
BEGIN 
    SELECT COUNT(*),E.ID_RESPONSABLE, P.NOMBRES||' '||P.APELLIDOS
    INTO C_CANTIDAD_PARTICIPANTES, C_CODIGO_RESPONSABLE, C_NOMBRE_RESPONSABLE
    FROM GE_EVENTO E, GE_PERSONA_EVENTO PV, GE_PERSONA P
    WHERE pv.id_evento = e.id_evento
    AND E.ID_RESPONSABLE = P.ID_PERSONA
    AND PV.ASISTENCIA = 'A'
    AND E.ID_EVENTO = C_ID_EVENTO
    GROUP BY E.ID_RESPONSABLE,P.NOMBRES||' '||P.APELLIDOS;
END;
/
--PRUEBO:
SET SERVEROUTPUT ON
DECLARE
    --DECLARO LAS VARIABLES
    C_ID_EVENTO NUMBER;
    C_CANTIDAD_PARTICIPANTES NUMBER;
    C_CODIGO_RESPONSABLE NUMBER;
    C_NOMBRE_RESPONSABLE VARCHAR2(100);
BEGIN
    C_ID_EVENTO := 3;
    SP_OBTENER_PARTICIPANTES_RESPONSABLE(C_ID_EVENTO,C_CANTIDAD_PARTICIPANTES,C_CODIGO_RESPONSABLE,C_NOMBRE_RESPONSABLE);
    dbms_output.put_line('El evento con id '||C_ID_EVENTO||' tiene '||C_CANTIDAD_PARTICIPANTES||' personas');
    dbms_output.put_line('El responsable de este evento es '||C_NOMBRE_RESPONSABLE||' con codigo '||C_CODIGO_RESPONSABLE);
END;
/
----------------------------------------------------------------------------------------------
-- PREGUNTA 2: elabora la FUNCION que permita obtener el nombre del sector con más eventos repro
----------------------------------------------------------------------------------------------
SELECT * FROM GE_SECTOR; -- ID_SECTOR + NOMOBRE_SECTOR
SELECT * FROM GE_EVENTO; -- ID_SECTOR + ESTADO ('R')

--HAGO EL SELECT PARA HALLAR LA CANTIDAD DE EVENTOS REPROGRAMADOS
SELECT COUNT(*) CONT, S.NOMBRE_SECTOR NOMBRE
FROM GE_EVENTO E, GE_SECTOR S
WHERE E.ESTADO = 'R'
AND s.id_sector = e.id_sector
GROUP BY S.NOMBRE_SECTOR
ORDER BY CONT DESC; -- DE MAYOR A MENOR

--HAGO SELECT PARA HALLAR SOLO NOMBRE DEL SECTOR QUE TIENE + EVENTOS R
SELECT X.NOMBRE 
FROM (  SELECT COUNT(*) CONT, S.NOMBRE_SECTOR NOMBRE
        FROM GE_EVENTO E, GE_SECTOR S
        WHERE E.ESTADO = 'R'
        AND s.id_sector = e.id_sector
        GROUP BY S.NOMBRE_SECTOR
        ORDER BY CONT DESC)X
WHERE ROWNUM = 1 --PARA QUE ME DE EL MAYOR
;

CREATE OR REPLACE FUNCTION FN_OBTENER_SECTOR_TOP
RETURN VARCHAR2 AS
    C_NOMBRE_SECTOR VARCHAR2 (100);
BEGIN
    SELECT X.NOMBRE INTO C_NOMBRE_SECTOR
    FROM (  SELECT COUNT(*) CONT, S.NOMBRE_SECTOR NOMBRE
            FROM GE_EVENTO E, GE_SECTOR S
            WHERE E.ESTADO = 'R'
            AND s.id_sector = e.id_sector
            GROUP BY S.NOMBRE_SECTOR
            ORDER BY CONT DESC)X
    WHERE ROWNUM = 1; --PARA QUE ME DE EL MAYOR
    RETURN C_NOMBRE_SECTOR;
END;
/
--PRUEBO:
DECLARE
  C_NOMBRE_SECTOR VARCHAR2(100);
BEGIN
  C_NOMBRE_SECTOR := FN_OBTENER_SECTOR_TOP;
  DBMS_OUTPUT.PUT_LINE('El sector con más eventos es: ' || C_NOMBRE_SECTOR);
END;
/
----------------------------------------------------------------------------------------------
-- PREGUNTA 3: elabore SUBPROGRAMA que recibe el mes como texto y el estado
-- con ello actualice todos los eventos registrados en dicho mes con el nuevo estado 
-- y actualice la fecha de actualizacion
----------------------------------------------------------------------------------------------
SELECT * FROM GE_EVENTO; -- ESTADO + FECHA_ACTUALIZACION
SELECT * FROM GE_RESULTADO; 
/
CREATE OR REPLACE PROCEDURE SP_ACTUALIZA_EVENTO (C_MES VARCHAR2, C_ESTADO CHAR)
AS
    --como en el mes son muchos datos, mejor creo una variable que me ayude a hacerlo más rapido
    C_MES_NUMERO NUMBER;
BEGIN
    --COMO SON VARIOS DATOS PUEDO USAR UN CASE
    CASE C_MES
        WHEN 'ENERO' THEN C_MES_NUMERO := 1;
        WHEN 'FEBRERO' THEN C_MES_NUMERO := 2;
        WHEN 'MARZO' THEN C_MES_NUMERO := 3;
        WHEN 'ABRIL' THEN C_MES_NUMERO := 4;
        WHEN 'MAYO' THEN C_MES_NUMERO := 5;
        WHEN 'JUNIO' THEN C_MES_NUMERO := 6;
        WHEN 'JULIO' THEN C_MES_NUMERO := 7;
        WHEN 'AGOSTO' THEN C_MES_NUMERO := 8;
        WHEN 'SETIEMBRE' THEN C_MES_NUMERO := 9;
        WHEN 'OCTUBRE' THEN C_MES_NUMERO := 10;
        WHEN 'NOVIEMBRE' THEN C_MES_NUMERO := 11;
        else C_MES_NUMERO := 12;
    END CASE;
    --AHORA ACTUALIZO LAS VARIABLES
    UPDATE GE_EVENTO
    SET ESTADO = C_ESTADO, FECHA_ACTUALIZACION = SYSDATE
    WHERE TO_NUMBER(TO_CHAR(FECHA_HORA_INICIO,'MM')) = C_MES_NUMERO;
END;
/
----------------------------------------------------------------------------------------------
-- PREGUNTA 4: elabore un SUBPROGRAMA que reciba el codResponsable y el codEvento. 
-- con ellos retorne el nombre del evento, fecha, nombre del sector, nombre de la categoria
-- nombre del responsable, enlace del evento (si no es V mostrar ---)
----------------------------------------------------------------------------------------------
SELECT * FROM GE_EVENTO; --VIRTUAL (1) + NOMBRE + FECHA_HORA_INICIO + ID_SECTOR + ID_TIPO_EVENTO + ENLACE
SELECT * FROM GE_SECTOR; -- ID_SECTOR + NOMBRE_SECTOR
SELECT * FROM GE_TIPO_EVENTO; -- ID_TIPO_EVENTO + ID_CATEGORIA_EVENTO
SELECT * FROM GE_CATEGORIA_EVENTO; -- ID_CATEGORIA_EVENTO + NOMBRE_CATEGORIA 
SELECT * FROM GE_PERSONA; --ID_PERSONA + NOMBRES
/
--HAGO EL SELECT:
SELECT  E.NOMBRE, E.FECHA_HORA_INICIO, S.NOMBRE_SECTOR, C.NOMBRE_CATEGORIA, P.NOMBRES, NVL(E.ENLACE,'---')
FROM GE_EVENTO E, GE_SECTOR S, GE_TIPO_EVENTO T, GE_CATEGORIA_EVENTO C, GE_PERSONA P
WHERE t.id_tipo_evento = e.id_tipo_evento AND T.ID_CATEGORIA_EVENTO = c.id_categoria_evento
AND E.ID_SECTOR = S.ID_SECTOR AND P.ID_PERSONA = E.ID_RESPONSABLE;
AND E.ID_EVENTO = C_COD_EVENTO AND P.ID_PERSONA = C_COD_RESPONSABLE; --estos datos son los que estoy ingresando

/
CREATE OR REPLACE PROCEDURE SP_INFO_EVENTO (C_COD_RESPONSABLE NUMBER, C_COD_EVENTO NUMBER,
    C_NOMBRE_EVENTO OUT VARCHAR2, C_FECHA OUT DATE, C_NOMBRE_SECTOR OUT VARCHAR2,
    C_NOMBRE_CATEGORIA OUT VARCHAR2, C_NOMBRE_RESPONSABLE OUT VARCHAR2, C_ENLACE OUT VARCHAR2)
AS --NO PONGO NADA ACA PORQUE TODO ESTÁ DECLARADO
BEGIN 
    SELECT  E.NOMBRE, E.FECHA_HORA_INICIO, S.NOMBRE_SECTOR, C.NOMBRE_CATEGORIA, P.NOMBRES, NVL(E.ENLACE,'---')
    INTO C_NOMBRE_EVENTO, C_FECHA, C_NOMBRE_SECTOR, C_NOMBRE_CATEGORIA, C_NOMBRE_RESPONSABLE, C_ENLACE --VALORES A RETORNAR
    FROM GE_EVENTO E, GE_SECTOR S, GE_TIPO_EVENTO T, GE_CATEGORIA_EVENTO C, GE_PERSONA P
    WHERE t.id_tipo_evento = e.id_tipo_evento AND T.ID_CATEGORIA_EVENTO = c.id_categoria_evento
    AND E.ID_SECTOR = S.ID_SECTOR AND P.ID_PERSONA = E.ID_RESPONSABLE
    AND E.ID_EVENTO = C_COD_EVENTO;--estos datos son los que estoy ingresando
END;
/
--PRUEBO:
set serveroutput ON
DECLARE 
    C_COD_RESPONSABLE NUMBER;
    C_COD_EVENTO NUMBER;
    C_NOMBRE_EVENTO VARCHAR2(70);
    C_FECHA DATE;
    C_NOMBRE_SECTOR VARCHAR2(70);
    C_NOMBRE_CATEGORIA VARCHAR2(70);
    C_NOMBRE_RESPONSABLE VARCHAR2(80);
    C_ENLACE VARCHAR2(100);
    
BEGIN --le doy valor a las variables
    C_COD_RESPONSABLE := 2;
    C_COD_EVENTO := 4;
    SP_INFO_EVENTO (C_COD_RESPONSABLE, C_COD_EVENTO,C_NOMBRE_EVENTO, C_FECHA, C_NOMBRE_SECTOR,
    C_NOMBRE_CATEGORIA , C_NOMBRE_RESPONSABLE , C_ENLACE );
    dbms_output.put_line('La persona con cod '||C_COD_RESPONSABLE||' es responsable del evento '||C_COD_EVENTO);
    dbms_output.put_line('Fue responsable del evento '||C_NOMBRE_EVENTO||' el dia '||C_FECHA);
    dbms_output.put_line('El sector fue '||C_NOMBRE_SECTOR||' con categoria '||C_NOMBRE_CATEGORIA);
    dbms_output.put_line('La responsable fue '||C_NOMBRE_RESPONSABLE||' e hizo el evento por '||C_ENLACE);
END;
/
----------------------------------------------------------------------------------------------
-- PREGUNTA 5: elabora funcion FN_CADENA_DATOS_EVENTO que reciba como parametro el codEvento y 
-- retorne la cadena donde cada campo estará separada 
----------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION FN_CADENA_DATOS_EVENTO(C_COD_EVENTO NUMBER)
RETURN VARCHAR2
IS
    --PRIMERO PREGUNTO QUE NECESITO Y QUE QUIERO QUE ME DEVUELVA
    C_NOMBRE_EVENTO VARCHAR2(70);
    --ME PIDE PONER LA FECHA COMO CADENA, ENTONCES TENGO QUE SEPARARLA EN NMRS Y DPS PASARLO A CHAR
    C_D NUMBER;
    C_M NUMBER;
    C_A NUMBER;
    C_DIA VARCHAR2(2); --DIA ESCRITO
    C_MES VARCHAR2(20); --MES ESCRITO
    C_AÑO VARCHAR2(4); --AÑO ESCRITO
    C_FECHACOMPLETA VARCHAR2(30); --COMPLETO
    C_FECHA DATE;
    C_NOMBRE_SECTOR VARCHAR2(70);
    C_NOMBRE_CATEGORIA VARCHAR2(70);
    C_CANTIDAD NUMBER;
    C_ENLACE VARCHAR2(100);
    C_CODIGO_RESP NUMBER;
    C_NOMBRE_R VARCHAR2(100);
    C_CADENADATOS VARCHAR2(200);

BEGIN 
    SP_OBTENER_PARTICIPANTES_RESPONSABLE(
        C_ID_EVENTO => C_COD_EVENTO,
        C_CANTIDAD_PARTICIPANTES => C_CANTIDAD,
        C_CODIGO_RESPONSABLE => C_CODIGO_RESP,
        C_NOMBRE_RESPONSABLE => C_NOMBRE_R
    );
    
    SP_INFO_EVENTO (
    C_COD_RESPONSABLE => C_CODIGO_RESP,
    C_COD_EVENTO => C_COD_EVENTO,
    C_NOMBRE_EVENTO => C_NOMBRE_EVENTO,
    C_FECHA => C_FECHA,
    C_NOMBRE_SECTOR => C_NOMBRE_SECTOR,
    C_NOMBRE_CATEGORIA => C_NOMBRE_CATEGORIA,
    C_NOMBRE_RESPONSABLE => C_NOMBRE_R,
    C_ENLACE => C_ENLACE
    );
    
    --2DO: saco los datos a evaluar del dato que paso por parametro
    C_D := EXTRACT( DAY FROM C_FECHA);
    C_M := EXTRACT (MONTH FROM C_FECHA);
    C_A := EXTRACT (YEAR FROM C_FECHA);
    
    CASE C_M
        WHEN 1 THEN C_MES := 'ENERO';
        WHEN 2 THEN C_MES := 'FEBRERO';
        WHEN 3 THEN C_MES := 'MARZO';
        WHEN 4 THEN C_MES := 'ABRIL';
        WHEN 5 THEN C_MES := 'MAYO';
        WHEN 6 THEN C_MES := 'JUNIO';
        WHEN 7 THEN C_MES := 'JULIO';
        WHEN 8 THEN C_MES := 'AGOSTO';
        WHEN 9 THEN C_MES := 'SETIEMBRE';
        WHEN 10 THEN C_MES := 'OCTUBRE';
        WHEN 11 THEN C_MES := 'NOVIEMBRE';
        ELSE C_MES := 'DICIEMBRE';
    END CASE;
    
    --AHORA PASO LOS DATOS A VARCHAR2
    C_DIA := TO_CHAR (C_D); --estos los paso pq son numeros
    C_AÑO := TO_CHAR (C_A); --estos los paso pq son numeros
    C_FECHACOMPLETA := C_DIA || ' DE '||C_MES||' DEL '||C_AÑO; --junto los datos
    
    --ARMO LA CADENA COMPLETA:
    C_CADENADATOS := C_NOMBRE_EVENTO||' '||C_FECHACOMPLETA||' '||C_NOMBRE_SECTOR||' '||C_NOMBRE_CATEGORIA||' '||C_CANTIDAD;
    
    RETURN C_CADENADATOS;
    
END;
/
--PRUEBA:
SELECT FN_CADENA_DATOS_EVENTO(4) FROM DUAL;

----------------------------------------------------------------------------------------------
-- FINALIZADO :)
----------------------------------------------------------------------------------------------