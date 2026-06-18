-- =============================================================
-- Lab 1 - DML: load the staging CSV into the Iceberg target table
-- Update the placehoder <username> to your username.
-- Only inserts if the target table is currently empty
-- =============================================================
INSERT INTO iceberg.airline_lab.flights_<username>
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
FROM hive.airline_lab.flights_raw_<username>
WHERE NOT EXISTS (
    SELECT 1 FROM iceberg.airline_lab.flights_<username>
);
