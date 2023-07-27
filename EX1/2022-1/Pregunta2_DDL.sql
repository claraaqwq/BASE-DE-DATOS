CREATE TABLE e1_autor (
    id_autor    NUMBER NOT NULL,
    apellidos   VARCHAR2(40) NOT NULL,
    nombres     VARCHAR2(40) NOT NULL
);

ALTER TABLE e1_autor ADD CONSTRAINT autor_pk PRIMARY KEY ( id_autor );

CREATE TABLE e1_autordelibro (
    id_libro   NUMBER NOT NULL,
    id_autor   NUMBER NOT NULL
);

ALTER TABLE e1_autordelibro ADD CONSTRAINT autordelibro_pk PRIMARY KEY ( id_libro,
                                                                         id_autor );

CREATE TABLE e1_copia (
    numcopia       NUMBER(2) NOT NULL,
    edicion_isbn   NUMBER(13) NOT NULL
);

ALTER TABLE e1_copia ADD CONSTRAINT copia_pk PRIMARY KEY ( numcopia );

CREATE TABLE e1_edicion (
    isbn        NUMBER(13) NOT NULL,
    anho        NUMBER(4) NOT NULL,
    id_libro    NUMBER NOT NULL,
    id_idioma   NUMBER NOT NULL
);

ALTER TABLE e1_edicion ADD CONSTRAINT edicion_pk PRIMARY KEY ( isbn );

CREATE TABLE e1_libro (
    id_libro   NUMBER NOT NULL,
    titulo     VARCHAR2(120) NOT NULL
);

ALTER TABLE e1_libro ADD CONSTRAINT libro_pk PRIMARY KEY ( id_libro );

CREATE TABLE e1_prestamo (
    fechaprestamo     DATE NOT NULL,
    numcopia          NUMBER(2) NOT NULL,
    id_usuario        NUMBER NOT NULL,
    fechadevolucion   DATE NOT NULL,
    fechadevuelto     DATE
);

ALTER TABLE e1_prestamo
    ADD CONSTRAINT prestamo_pk PRIMARY KEY ( fechaprestamo,
                                             numcopia,
                                             id_usuario );

CREATE TABLE e1_usuario (
    id_usuario   NUMBER NOT NULL,
    nombre       VARCHAR2(40) NOT NULL
);

ALTER TABLE e1_usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

CREATE TABLE e1_idioma (
    id_idioma     NUMBER NOT NULL,
    descripcion   VARCHAR2(60) NOT NULL
);

ALTER TABLE e1_idioma ADD CONSTRAINT idioma_pk PRIMARY KEY ( id_idioma );

ALTER TABLE e1_autordelibro
    ADD CONSTRAINT autordelibro_autor_fk FOREIGN KEY ( id_autor )
        REFERENCES e1_autor ( id_autor );

ALTER TABLE e1_autordelibro
    ADD CONSTRAINT autordelibro_libro_fk FOREIGN KEY ( id_libro )
        REFERENCES e1_libro ( id_libro );

ALTER TABLE e1_copia
    ADD CONSTRAINT copia_edicion_fk FOREIGN KEY ( edicion_isbn )
        REFERENCES e1_edicion ( isbn );

ALTER TABLE e1_edicion
    ADD CONSTRAINT edicion_idioma_fk FOREIGN KEY ( id_idioma )
        REFERENCES e1_idioma ( id_idioma );

ALTER TABLE e1_edicion
    ADD CONSTRAINT edicion_libro_fk FOREIGN KEY ( id_libro )
        REFERENCES e1_libro ( id_libro );

ALTER TABLE e1_prestamo
    ADD CONSTRAINT prestamo_copia_fk FOREIGN KEY ( numcopia )
        REFERENCES e1_copia ( numcopia );

ALTER TABLE e1_prestamo
    ADD CONSTRAINT prestamo_usuario_fk FOREIGN KEY ( id_usuario )
        REFERENCES e1_usuario ( id_usuario );
