-- ALEX CALERO REVILLA - 20206455

SET SERVEROUTPUT ON;

-- PREGUNTA 1
CREATE OR REPLACE PROCEDURE SP_IMPRIMIR_ORDENES_SABOR(p_id_sabor IN NUMBER)
IS
    CURSOR cur_ord_prod(p_id_sabor IN NUMBER) IS
    SELECT id_orden_produccion, cantidad,
           fecha_hora_term_planif, fecha_hora_term_real
    FROM he_orden_produccion
    WHERE id_sabor = p_id_sabor;
    
    nomb_sabor he_sabor.nombre%type;
BEGIN
    SELECT nombre INTO nomb_sabor
    FROM he_sabor s
    WHERE s.id_sabor = p_id_sabor;
    dbms_output.put_line('Sabor: '||nomb_sabor);
    dbms_output.put_line('ÓRDENES DE PRODUCCIÓN');
    FOR reg IN cur_ord_prod(p_id_sabor) LOOP
        dbms_output.put_line('Orden de producción ID. '||reg.id_orden_produccion);
        dbms_output.put_line('Fecha de término (planificado): '||reg.fecha_hora_term_planif);
        IF reg.fecha_hora_term_real IS NOT NULL THEN
            dbms_output.put_line('Fecha de término (real): '||reg.fecha_hora_term_real);
        END IF;
        dbms_output.put_line('Cantidad: '||reg.cantidad||' lotes');
        dbms_output.put_line('');
    END LOOP;
END;
/
-- PRUEBO SALIDAS
EXEC SP_IMPRIMIR_ORDENES_SABOR(1);
EXEC SP_IMPRIMIR_ORDENES_SABOR(2);
EXEC SP_IMPRIMIR_ORDENES_SABOR(3);
/

-- PREGUNTA 2
CREATE OR REPLACE PROCEDURE SP_IMPRIMIR_PEDIDOS_CLIENTE(p_id_cliente IN NUMBER)
IS
    CURSOR cur_ped(p_id_cliente IN NUMBER) IS
    SELECT id_pedido
    FROM he_pedido
    WHERE id_cliente = p_id_cliente;
    
    CURSOR cur_post_comp(p_id_pedido NUMBER) IS
    SELECT id_postre, id_complemento_postre
    FROM he_pedido_postre
    WHERE id_pedido = p_id_pedido;
    
    nomb_cliente he_cliente.nombres%type;
    apel_cliente he_cliente.apellidos%type;
    nomb_postre he_postre.nombre%type;
    nomb_comple he_complemento_postre.nombre%type;
BEGIN
    SELECT nombres, apellidos INTO nomb_cliente, apel_cliente
    FROM he_cliente c
    WHERE c.id_cliente = p_id_cliente;
    dbms_output.put_line('Cliente: '||nomb_cliente||' '||apel_cliente);
    dbms_output.put_line('PEDIDOS');
    FOR reg_cli IN cur_ped(p_id_cliente) LOOP
        dbms_output.put_line('Pedido ID. '||reg_cli.id_pedido);
        FOR reg_ped IN cur_post_comp(reg_cli.id_pedido) LOOP
            SELECT nombre INTO nomb_postre FROM he_postre p
            WHERE p.id_postre = reg_ped.id_postre;
            IF reg_ped.id_complemento_postre IS NOT NULL THEN
                SELECT nombre INTO nomb_comple FROM he_complemento_postre cp
                WHERE cp.id_complemento_postre = reg_ped.id_complemento_postre;
            END IF;
            IF reg_ped.id_complemento_postre IS NOT NULL THEN
                dbms_output.put_line('-'||nomb_postre||' con '||nomb_comple);
            ELSE
                dbms_output.put_line('-'||nomb_postre);
            END IF;   
        END LOOP;
        dbms_output.put_line('');
    END LOOP;
END;
/
-- PRUEBO SALIDAS
EXEC SP_IMPRIMIR_PEDIDOS_CLIENTE(1);
EXEC SP_IMPRIMIR_PEDIDOS_CLIENTE(2);
EXEC SP_IMPRIMIR_PEDIDOS_CLIENTE(3);
/

-- PREGUNTA 3
CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_STOCK
AFTER INSERT ON he_orden_produccion
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.ESTADO = 'T' THEN
        UPDATE he_sabor SET stock = stock - (:NEW.cantidad*0.6)
        WHERE id_sabor = :NEW.id_sabor;
    END IF;
END;
/

-- PREGUNTA 4
-- PARTE 1
CREATE OR REPLACE PROCEDURE SP_ACTUALIZAR_PRECIO_PEDIDO(p_id_pedido IN NUMBER)
IS
    CURSOR cur_ped_post(p_id_pedido IN NUMBER) IS
    SELECT id_postre, id_complemento_postre
    FROM he_pedido_postre
    WHERE id_pedido = p_id_pedido;
    
    prec_tot_postre he_postre.precio%type;
    prec_parc_postre he_postre.precio%type;
    prec_tot_comple he_complemento_postre.precio%type;
    prec_parc_comple he_complemento_postre.precio%type;
    nuevo_precio he_pedido.precio%type;
BEGIN
    prec_tot_postre := 0;
    prec_tot_comple := 0;
    FOR reg IN cur_ped_post(p_id_pedido) LOOP
        SELECT precio INTO prec_parc_postre
        FROM he_postre WHERE id_postre = reg.id_postre;
        prec_tot_postre := prec_tot_postre + prec_parc_postre;
        SELECT precio INTO prec_parc_comple
        FROM he_complemento_postre
        WHERE id_complemento_postre = reg.id_complemento_postre;
        prec_tot_comple := prec_tot_comple + prec_parc_comple;
    END LOOP;
    nuevo_precio := prec_tot_postre + prec_tot_comple;
    UPDATE he_pedido SET precio = nuevo_precio WHERE id_pedido = p_id_pedido;
END;
/