INSERT INTO [Car-Service].dbo.customer(name, Email, phone, customer_ID)
SELECT DISTINCT name, email, phone, customer_ID
FROM test.dbo.[Book(customer)]

INSERT INTO [Car-Service].dbo.car( Car_reg, customer_ID, make,model,date_of_manufacture, date_of_next_service)
SELECT DISTINCT  Car_reg, customer_ID, make,model,date_of_manufacture, date_of_next_service
FROM test.dbo.[Book(car)]

INSERT INTO [Car-Service].dbo.serv(serv_ID,Car_reg,Drop_off_date,drop_off_time,descript,mileage,date_of_next_service)
SELECT DISTINCT serv_ID,Car_reg,Drop_off_date,drop_off_time,descript,mileage,date_of_next_service
FROM test.dbo.[Book(service)]

INSERT INTO [Car-Service].dbo.mechanic(Mech_ID,Mech_name,Mech_phone,grade)
SELECT DISTINCT Mech_ID,Mech_name,Mech_phone,grade
FROM test.dbo.[Book(mechanic)]

INSERT INTO [Car-Service].dbo.serv_mechanic(mech_ID,serv_ID,time_spent_minutes)
SELECT DISTINCT mech_ID,serv_ID,time_spent_minutes
FROM test.dbo.[book(service-mechanic)]

-- querires used to transfer data from testdb to main car-servicedb
-- data was transfered into SQL using the built in wizard function
-- divided sql file into individuaL sheets for each table in db then coverted them into csv files 