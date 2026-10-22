--business process 1, add details of a new service without specifying mechanic
--part 1
--creates customer data
use [Car-Service]
INSERT INTO dbo.customer (customer_ID, [name], phone, Email)
VALUES ('01B1-V76', 'Quinton Tarantino', '07950273803', 'tarantino.quin@yahoo.com');

--part 2
-- Check if this customer exists
SELECT customer_ID
FROM dbo.customer
WHERE customer_ID = '01B1-V76';

-- inserts car data on for previously created customer
INSERT INTO dbo.car (Car_reg, make, model, customer_ID)
VALUES ('BJI 233', 'toyota', 'corolla', '01B1-V76');

--part 3
--inserts service data without specifying mechanic
insert into serv (serv_ID, Car_reg, Drop_off_date, drop_off_time, descript, mileage, date_of_next_service)
values ('S2025-999','BJI 233','01/12/2025', '8:30:00','annual service', 50000, '01/12/2026')
