--LABORATORIO 5
--2021-2
--PARTE CALIFICADA
SET SERVEROUTPUT ON
---------------------------------------------------------------------------
--PREGUNTA 1: crear funcion SF_CONTAR_TRANSFERENCIAS que devuelva la cantidad
--de transferencias x cliente
---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION SF_CONTAR_TRANSFERENCIAS(C_ID_CLIENTE NUMBER)
RETURN NUMBER
IS
    C_CANTIDAD NUMBER:=0;
BEGIN
    SELECT COUNT(T.ID_TRANSFERENCIA) INTO C_CANTIDAD
    FROM PP_CUENTA_BANCARIA C, PP_TRANSFERENCIA T
    WHERE C.ID_CLIENTE = C_ID_CLIENTE
    AND C.ID_CUENTA = T.CUENTA_ORIGEN;
    RETURN C_CANTIDAD;
END;
/
SELECT SF_CONTAR_TRANSFERENCIAS(1) FROM DUAL;
/
---------------------------------------------------------------------------
--PREGUNTA 2: elaborar PROCEDURE con nombre SP_REPORTE_TRANSFERENCIAS
--que imprima todas las transferencias que ha realizado un cliente
--recibe como parametro id_cliente
---------------------------------------------------------------------------
SELECT * FROM PP_TRANSFERENCIA;--ID_TRANSFERENCIA, MONTO_TRANSFERIDO, CUENTA_ORIGEN, 
--CUENTA_DESTINO,FECHA_TRANSACCION,FECHA_CONFIRMACION, MENSAJE, ESTADO
SELECT * FROM PP_CUENTA_BANCARIA;--ID_CLIENTE, ID_CUENTA
SELECT * FROM PP_TARJETA_BANCARIA;--ID_CUENTA, NUMERO_TARJETA
/
CREATE OR REPLACE PROCEDURE SP_REPORTE_TRANSFERENCIAS (S_ID_CLIENTE NUMBER)
IS  
    C_NUM_TARJET NUMBER;
    C_FECHA_TRANS CHAR(10) := '---';
    C_FECHA_CONF CHAR(10);
    C_NUM_CUENTA_O NUMBER;
    C_NUM_CUENTA_T NUMBER;
    --recorro la tabla transferencia
    CURSOR C_TRANSFERENCIAS IS
        SELECT T.ID_TRANSFERENCIA, T.MONTO_TRANSFERIDO, T.CUENTA_ORIGEN, 
        T.CUENTA_DESTINO,T.FECHA_TRANSACCION,T.FECHA_CONFIRMACION, T.MENSAJE, T.ESTADO
        FROM PP_TRANSFERENCIA T,PP_CUENTA_BANCARIA C
        WHERE T.CUENTA_ORIGEN = C.ID_CUENTA AND C.ID_CUENTA = S_ID_CLIENTE;
    DAT_TRANS C_TRANSFERENCIAS%ROWTYPE;
BEGIN
    OPEN C_TRANSFERENCIAS;
    LOOP
    FETCH C_TRANSFERENCIAS INTO DAT_TRANS;
    EXIT WHEN C_TRANSFERENCIAS%NOTFOUND;
        --saco informacion del nmr de tarjeta
        SELECT B.NUMERO_TARJETA, C1.NUMERO_CUENTA, C2.NUMERO_CUENTA INTO C_NUM_TARJET,C_NUM_CUENTA_O, C_NUM_CUENTA_T
        FROM PP_TARJETA_BANCARIA B, PP_CUENTA_BANCARIA C1, PP_CUENTA_BANCARIA C2
        WHERE B.ID_CUENTA = C1.ID_CUENTA
        AND C1.ID_CUENTA = DAT_TRANS.CUENTA_ORIGEN AND C2.ID_CUENTA = DAT_TRANS.CUENTA_DESTINO;
        C_FECHA_TRANS := TO_CHAR(DAT_TRANS.FECHA_TRANSACCION,'DD/MM/YYYY');
        IF (DAT_TRANS.FECHA_CONFIRMACION IS NOT NULL)THEN
            C_FECHA_CONF := TO_CHAR(DAT_TRANS.FECHA_CONFIRMACION,'DD/MM/YYYY');
        END IF;
        --imprimo
        dbms_output.put_line('Codigo de transferencia   : '||RPAD(DAT_TRANS.ID_TRANSFERENCIA,5));
        dbms_output.put_line('Monto transferido         : S/'||RPAD(DAT_TRANS.MONTO_TRANSFERIDO,6));
        dbms_output.put_line('    Cuenta origen         : '||RPAD(C_NUM_CUENTA_O,15)||'(Nro. Tarjeta: '||RPAD(C_NUM_TARJET,15)||')');
        dbms_output.put_line('    Cuenta destino        : '||RPAD(C_NUM_CUENTA_T,15));
        dbms_output.put_line('    Fecha de transaccion  : '||RPAD(C_FECHA_TRANS,10));
        dbms_output.put_line('    Fecha de confirmacion : '||RPAD(C_FECHA_CONF,10));
        dbms_output.put_line('    Motivo                : '||RPAD(DAT_TRANS.MENSAJE,200));
        CASE (DAT_TRANS.ESTADO ) 
            WHEN 'P' THEN
                dbms_output.put_line('    Estado                : En proceso');
            WHEN 'A' THEN
                dbms_output.put_line('    Estado                : Anulado');
            WHEN 'C' THEN
                dbms_output.put_line('    Estado                : Confirmada');
        END CASE;
        dbms_output.put_line('                                                                           ');
    END LOOP;
    CLOSE C_TRANSFERENCIAS;
END;
/
EXEC SP_REPORTE_TRANSFERENCIAS (1);
/

---------------------------------------------------------------------------
--PREGUNTA 3: es lo mismo q la anterior funcion pero ahora agrego un cursor
--para clientes, pq quiero que me imprima la informacion de todos los clientes
---------------------------------------------------------------------------
SELECT * FROM PP_CLIENTE;
/
CREATE OR REPLACE PROCEDURE SP_REPORTE_CLIENTES
IS  
    --recorro la tabla CLIENTES
    CURSOR C_CLIENTES IS
        SELECT ID_CLIENTE,APELLIDO_PATERNO,APELLIDO_MATERNO,NOMBRES,TIPO_DOCUMENTO,NUMERO_DOCUMENTO
        FROM PP_CLIENTE;
    C_NOMBRE VARCHAR2(100);
    C_CONTADOR NUMBER :=0;
BEGIN
FOR RCLIENTE IN C_CLIENTES
LOOP
        --imprimo
        C_NOMBRE := RCLIENTE.APELLIDO_PATERNO||' '||RCLIENTE.APELLIDO_MATERNO||' '||RCLIENTE.NOMBRES;
        dbms_output.put_line('Cliente   : '||C_NOMBRE);
        CASE (RCLIENTE.TIPO_DOCUMENTO ) 
            WHEN 'D' THEN
                dbms_output.put_line('Tipo Documento: DNI / Numero de Documento: '||RCLIENTE.NUMERO_DOCUMENTO);
            WHEN 'R' THEN
                dbms_output.put_line('Tipo Documento: RUC / Numero de Documento: '||RCLIENTE.NUMERO_DOCUMENTO);
            WHEN 'C' THEN
                dbms_output.put_line('Tipo Documento: Carnet de extranjeria / Numero de Documento: '||RCLIENTE.NUMERO_DOCUMENTO);
            WHEN 'P' THEN
                dbms_output.put_line('Tipo Documento: Pasaporte / Numero de Documento: '||RCLIENTE.NUMERO_DOCUMENTO);
            WHEN 'O' THEN
                dbms_output.put_line('Tipo Documento: Otros / Numero de Documento: '||RCLIENTE.NUMERO_DOCUMENTO);
        END CASE;
        --Ahora valido si tiene o no transferencias
        C_contador := SF_CONTAR_TRANSFERENCIAS(RCLIENTE.ID_CLIENTE);
        IF(C_CONTADOR >0) THEN
            SP_REPORTE_TRANSFERENCIAS(RCLIENTE.ID_CLIENTE);
        ELSE
            dbms_output.put_line('El cliente no ha realizado transferencias');
        END IF;
        dbms_output.put_line('******************************************************************************');
    END LOOP;
END;
/
EXEC SP_REPORTE_CLIENTES();
/
---------------------------------------------------------------------------
--PREGUNTA 4: elaborar TRIGGER que actualice el nuevo atrib SALDO en la tabla
--PP_CUENTA_BANCARIA cada vez que se inserte un registrro en la tabla PP_TRANSFERENCIA
---------------------------------------------------------------------------
SELECT * FROM PP_CUENTA_BANCARIA;
SELECT * FROM PP_TRANSFERENCIA;
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZA_DATOS
AFTER INSERT ON PP_TRANSFERENCIA
FOR EACH ROW
DECLARE
    
BEGIN
    UPDATE PP_CUENTA_BANCARIA
    SET SALDO = SALDO - :NEW.MONTO_TRANSFERIDO
    WHERE ID_CUENTA = :NEW.CUENTA_ORIGEN;
    
    UPDATE PP_CUENTA_BANCARIA
    SET SALDO = SALDO + :NEW.MONTO_TRANSFERIDO
    WHERE ID_CUENTA = :NEW.CUENTA_DESTINO;
END;
/
INSERT INTO PP_TRANSFERENCIA VALUES (11,12,13,1250,'por contratos',TO_DATE('21/08/2021','DD/MM/YYYY'),
    TO_DATE('29/08/2021','DD/MM/YYYY'),'C');
/
SELECT * FROM PP_CUENTA_BANCARIA;
SELECT * FROM PP_TRANSFERENCIA;
/
---------------------------------------------------------------------------
--PREGUNTA 5:
---------------------------------------------------------------------------
SELECT * FROM PP_ESTADO_TRANSFERENCIA;
SELECT * FROM PP_TRANSFERENCIA;
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZA_DATOS 
AFTER INSERT OR UPDATE OR DELETE ON PP_TRANSFERENCIA
FOR EACH ROW
DECLARE
    C_CONTADOR NUMBER :=0;
BEGIN
    --para tener la cant y poder cambiar las id's
    SELECT COUNT(*) INTO C_CONTADOR
    FROM PP_ESTADO_TRANSFERENCIA;
    
    IF INSERTING THEN
        IF :NEW.FECHA_CONFIRMACION IS NULL THEN
            --inserta un registro en la tabla PP_ESTADO_TRANSFERENCIA
            INSERT INTO PP_ESTADO_TRANSFERENCIA(ID_ESTADO_TRANSFERENCIA,ID_TRANSFERENCIA,DESCRIPCION,FECHA_REGISTRO,
                                                 ESTADO_ANTERIOR,ESTADO_ACTUAL)
            VALUES (C_CONTADOR+1,:NEW.ID_TRANSFERENCIA,'Transferencia en Proceso',SYSDATE,NULL,'P');
        ELSE
            --insertar un registro en la tabla PP_ESTADO_TRANSFERENCIA
            INSERT INTO PP_ESTADO_TRANSFERENCIA(ID_ESTADO_TRANSFERENCIA,ID_TRANSFERENCIA,DESCRIPCION,FECHA_REGISTRO,
                                                 ESTADO_ANTERIOR,ESTADO_ACTUAL)
            VALUES (C_CONTADOR+1,:NEW.ID_TRANSFERENCIA,'Transferencia en Proceso',SYSDATE,'P','C');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF (:OLD.FECHA_CONFIRMACION IS NULL AND :NEW.FECHA_CONFIRMACION IS NOT NULL) THEN
            --insertar un registro en la tabla PP_ESTADO_TRANSFERENCIA
            INSERT INTO PP_ESTADO_TRANSFERENCIA(ID_ESTADO_TRANSFERENCIA,ID_TRANSFERENCIA,DESCRIPCION,FECHA_REGISTRO,
                                                 ESTADO_ANTERIOR,ESTADO_ACTUAL)
            VALUES (C_CONTADOR+1,:NEW.ID_TRANSFERENCIA,'Transferencia Confirmada',SYSDATE,'P','C');
        END IF;
    END IF;
    
    IF DELETING THEN
        ----insertar un registro en la tabla PP_ESTADO_TRANSFERENCIA
        INSERT INTO PP_ESTADO_TRANSFERENCIA(ID_ESTADO_TRANSFERENCIA,ID_TRANSFERENCIA,DESCRIPCION,FECHA_REGISTRO,
                                                 ESTADO_ANTERIOR,ESTADO_ACTUAL)
        VALUES (C_CONTADOR+1,:OLD.ID_TRANSFERENCIA,'Transferencia Anulada',SYSDATE,'C','A');
    END IF;
END;
/
--PARA LA REGLA 1:
INSERT INTO PP_TRANSFERENCIA(ID_TRANSFERENCIA,CUENTA_ORIGEN,CUENTA_DESTINO,MONTO_TRANSFERIDO,
                                    MENSAJE,FECHA_TRANSACCION,FECHA_CONFIRMACION,ESTADO)
VALUES (12,12,13,150,'Compras del mes',SYSDATE,NULL,'P');
/
--PARA LA REGLA 2:
INSERT INTO PP_TRANSFERENCIA(ID_TRANSFERENCIA,CUENTA_ORIGEN,CUENTA_DESTINO,MONTO_TRANSFERIDO,
                                    MENSAJE,FECHA_TRANSACCION,FECHA_CONFIRMACION,ESTADO)
VALUES (13,13,12,150,'Devolucion de compras',TO_DATE('28/11/2021','DD/MM/YYYY'),SYSDATE,'C');
/
--PARA LA REGLA 3:
UPDATE PP_TRANSFERENCIA SET FECHA_CONFIRMACION = SYSDATE WHERE ID_TRANSFERENCIA = 12;
/
--PARA LA REGLA 4:
DELETE FROM PP_TRANSFERENCIA WHERE ID_TRANSFERENCIA =13;
/
SELECT * FROM PP_ESTADO_TRANSFERENCIA;
---------------------------------------------------------------------------
--TERMINADO :)
---------------------------------------------------------------------------