--EXAMEN 2
--2022.2
set serveroutput on;
--------------------------------------------------------------------------------
--PREGUNTA A: desarrollar funcion para calcular la deuda correspondiente a un 
--determinado chip con un contrato vigente en una facha dada
--------------------------------------------------------------------------------
SELECT * FROM E222TAM_CHIP;--ID_CHIP,ID_CLIENTE
SELECT * FROM E222CONTRATO;--ID_CHIP,FECHAINICIO,FECHAFIN,ID_CONTRATO
--comprobar que la fecha es vigente -> between
SELECT * FROM E222PROCESOXCONTRATO;--ID_CONTRATO,ID_FACTURA
SELECT * FROM E222FACTURA;--ID_FACTURA,TOTAL,ID_ESTADO,FECHAVENCIMIENTO,FECHACANCELACION
--considerar facturas con deuda a aquella que tengan estado 'E', la fecha de 
--cancelacion es nula y la de vencimiento es menor a la fecha actual
/
SELECT T.ID_CHIP, F.ID_FACTURA, F.TOTAL
FROM E222CONTRATO C,E222TAM_CHIP T,E222PROCESOXCONTRATO P,
    E222FACTURA F,E22ESTADO E
WHERE T.ID_CHIP = C.ID_CHIP AND C.ID_CONTRATO = P.ID_CONTRATO
AND P.ID_FACTURA = F.ID_FACTURA
AND C.FECHAINICIO BETWEEN F_FECHA AND SYSDATE
AND E.ID_ESTADO = F.ID_ESTADO
AND E.DESCRIPCION = 'E'
AND F.FECHACANCELACION IS NULL
AND F.FECHAVENCIMIENTO < SYSDATE;
/
CREATE OR REPLACE FUNCTION FC_CALCULA_DEUDA(F_ID_CHIP NUMBER,F_FECHA DATE)
RETURN NUMBER --retorna la deuda
IS
    DEUDA NUMBER;
BEGIN 
    SELECT SUM(F.TOTAL) INTO DEUDA
    FROM E222CONTRATO C,E222TAM_CHIP T,E222PROCESOXCONTRATO P,
        E222FACTURA F,E222ESTADO E,E222DETALLEPROCESO D
    WHERE T.ID_CHIP = C.ID_CHIP AND C.ID_CONTRATO = P.ID_CONTRATO
    AND P.ID_FACTURA = F.ID_FACTURA
    AND C.FECHAINICIO <= F_FECHA
    AND C.FECHAFIN >= F_FECHA
    AND E.ID_ESTADO = F.ID_ESTADO
    AND E.DESCRIPCION = 'E'
    AND F.FECHACANCELACION IS NULL
    AND F.FECHAVENCIMIENTO < SYSDATE
    AND F.ID_FACTURA = D.ID_FACTURA
    AND D.ID_CONCEPTO NOT IN (5, 6, 7);
    return DEUDA;
    
END;
/
--------------------------------------------------------------------------------
--PREGUNTA B: desarrollar un trigger en la tabla CONTRATO que no permita crear
--un nuevo contrato si es que el cliente propietario del chip del contrato
--tiene deudas superiores a los 100 soles. El trigger debe mandar mensaje de error
--------------------------------------------------------------------------------
SELECT * FROM E222CONTRATO;--ID_CONTRATO, ID_CHIP
/
CREATE OR REPLACE TRIGGER TR_VERIFICAR_CONTRATO
BEFORE INSERT ON E222CONTRATO
FOR EACH ROW
DECLARE
    DEUDA NUMBER;
BEGIN
    DEUDA := FC_CALCULA_DEUDA(:NEW.ID_CHIP,:NEW.FECHAINICIO);
    IF DEUDA > 100 THEN
        RAISE_APPLICATION_ERROR(-20000,'NO SE PUEDE -.-');
    ELSE
        dbms_output.put_line('Si se puede insertar :)');
    END IF;
END;
/
DECLARE
  v_total_deuda NUMBER;
BEGIN
  v_total_deuda := FC_CALCULA_DEUDA(123, TO_DATE('2023-07-02', 'YYYY-MM-DD'));
  DBMS_OUTPUT.PUT_LINE('Deuda total: ' || v_total_deuda);
END;
--------------------------------------------------------------------------------
--ia ta
--------------------------------------------------------------------------------