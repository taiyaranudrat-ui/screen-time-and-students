"""
Load the CSV into a SQLite database called students.db.

Run it once:   python load_data.py
Then open students.db in DB Browser for SQLite (or any SQL tool)
and run the queries in queries.sql.
"""
import csv
import sqlite3

CSV_FILE = "data/Social_media_impact_on_life.csv"
DB_FILE = "students.db"

con = sqlite3.connect(DB_FILE)

# Start fresh each time the script runs
con.execute("DROP TABLE IF EXISTS students")

# Shorter, lowercase column names so the queries are easier to type
con.execute("""
    CREATE TABLE students (
        student_id          TEXT PRIMARY KEY,
        age                 INTEGER,
        gender              TEXT,
        academic_level      TEXT,
        platform            TEXT,
        daily_hours         REAL,
        weekend_extra_hours REAL,
        device              TEXT,
        sleep_hours         REAL,
        sleep_quality       INTEGER,
        late_night          INTEGER,   -- 1 = yes, 0 = no
        comparison_freq     TEXT,
        stress_score        REAL,
        mental_health_index INTEGER,
        gpa                 REAL,
        overall_impact      TEXT
    )
""")

rows = []
with open(CSV_FILE, newline="") as f:
    reader = csv.reader(f)
    next(reader)  # skip the header row
    for row in reader:
        # Blank cells become NULL, so AVG() skips them instead of counting them as 0
        row = [None if value == "" else value for value in row]
        # Turn True/False into 1/0
        row[10] = 1 if row[10] == "True" else 0
        rows.append(row)

con.executemany(f"INSERT INTO students VALUES ({','.join('?' * 16)})", rows)
con.commit()

count = con.execute("SELECT COUNT(*) FROM students").fetchone()[0]
print(f"Loaded {count} students into {DB_FILE}")
con.close()
