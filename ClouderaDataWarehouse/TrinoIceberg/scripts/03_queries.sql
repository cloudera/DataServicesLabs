-- =============================================================
-- Lab 2 & 3 - Example analytical queries on the airline dataset
-- =============================================================

-- Q1. Top 10 departure countries by flight volume.
SELECT country_name, COUNT(*) AS flights
FROM iceberg.airline_lab.flights
GROUP BY country_name
ORDER BY flights DESC
LIMIT 10;

-- Q2. Flight-status mix per continent.
SELECT airport_continent,
       flight_status,
       COUNT(*)                                                                AS flights,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY airport_continent), 2) AS pct_of_continent
FROM iceberg.airline_lab.flights
GROUP BY airport_continent, flight_status
ORDER BY airport_continent, flights DESC;

-- Q3. Passenger age buckets.
SELECT CASE
           WHEN age < 18 THEN '0-17'
           WHEN age < 35 THEN '18-34'
           WHEN age < 60 THEN '35-59'
           ELSE '60+'
       END AS age_bucket,
       COUNT(*) AS passengers
FROM iceberg.airline_lab.flights
GROUP BY 1
ORDER BY 1;

-- Q4. Monthly departure trend (rolling 3-month window).
WITH monthly AS (
    SELECT date_trunc('month', departure_date) AS month,
           COUNT(*)                            AS flights
    FROM iceberg.airline_lab.flights
    GROUP BY date_trunc('month', departure_date)
)
SELECT month,
       flights,
       SUM(flights) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_3m
FROM monthly
ORDER BY month;

-- Q5. Rank airports within each continent by traffic (ROW_NUMBER).
SELECT *
FROM (
    SELECT airport_continent,
           airport_name,
           COUNT(*)                                                               AS flights,
           ROW_NUMBER() OVER (PARTITION BY airport_continent ORDER BY COUNT(*) DESC) AS rnk
    FROM iceberg.airline_lab.flights
    GROUP BY airport_continent, airport_name
)
WHERE rnk <= 5
ORDER BY airport_continent, rnk;

-- Q6. Approximate distinct pilots (fast cardinality).
SELECT APPROX_DISTINCT(pilot_name) AS unique_pilots_approx
FROM iceberg.airline_lab.flights;

-- Q7. EXPLAIN ANALYZE example for a self-join (delays by pilot).
EXPLAIN ANALYZE
SELECT f.pilot_name,
       COUNT(*) AS delayed_flights
FROM iceberg.airline_lab.flights f
JOIN (SELECT DISTINCT pilot_name FROM iceberg.airline_lab.flights WHERE flight_status = 'Delayed') d
  ON f.pilot_name = d.pilot_name
WHERE f.flight_status = 'Delayed'
GROUP BY f.pilot_name
ORDER BY delayed_flights DESC
LIMIT 20;
