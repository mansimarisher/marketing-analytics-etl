import pandas as pd
import numpy as np

def clean_paid_ads_data(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()

    df.columns = df.columns.str.lower()

    # Clean currency columns safely
    for col in ["cost", "sale_amount"]:
        df[col] = (
            df[col]
            .astype(str)
            .str.replace(r"[^0-9.]", "", regex=True)
            .replace("", np.nan)
            .astype(float)
            .fillna(0)
        )

    # Clean date
    df["ad_date"] = pd.to_datetime(df["ad_date"], 
                                   errors="coerce").dt.date


    # Standardize text
    for col in ["campaign_name", "location", "device", "keyword"]:
        df[col] = (
            df[col]
            .astype(str)
            .str.strip()
            .str.lower()
        )

    # Numeric columns
    for col in ["clicks", "impressions", "leads", "conversions"]:
        df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0).astype(int)

    # Data quality filters
    df = df[
        (df["impressions"] >= df["clicks"]) &
        (df["clicks"] >= df["conversions"]) &
        (df["cost"] >= 0) &
        (df["sale_amount"] >= 0)
    ]

    df["created_at"] = pd.Timestamp.utcnow()

    return df
