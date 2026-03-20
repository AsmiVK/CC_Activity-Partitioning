-- Create a keyspace for our distributed data
CREATE KEYSPACE lab_hashing WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE lab_hashing;

-- Partitioning by Hash of Key (sensor_id) [cite: 81, 83]
-- This ensures even distribution across the cluster [cite: 84]
CREATE TABLE sensor_hashes (
	sensor_id UUID PRIMARY KEY,
	location TEXT,
	data_value FLOAT
);

-- Note: In Cassandra, the 'PRIMARY KEY' is the partition key by default.
-- It maps to a position on the Hash Ring (Consistent Hashing)[cite: 135].
