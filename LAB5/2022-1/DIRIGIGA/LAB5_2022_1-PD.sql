--LAB5-2022_1
--PARTE DIRIGIDA

---------------------------------------------------------------------------------
--EJERCICIO 1: elabore SUBPROGRAMA que en base a sus movimientos registrados 
--en la tabla SB_DEPOSITO_RETIRO calcule y actualice el saldo de todas las cuentas
---------------------------------------------------------------------------------
SELECT * FROM SB_CUENTA; --recorro todas las filas de esta tabla usando un cursor + ID_CUENTA + SALDO + MONEDA
SELECT * FROM SB_DEPOSITO_RETIRO; --movimientos -> deposito o retiro
--el saldo será de la diferencia entre total depositado menos el total retirado
--solo actualizamos el saldo de la cuenta en caso el valor calculado sea diferente al actual
/
--HACEMOS 2 SELECTS: UNO POR RETIRO Y OTRO POR DEPOSITO
SELECT NVL(SUM(MONTO),0)
FROM SB_DEPOSITO_RETIRO R
WHERE R.TIPO = 'D';
/
SELECT NVL(SUM(MONTO),0)
FROM SB_DEPOSITO_RETIRO R
WHERE R.TIPO = 'R';
/
SELECT ID_CUENTA, SALDO, MONEDA
FROM SB_CUENTA;
/
CREATE OR REPLACE PROCEDURE SP_RECALCULAR_SALDO_CUENTA
AS
    NTOTAL_DEPOSITADO NUMBER;
    NTOTAL_RETIRADO NUMBER;
    NSALDO NUMBER;
    
    --CREO CURSOR PARA EVALUAR LAS FILAS DE LAS CUENTAS
    CURSOR CUR_CUENTAS IS
        SELECT ID_CUENTA, SALDO, MONEDA
        FROM SB_CUENTA;
BEGIN
--COMO EVALUARÁ FILA X FILA, PUEDO AYUDARME DE UNA ITERACION -> FOR
--APODO IN NOMBRE_CURSOR
FOR RCUENTA IN CUR_CUENTAS 
    LOOP
        --INICIALIZO MIS VARIABLES EN CERO
        NTOTAL_DEPOSITADO:=0;
        NTOTAL_RETIRADO:=0;
        --AGREGO LOS SELECT'S POR CADA TIPO
        SELECT NVL(SUM(MONTO),0) INTO NTOTAL_DEPOSITADO
        FROM SB_DEPOSITO_RETIRO R
        WHERE R.TIPO = 'D' AND R.ID_CUENTA = RCUENTA.ID_CUENTA;
        
        SELECT NVL(SUM(MONTO),0) INTO NTOTAL_RETIRADO
        FROM SB_DEPOSITO_RETIRO R
        WHERE R.TIPO = 'R' AND R.ID_CUENTA = RCUENTA.ID_CUENTA;
        
        --ACTUALIZO EL SALDO:
        NSALDO := NTOTAL_DEPOSITADO - NTOTAL_RETIRADO;
        --IMPRIMO:
        dbms_output.put_line('TD: '||NTOTAL_DEPOSITADO||' TR: '||NTOTAL_RETIRADO
        ||' SR: '||NSALDO||' SC: '||RCUENTA.SALDO);
        
        --EVALUO SI TENGO QUE ACTUALIZAR O NO
        IF (RCUENTA.SALDO !=  NSALDO)THEN
            UPDATE SB_CUENTA SET SALDO = NSALDO
            WHERE ID_CUENTA = RCUENTA.ID_CUENTA;
        END IF;
        
    END LOOP;

END;
/
--PRUEBA: VEO DATOS QUE ACTUALIZÓ
SELECT * FROM SB_CUENTA;
/
--AHORA VEO EL PROCEDURE => MUESTRA POR CADA ID_CUENTA (1-7)
SET SERVEROUTPUT ON
EXEC SP_RECALCULAR_SALDO_CUENTA();
/
---------------------------------------------------------------------------------
--EJERCICIO 2: elabore un SUBPROGRAMA que genere el calendario de todos los pagos
--de todos los préstamos, es decir, se debe generar cada una de las cuotas mensuales
---------------------------------------------------------------------------------
--TODOS LOS PRESTAMOS = recorrer cada uno de ellos (cursor)
--Cada vez que el subprograma se ejecute, borro la data de SB_CUOTA
SELECT * FROM SB_PRESTAMO; -- MONTO + CUENTA
SELECT * FROM SB_CUOTA; -- ID_PRESTAMO + FECHAS + MONTO_CUOTA
/
--HAGO SELECT POR LA TABLE PRESTAMO <- CURSOR DE ESTO
SELECT ID_PRESTAMO, MONTO, MONEDA, FECHA, PLAZO, INTERES, CUOTA
FROM SB_PRESTAMO;

/
CREATE OR REPLACE PROCEDURE SP_GENERAR_CALENDARIO_PAGOS
AS
    NCONTADOR NUMBER;
    NCUOTA NUMBER;
    NCONTADORCUOTA NUMBER;
    NVENCIMIENTO DATE;
    CURSOR CUR_PRESTAMO IS
        SELECT ID_PRESTAMO, MONTO, MONEDA, FECHA, PLAZO, INTERES, CUOTA
        FROM SB_PRESTAMO;
    
BEGIN
    DELETE FROM SB_CUOTA;
    NCONTADOR := 0;
    FOR RPRESTAMO IN CUR_PRESTAMO LOOP
        NCUOTA := 1;
        NCONTADORCUOTA := 1;
        NVENCIMIENTO := LAST_DAY(RPRESTAMO.FECHA);
        
        WHILE NCONTADORCUOTA < RPRESTAMO.PLAZO LOOP
            --VOY GENERANDO LAS CUOTAS MENSUALES
            INSERT INTO SB_CUOTA (ID_CUOTA,ID_PRESTAMO,NUM_CUOTA,FECHA_VENCIMIENTO,MONTO_CUOTA,ESTADO)
            VALUES (NCONTADOR+1,RPRESTAMO.ID_PRESTAMO,NCUOTA,NVENCIMIENTO,RPRESTAMO.CUOTA,0);
            --VOY AUMENTANDO LOS INDICES
            NCONTADOR:=NCONTADOR+1;
            NCONTADORCUOTA:=NCONTADORCUOTA+1;
            NCUOTA:=NCUOTA+1;
            NVENCIMIENTO:=ADD_MONTHS(NVENCIMIENTO,1);
        END LOOP;
        --IMPRIMO
        dbms_output.put_line('Prestamos ID: '||RPRESTAMO.ID_PRESTAMO||' Cuotas generadas: '||NCONTADORCUOTA);
    END LOOP;
END;
/
--PRUEBO:
SET SERVEROUTPUT ON
EXEC SP_GENERAR_CALENDARIO_PAGOS();

---------------------------------------------------------------------------------
--FINALIZADO PARTE DE CURSORES :)
---------------------------------------------------------------------------------

