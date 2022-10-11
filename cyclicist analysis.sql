 
 -- bike use Days
 SELECT 
     Weekdays,
     AVG(tripduration) AS Average
 FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
 GROUP BY Weekdays
 ORDER BY Average DESC

 -- Days of bike use by Usertype
 SELECT 
     Weekdays,
     usertype,
     AVG(tripduration) AS Average
 FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
 GROUP BY Weekdays, usertype
 ORDER BY Average DESC
 -- package to encourage customers to use it more on weekdays
 -- by lowering prices


-- bike use by weekend and weekdays
WITH day_categorize AS
(
   SELECT *,
      CASE WHEN DayOfWeek = 1 THEN "WEEKEND"
        WHEN DayOfWeek = 2 THEN "WEEKDAY"
        WHEN DayOfWeek = 3 THEN "WEEKDAY"
        WHEN DayOfWeek = 4 THEN "WEEKDAY"
        WHEN DayOfWeek = 5 THEN "WEEKDAY"
        WHEN DayOfWeek = 6 THEN "WEEKEND"
        ELSE "WEEKDAY"  END AS Is_weekend
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)
   SELECT
       Is_weekend,
       ROUND(AVG(tripduration),2) As Average
   FROM day_categorize
   GROUP BY Is_weekend
   ORDER BY Average DESC

-- bike use on weekend and weekdays by usertype
WITH day_categorize AS
(
   SELECT *,
      CASE WHEN DayOfWeek = 1 THEN "WEEKEND"
        WHEN DayOfWeek = 2 THEN "WEEKDAY"
        WHEN DayOfWeek = 3 THEN "WEEKDAY"
        WHEN DayOfWeek = 4 THEN "WEEKDAY"
        WHEN DayOfWeek = 5 THEN "WEEKDAY"
        WHEN DayOfWeek = 6 THEN "WEEKEND"
        ELSE "WEEKDAY"  END AS Is_weekend
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)
   SELECT
       Is_weekend,
       usertype,
       ROUND(AVG(tripduration),2) As Average
   FROM day_categorize
   GROUP BY Is_weekend, usertype
   ORDER BY Average DESC

-- Busiest time of Bike usage
WITH group_hour AS
(
   SELECT
       *,
       EXTRACT(HOUR FROM start_time) AS Hour
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)
   SELECT
       Hour,
       ROUND(AVG(tripduration),2) As Average
   FROM group_hour
   GROUP BY group_hour.HOUR
   ORDER BY Average DESC

-- Busiest time of Bike usage by usertype
WITH group_hour AS
(
   SELECT
       *,
       EXTRACT(HOUR FROM start_time) AS Hour
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)
   SELECT
       Hour,
       usertype,
       ROUND(AVG(tripduration),2) As Average
   FROM group_hour
   GROUP BY group_hour.HOUR, usertype
   ORDER BY Average DESC


-- Busiest time of Bike usage by usertype and weekday
WITH group_hour AS
(
   SELECT
       *,
       EXTRACT(HOUR FROM start_time) AS Hour
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)
   SELECT
       Hour,
       usertype,
       Weekdays,
       ROUND(AVG(tripduration),2) As Average
   FROM group_hour
   GROUP BY group_hour.HOUR, usertype, Weekdays
   ORDER BY Average DESC

-- bike use on weekend and weekdays by hour
WITH day_categorize AS
(
   SELECT *,
       EXTRACT(HOUR FROM start_time) AS Hour,
      CASE WHEN DayOfWeek = 1 THEN "WEEKEND"
        WHEN DayOfWeek = 2 THEN "WEEKDAY"
        WHEN DayOfWeek = 3 THEN "WEEKDAY"
        WHEN DayOfWeek = 4 THEN "WEEKDAY"
        WHEN DayOfWeek = 5 THEN "WEEKDAY"
        WHEN DayOfWeek = 6 THEN "WEEKEND"
        ELSE "WEEKDAY"  END AS Is_weekend
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)
   SELECT
       Is_weekend,
       day_categorize.HOUR,
       ROUND(AVG(tripduration),2) As Average
   FROM day_categorize
   GROUP BY Is_weekend, day_categorize.HOUR
   ORDER BY Average DESC

-- bike use on weekend and weekdays by usertype and hour
WITH day_categorize AS
(
   SELECT *,
       EXTRACT(HOUR FROM start_time) AS Hour,
      CASE WHEN DayOfWeek = 1 THEN "WEEKEND"
        WHEN DayOfWeek = 2 THEN "WEEKDAY"
        WHEN DayOfWeek = 3 THEN "WEEKDAY"
        WHEN DayOfWeek = 4 THEN "WEEKDAY"
        WHEN DayOfWeek = 5 THEN "WEEKDAY"
        WHEN DayOfWeek = 6 THEN "WEEKEND"
        ELSE "WEEKDAY"  END AS Is_weekend
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)
   SELECT
       Is_weekend,
       day_categorize.HOUR,
       usertype,
       ROUND(AVG(tripduration),2) As Average
   FROM day_categorize
   GROUP BY Is_weekend, day_categorize.HOUR, usertype
   ORDER BY Average DESC

-- bike use in different seasons by usertype 
WITH season_data AS
(
   SELECT *,
      CASE WHEN Month = 6 THEN "Summer"
        WHEN Month = 7 THEN "Summer"
        WHEN Month = 8 THEN "Summer"
        WHEN Month = 1 THEN "Winter"
        WHEN Month = 2 THEN "Winter"
        WHEN Month = 12 THEN "Winter"
        WHEN Month = 3 THEN "Spring"
        WHEN Month = 4 THEN "Spring"
        WHEN Month = 5 THEN "Spring"
        ELSE "Autumn"  END AS Season
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)

   SELECT
       season_data.Season,
       usertype,
       ROUND(AVG(tripduration),2) As Average
   FROM season_data
   GROUP BY season_data.Season, usertype
   ORDER BY Average DESC


-- bike use on week days by usertype
WITH day_categorize AS
(
   SELECT *,
      CASE WHEN DayOfWeek = 1 THEN "WEEKEND"
        WHEN DayOfWeek = 2 THEN "WEEKDAY"
        WHEN DayOfWeek = 3 THEN "WEEKDAY"
        WHEN DayOfWeek = 4 THEN "WEEKDAY"
        WHEN DayOfWeek = 5 THEN "WEEKDAY"
        WHEN DayOfWeek = 6 THEN "WEEKEND"
        ELSE "WEEKDAY"  END AS Is_weekend
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)
   SELECT
       Weekdays,
       usertype,
       ROUND(AVG(tripduration),2) As Average,
       ROUND(MAX(tripduration),2) As Highest,
       ROUND(MIN(tripduration),2) As Lowest,
       COUNT(tripduration) As Frequency
   FROM day_categorize
   WHERE Is_weekend != "WEEKEND"
   GROUP BY Weekdays, usertype
   ORDER BY Average DESC


-- bike use on week days in summer by usertype
WITH season_categorize AS
(
   SELECT *,
      CASE WHEN DayOfWeek = 1 THEN "WEEKEND"
        WHEN DayOfWeek = 2 THEN "WEEKDAY"
        WHEN DayOfWeek = 3 THEN "WEEKDAY"
        WHEN DayOfWeek = 4 THEN "WEEKDAY"
        WHEN DayOfWeek = 5 THEN "WEEKDAY"
        WHEN DayOfWeek = 6 THEN "WEEKEND"
        ELSE "WEEKDAY"  END AS Is_weekend,
      CASE WHEN Month = 6 THEN "Summer"
        WHEN Month = 7 THEN "Summer"
        WHEN Month = 8 THEN "Summer"
        WHEN Month = 1 THEN "Winter"
        WHEN Month = 2 THEN "Winter"
        WHEN Month = 12 THEN "Winter"
        WHEN Month = 3 THEN "Spring"
        WHEN Month = 4 THEN "Spring"
        WHEN Month = 5 THEN "Spring"
        ELSE "Autumn"  END AS Season
    FROM `oceanic-will-353512.cyclicist.cyclicist_2018`
)
   SELECT
       Weekdays,
       usertype,
       ROUND(AVG(tripduration),2) As Average,
       ROUND(MAX(tripduration),2) As Highest,
       ROUND(MIN(tripduration),2) As Lowest,
       COUNT(tripduration) As Frequency
   FROM season_categorize
   WHERE Is_weekend != "WEEKEND" AND Season = "Summer"
   GROUP BY Weekdays, usertype
   ORDER BY Average DESC