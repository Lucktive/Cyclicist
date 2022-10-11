 -- summary statistics for the usertype
 SELECT 
    usertype,
    MIN(tripduration) AS min_trip_duration,
    AVG(tripduration) AS mean_trip_duration,
    MAX(tripduration) AS min_trip_duration
 FROM cyclicist.cyclicist_2018
 GROUP BY usertype

  -- how cyclicist customers and subscribers use its services on weekdays
 SELECT 
    usertype,
    Weekdays,
    MIN(tripduration) AS min_trip_duration,
    AVG(tripduration) AS mean_trip_duration,
    MAX(tripduration) AS min_trip_duration
 FROM cyclicist.cyclicist_2018
 GROUP BY Weekdays, usertype
 ORDER BY mean_trip_duration DESC

 
  -- how cyclicist customers and subscribers use its services throughout the year
 SELECT 
    usertype,
    Month,
    MIN(tripduration) AS min_trip_duration,
    AVG(tripduration) AS mean_trip_duration,
    MAX(tripduration) AS min_trip_duration
 FROM cyclicist.cyclicist_2018
 GROUP BY Month, usertype
 ORDER BY mean_trip_duration DESC


  
  -- are members using cyclicist services increasing on average
 SELECT 
    Month,
    AVG(tripduration) AS mean_trip_duration,
 FROM cyclicist.cyclicist_2018
 WHERE usertype = "Subscriber"
 GROUP BY Month
 ORDER BY mean_trip_duration 

   -- are casual riders using cyclicist services increasing on average
 SELECT 
    Month,
    AVG(tripduration) AS mean_trip_duration,
 FROM cyclicist.cyclicist_2018
 WHERE usertype = "Customer"
 GROUP BY Month
 ORDER BY mean_trip_duration 

  -- are annual riders using cyclicist services increasing on average
 SELECT usertype,
    ( (EXTRACT(YEAR FROM CURRENT_DATE()))- birthyear) AS Age,
    ROUND(AVG(tripduration), 1) AS mean_trip_duration,
 FROM cyclicist.cyclicist_2018
 WHERE usertype = "Customer"
 GROUP BY birthyear, usertype
 ORDER BY mean_trip_duration DESC

 
