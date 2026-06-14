import csv
import random
import os
import sys

NUM_ROWS = 50


COLUMNS = ["trip_id", "transport_type", "cost_rub", "status"]

def generate_row():
    transports = ["bus", "subway", "taxi", "tram"]
    statuses = ["completed", "completed", "completed", "failed", "cancelled"]
    return {
        "trip_id": f"id_{random.randint(10000, 99999)}",
        "transport_type": random.choice(transports),
        "cost_rub": random.randint(40, 600),
        "status": random.choice(statuses)
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)