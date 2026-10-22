--business process 5,make a mechanic unavailable temporarily and get a list of any services on they may be invovlved in on the days they are unavaliable.
--part 1
USE [Car-Service];
CREATE TABLE dbo.mechanic_unavailability (
Mech_ID VARCHAR(20) NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
reason VARCHAR(200) NULL,
FOREIGN KEY (Mech_ID)
REFERENCES dbo.Mechanic(Mech_ID)
ON DELETE CASCADE
ON UPDATE CASCADE
);
-- creates mechanic-unavailibility needed for parts 2,3 of business process 5
-- 

--step 2
use [Car-Service]
insert into mechanic_unavailability(Mech_ID,start_date ,end_date ,reason)
values('1037.00','25/09/12','25/12/12','sick leave')
-- query inserts values needed for part 3 of business process 5

--step 3
Declare @Date1 DATE = datefromparts(2020, 6, 5) -- lines 22-24 are inputs
Declare @Date2 DATE = datefromparts(2020, 6, 30)
Declare @mechID Varchar(20) = '2648.00'

Select S.Serv_ID, s.Drop_Off_date ,sm.mech_ID
from Serv s
join Serv_Mechanic sm on S.Serv_ID = sm.Serv_ID
where mech_ID = @mechID
and date_of_next_service between @Date1 and @Date2
-- lines 31-32 search the database for any services between these dates