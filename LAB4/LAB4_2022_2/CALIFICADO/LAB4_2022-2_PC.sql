--LABORATORIO 5
--2022.2
--PARTE CALIFICADA
SET SERVEROUTPUT ON
---------------------------------------------------------------------------------------------
--PREGUNTA 1: pide recalcular los subtotales de la tabla SP_DETALLE_COMPRA, para ello se le
--solicita elaborar subprograma (CURSOR) SP_RECARLCULAR_DETALLE_COMPRA
---------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_RECALCULAR_DETALLE_COMPRA
IS  
    S_SUBTOTAL NUMBER;
    S_PRECIO NUMBER;
    --me pide recorrer toda la tabla detalle_compra
    CURSOR DETALLE IS
        SELECT ID_COMPRA,ID_INSUMO,CANTIDAD
        FROM SP_DETALLE_COMPRA;
BEGIN
FOR RDETALLE IN DETALLE
    LOOP
        SELECT I.PRECIO INTO S_PRECIO
        FROM SP_INSUMO I
        WHERE I.ID_INSUMO = RDETALLE.ID_INSUMO;
        --CALCULO EL SUBTOTAL
        S_SUBTOTAL := RDETALLE.CANTIDAD * S_PRECIO;
        --RECORRO EL CURSOR DE DETALLE
        dbms_output.put_line('ID_COMPRA: '||RDETALLE.ID_COMPRA||' SUBTOTAL: '||S_SUBTOTAL);
        
        UPDATE SP_DETALLE_COMPRA
        SET SUBTOTAL = S_SUBTOTAL
        WHERE ID_COMPRA = RDETALLE.ID_COMPRA;
        
    END LOOP;
END;
/
EXEC SP_RECALCULAR_DETALLE_COMPRA();
/
---------------------------------------------------------------------------------------------
--PREGUNTA 2: elaborar un subprograma SP_DEPURAR_ORDENES_PRD para eliminar de forma lógica
--las ordenes de produccion que no cuentan con un detalle
---------------------------------------------------------------------------------------------
SELECT * FROM SP_ORDEN_PRODUCCION;
/
CREATE OR REPLACE PROCEDURE SP_DEPURAR_ORDENES_PRD
IS  
    S_CONTADOR NUMBER;
    --piden recorrer cada registro de la tabla SP_ORDEN_PRODUCCION
    CURSOR PRODUCCION IS
        SELECT ID_ORDEN, ESTADO
        FROM SP_ORDEN_PRODUCCION;
    --saque el id_orden porque lo compararé en la tabla detalle_producto
BEGIN
FOR RPRODUCCION IN PRODUCCION
    LOOP
        --abro la tabla sp_detalle_producto, realizo un contador, para saber si existe el producto
        --asi será mas facil saber si existe o no un producto, en vez de hacer un <>
        SELECT COUNT(ID_COMPRA) INTO S_CONTADOR
        FROM SP_DETALLE_PRODUCTO P
        WHERE P.ID_ORDEN = RPRODUCCION.ID_ORDEN;
        
        IF S_CONTADOR = 0 THEN
            --si no se encuentra se cambia el estado por ELIMINADO
            UPDATE SP_ORDEN_PRODUCCION
            SET ESTADO = 'E'
            WHERE ID_ORDEN = RPRODUCCION.ID_ORDEN; --busca el orden
            dbms_output.put_line('ID_ORDEN: '||RPRODUCCION.ID_ORDEN||' ELIMINADO');
        END IF;
        
    END LOOP;
END;
/
EXEC SP_DEPURAR_ORDENES_PRD();
/
---------------------------------------------------------------------------------------------
--PREGUNTA 3: elaborar el subprograma SP_RECALCULAR_ORDEN_COMPRA, para realizar el recalculo
--de los subtotales de la tabla SP_ORDEN_COMPRA
---------------------------------------------------------------------------------------------
SELECT * FROM SP_ORDEN_COMPRA;
SELECT * FROM SP_DETALLE_COMPRA; --SUBTOTAL
/
CREATE OR REPLACE PROCEDURE SP_RECALCULAR_ORDEN_COMPRA
IS
    S_SUBTOTAL NUMBER;
    S_MONTO_TOTAL NUMBER;
    S_MONTO_IGV NUMBER;
    --creo cursor que ayude a recorrer la tabla orden_compra
    CURSOR COMPRAS IS
        SELECT ID_ORDEN
        FROM SP_ORDEN_COMPRA;
BEGIN
FOR RCOMPRAS IN COMPRAS
    LOOP
        --inicializo los montos en cero
        S_MONTO_TOTAL :=0;
        S_MONTO_IGV := 0;
        --sumo el subtotal de la tabla detalle_compra (POR CADA ORDEN)
        SELECT SUM(D.SUBTOTAL) INTO S_SUBTOTAL
        FROM SP_DETALLE_COMPRA D
        WHERE D.ID_ORDEN = RCOMPRAS.ID_ORDEN;
        
        S_MONTO_IGV := S_SUBTOTAL*0.18;
        S_MONTO_TOTAL := S_SUBTOTAL + S_MONTO_IGV;
        --imprimo
        dbms_output.put_line('ID_ORDEN: '||RPAD(RCOMPRAS.ID_ORDEN,3)||' SUBTOTAL: '||RPAD(S_SUBTOTAL,4)||' MONTO_IGV: '||RPAD(S_MONTO_IGV,3)||' MONTO_TOTAL: '||RPAD(S_MONTO_TOTAL,4));
        --ahora agrego los calculos a la tabla orden_compra
        UPDATE SP_ORDEN_COMPRA
        SET MONTO_TOTAL = S_MONTO_TOTAL, SUBTOTAL = S_SUBTOTAL, MONTO_IGV = S_MONTO_IGV
        WHERE ID_ORDEN = RCOMPRAS.ID_ORDEN;
        
    END LOOP;
END;
/
EXEC SP_RECALCULAR_ORDEN_COMPRA();
/
---------------------------------------------------------------------------------------------
--PREGUNTA 4: realizar un TRIGGER que al agregar un nuevo registro en la tabla SP_DETALLE_COMPRA
--incremente el monto del subtotal de la orden de compra y recalcule el MONTO_IGV y MONTO_TOTAL
---------------------------------------------------------------------------------------------
SELECT * FROM SP_DETALLE_COMPRA; --ID_ORDEN , SUBTOTAL
SELECT * FROM SP_ORDEN_COMPRA; --ID_ORDEN, SUBTOTAL , RECALCULAR(MONTO_TOTAL , MONTO_IGV)
/
CREATE OR REPLACE TRIGGER TR_AGREGAR_NUEVO_REGISTRO
AFTER INSERT ON SP_DETALLE_COMPRA
FOR EACH ROW
BEGIN
    UPDATE SP_ORDEN_COMPRA
    SET SUBTOTAL = SUBTOTAL + :NEW.SUBTOTAL,MONTO_IGV = (SUBTOTAL + :NEW.SUBTOTAL)*0.18 
    WHERE ID_ORDEN = :NEW.ID_ORDEN;
    --sigo realizando el update
    UPDATE SP_ORDEN_COMPRA
    SET MONTO_TOTAL = MONTO_IGV + SUBTOTAL
    WHERE ID_ORDEN = :NEW.ID_ORDEN;

END;
/
SELECT * FROM SP_ORDEN_COMPRA WHERE ID_ORDEN = 1;
/
INSERT INTO SP_DETALLE_COMPRA (ID_COMPRA,ID_ORDEN,ID_INSUMO,CANTIDAD,SUBTOTAL)
VALUES (12,1,5,270.0,675);
/
SELECT * FROM SP_ORDEN_COMPRA WHERE ID_ORDEN = 1;
/
---------------------------------------------------------------------------------------------
--PREGUNTA 5: realizar un TRIGGER que actualice el subtotal de la tabla SP_DETALLE_COMPRA 
--cuando se actualice el precio de un insumo (after update of xxx on xxx)
---------------------------------------------------------------------------------------------
SELECT * FROM SP_DETALLE_COMPRA;
SELECT * FROM SP_INSUMO;
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_SUBTOTAL
AFTER UPDATE OF PRECIO ON SP_INSUMO
FOR EACH ROW
BEGIN
    --solo se ejecuta si se llegó a realizar un cambio en el precio
    IF :NEW.PRECIO != :OLD.PRECIO THEN
        UPDATE SP_DETALLE_COMPRA
        SET SUBTOTAL = CANTIDAD * :NEW.PRECIO
        WHERE ID_INSUMO = :NEW.ID_INSUMO;
    END IF;
END;
/
SELECT ID_COMPRA, SUBTOTAL
FROM SP_DETALLE_COMPRA WHERE ID_INSUMO = 1;
/
UPDATE SP_INSUMO SET PRECIO = 1.13 WHERE ID_INSUMO = 1;
/
SELECT ID_COMPRA, SUBTOTAL
FROM SP_DETALLE_COMPRA WHERE ID_INSUMO = 1;
--------------------------------------------------------------------------
--TERMINADO :)

