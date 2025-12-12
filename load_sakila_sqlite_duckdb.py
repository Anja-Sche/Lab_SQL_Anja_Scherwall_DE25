import dlt
from dlt.sources.sql_database import sql_database
from pathlib import Path

DATA_PATH = Path(__file__).parent / "data"
SQLITE_PATH = DATA_PATH / "sqlite-sakila.db"
DUCKDB_PATH = DATA_PATH / "sakila.duckdb"

DASHBOARD_PATH = Path(__file__).parent / "dashboard" / "sources" / "sakila" / "sakila.duckdb"

source = sql_database(credentials=f"sqlite:///{SQLITE_PATH}", schema="main")

#placing the tables in main schema
pipeline_data = dlt.pipeline(
    pipeline_name = "sakila_sqlite_duckdb",
    destination = dlt.destinations.duckdb(str(DUCKDB_PATH)),
    dataset_name = "staging"
)

pipeline_dashboard = dlt.pipeline(
    pipeline_name = "sakila_sqlite_duckdb_dashboard",
    destination = dlt.destinations.duckdb(str(DASHBOARD_PATH)),
    dataset_name = "staging"
)

load_info_data = pipeline_data.run(source, write_disposition="replace")
load_info_dashboard = pipeline_dashboard.run(source, write_disposition="replace")

print(load_info_data)
print(load_info_dashboard)