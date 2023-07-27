SET SERVEROUTPUT ON
SELECT *FROM E2_PEDIDO;
/
CREATE OR REPLACE PROCEDURE ImprimirPedidosCF
IS
    CURSOR c1 IS
    SELECT IDPEDIDO,FECHAPEDIDO,MONTOIGV
    FROM E2_PEDIDO
    WHERE FECHAPEDIDO BETWEEN '01/11/20' AND '05/11/20'; 
    
    suma E2_PEDIDO.MONTOIGV%TYPE;
BEGIN
    suma := 0;
    FOR r_c1 IN c1 LOOP
        dbms_output.put_line('EL pedido '||r_c1.IDPEDIDO||' del '||r_c1.FECHAPEDIDO||' acumula S/'||r_c1.MONTOIGV||' de crédito fiscal');       
        suma := suma + r_c1.MONTOIGV;
    END LOOP;
    
    dbms_output.put_line('TOTAL ACUMULADO: S/ '||suma);

END;
/
exec imprimirPedidoscf;
SELECT *FROM E2_CLIENTE;
/
CREATE OR REPLACE FUNCTION ObtenerSiguienteCodigoCliente
RETURN NUMBER
IS
    sigCod NUMBER;
BEGIN
    
    SELECT MAX(IDCLIENTE) INTO sigCod FROM E2_CLIENTE;
    
    IF sigCod IS NULL THEN
        return 0;
    END IF; 
    
    RETURN sigCod+1;    
END;
/
select obtenerSiguienteCodigocliente() from dual;
SELECT *FROM E2_CLIENTE;
/
CREATE OR REPLACE FUNCTION ObtenerCodigoCliente(
    p_numDNI E2_CLIENTE.DOCUMENTOIDENTIDAD%TYPE
)
RETURN E2_CLIENTE.IDCLIENTE%TYPE
IS
    cod E2_CLIENTE.IDCLIENTE%TYPE;
BEGIN
    
    SELECT IDCLIENTE INTO cod
    FROM E2_CLIENTE
    WHERE DOCUMENTOIDENTIDAD = p_numDNI;
    
    RETURN cod;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN -1;
END;
/
select obtenercodigocliente('23648228') from dual;
select obtenercodigocliente('45380648') from dual;
SELECT *FROM E2_PEDIDO;
/
CREATE OR REPLACE PROCEDURE ImprimirPedidosDia(p_fecha VARCHAR2)
IS
    CURSOR c1 IS 
    SELECT IDPEDIDO,MONTOTOTAL,MONTOIGV
    FROM E2_PEDIDO
    WHERE TO_CHAR(FECHAPEDIDO,'YYYY-MM-DD') = p_fecha;
    
    cuentaReg NUMBER;
    NO_PEDIDOS EXCEPTION;
BEGIN
    cuentaReg := 0;
    FOR r_c1 IN c1 LOOP
        dbms_output.put_line(p_fecha||': Pedido'||r_c1.IDPEDIDO||'/ Monto Total '||r_c1.MONTOTOTAL||'/IGV '||r_c1.MONTOIGV);
    END LOOP;
    
EXCEPTION
    WHEN NO_PEDIDOS THEN
        dbms_output.put_line('No hay pedidos para el dia '||p_fecha);
END;
/
exec ImprimirPedidosDia('2020-11-07');