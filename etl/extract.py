import os
import pandas as pd


RAW_DATA_PATH = "data/raw"


def extract_data():

    datasets = {}

    csv_files = [
        "hospitals.csv",
        "departments.csv",
        "doctors.csv",
        "patients.csv",
        "insurance.csv",
        "appointments.csv",
        "claims.csv"
    ]

    print("\n========== EXTRACT PHASE ==========\n")

    for file in csv_files:

        path = os.path.join(RAW_DATA_PATH, file)

        try:

            df = pd.read_csv(path)

            datasets[file.replace(".csv", "")] = df

            print(f" Loaded {file} ({len(df)} rows)")

        except FileNotFoundError:

            print(f" {file} not found.")

    print("\nExtraction Completed Successfully!\n")

    return datasets