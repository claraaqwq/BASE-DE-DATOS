--PREGUNTA 2:
SET SERVEROUTPUT ON;
------------------------------------------------------------------------------------
--B) mecanismo que permita actualizar las columnas creadas en a), cada vez que se 
--registra una nueva comunicación.
------------------------------------------------------------------------------------
SELECT * FROM EXPEDIENTE;--TOTAL_COMUNICACIONES , TOTAL_SERVICIOS
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_COMUNICACIONES
AFTER INSERT ON COMUNICACIONXEXPEDIENTE
FOR EACH ROW 
DECLARE
    T_TOTAL_COMU NUMBER;
BEGIN
    --como empieza en NULL, lo paso a cero, y despues puedo actualizar normal
    SELECT NVL(TOTAL_COMUNICACIONES,0) INTO T_TOTAL_COMU
    FROM EXPEDIENTE
    WHERE IDEXPEDIENTE = :NEW.IDEXPEDIENTE;
    --ahora si actualizo en esa misma tabla la nueva cantidad
    UPDATE EXPEDIENTE
    SET TOTAL_COMUNICACIONES = T_TOTAL_COMU + 1
    WHERE IDEXPEDIENTE = :NEW.IDEXPEDIENTE;
END;
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_SERVICIOS
AFTER INSERT ON SERVICIOXEXPEDIENTE
FOR EACH ROW 
DECLARE
    T_TOTAL_SERVICIO NUMBER;
BEGIN
    --como empieza en NULL, lo paso a cero, y despues puedo actualizar normal
    SELECT NVL(TOTAL_SERVICIOS,0) INTO T_TOTAL_SERVICIO
    FROM EXPEDIENTE
    WHERE IDEXPEDIENTE = :NEW.IDEXPEDIENTE;
    --ahora si actualizo en esa misma tabla la nueva cantidad
    UPDATE EXPEDIENTE
    SET TOTAL_SERVICIOS = T_TOTAL_SERVICIO + 1
    WHERE IDEXPEDIENTE = :NEW.IDEXPEDIENTE;
END;
/
------------------------------------------------------------------------------------
--C) mecanismo que se asigne la fecha de registro como la fecha actual cada vez que 
--se registra un nuevo expediente.
------------------------------------------------------------------------------------
SELECT * FROM EXPEDIENTE;
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_FECHA
BEFORE INSERT ON EXPEDIENTE
FOR EACH ROW
DECLARE
BEGIN
    :NEW.FREGISTRO := SYSDATE;
END;
/
------------------------------------------------------------------------------------
--D)desarrollar un mecanismo que verifique que el expediente no tenga ningun servicio
--o comunicación asociada cuando se intenta eliminar dicho expediente
------------------------------------------------------------------------------------
SELECT * FROM COMUNICACIONXEXPEDIENTE;
/
CREATE OR REPLACE TRIGGER TR_VERIFICAR_EXPEDIENTE
BEFORE DELETE ON EXPEDIENTE
FOR EACH ROW
DECLARE
    TOTAL_COMUNICACION NUMBER;
    TOTAL_SERVICIO NUMBER;
    TOTAL_EXPEDIENTE NUMBER;
BEGIN
    SELECT COUNT(*) INTO TOTAL_COMUNICACION
    FROM COMUNICACIONXEXPEDIENTE
    WHERE IDEXPEDIENTE = :OLD.IDEXPEDIENTE;
    
    SELECT COUNT(*) INTO TOTAL_SERVICIO
    FROM SERVICIOXEXPEDIENTE
    WHERE IDEXPEDIENTE = :OLD.IDEXPEDIENTE;
    
    IF(TOTAL_COMUNICACION > 0 OR TOTAL_SERVICIO > 0) THEN
        RAISE_APPLICATION_ERROR (-2000,'EL EXPEDIENTE SI TIENE SERVICIOS O COMUNICACIONES ACTIVAS');
    --caso si tenga el trigger continuará sin ningun problema y logrará eliminar
    END IF;
END;

