CREATE SCHEMA IF NOT EXISTS dw;

CREATE TABLE dw.shipping_dim
	( shipping_id serial NOT NULL,
 	ship_mode   varchar(25) NOT NULL,
 	CONSTRAINT PK_41 PRIMARY KEY ( shipping_id ));

CREATE TABLE sdw.segment_dim
	( segment_id   serial NOT NULL,
 	segment_name varchar(50) NOT NULL,
 	CONSTRAINT PK_67 PRIMARY KEY ( segment_id ));


CREATE TABLE dw.returned_dim
	( order_id varchar(20) NOT NULL,
 	returned boolean NOT NULL,
 	CONSTRAINT PK_77 PRIMARY KEY ( order_id ));


CREATE TABLE dw.product_dim
	( product_id   varchar(20) NOT NULL,
 	category     varchar(20) NOT NULL,
 	subcategory  varchar(15) NOT NULL,
 	product_name varchar(130) NOT NULL,
 	CONSTRAINT PK_5 PRIMARY KEY ( product_id, product_name) /* Т.к. в таблице orders обнаружилось разное 
 	название товара с одинаковыми product_id, пришлось сделать составной  CONSTRAINT из product_id, product_name 
 	во избежания потери данных*/
);




CREATE TABLE dw.location_dim
	( 	location_id       serial NOT NULL,
 	country           varchar(50) NOT NULL,
 	region            varchar(50) NOT NULL,
 	"state"             varchar(50) NOT NULL,
 	city              varchar(50) NOT NULL,
 	postal_code       varchar(10) NULL,
 	manager_full_name varchar(50) NOT NULL,
 	CONSTRAINT PK_47 PRIMARY KEY ( location_id ));



CREATE TABLE dw.customer_dim
	( customer_id   varchar(15) NOT NULL,
 	castomer_name varchar(50) NOT NULL,
 	CONSTRAINT PK_35 PRIMARY KEY ( customer_id ));


CREATE TABLE dw.calendar_dim (
 	date      date NOT NULL,
 	ship_date date NOT NULL,
 	year      int NOT NULL,
 	month     int NOT null,
 	CONSTRAINT PK_10 PRIMARY KEY (date, ship_date));


CREATE TABLE dw.sales_fact
	( row_id         serial NOT NULL,
 	order_id       varchar(20) NOT NULL,
 	segment_id     serial NOT NULL,
 	location_id    serial NOT NULL,
 	shipping_id    serial NOT NULL,
 	customer_id    varchar(15) NOT NULL,
 	product_id     varchar(20) NOT NULL,
 	"date"           date NOT NULL,
 	sales_amount   numeric(10,4) NOT NULL,
 	profit         numeric(10,4) NOT NULL,
 	quantity       int NOT NULL,
 	discount       smallint NOT NULL,
 	ship_date      date NOT NULL,
 	product_name varchar(130) NOT NULL,
 	CONSTRAINT PK_15 PRIMARY KEY ( row_id ),
 	CONSTRAINT FK_19 FOREIGN KEY ( "date", ship_date ) REFERENCES dw.calendar_dim ( "date", ship_date ),
 	CONSTRAINT FK_31 FOREIGN KEY ( product_id, product_name ) REFERENCES dw.product_dim ( product_id, product_name ),
 	CONSTRAINT FK_37 FOREIGN KEY ( customer_id ) REFERENCES dw.customer_dim ( customer_id ),
 	CONSTRAINT FK_43 FOREIGN KEY ( shipping_id ) REFERENCES dw.shipping_dim ( shipping_id ),
 	CONSTRAINT FK_53 FOREIGN KEY ( location_id ) REFERENCES dw.location_dim ( location_id ),
 	CONSTRAINT FK_69 FOREIGN KEY ( segment_id ) REFERENCES dw.segment_dim ( segment_id ));

 
CREATE INDEX FK_21 ON dw.sales_fact
	( "date",
 	ship_date);

CREATE INDEX FK_33 ON dw.sales_fact
	( product_id,
 	product_name);

CREATE INDEX FK_39 ON dw.sales_fact
	( customer_id);

CREATE INDEX FK_45 ON dw.sales_fact
	( shipping_id );

CREATE INDEX FK_55 ON dw.sales_fact
	( location_id );

CREATE INDEX FK_71 ON dw.sales_fact
	( segment_id);

CREATE INDEX FK_83 ON dw.sales_fact
	( order_id);