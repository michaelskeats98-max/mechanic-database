-- business process 4, list the names and emails of customers who own a car whered the date of nest service falls within two dates, including car registration, make and date of next service.
use [Car-Service]
select customer.name, customer.Email, car.Car_reg, car.make, serv.date_of_next_service
from customer
join car
on customer.customer_ID = car.customer_ID
join serv
on car.Car_reg = serv.Car_reg
where serv.date_of_next_service between '2021-06-12' and '2021-06-21'
