from etl.extract import extract_data
from etl.validate import validate_data
from etl.transform import transform_data
from etl.load import load_data


def main():

    datasets = extract_data()

    validated = validate_data(datasets)

    transformed = transform_data(validated)

    load_data(transformed)

    print("\n Complete ETL Pipeline Finished!")


if __name__ == "__main__":
    main()