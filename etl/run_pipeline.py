from extract import extract_paid_ads
from transform import clean_paid_ads_data
from load import load_to_postgres

RAW_PATH = "data/raw/GoogleAds_DataAnalytics_Sales_Uncleaned.csv"
TABLE_NAME = "stg_paid_ads"

def main():
    print("🚀 Starting ETL pipeline...")

    df_raw = extract_paid_ads(RAW_PATH)
    print(f"📥 Extracted raw data: {df_raw.shape[0]} rows")

    df_clean = clean_paid_ads_data(df_raw)
    print(f"🧹 Cleaned data: {df_clean.shape[0]} rows")

    load_to_postgres(df_clean, TABLE_NAME)
    print(f"📦 Loaded data into table: {TABLE_NAME}")

    print("✅ ETL pipeline completed successfully")

if __name__ == "__main__":
    main()

