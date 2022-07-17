CREATE SCHEMA IF NOT EXISTS module2;

CREATE TABLE module2.shipping_dim
	( shipping_id serial NOT NULL,
 	ship_mode   varchar(25) NOT NULL,
 	CONSTRAINT PK_41 PRIMARY KEY ( shipping_id ));

CREATE TABLE module2.segment_dim
	( segment_id   serial NOT NULL,
 	segment_name varchar(50) NOT NULL,
 	CONSTRAINT PK_67 PRIMARY KEY ( segment_id ));


CREATE TABLE module2.returned_dim
	( order_id varchar(20) NOT NULL,
 	returned boolean NOT NULL,
 	CONSTRAINT PK_77 PRIMARY KEY ( order_id ));


CREATE TABLE module2.product_dim
	( product_id   varchar(20) NOT NULL,
 	category     varchar(20) NOT NULL,
 	subcategory  varchar(15) NOT NULL,
 	product_name varchar(130) NOT NULL,
 	CONSTRAINT PK_5 PRIMARY KEY ( product_id, product_name) /* Т.к. в таблице orders обнаружилось разное 
 	название товара с одинаковыми product_id, пришлось сделать составной  CONSTRAINT из product_id, product_name 
 	во избежания потери данных*/
);




CREATE TABLE module2.location_dim
	( 	location_id       serial NOT NULL,
 	country           varchar(50) NOT NULL,
 	region            varchar(50) NOT NULL,
 	"state"             varchar(50) NOT NULL,
 	city              varchar(50) NOT NULL,
 	postal_code       varchar(10) NULL,
 	manager_full_name varchar(50) NOT NULL,
 	CONSTRAINT PK_47 PRIMARY KEY ( location_id ));



CREATE TABLE module2.customer_dim
	( customer_id   varchar(15) NOT NULL,
 	castomer_name varchar(50) NOT NULL,
 	CONSTRAINT PK_35 PRIMARY KEY ( customer_id ));


CREATE TABLE module2.calendar_dim (
 	date      date NOT NULL,
 	ship_date date NOT NULL,
 	year      int NOT NULL,
 	month     int NOT null,
 	CONSTRAINT PK_10 PRIMARY KEY (date, ship_date));


CREATE TABLE module2.sales_fact
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
 	CONSTRAINT FK_19 FOREIGN KEY ( "date", ship_date ) REFERENCES calendar_dim ( "date", ship_date ),
 	CONSTRAINT FK_31 FOREIGN KEY ( product_id, product_name ) REFERENCES product_dim ( product_id, product_name ),
 	CONSTRAINT FK_37 FOREIGN KEY ( customer_id ) REFERENCES customer_dim ( customer_id ),
 	CONSTRAINT FK_43 FOREIGN KEY ( shipping_id ) REFERENCES shipping_dim ( shipping_id ),
 	CONSTRAINT FK_53 FOREIGN KEY ( location_id ) REFERENCES location_dim ( location_id ),
 	CONSTRAINT FK_69 FOREIGN KEY ( segment_id ) REFERENCES segment_dim ( segment_id ),);

 
CREATE INDEX FK_21 ON sales_fact
	( "date",
 	ship_date);

CREATE INDEX FK_33 ON sales_fact
	( product_id,
 	product_name);

CREATE INDEX FK_39 ON sales_fact
	( customer_id);

CREATE INDEX FK_45 ON sales_fact
	( shipping_id );

CREATE INDEX FK_55 ON sales_fact
	( location_id );

CREATE INDEX FK_71 ON sales_fact
	( segment_id);

CREATE INDEX FK_83 ON sales_fact
	( order_id);