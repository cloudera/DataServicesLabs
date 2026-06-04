# Airline Dataset — Schema Description

Source: Kaggle — https://www.kaggle.com/datasets/iamsouravbanerjee/airline-dataset

The sample file `airlines.csv` is a column-renamed subset of the public Kaggle airline dataset, used throughout this workshop. The full dataset contains ~98,000 rows; the bundled sample (~50 rows) is large enough to exercise every query in the notebooks while remaining small enough to commit.

## Columns

| Column | Type | Description |
|---|---|---|
| `passenger_id` | VARCHAR | Unique alphanumeric passenger identifier. |
| `first_name` | VARCHAR | Passenger first name. |
| `last_name` | VARCHAR | Passenger last name. |
| `gender` | VARCHAR | `Male` or `Female`. |
| `age` | INTEGER | Passenger age in years. |
| `nationality` | VARCHAR | Country of citizenship. |
| `airport_name` | VARCHAR | Departure airport full name. |
| `airport_country_code` | VARCHAR(2) | ISO-3166 alpha-2 code of the departure country. |
| `country_name` | VARCHAR | Departure airport country name. |
| `airport_continent` | VARCHAR | Continent abbreviation (e.g. `NAM`, `EU`, `AS`, `AF`, `SAM`, `OC`). |
| `continents` | VARCHAR | Continent full name. |
| `departure_date` | DATE | Scheduled departure date. |
| `arrival_airport` | VARCHAR | IATA code of arrival airport. |
| `pilot_name` | VARCHAR | Name of the assigned pilot. |
| `flight_status` | VARCHAR | One of `On Time`, `Delayed`, `Cancelled`. |

## Notes

- `departure_date` is stored as ISO `YYYY-MM-DD` in the CSV. Trino will read it as a `DATE` when the staging schema declares it as such.
- Column names are lower snake-case (normalized from the original title-cased Kaggle headers) to match Trino/Iceberg conventions and avoid quoting in SQL.
- When you replace this file with the full Kaggle dataset, ensure the header row matches the names above, or update `scripts/01_ddl.sql` accordingly.
