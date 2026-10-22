use [Car-Service]

create table customer (
name varchar(100) not null,
Email varchar(255) not null,
phone varchar(30),
customer_ID varchar(50) 
constraint pk_customer primary key (customer_ID)
);

create table car (
Car_reg varchar(20) primary key,
customer_ID varchar(50) not null,
make varchar (50),
model varchar (50),
date_of_manufacture date,
date_of_next_service date,
foreign key (customer_ID) references customer(customer_ID)
	on delete CASCADE
);

create table serv (
serv_ID varchar(20) primary key,
Car_reg varchar(20), 
drop_off_time time,
Drop_off_date date,
descript text,
mileage int,
date_of_next_service date,
foreign key (Car_reg) references car(Car_reg)
	ON DELETE CASCADE
);

create table mechanic (
Mech_ID varchar(20) primary key,
Mech_name varchar(50),
Mech_phone varchar(20),
grade char(50)
);

create table serv_mechanic (
mech_ID varchar(20) not null,
serv_ID varchar(20) not null, 
time_spent_minutes int default 0, 
primary key (serv_ID, mech_ID),
foreign key (serv_ID) references serv(serv_ID) ON DELETE CASCADE,
foreign key (mech_ID) references mechanic(mech_ID) on delete CASCADE
);
-- creates initail tables of the database
-- mechanic unavailability created later when developing process 5
-- on delete cascade clauses deletes specified data in all tables when deleted