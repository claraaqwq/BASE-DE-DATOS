--LABOTORIO 5
--2021-2
--PARTE DIRIGIDA
SET SERVEROUTPUT ON
------------------------------------------------------------------------------------
--PREGUNTA 1: cursor que liste los tipos de documentos, perosnas y cargo 
------------------------------------------------------------------------------------
SELECT * FROM TIPO_DOCUMENTO; -- ID_TIPO_DOCUMENTO
SELECT * FROM PERSONA; -- ID_TIPO_DOCUMENTO, ID_PERSONA, NOMBRES 
SELECT * FROM PERSONAL; --ID_PERSONAL , ID_CARGO
SELECT * FROM CARGO;--ID_CARGO, NOMBRE
/
CREATE OR REPLACE PROCEDURE SO_LISTAR_EMPLEADOS
IS
    --uso un cursor que me permita sacar el tipo de documento junto con su nombre
    CURSOR C_DOCUMENTOS IS
        SELECT ID_TIPO_DOCUMENTO, NOMBRE
        FROM TIPO_DOCUMENTO
        ORDER BY 1;
    CURSOR C_PERSONAS (P_ID_TIPO_DOCUMENTO NUMBER) IS
        SELECT ID_PERSONA, NOMBRES
        FROM PERSONA
        WHERE ID_TIPO_DOCUMENTO = P_ID_TIPO_DOCUMENTO;
    CURSOR C_CARGO (P_ID_PERSONA NUMBER)IS
        SELECT C.ID_CARGO, C.NOMBRE
        FROM PERSONAL P, CARGO C
        WHERE P.ID_PERSONA = P_ID_PERSONA 
        AND P.ID_CARGO = C.ID_CARGO;
    
    S_ID_TIPO_DOCUMENTO NUMBER;
    S_NOMBRE VARCHAR2 (60);
    S_ID_PERSONA NUMBER;
    S_NOMBRE_PERSO VARCHAR2 (60);
    S_ID_CARGO NUMBER;
    S_NOMBRE_CARGO VARCHAR2 (60);
BEGIN
    OPEN C_DOCUMENTOS;
    LOOP
    FETCH C_DOCUMENTOS INTO S_ID_TIPO_DOCUMENTO, S_NOMBRE;
    EXIT WHEN C_DOCUMENTOS%NOTFOUND;
    
    dbms_output.put_line('TIPO DOCUMENTO: '||S_ID_TIPO_DOCUMENTO||' - '||S_NOMBRE);
    
        OPEN C_PERSONAS (S_ID_TIPO_DOCUMENTO);
        LOOP
        FETCH C_PERSONAS INTO S_ID_PERSONA, S_NOMBRE_PERSO;
        EXIT WHEN C_PERSONAS%NOTFOUND;
        
        dbms_output.put_line(' PERSONA: '||S_ID_PERSONA||' - '||S_NOMBRE_PERSO);
        
            OPEN C_CARGO(S_ID_PERSONA);
            LOOP
            FETCH C_CARGO INTO S_ID_CARGO, S_NOMBRE_CARGO;
            EXIT WHEN C_CARGO%NOTFOUND;
            
            dbms_output.put_line('  CARGO: '||S_ID_CARGO||' - '||S_NOMBRE_CARGO);
            
            END LOOP;
            CLOSE C_CARGO;
        END LOOP;
        CLOSE C_PERSONAS;
    END LOOP;    
    CLOSE C_DOCUMENTOS;
END;
/
EXEC SO_LISTAR_EMPLEADOS();
/
------------------------------------------------------------------------------------
--PREGUNTA 2: crear funcion que calcule la bonificacion sobre el sueldo basico de un
--empleado
------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION FC_CALCULAR_BONIF(P_SUELDO NUMBER, P_ID_CARGO NUMBER)
RETURN NUMBER
IS

BEGIN
    IF P_ID_CARGO IN (1,2,3,4) THEN
        RETURN P_SUELDO*1.2;
    END IF;
    IF P_ID_CARGO IN (5,6,7,8) THEN
        RETURN P_SUELDO*1.15;
    END IF;
    IF P_ID_CARGO IN (9,10,11) THEN
        RETURN P_SUELDO*1.1;
    END IF;
    RETURN 0; --caso ingrese un cargo que no exista
END;
/
SELECT FC_CALCULAR_BONIF (25000,1) AS BONIFICACION FROM DUAL;
/
------------------------------------------------------------------------------------
--PREGUNTA 3: crear PROCEDURE que recorra la tabla CARGOS todos los registros de la
--table PERSONAL, para poder calcular y actualizar el valor del campo SUELDO_BONI
--usando la funcion anterior. Si el sueldo basico es >=5500 -> agrega boni 300
------------------------------------------------------------------------------------
SELECT * FROM CARGO;--ID_CARGO,SUELDO_V
SELECT * FROM PERSONAL;--SUELDO_BODIFICACION (calcular y actualizar)
/
CREATE OR REPLACE PROCEDURE PR_CALCULAR_BONIF
IS
    --cursor que recorra la tabla cargos
    CURSOR C_CARGO IS
        SELECT ID_CARGO, SUELDO_BASICO
        FROM CARGO
        WHERE ESTADO = 'A';
    S_ID_CARGO NUMBER;
    S_SUELDO_BASICO NUMBER;
BEGIN
    OPEN C_CARGO;
    LOOP
    FETCH C_CARGO INTO S_ID_CARGO, S_SUELDO_BASICO;
    EXIT WHEN C_CARGO%NOTFOUND;
    --caso el sueldo basico sea menor a 5500 agregar bonificacion
    IF S_SUELDO_BASICO <= 5500 THEN
        UPDATE PERSONAL
        SET SUELDO_BONIFICACION = FC_CALCULAR_BONIF(SUELDO_BASICO,S_ID_CARGO)+300
        WHERE ID_CARGO = S_ID_CARGO;
    ELSE
        UPDATE PERSONAL
        SET SUELDO_BONIFICACION = FC_CALCULAR_BONIF(SUELDO_BASICO,S_ID_CARGO)
        WHERE ID_CARGO = S_ID_CARGO;
    END IF;
    END LOOP;
    CLOSE C_CARGO;
END;
/
EXEC PR_CALCULAR_BONIF();
/
SELECT * FROM PERSONAL;
/
------------------------------------------------------------------------------------
--PREGUNTA 4: hacer TRIGGER de quien inserta datos en la tabla PERSONA, la trazabilidad
--se hará en la tabla LOG_AUDITORIA
--debe imprimir el nombre de la tabla, el usuario y la fecha del insert 
------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TR_LOG_PERSONA
AFTER INSERT ON PERSONA
FOR EACH ROW
DECLARE
    V_ID_LOG NUMBER;
BEGIN
    SELECT NVL(MAX(ID_LOG),0) INTO V_ID_LOG
    FROM LOG_AUDITORIA;
    INSERT INTO LOG_AUDITORIA (ID_LOG,NOMBRE_TABLA,USUARIO,FECHA_REGISTRO)
    VALUES(V_ID_LOG+1,'PERSONA',USER,SYSDATE);
END;
/
SELECT * FROM LOG_AUDITORIA;
SELECT * FROM PERSONA;
/
INSERT INTO PERSONA (ID_PERSONA,ID_TIPO_DOCUMENTO,NRO_DOCUMENTO,NOMBRES,TELEFONO,CORREO_ELECTRONICO)
VALUES (13,1,'41671717','CORDOVA RUIZ, DANIEL','984700436','dcordova@rent.com.pe');
/
------------------------------------------------------------------------------------
--PREGUNTA 5: hacer TRIGGER, caso actualice o inserte (OJO) 
------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TR_TAZA_PERSONA
AFTER INSERT OR UPDATE ON PERSONA
FOR EACH ROW
DECLARE
    V_ID_LOG NUMBER;
BEGIN
    SELECT NVL(MAX(ID_LOG_PERSONA),0) INTO V_ID_LOG FROM LOG_PERSONA;
    
    IF INSERTING THEN
        INSERT INTO LOG_PERSONA(ID_LOG_PERSONA,ID_PERSONA,TELEFONO,CORREO,USUARIO,FECHA_REGISTRO,ACCION,ESTADO)
        VALUES (V_ID_LOG + 1,:NEW.ID_PERSONA,:NEW.TELEFONO,:NEW.CORREO_ELECTRONICO,USER,SYSDATE,'I','1');
    END IF;
    IF UPDATING THEN
        UPDATE LOG_PERSONA 
        SET ESTADO = '0'
        WHERE ID_PERSONA = :NEW.ID_PERSONA
        AND ESTADO = '1';
        
        INSERT INTO LOG_PERSONA(ID_LOG_PERSONA,ID_PERSONA,TELEFONO,CORREO,USUARIO,FECHA_REGISTRO,ACCION,ESTADO)
        VALUES (V_ID_LOG + 1,:NEW.ID_PERSONA,:NEW.TELEFONO,:NEW.CORREO_ELECTRONICO,USER,SYSDATE,'U','1');
    END IF;
END;
/
INSERT INTO PERSONA VALUES (14,1,'42671717','ARANA QUISPE, DAVID','944700499','darana@rent.com.pe');
/
SELECT * FROM PERSONA ;
SELECT * FROM LOG_PERSONA;
