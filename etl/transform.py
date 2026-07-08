import pandas as pd


def transform_data(datasets):

    transformed_data = {}

    print("\n========== TRANSFORM PHASE ==========\n")

    for name, df in datasets.items():

        df = df.copy()

        # Convert all object/string columns
        for column in df.select_dtypes(include="object").columns:

            df[column] = df[column].astype(str).str.strip()

            # Don't change emails to title case
            if "email" in column.lower():

                df[column] = df[column].str.lower()

            else:

                df[column] = df[column].str.title()

        transformed_data[name] = df

        print(f" {name} transformed")

    print("\nTransformation Completed Successfully!\n")

    return transformed_data