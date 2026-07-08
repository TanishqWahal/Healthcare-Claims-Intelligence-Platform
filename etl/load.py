from sqlalchemy import text
from config.database import engine

# Load order (Parent → Child)
LOAD_ORDER = [
    "hospitals",
    "departments",
    "doctors",
    "patients",
    "insurance",
    "appointments",
    "claims"
]

# Truncate order (Child → Parent)
TRUNCATE_ORDER = [
    "claims",
    "appointments",
    "insurance",
    "patients",
    "doctors",
    "departments",
    "hospitals"
]


def clear_database():
    """
    Clears all tables before loading fresh data.
    """

    print("\n========== CLEAR DATABASE ==========\n")

    try:
        with engine.begin() as conn:

            # Disable Foreign Key Checks
            conn.execute(text("SET FOREIGN_KEY_CHECKS = 0;"))

            for table in TRUNCATE_ORDER:
                conn.execute(text(f"TRUNCATE TABLE {table};"))
                print(f" Cleared {table}")

            # Enable Foreign Key Checks
            conn.execute(text("SET FOREIGN_KEY_CHECKS = 1;"))

        print("\n Database Cleared Successfully!\n")

    except Exception as e:
        print("\n Error while clearing database")
        print(e)


def load_data(datasets):
    """
    Loads all validated & transformed data into MySQL.
    """

    # Always clear database first
    clear_database()

    print("\n========== LOAD PHASE ==========\n")

    try:

        for table in LOAD_ORDER:

            df = datasets[table]

            df.to_sql(
                name=table,
                con=engine,
                if_exists="append",
                index=False
            )

            print(f" {table} loaded ({len(df)} rows)")

        print("\n All tables loaded successfully!")

    except Exception as e:

        print(f"\n Error while loading data")
        print(e)