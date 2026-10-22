DECLARE @Registration  nvarchar(50) = N'AF56 WWJ'; -- line 1-3 are user inputs
DECLARE @drop_off_date  date         = '2020-12-11';
DECLARE @drop_off_time  time(0)      = '09:30:00';
-- businness process 2, get the names of mechanic who have wokrded on previous services of a car
use [Car-Service]
SELECT
    m.[Mech_name] AS MechanicName,
    -- Count jobs on the drop-off-date for a mechanic
(SELECT COUNT(*) -- counts how many service rows meet the requirements
FROM [serv_mechanic] AS msDay
JOIN [Serv] AS sDay
ON sDay.[Serv_ID] = msDay.[Serv_ID]
WHERE msDay.[Mech_ID] = m.[mech_ID]
AND sDay.[Drop_off_date] = @drop_off_date) AS JobsOnDay
FROM [Mechanic] AS m
WHERE
    -- filter 1:filters for mechanics who have worked on previous services of the same car
    EXISTS (
SELECT 1
FROM [serv_mechanic] AS msPrev
JOIN [Serv] AS sPrev
ON sPrev.[Serv_ID] = msPrev.[Serv_ID]
WHERE msPrev.[Mech_ID] = m.[mech_ID]
AND sPrev.[Car_reg] = @Registration
AND (sPrev.[Drop_off_date] <  @drop_off_date
OR (sPrev.[Drop_off_date] = @drop_off_date AND sPrev.[drop_off_time] < @drop_off_time)))
    -- filter 2:flters for mechanics who had zero jobs on the drop-off-date
AND (SELECT COUNT(*)
FROM [serv_mechanic] AS msDay
JOIN [Serv]          AS sDay
ON sDay.[Serv_ID] = msDay.[Serv_ID]
WHERE msDay.[Mech_ID] = m.[mech_ID]
AND sDay.[Drop_off_date] = @drop_off_date) = 0
ORDER BY m.[Mech_name];
