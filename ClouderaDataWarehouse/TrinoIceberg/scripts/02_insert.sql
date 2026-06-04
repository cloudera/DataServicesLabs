-- =============================================================
-- Lab 1 - DML: load the staging CSV into the Iceberg target table
-- =============================================================

INSERT INTO iceberg.airline_lab.flights
SELECT
    passenger_id,
    first_name,
    last_name,
    gender,
    CAST(age AS INTEGER) AS age,
    nationality,
    airport_name,
    airport_country_code,
    country_name,
    airport_continent,
    continents,
    CAST(departure_date AS DATE) AS departure_date,
    arrival_airport,
    pilot_name,
    flight_status
FROM hive.airline_lab.flights_raw;

-- Sanity checks after the load.
SELECT COUNT(*)                  AS total_flights       FROM iceberg.airline_lab.flights;
SELECT flight_status, COUNT(*)   AS cnt                 FROM iceberg.airline_lab.flights GROUP BY flight_status;
SELECT MIN(departure_date)       AS earliest,
       MAX(departure_date)       AS latest              FROM iceberg.airline_lab.flights;
