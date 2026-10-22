Car Service Database (SQL Server)

A relational database for a car servicing garage, built in Microsoft SQL Server (T-SQL) as Year 1 coursework. It stores customers, their cars, service bookings and the mechanics who carry out the work. A set of queries then supports the garage's day-to-day business processes.

The original data came as one flat spreadsheet (`CarServiceData_worked.xlsx`). It was normalised into separate tables and loaded into a database called `Car-Service`.

## Database schema

| Table | Purpose | Key |
|---|---|---|
| `customer` | Customer name, email and phone | `customer_ID` |
| `car` | Cars, each linked to an owner, with make, model, manufacture date and next service date | `Car_reg` → FK `customer_ID` |
| `serv` | Service bookings: drop-off date/time, description, mileage, next service date | `serv_ID` → FK `Car_reg` |
| `mechanic` | Mechanic name, phone and grade (Trainee, Mechanic, Senior Mechanic) | `Mech_ID` |
| `serv_mechanic` | Junction table linking mechanics to services (many-to-many), with time spent in minutes | (`serv_ID`, `mech_ID`) |
| `mechanic_unavailability` | Dates when a mechanic can't work (e.g. sick leave), with a reason | FK `Mech_ID` |

```
customer 1───* car 1───* serv *───* mechanic 1───* mechanic_unavailability
                                 (via serv_mechanic)
```

Foreign keys use `ON DELETE CASCADE`, so deleting a customer also removes their cars, services and service–mechanic links.

## Files

### Setup

| File | What it does |
|---|---|
| `CarServiceData_worked.xlsx` | Source data. The `main` sheet holds the original flat data. The other sheets (`customer`, `car`, `service`, `mechanic`, `service_mechanic`) split it into one sheet per table. These sheets were exported to CSV and imported with SQL Server's Import Wizard. |
| `SQLQuery1.sql` | **Creates the core tables:** `customer`, `car`, `serv`, `mechanic` and `serv_mechanic`, with primary keys, foreign keys and cascading deletes. |
| `SQLQuery2.sql` | **Loads the data.** Copies the imported rows from the staging database (`test`) into the matching tables in `Car-Service`, using `INSERT INTO … SELECT DISTINCT` so duplicate rows are dropped. |

### Business process 1: book a new service (no mechanic assigned)

| File | What it does |
|---|---|
| `SQLQuery3.sql` | Three steps: (1) adds a new customer, (2) checks the customer exists and registers their car, (3) creates a service booking for that car without assigning a mechanic. |
| `SQLQuery4.sql` | The same process as `SQLQuery3.sql`, with slightly different comments. Only run one of the two, because running both causes duplicate primary key errors. |

### Business process 2: suggest a mechanic for a car

| File | What it does |
|---|---|
| `SQLQuery5.sql` | Takes a car registration, drop-off date and drop-off time as inputs (`DECLARE` variables). It returns the mechanics who **have worked on that car before** and have **no other jobs on the drop-off date**. A subquery counts each mechanic's jobs that day, and `EXISTS` checks their previous work on the car. |

### Business process 4: upcoming services report

| File | What it does |
|---|---|
| `-business process 4.sql` | Lists the name and email of every customer whose car has its next service between two dates. The output includes the car's registration, make and next service date. It joins `customer` → `car` → `serv`. |

### Business process 5: handle mechanic unavailability

| File | What it does |
|---|---|
| `SQLQuery12-business process 5 whole.sql` | **The complete process in one script:** (1) creates the `mechanic_unavailability` table, (2) records a period of sick leave for a mechanic, (3) takes a mechanic ID and a date range as inputs and lists the services that mechanic is assigned to in that period, so the work can be reassigned. |
| `SQLQuery12-table creation.sql` | Step 1 of process 5 on its own: creates the `mechanic_unavailability` table. |
| `SQLQuery13-data insert.sql` | Step 2 of process 5 on its own: inserts a sample unavailability record (mechanic `1037.00`, sick leave). |

## How to run

1. Create a database called `Car-Service` in SQL Server Management Studio.
2. Run `SQLQuery1.sql` to create the tables.
3. Import the spreadsheet sheets as CSVs into a staging database called `test`, then run `SQLQuery2.sql`.
4. Run the business process scripts in any order. For process 5, use either the "whole" script **or** the two separate step files, not both.

The process 2 and 5 queries start with `DECLARE` variables. Change their values to try different cars, mechanics or dates.

## Notes

- Written in T-SQL for Microsoft SQL Server.
- There is no business process 3 script in this repo.
