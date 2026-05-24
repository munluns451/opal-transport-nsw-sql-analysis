-- Opal Transport NSW SQL Analysis
-- Munna Naharki | github.com/munluns451
-- Data Source: Transport for NSW Open Data Hub

-- Q1: Which transport mode has the most total trips?
SELECT Travel_Mode,
       ROUND(SUM(Trip), 0) AS total_trips
FROM opal_trips
GROUP BY Travel_Mode
ORDER BY total_trips DESC;
-- Insight 1: Train dominates with 2.38B trips. Bus is 2nd at 2.09B.
-- Together they account for 93% of all Sydney public transport.

-- Q2: Which year had the highest total trips?
SELECT SUBSTR(Year_Month, 5, 2) AS year,
       ROUND(SUM(Trip), 0) AS total_trips
FROM opal_trips
WHERE LENGTH(Year_Month) = 6
GROUP BY year
ORDER BY total_trips DESC;
-- Insight 2: Pre-COVID peak was 2019 at 753M trips.
-- COVID caused 56% crash in 2021. 2023 shows recovery at 598M.

-- Q3: Which card type uses transport the most?
SELECT "Card Type",
       ROUND(SUM(Trip), 0) AS total_trips
FROM opal_trips
GROUP BY "Card Type"
ORDER BY total_trips DESC;
-- Insight 3: Adult Opal accounts for 2.7B trips -- 56% of all trips.
-- Senior/Pensioner is 3rd showing significant elderly transport usage.

-- Q4: How did COVID impact public transport by mode?
SELECT SUBSTR(Year_Month, 5, 2) AS year,
       Travel_Mode,
       ROUND(SUM(Trip), 0) AS total_trips
FROM opal_trips
WHERE SUBSTR(Year_Month, 5, 2) IN ('19', '20', '21', '22')
GROUP BY year, Travel_Mode
ORDER BY year, total_trips DESC;
-- Insight 4: Train dropped 49% from 2019 to 2020.
-- Ferry was hit hardest at 65% drop due to loss of tourist traffic.

-- Q5: Which month has the highest average trips?
SELECT SUBSTR(Year_Month, 1, 3) AS month,
       ROUND(SUM(Trip), 0) AS total_trips
FROM opal_trips
GROUP BY month
ORDER BY total_trips DESC;
-- Insight 5: March highest as Sydney returns to work after summer.
-- January lowest due to summer holidays and school breaks.

-- Q6: What percentage of total trips does each mode represent?
SELECT Travel_Mode,
       ROUND(SUM(Trip) * 100.0 /
       (SELECT SUM(Trip) FROM opal_trips), 1) AS percentage
FROM opal_trips
GROUP BY Travel_Mode
ORDER BY percentage DESC;
-- Insight 6: Train 49.5% and Bus 43.4% = 93% of all Sydney transport.
-- Metro only 1.8% but newest and fastest growing mode.
