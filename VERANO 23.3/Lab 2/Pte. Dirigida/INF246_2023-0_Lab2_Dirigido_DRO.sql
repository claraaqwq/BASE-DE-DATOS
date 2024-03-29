BEGIN
EXECUTE IMMEDIATE 'DROP TABLE LIBRO_PRESTADO CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE LIBRO_BIBLIOTECA CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ALUMNO CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE LIBRO CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE TIPOLIBRO  CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE BIBLIOTECA  CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE departamentos  CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/
BEGIN
EXECUTE IMMEDIATE 'DROP TABLE persona  CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE PROC_TIT_ASIG CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE HISTORIAL_LABORAL CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE HISTORIAL_SALARIAL CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE CARGOS CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE ESTUDIOS CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE UNIVERSIDADES CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE DEPARTAMENTOS CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE EMPLEADOS CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF;
END;
/