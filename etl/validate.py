import os
import re
import pandas as pd

CLEANED_PATH = "data/cleaned"
INVALID_PATH = "data/invalid"

os.makedirs(CLEANED_PATH, exist_ok=True)
os.makedirs(INVALID_PATH, exist_ok=True)


EMAIL_REGEX = r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'


def validate_data(datasets):

    validated_data = {}

    print("\n========== VALIDATION PHASE ==========\n")

    for name, df in datasets.items():

        original_rows = len(df)

        valid_df = df.copy()

        invalid_df = pd.DataFrame()

        # -----------------------------
        # Remove duplicate rows
        # -----------------------------

        duplicates = valid_df[valid_df.duplicated()]

        invalid_df = pd.concat([invalid_df, duplicates])

        valid_df = valid_df.drop_duplicates()

        # -----------------------------
        # Remove rows with NULL values
        # -----------------------------

        null_rows = valid_df[valid_df.isnull().any(axis=1)]

        invalid_df = pd.concat([invalid_df, null_rows])

        valid_df = valid_df.dropna()

        # -----------------------------
        # Email Validation
        # -----------------------------

        if "email" in valid_df.columns:

            invalid_email = valid_df[
                ~valid_df["email"].astype(str).str.match(EMAIL_REGEX)
            ]

            invalid_df = pd.concat([invalid_df, invalid_email])

            valid_df = valid_df[
                valid_df["email"].astype(str).str.match(EMAIL_REGEX)
            ]

        # -----------------------------
        # Save Files
        # -----------------------------

        valid_df.to_csv(
            f"{CLEANED_PATH}/{name}.csv",
            index=False
        )

        invalid_df.to_csv(
            f"{INVALID_PATH}/{name}.csv",
            index=False
        )

        validated_data[name] = valid_df

        print(f"{name}")

        print(f"Original : {original_rows}")

        print(f"Valid    : {len(valid_df)}")

        print(f"Invalid  : {len(invalid_df)}")

        print("-"*40)

    return validated_data
if __name__ == "__main__":
    validate_data()