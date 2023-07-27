--TRABAJO BASE DE DATOS
SET SERVEROUTPUT ON
-------------------------------------------------------------------------------------------------
--PARTE CLARA:
-------------------------------------------------------------------------------------------------
/
SELECT * FROM hb_persona;
/
-------------------------------------------------------------------------------------------------
--1) PROCEDIMIENTO PARA INSERTAR UNA PERSONA CON SUS DATOS EN LA TABLA PERSONA
-------------------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE INSERTAR_PERSONA(K_NOMBRE VARCHAR2, K_APELLIDO VARCHAR2,K_TIPO CHAR)
IS
    C_CONTADOR NUMBER :=0;
BEGIN
    SELECT count(ID_PERSONA)INTO C_CONTADOR
    FROM HB_PERSONA;
    
    IF (K_TIPO = 'C' OR K_TIPO = 'M' ) THEN 
        INSERT INTO HB_PERSONA VALUES (C_CONTADOR+1,K_NOMBRE,K_APELLIDO,K_TIPO);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ingresó mal el tipo de persona');
    END IF;
END;
/
EXEC INSERTAR_PERSONA('MARIO','MEDINA','X');
/
-------------------------------------------------------------------------------------------------
--2) TRIGGER QUE MANDE MENSAJE DESPUES DE INSERTAR, PARA SABER QUE TIPO DE PERSONA INGRESÓ 
-------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TR_INSERTAR_PERSONA
AFTER INSERT ON HB_PERSONA
FOR EACH ROW
DECLARE

BEGIN

    IF :NEW.TIPO_PERSONA = 'C' THEN
        dbms_output.put_line('El tipo de persona que se ingresó es un CAJERO');
    END IF;
    
    IF :NEW.TIPO_PERSONA = 'M' THEN
        dbms_output.put_line('El tipo de persona que se ingresó es un MOTORIZADO');
    END IF;
    
END;
/
EXEC INSERTAR_PERSONA('MELISSA','MERINO','M');
/
-------------------------------------------------------------------------------------------------
--3) TRIGGER QUE ME IMPRIME EL LOTE DESPUES DE ACTUALIZAR, IMPRIME EL ANTIGUO Y EL NUEVO
-------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TR_INGRESO_CANT_LOTE
BEFORE UPDATE ON HB_LOTE
FOR EACH ROW
DECLARE
    CANTIDAD_ANT_LOTE NUMBER;
    CANTIDAD_NUEVA_LOTE NUMBER;
    V_COUNT NUMBER :=0;
    CustomException EXCEPTION;
BEGIN
    
    IF(:NEW.CANTIDAD > :OLD.STOCK_MAXIMO) THEN
        raise CustomException;
    END IF;
    
    CANTIDAD_ANT_LOTE:= :OLD.CANTIDAD;
    
    dbms_output.put_line('ID_LOTE: '||:NEW.ID_LOTE);
    dbms_output.put_line('Lote anterior: '||CANTIDAD_ANT_LOTE);
    
    CANTIDAD_NUEVA_LOTE:= :NEW.CANTIDAD;
    
    dbms_output.put_line('Lote Nuevo: '||CANTIDAD_NUEVA_LOTE);
EXCEPTION
    WHEN CustomException THEN
        DECLARE
        v_error_msg VARCHAR2(200) := 'Sobrepasa el stock maximo.';
        BEGIN
        RAISE_APPLICATION_ERROR(-20001, v_error_msg);
    END;
END;
/
UPDATE HB_LOTE
SET CANTIDAD = CANTIDAD+110
WHERE ID_INGREDIENTE = 1001;
/
SELECT * FROM HB_LOTE;
/
--TABLAS MODIFICADAS
SELECT* FROM HB_LOTE
ORDER BY ID_LOTE ASC;
SELECT * FROM HB_PERSONA
ORDER BY ID_PERSONA ASC;
SELECT * FROM HB_INGREDIENTE
ORDER BY ID_INGREDIENTE;
--:)
/
-------------------------------------------------------------------------------------------------
--PARTE ANTONIO:
-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
--4) FUNCION QUE RETORNA LA CANTIDAD DE LOTES DE UN INGREDIENTE EN ESPECIFICO
-------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION F_OBTENER_CANT_LOTES(F_ID_INGREDIENTE NUMBER)
RETURN VARCHAR2
IS
    V_MENSAJE VARCHAR2(100 BYTE);
    V_CANTIDAD NUMBER := 0;
BEGIN  
    SELECT COUNT(*)
    INTO V_CANTIDAD
    FROM HB_LOTE L
    WHERE L.ID_INGREDIENTE = F_ID_INGREDIENTE;
    
    IF V_CANTIDAD = 0 THEN
        V_MENSAJE := 'NO SE CUENTA CON LOTES DEL INGREDIENTE CONSULTADO.';
    ELSE
        V_MENSAJE := 'SE CUENTA CON '||V_CANTIDAD||' LOTES DEL INGREDIENTE CONSULTADO.';
    END IF;
    
    RETURN V_MENSAJE;
END;
/
DECLARE
    MENSAJE VARCHAR2(100);
BEGIN
    MENSAJE := F_OBTENER_CANT_LOTES(1001);
    DBMS_OUTPUT.PUT_LINE(MENSAJE);
END;
/
SELECT * FROM HB_LOTE;
-------------------------------------------------------------------------------------------------
--5) En caso el cliente desee hacer un reclamo por sus orden,
--tenemos q verificar que esta orden exista
-------------------------------------------------------------------------------------------------
/
CREATE OR REPLACE FUNCTION F_BUSCAR_ORDEN(F_ID_PEDIDO NUMBER)
RETURN VARCHAR2
IS
    F_MENSAJE VARCHAR2(100);
    F_PEDIDO  NUMBER;
BEGIN
    SELECT ID_PEDIDO INTO F_PEDIDO
    FROM HB_PEDIDO
    WHERE F_ID_PEDIDO = ID_PEDIDO;
    
    F_MENSAJE := 'LA ORDEN '||F_ID_PEDIDO||' SI EXISTE';
    
    RETURN F_MENSAJE;
EXCEPTION

    WHEN NO_DATA_FOUND THEN
        F_MENSAJE := 'LA ORDEN '||F_ID_PEDIDO||' NO EXISTE';
    RETURN F_MENSAJE;
END;
/
DECLARE
    MENSAJE VARCHAR2(100);
BEGIN
    MENSAJE := F_BUSCAR_ORDEN(34566);
    DBMS_OUTPUT.PUT_LINE(MENSAJE);
END;
/
SELECT * FROM HB_PEDIDO;
/
-------------------------------------------------------------------------------------------------
--PARTE JOSUE:
-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
--6) PROCEDIMIENTO QUE DEVUELVA LOS PRODUCTOS VENDIDOS EN X FECHA  + CURSORES
-------------------------------------------------------------------------------------------------
create or replace procedure productosVendidosFecha(fecha_ingresada date)
AS
nombre_producto varchar2(60);
codigo_producto number;
cantidad_productos number;
cantidad_total number;
cantidad_fechas number;
precio_producto number;
total_producto number;
CURSOR C1 IS
    SELECT ID_PRODUCTO, NOMBRE,PRECIO
    FROM HB_PRODUCTO;
CURSOR C2(codigo_producto number) IS
    select (cant_producto)
    from hb_Detalle_pedido PO,hb_pedido P
    where id_producto=codigo_producto and PO.ID_PEDIDO=P.ID_PEDIDO and 
            to_char(FECHA,'dd/mm/yy')=to_char(fecha_ingresada,'dd/mm/yy');
   
BEGIN
    SELECT COUNT(*)into cantidad_fechas
    FROM HB_PEDIDO
    WHERE to_char(FECHA,'dd/mm/yy')=fecha_ingresada;
    
    if(cantidad_fechas=0)then
    raise no_Data_found;
    end if;
    dbms_output.put_line('Productos vendidos en el día '||fecha_ingresada);
    dbms_output.put_line('---------------------------------');
    open c1;
    loop
        fetch c1 into codigo_producto,nombre_producto,precio_producto;
        exit when c1%NOTFOUND;
   
        cantidad_total:=0;
        open c2(codigo_producto);
            loop
                fetch c2 into cantidad_productos;
                exit when c2%NOTFOUND;
                cantidad_total:=cantidad_total+cantidad_productos;
            end loop;
        total_producto:=cantidad_total*precio_producto;
        if(cantidad_total>0)then 
        dbms_output.put_line('Producto: '||nombre_producto||' ('||codigo_producto||')');
        dbms_output.put_line('---------------------------------------------------------------------------');
        dbms_output.put_line('La cantidad total vendida de este producto en el día fue de '||cantidad_total);
        dbms_output.put_line('El monto total recaudado en este producto en soles fue de: '||total_producto);
        dbms_output.put_line('=========================================================================');
        end if;
        close c2;
    end loop;
    close c1;
Exception
WHEN no_data_found THEN
    dbms_output.put_line('Aún no se han registrado pedidos para la fecha ingresada');
END;

/
set SERVEROUTPUT ON
exec productosVendidosFecha(to_date('27/06/2023','dd/mm/yyyy'));
/
set SERVEROUTPUT ON
exec productosVendidosFecha(to_date('20/04/2023','dd/mm/yyyy'));
/
select * from hb_pedido;
-------------------------------------------------------------------------------------------------
--7) PROCEDIMIENTO QUE CALCULE EL MONTO TOTAL VENDIDO X DIA
-------------------------------------------------------------------------------------------------
create or replace procedure calcularMontoDia(fecha_ingreso date)
is
montoTotal number;
begin
  select NVL(sum(monto),0)into montoTotal
  from hb_pedido
  where to_char(FECHA,'dd/mm/yy')=to_char(fecha_ingreso,'dd/mm/yy');
  
  if(montoTotal<=0) then
    raise no_data_found;
  end if;
  
  dbms_output.put_line('El monto total en el dia '||fecha_ingreso||' es: '|| montoTotal|| ' soles');
exception
WHEN no_data_found THEN
    dbms_output.put_line('No existe monto total para el día ingresado');
END;
/
set SERVEROUTPUT ON;
declare
fecha_ingreso date;
begin
fecha_ingreso := to_date('20/04/2023','dd/mm/yyyy');
calcularMontoDia(fecha_ingreso);
end;
/
-------------------------------------------------------------------------------------------------
--8) TRIGGER QUE COMPLETA LA TABLA ENTREGA
-------------------------------------------------------------------------------------------------
create or replace trigger completar_tabla_entrega
after insert on hb_pedido
for each row
declare
hora_pedido number;
minuto_pedido number;
segundo_pedido number;
tiempo_total char(8);
max_valor number;
val number;
tiempo_pedido number;
fuera_de_trabajo exception;
begin
    if(:new.Tipo_pedido ='D')then
        select max(id_entrega)into max_valor
        from hb_entrega;
        max_valor:=max_valor+1;
        hora_pedido:= TO_NUMBER(TO_CHAR(TO_DATE(:new.hora_pedido, 'HH24:MI:SS'), 'HH24'));
        minuto_pedido:=TO_NUMBER(TO_CHAR(TO_DATE(:new.hora_pedido, 'HH24:MI:SS'), 'MI'));
        segundo_pedido:=TO_NUMBER(TO_CHAR(TO_DATE(:new.hora_pedido, 'HH24:MI:SS'), 'SS'));
        tiempo_pedido:=hora_pedido||minuto_pedido;
            if(tiempo_pedido>2130)then
                raise fuera_de_trabajo;
            end if;
        tiempo_total:=hora_pedido*3600+minuto_pedido*60+segundo_pedido+45*60;
        hora_pedido:=TRUNC(tiempo_total/3600);
        val:=MOD(tiempo_total,3600);
        minuto_pedido:=TRUNC(val/60);
        segundo_pedido:=MOD(val,60);
        tiempo_total:=hora_pedido||':'||minuto_pedido||':'||segundo_pedido;
        insert into hb_entrega values (max_valor,:new.id_pedido,1,TO_CHAR(TO_DATE(tiempo_total,'HH24:MI:SS'),'HH24'||':'||'MI'||':'||'SS'));
        dbms_output.put_line('Se ha ingresado un nuevo registro a la tabla de entregas');
    end if;
    EXCEPTION
    WHEN fuera_de_trabajo THEN
        DECLARE
        v_error_msg VARCHAR2(200) := 'No se pueden entregar deliverys en esa hora de trabajo';
        BEGIN
        RAISE_APPLICATION_ERROR(-20001, v_error_msg);
    END;
end;
/
-------------------------------------------------------------------------------------------------
--PARTE GABRIEL:
-------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
--9) PROCEDIMIENTO QUE AÑADE UN LOTE
-------------------------------------------------------------------------------------------------
CREATE or REPLACE PROCEDURE anadir_lote(p_nombre varchar2, p_cantidad number )
as
cursor c1 is select L.id_ingrediente,id_lote,cantidad,stock_maximo,fecha_vencimiento,fecha_ingreso from hb_lote L, hb_ingrediente ing
where ing.id_ingrediente = L.id_ingrediente and ing.nombre = p_nombre;
-- variables del fetch
id_ingredi number;
canti number;
stmax number;
id_lot number;
fvenci date;
fingre date;
--variables en caso se ingresa una nueva fila
auxmax number;--stock maximo
auxfing varchar2 (8 byte);--f ingreso
auxfven varchar2 (8 byte);-- f vencimiento
auxidingred number;-- id_ingrediente
maxIdlote number;--permite ingresar un nuevo id_lote
maxNumLote number;--permite ingresar un nuevo numero_lote
bandera number;--para que el programa sepa si se actualizo o no
begin
    bandera:=0;
    open c1;
    loop
        fetch c1 into id_ingredi,id_lot,canti,stmax,fvenci,fingre;
        exit when c1%NOTFOUND;
        auxmax:=stmax;
        auxfing:=to_char(fingre);
        auxfven:=to_char(fvenci);
        auxidingred:=id_ingredi;
        if(canti + p_cantidad <= stmax) then
            update hb_lote L
            set L.cantidad = L.cantidad  + p_cantidad
            where L.id_lote = id_lot;
            bandera:=1;
            exit;
        end if;
    end loop;
    close c1;
    --si no se actualizo añado un nuevo lote
    if bandera = 0 and p_cantidad <=auxmax then
        select max(id_lote) into maxIdlote from hb_lote;
        select max(numero_lote) into maxNumLote from hb_lote L  where L.id_ingrediente = auxidingred;
        insert into hb_lote values(maxIdlote+1,p_nombre,maxNumLote+1,auxidingred,p_cantidad,auxfven,auxfing,auxmax);
    else
        if bandera <> 1 then
            dbms_output.put_line('No es posible ingresar dicha cantidad, ya que sobrepasa el maximo');
        end if;
    end if;
end;

/
EXEC anadir_lote('queso',2);
/
SELECT * FROM HB_LOTE;
-------------------------------------------------------------------------------------------------
--10) TRIGGER QUE MUESTRA MENSAJE DE ACTUALIZACION
-------------------------------------------------------------------------------------------------
create or replace trigger mensajeAc_In_Lote
after insert or update on hb_lote
for each row
begin
    if inserting then
        dbms_output.put_line('Se inserto una nueva tupla con id_ingrediente: ' || :new.id_ingrediente);
    end if;
    if updating then
        dbms_output.put_line('Se actualizo el lote numero: ' || :old.numero_lote || ' con id_ingrediente igual a ' ||
        :old.id_ingrediente || ', se actualizo con una cantidad total igual a : ' || :new.cantidad);
    end if;
end;
/
-------------------------------------------------------------------------------------------------
--PARTE ANYELO:
-------------------------------------------------------------------------------------------------
select * from hb_lote;
/
-------------------------------------------------------------------------------------------------
--11)PROCEDIMIENTO PARA MOVER DATOS COMO UNA COLA
-------------------------------------------------------------------------------------------------
CREATE OR REPLACE 
procedure mover(ID_PROD NUMBER ,ID_INGRED NUMBER)
is 
lote_anterior number;
lote_siguiente number;
pos number;
canti number;
maxim number;
pos2 number;
fecha1 date;
fecha2 date;
begin
pos:=1;
pos2:=0;
select max(numero_lote) into maxim from hb_lote where id_ingrediente=id_ingred;
loop
pos2:=pos2+1;
select cantidad,fecha_vencimiento,fecha_ingreso into canti ,fecha1,fecha2 from hb_lote where id_ingrediente=id_ingred and numero_lote=pos2 ;
if canti>0 then
update hb_lote 
set cantidad=canti,fecha_ingreso=fecha2,fecha_vencimiento=fecha1
where numero_lote=pos and id_ingrediente=id_ingred;

pos:=pos+1;
delete hb_lote
where numero_lote=pos2 and id_ingrediente=id_ingred;
end if;
exit when pos2= maxim;
end loop;
end;
/
--Proceso:
-------------------------------------------------------------------------------------------------
--12) PROCEDIMIENTOQUE QUITA VALORES DE MENOR LOTE
-------------------------------------------------------------------------------------------------
create or replace
procedure at_colas(ID_PROD NUMBER ,ID_INGRED NUMBER, CANT_UTILIZAR NUMBER ,CANT_PEDIDOS NUMBER)
is
CANTIDAD_AUX NUMBER;
NUM_LOTE NUMBER;
CANT_QUITAR NUMBER;
BEGIN
CANT_QUITAR:=CANT_PEDIDOS*CANT_UTILIZAR;
NUM_LOTE:=0;
LOOP 
NUM_LOTE:=NUM_LOTE+1;
SELECT CANTIDAD INTO CANTIDAD_AUX FROM HB_LOTE WHERE ID_INGREDIENTE=ID_INGRED AND NUMERO_LOTE=NUM_LOTE;
IF CANT_QUITAR>CANTIDAD_AUX THEN
CANT_QUITAR:=CANT_QUITAR-CANTIDAD_AUX;
UPDATE HB_LOTE SET  CANTIDAD=0 WHERE ID_INGREDIENTE=ID_INGRED AND NUMERO_LOTE=NUM_LOTE;
ELSE
UPDATE HB_LOTE SET  CANTIDAD=CANTIDAD_AUX-CANT_QUITAR WHERE ID_INGREDIENTE=ID_INGRED AND NUM_LOTE=NUMERO_LOTE;
CANT_QUITAR:=0;
END IF;
EXIT WHEN CANT_QUITAR=0;
END LOOP;
NUM_LOTE:=0;
END;
/
--para at colas
execute at_colas(10,1001,10,2);

--para actualizar
UPDATE HB_PEDIDO
SET ESTADO='E'
WHERE ID_PEDIDO=34566;

--para reiniciar
UPDATE hb_lote 
SET cantidad=100
WHERE id_lote>0;
/
-------------------------------------------------------------------------------------------------
--13) PROCEDIMIENTO PARA ACTUALIZAR LOS LOTES
-------------------------------------------------------------------------------------------------
CREATE OR REPLACE procedure actualizar_cant_ing_combos(ID_PED NUMBER )
is 
    CURSOR COMB IS select i.id_producto,i.id_ingrediente,i.cantidad
        ,(select sum(cantidad)
        from HB_PRODUCTO_COMBO  
        where id_combo in (SELECT ID_PRODUCTO FROM HB_DETALLE_PEDIDO WHERE ID_PEDIDO=ID_PED) 
        and id_producto=i.id_producto
        group by id_producto)
    from hb_hamburguesa_ingrediente i
    where id_producto in (select id_producto
        from HB_PRODUCTO_COMBO  
        where id_combo in (SELECT ID_PRODUCTO FROM HB_DETALLE_PEDIDO WHERE ID_PEDIDO=ID_PED) 
        and i.id_producto>=5
        group by id_producto)
    order by id_producto;

    CURSOR NOR IS 
    select i.id_producto,i.id_ingrediente,i.cantidad, nvl((select d.cant_producto
        from hb_detalle_pedido D,HB_PRODUCTO PR
        where PR.ID_PRODUCTO=d.id_producto and D.id_pedido=ID_PED
        and pr.tipo='N' and d.id_producto=i.id_producto),0)  as cantidad_pedidos
    from hb_hamburguesa_ingrediente i
    where id_producto in (select id_producto
        from HB_PRODUCTO_COMBO  
        where id_combo in (SELECT ID_PRODUCTO FROM HB_DETALLE_PEDIDO WHERE ID_PEDIDO=ID_PED) )
    order by id_producto;

    ID_PROD NUMBER;
    ID_INGRED NUMBER;
    CANT_UTILIZAR NUMBER;
    CANT_PEDIDOS NUMBER;
begin
OPEN COMB;
OPEN NOR;
    LOOP
    FETCH COMB INTO ID_PROD,ID_INGRED,CANT_UTILIZAR,CANT_PEDIDOS;
    EXIT WHEN COMB%NOTFOUND;
    
    at_colas(ID_PROD,ID_INGRED,CANT_UTILIZAR,CANT_PEDIDOS);
    mover(ID_PROD,ID_INGRED);
    
    END LOOP;

    LOOP
    FETCH NOR INTO ID_PROD,ID_INGRED,CANT_UTILIZAR,CANT_PEDIDOS;
    EXIT WHEN NOR%NOTFOUND;
    
    at_colas(ID_PROD,ID_INGRED,CANT_UTILIZAR,CANT_PEDIDOS);
    mover(ID_PROD,ID_INGRED);
    
    END LOOP;
CLOSE COMB;
CLOSE NOR;
exception
when others then 
dbms_output.put_line('no se deberia haber podido generar el pedido, verifique su almacen');
end;
/
-------------------------------------------------------------------------------------------------
--14) TRIGGER PARA ACTUALIZAR DATOS DE LOTES
-------------------------------------------------------------------------------------------------
create or replace trigger actualizar_datos_lotes
after update of estado on hb_pedido
for each row when (new.estado='E')
begin
 actualizar_cant_ing_combos(:old.id_pedido);
end;
/
UPDATE HB_PEDIDO
SET ESTADO='E'
WHERE ID_PEDIDO=34566;
/
-------------------------------------------------------------------------------------------------
--TERMINADO:)
-------------------------------------------------------------------------------------------------