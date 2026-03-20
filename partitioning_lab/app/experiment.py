import psycopg2
from datetime import datetime

# Connect to Postgres
conn = psycopg2.connect(
	host="localhost",
	dbname="postgres",
	user="postgres",
	password="password123"
)
cur = conn.cursor()

# SIMULATING A HOT SPOT [cite: 31, 70]
# Writing 1000 records for the same day (Today)
today = datetime.now()
for i in range(1000):
	cur.execute(
		"INSERT INTO sensor_readings (sensor_id, reading_value, recorded_at) VALUES (%s, %s, %s)",
		(i, 25.5, today)
	)
conn.commit()

# EXPLAIN QUERY: See which partition is hit [cite: 63]
cur.execute("EXPLAIN SELECT * FROM sensor_readings WHERE recorded_at = %s", (today,))
print("Query Plan Target:", cur.fetchone()[0])

# Result will show only 'readings_q1' or 'q2' is active while others are idle[cite: 70].
