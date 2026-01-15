from sqlalchemy import create_engine

def load_to_postgres(df, table_name):
    engine = create_engine(
        "postgresql://marketing_user:marketing_pass@localhost:5433/marketing_db"
    )

    df.to_sql(
        table_name,
        engine,
        if_exists="replace",
        index=False
    )

    print(f"✅ {len(df)} rows written to {table_name}")
