 -- clean cyclcist_2018_Q1 table by selecting the required columns
  -- create a view with the new view
  create view `oceanic-will-353512.cyclicist.cyclicist_2018_Q1w`  as
  SELECT 
      _01___Rental_Details_Local_Start_Time As start_time,
      _01___Rental_Details_Local_End_Time AS end_time,
      _01___Rental_Details_Duration_In_Seconds_Uncapped	 As tripduration,
      User_Type AS usertype,
      Member_Gender AS gender,
      _05___Member_Details_Member_Birthday_Year	 As birthyear
  FROM `oceanic-will-353512.cyclicist.cyclicist_2018_Q1` 
  ORDER BY start_time

  -- clean cyclicist_2018_Q4 by selecting the required columns
  -- create a view with the new view
  create view `oceanic-will-353512.cyclicist.cyclicist_2018_Q4n`  as
  SELECT
      start_time,		
      end_time,  
      tripduration,			
      usertype,		
      gender,			
      birthyear
   FROM `oceanic-will-353512.cyclicist.cyclicist_2018_Q4`
   ORDER BY start_time

  -- Join all the cyclicist 2018 tables together
   -- create a view with the new view
  create view `oceanic-will-353512.cyclicist.cyclicist_2018_k`  as
  SELECT *
  FROM `oceanic-will-353512.cyclicist.cyclicist_2018_Q1w`
  UNION DISTINCT
  SELECT *
  FROM `oceanic-will-353512.cyclicist.cyclicist_2018_Q2`
  UNION DISTINCT
  SELECT *
  FROM `oceanic-will-353512.cyclicist.cyclicist_2018_Q3`
  UNION DISTINCT
  SELECT *
  FROM `oceanic-will-353512.cyclicist.cyclicist_2018_Q4n`
 
 
  -- Extracting day, month and week days from start_date
  -- create a view with the new table
  create view `oceanic-will-353512.cyclicist.cyclicist_2018`  as
  WITH date_extract AS
  (
  SELECT *,
       EXTRACT(DAY FROM start_time) AS Day,
       EXTRACT(MONTH FROM start_time) AS Month,
       EXTRACT(DAYOFWEEK FROM start_time) AS DayOFWeek
  FROM `oceanic-will-353512.cyclicist.cyclicist_2018_k`
  )
  SELECT *,
       CASE WHEN DayOfWeeK = 1 THEN "Sunday"
            WHEN DayOfWeeK = 2 THEN "Monnday"
            WHEN DayOfWeeK = 3 THEN "Tuesday"
            WHEN DayOfWeeK = 4 THEN "Wednesday"
            WHEN DayOfWeeK = 5 THEN "Thursday"
            WHEN DayOfWeeK = 6 THEN "Friday"
       ELSE "Saturday" END AS Weekdays
   FROM date_extract
 