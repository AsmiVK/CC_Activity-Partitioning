-- PHASE 1: KEY-RANGE PARTITIONING (Sensor Data by Time) [cite: 67]
CREATE TABLE sensor_readings (
	sensor_id INT,
	reading_value FLOAT,
	recorded_at TIMESTAMP NOT NULL
) PARTITION BY RANGE (recorded_at);

-- Create specific partitions for quarters [cite: 95, 98]
CREATE TABLE readings_q1 PARTITION OF sensor_readings
	FOR VALUES FROM ('2026-01-01') TO ('2026-04-01');
CREATE TABLE readings_q2 PARTITION OF sensor_readings
	FOR VALUES FROM ('2026-04-01') TO ('2026-07-01');

-- PHASE 2: VERTICAL PARTITIONING [cite: 35, 37]
-- Separating small metadata from large blobs to improve IO [cite: 38]
CREATE TABLE user_metadata (
	user_id INT PRIMARY KEY,
	first_name TEXT,
	email TEXT
);
CREATE TABLE user_blobs (
	user_id INT REFERENCES user_metadata(user_id),photo_large BYTEA,
	thumbnail_small BYTEA
);
