-- ALEX CALERO REVILLA - 20206455

-- PARTE B
CREATE OR REPLACE TRIGGER TR_AUMENTAR_COMUNICACIONES
AFTER INSERT ON COMUNICACIONXEXPEDIENTE
FOR EACH ROW
DECLARE
    V_COMUNICACIONES_PARCIALES NUMBER;
BEGIN
    /*
    guardo el valor que hay en total_comunicaciones en mi variable v_comunicaciones_parciales,
    si es la primera vez q voy a agregar una comunicacion, entonces total_comunicaciones será
    null, ya que ese valor se le da por defecto al crear la tabla. Por lo tanto, uso la funcion
    NVL para que me retorne 0 la primera vez que agregué una comunicacion, cuando ya sea la
    segunda o tercera vez, el NVL me va a devolver ese valor sin ningun problema.
    */
    SELECT NVL(TOTAL_COMUNICACIONES,0)
    INTO V_COMUNICACIONES_PARCIALES
    FROM EXPEDIENTE
    WHERE IDEXPEDIENTE = :NEW.IDEXPEDIENTE;
    
    /*
    el total_comunicaciones va a ir aumentando de uno en uno, por eso utilizo el valor
    almacenado en la variable v_comunicaciones_parciales, que tiene el valor hasta antes
    de haber agregado esta ultima comunicacion.
    */
    UPDATE EXPEDIENTE
    SET TOTAL_COMUNICACIONES = V_COMUNICACIONES_PARCIALES + 1
    WHERE IDEXPEDIENTE = :NEW.IDEXPEDIENTE;
END;
/
CREATE OR REPLACE TRIGGER TR_AUMENTAR_SERVICIOS
AFTER INSERT ON SERVICIOXEXPEDIENTE
FOR EACH ROW
DECLARE
    V_SERVICIOS_PARCIALES NUMBER;
BEGIN
    SELECT NVL(TOTAL_SERVICIOS,0)
    INTO V_SERVICIOS_PARCIALES
    FROM EXPEDIENTE
    WHERE IDEXPEDIENTE = :NEW.IDEXPEDIENTE;
    
    UPDATE EXPEDIENTE
    SET TOTAL_SERVICIOS = V_SERVICIOS_PARCIALES + 1
    WHERE IDEXPEDIENTE = :NEW.IDEXPEDIENTE;
END;