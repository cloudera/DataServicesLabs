-- ============================================================
-- Lab 4 — Cloudera Specifics
-- Iceberg Table Format + Ranger Security
-- ============================================================


-- ============================================================
-- FEATURE 1 — SCHEMA EVOLUTION
-- ============================================================

-- Add a new column — no data rewrite, completes in milliseconds
ALTER TABLE iceberg.airline_lab.flights ADD COLUMN loyalty_tier VARCHAR;

-- Verify the new column appears in the schema
DESCRIBE iceberg.airline_lab.flights;

-- Existing rows return NULL for loyalty_tier — backward compatible, no data touched
-- Note: existing rows can be backfilled anytime using a simple UPDATE


-- ============================================================
-- FEATURE 2 — HIDDEN PARTITIONING
-- ============================================================

-- Query with a date predicate — Trino prunes to the 2022 partition automatically
-- Notice: no synthetic 'year' column in the WHERE clause — Iceberg handles it
SELECT flight_status, COUNT(*) AS total
FROM iceberg.airline_lab.flights
WHERE departure_date BETWEEN DATE '2022-01-01' AND DATE '2022-12-31'
GROUP BY flight_status
ORDER BY total DESC;

-- EXPLAIN confirms partition pruning
-- Look for 'filterPredicate' and 'departure_date' in Fragment 1
-- There is no 'year' column — Iceberg translated the date filter into
-- partition-aware file selection automatically
EXPLAIN SELECT COUNT(*)
FROM iceberg.airline_lab.flights
WHERE departure_date BETWEEN DATE '2022-01-01' AND DATE '2022-12-31';


-- ============================================================
-- FEATURE 3 — TIME TRAVEL
-- ============================================================

-- List all snapshots
-- snapshot 0 → empty table (0 rows) — created when table was defined
-- snapshot 1 → data loaded          — created when INSERT ran in Lab 1
SELECT snapshot_id, committed_at, operation
FROM iceberg.airline_lab."flights$snapshots"
ORDER BY committed_at;

-- Time travel by snapshot id
-- Replace <first_snap_id> and <latest_snap_id> with values from above query

-- First snapshot — table existed but was empty → 0 rows
SELECT COUNT(*) AS rows_at_first_snapshot
FROM iceberg.airline_lab.flights
FOR VERSION AS OF <first_snap_id>;

-- Latest snapshot — data was loaded → all rows
SELECT COUNT(*) AS rows_at_latest_snapshot
FROM iceberg.airline_lab.flights
FOR VERSION AS OF <latest_snap_id>;

-- Time travel by timestamp
-- Replace <first_committed_at> and <latest_committed_at> with values from snapshots query

-- First snapshot timestamp → 0 rows
SELECT COUNT(*) AS rows_at_timestamp
FROM iceberg.airline_lab.flights
FOR TIMESTAMP AS OF TIMESTAMP '<first_committed_at>';

-- Latest snapshot timestamp → all rows
SELECT COUNT(*) AS rows_at_timestamp
FROM iceberg.airline_lab.flights
FOR TIMESTAMP AS OF TIMESTAMP '<latest_committed_at>';


-- ============================================================
-- FEATURE 4 — SAFE ROLLBACK
-- ============================================================

-- Step 1 — record the clean snapshot before making any changes
-- Note the latest snapshot_id — this is what we roll back to
SELECT snapshot_id, committed_at, operation
FROM iceberg.airline_lab."flights$snapshots"
ORDER BY committed_at;

-- Current row counts by status (clean state)
SELECT flight_status, COUNT(*) AS cnt
FROM iceberg.airline_lab.flights
GROUP BY flight_status
ORDER BY cnt DESC;

-- Step 2 — simulate a bad write (corrupt all 'On Time' records)
UPDATE iceberg.airline_lab.flights
SET flight_status = 'CORRUPTED'
WHERE flight_status = 'On Time';

-- Confirm the damage
SELECT flight_status, COUNT(*) AS cnt
FROM iceberg.airline_lab.flights
GROUP BY flight_status
ORDER BY cnt DESC;

-- Step 3 — restore clean data using time travel back to the clean snapshot
-- Replace <clean_snap_id> with the snapshot_id recorded in Step 1
-- In open-source Trino this would be: CALL iceberg.system.rollback_to_snapshot(...)
-- In CDW we achieve the same result using time travel — outcome is identical:
--   - Bad data is gone, clean data is restored, no S3 files deleted
CREATE OR REPLACE TABLE iceberg.airline_lab.flights AS
SELECT * FROM iceberg.airline_lab.flights
FOR VERSION AS OF <clean_snap_id>;

-- Step 4 — verify CORRUPTED rows are gone and On Time records are restored
SELECT flight_status, COUNT(*) AS cnt
FROM iceberg.airline_lab.flights
GROUP BY flight_status
ORDER BY cnt DESC;


-- ============================================================
-- PART 2 — RANGER SECURITY
-- ============================================================

-- This query succeeds only if Ranger has granted SELECT to your user
-- If it throws 'Access Denied', request a policy from your CDW admin
-- on: iceberg → airline_lab → flights
SELECT first_name, last_name, nationality
FROM iceberg.airline_lab.flights
LIMIT 5;

-- Run after applying a Ranger masking policy on first_name
-- Expected: first_name returns a hash string, last_name returns plaintext
-- Masking is enforced server-side — no query change required
SELECT first_name, last_name
FROM iceberg.airline_lab.flights
LIMIT 10;
