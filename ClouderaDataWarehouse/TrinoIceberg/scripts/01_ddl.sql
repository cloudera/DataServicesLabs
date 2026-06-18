-- =============================================================
-- Lab 1 - DDL: create schema and tables for the airline workshop
-- Target engine: Trino on Cloudera Data Warehouse
-- Catalogs:
--   hive    -> external staging table over raw CSV
--   iceberg -> managed Iceberg target table
-- =============================================================

-- 1. Create the lab schema in both catalogs.
CREATE SCHEMA IF NOT EXISTS hive.airline_lab
WITH (location = 's3a://${bucket_name}/airline_lab/');

CREATE SCHEMA IF NOT EXISTS iceberg.airline_lab;

-- 2. External staging table over the raw CSV file uploaded in Lab 1 Step 1.
--    Update the external_location to match where you placed airlines.csv and Update the placehoder <username> to your username..
CREATE TABLE IF NOT EXISTS hive.airline_lab.flights_raw_<username> (
    passenger_id          VARCHAR,
    first_name            VARCHAR,
    last_name             VARCHAR,
    gender                VARCHAR,
    age                   VARCHAR,
    nationality           VARCHAR,
    airport_name          VARCHAR,
    airport_country_code  VARCHAR,
    country_name          VARCHAR,
    airport_continent     VARCHAR,
    continents            VARCHAR,
    departure_date        VARCHAR,   -- parsed to DATE on INSERT
    arrival_airport       VARCHAR,
    pilot_name            VARCHAR,
    flight_status         VARCHAR
)
WITH (
    format = 'CSV',
    external_location = 's3a://${bucket_name}/airline_lab/raw/',
    skip_header_line_count = 1
);

-- 3. Managed Iceberg target table.
-- Update the placehoder <username> to your username. 
--    Partitioned by departure_year (hidden via Iceberg transforms).
CREATE TABLE IF NOT EXISTS iceberg.airline_lab.flights__<username> (
    passenger_id          VARCHAR,
    first_name            VARCHAR,
    last_name             VARCHAR,
    gender                VARCHAR,
    age                   INTEGER,
    nationality           VARCHAR,
    airport_name          VARCHAR,
    airport_country_code  VARCHAR,
    country_name          VARCHAR,
    airport_continent     VARCHAR,
    continents            VARCHAR,
    departure_date        DATE,
    arrival_airport       VARCHAR,
    pilot_name            VARCHAR,
    flight_status         VARCHAR
)
WITH (
    format = 'PARQUET',
    partitioning = ARRAY['year(departure_date)', 'airport_continent']
);
