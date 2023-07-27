--LABORATORIO 5
--2021-1
--DIRIGIDA
SET SERVEROUTPUT ON
/
----------------------------------------------------------------------------------
--PREGUNTA 1: funcion que calcule la bonificacion sobre el sueldo basico de un 
--empleado 
----------------------------------------------------------------------------------
SELECT * FROM PERSONAL;--SUELDO_BONIFICACION
/
CREATE OR REPLACE FUNCTION FN_CALCULAR_BONIF(P_ID_CARGO NUMBER, P_SUELDO NUMBER)
RETURN NUMBER
IS
BEGIN
    IF P_ID_CARGO IN (1,2,3,4) THEN
        RETURN P_SUELDO * 1.2;
    END IF;
    IF P_ID_CARGO IN (5,6,7,8) THEN
        RETURN P_SUELDO * 1.15;
    END IF;
    IF P_ID_CARGO IN (9,10,11) THEN
        RETURN P_SUELDO * 1.1;
    END IF;
    RETURN 0; --CASO INGRESE UN ID_CARGO QUE NO EXISTE
END;
/
SELECT FN_CALCULAR_BONIF(1,25000) AS BONIFICACION
FROM DUAL;
/
----------------------------------------------------------------------------------
--PREGUNTA 1: crear procedimiento que recorra la tabla CARGOS todos los registros
--de la tabla PERSONAL, para calcular y actualizar el valor del SUELDO_BONIFICACION
----------------------------------------------------------------------------------
SELECT * FROM CARGO;--ID_CARGO
SELECT * FROM PERSONAL; --sueldo_bonificacion, ID_CARGO
/
CREATE OR REPLACE PROCEDURE PR_CALCULAR_BONIF
IS
    --creo cursor que recorra la tabla cargo
    CURSOR C_CARGO IS
        SELECT ID_CARGO
        FROM CARGO
        WHERE ESTADO = 'A';
BEGIN
--abro el cursor
FOR RCARGO IN C_CARGO
    LOOP
        UPDATE PERSONAL 
        SET SUELDO_BONIFICACION = FN_CALCULAR_BONIF(RCARGO.ID_CARGO,SUELDO_BASICO)
        WHERE ID_CARGO = RCARGO.ID_CARGO;
    END LOOP;
END;
/
EXEC PR_CALCULAR_BONIF();
/
SELECT * FROM PERSONAL;
/
----------------------------------------------------------------------------------
--PREGUNTA 1: crear un procedimiento que recorra la tabla TIPO_DOCUMENTO y agregue
--al numero de documento la letra P (pasaporte), C (Carnet de Extranjeria),
--tambien debe recorrer la tabla PERSONA y si son peruanas debe imprimir sus datos
--nombres,telefono,fecha inicio de laborar, además se le debe agregar +51 en el telef
----------------------------------------------------------------------------------
SELECT * FROM TIPO_DOCUMENTO;--ID_TIPO_DOCUMENTO,NOMBRE,ESTADO
SELECT * FROM PERSONA;--ID_TIPO_DOCUMENTO, ID_PERSONA
SELECT * FROM PERSONAL; --ID_PERSONA, FECHA_INICIO
/
CREATE OR REPLACE PROCEDURE PR_TIPO_DOCUMENTO
IS
    --cursor que recorra el tipo_documento 
    CURSOR C_TIPO_DOC IS
        SELECT ID_TIPO_DOCUMENTO 
        FROM TIPO_DOCUMENTO
        WHERE ESTADO = 'A';
    --cursor que recorra la tabla persona
    CURSOR C_PERSONA (H_ID_TIPO_DOCUMENTO NUMBER) IS
        SELECT P.NOMBRES, P.TELEFONO, PE.FECHA_INICIO
        FROM PERSONA P, PERSONAL PE
        WHERE P.ID_TIPO_DOCUMENTO = H_ID_TIPO_DOCUMENTO
        AND PE.ID_PERSONA = P.ID_PERSONA;
BEGIN
    
       
END;

