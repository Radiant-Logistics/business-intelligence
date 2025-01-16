from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from datetime import datetime, timedelta
import pandas as pd
import os
import psycopg2

# Define default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2025, 1, 14),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define file paths
DATA_PATH = "/usr/local/airflow/data"
TMP_PATH = "/usr/local/airflow/data/tmp"  # Fixed path for temporary files
FILE_1 = "/usr/local/airflow/data/CW_ServiceLevel_2024-01-07(in).csv"
FILE_2 = "/usr/local/airflow/data/TM_servicelevels_2024-12-26(Sheet1).csv"

# Database connection details
POSTGRES_CONN = {
    'host': 'postgres',
    'database': 'airflow',
    'user': 'airflow',
    'password': 'airflow'
}

# Function to extract data and save to temporary file
def extract_to_tmp(file_path, tmp_file_name):
    try:
        df = pd.read_csv(file_path, encoding='utf-8', encoding_errors='ignore')  # Explicitly set encoding
        tmp_file_path = f"{TMP_PATH}/{tmp_file_name}"  # Fixed temporary file path
        df.to_csv(tmp_file_path, index=None, header=True)
        print(f"Temporary file created: {tmp_file_path}")
    except Exception as e:
        print(f"Error occurred while reading file {file_path}: {e}")
        raise  # Re-raise the exception to allow Airflow retries

# Function to load CSV data from temporary file into PostgreSQL
def load_from_tmp(tmp_file_name, table_name):
    tmp_file_path = f"{TMP_PATH}/{tmp_file_name}"
    conn = psycopg2.connect(**POSTGRES_CONN)
    cursor = conn.cursor()
    df = pd.read_csv(tmp_file_path)
    
    # Create table if not exists
    create_table_query = f"""
    CREATE TABLE IF NOT EXISTS {table_name} (
        {', '.join([f'"{col}" TEXT' for col in df.columns])}
    );
    """
    cursor.execute(create_table_query)
    conn.commit()
    
    # Insert data into table
    for index, row in df.iterrows():
        insert_query = f"INSERT INTO {table_name} VALUES ({', '.join(['%s'] * len(row))})"
        cursor.execute(insert_query, tuple(row))
    
    conn.commit()
    cursor.close()
    conn.close()

# DAG definition
with DAG(
    'elt_pipeline_dag',
    default_args=default_args,
    description='ELT pipeline using Airflow and PostgreSQL',
    schedule_interval='@once',
    catchup=False
) as dag:

    # Task 1: Extract first CSV and save to temp file
    extract_file_1 = PythonOperator(
        task_id='extract_file_1',
        python_callable=extract_to_tmp,
        op_args=[FILE_1, 'cw_service_level_tmp.csv']
    )

    # Task 2: Extract second CSV and save to temp file
    extract_file_2 = PythonOperator(
        task_id='extract_file_2',
        python_callable=extract_to_tmp,
        op_args=[FILE_2, 'tm_service_levels_tmp.csv']
    )

    # Task 3: Load first temp file into PostgreSQL
    load_file_1 = PythonOperator(
        task_id='load_file_1',
        python_callable=load_from_tmp,
        op_args=['cw_service_level_tmp.csv', 'cw_service_level']
    )

    # Task 4: Load second temp file into PostgreSQL
    load_file_2 = PythonOperator(
        task_id='load_file_2',
        python_callable=load_from_tmp,
        op_args=['tm_service_levels_tmp.csv', 'tm_service_levels']
    )

    # Task 5: Transform data handled externally in pgAdmin
    transform_data = PostgresOperator(
        task_id='transform_data',
        postgres_conn_id='airflow_db',
        sql="""
        SELECT 'Transformation completed successfully';
        """
    )

    extract_file_1 >> extract_file_2 >> load_file_1 >> load_file_2 >> transform_data





