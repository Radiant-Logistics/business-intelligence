
# ELT Pipeline with Airflow and Docker

## Repository Structure and Workflow

**Branches**:
- `dev`: All development and changes should be committed here first.
- `prd`: Production-ready code. Changes must be merged from `dev` after code review.

**Workflow**:
1. Clone the repository.
2. Work on the `dev` branch.
3. Submit a pull request for code review to merge changes into `prd`.

## ELT Setup Instructions

### 1. Install Prerequisites
Install Docker and Docker Compose on your system.

### 2. Configure Airflow Docker Compose
Use the provided Airflow Docker Compose YAML file. Refer to the official [Docker Compose documentation for Airflow](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html).

### 3. Set Up Airflow
Place the DAG script into the Airflow `dags` folder.

### 4. Prepare the Environment
- Ensure the following Python libraries are installed:
  - `pandas`
  - `psycopg2`
- Ensure the `TMP_PATH` directory (for temporary files) exists and has write permissions.

### 5. Start Docker Services
- **Start the Services**:
  ```bash
  docker compose up 
  ```
- **Stop the Services**:
  ```bash
  docker compose down
  ```
- By default:
  - Airflow Web UI is accessible at [http://localhost:8080](http://localhost:8080).
  - PgAdmin is accessible at [http://localhost:5050](http://localhost:5050).

## Running the ELT Pipeline

1. **Trigger the DAG**:
   - Access the Airflow Web UI ([http://localhost:8080](http://localhost:8080)).
   - Locate and trigger the DAG.
2. **Monitor Progress**:
   - Track task execution and view logs in the Airflow Web UI.
3. **Verify PostgreSQL Connection**:
   - Ensure the PostgreSQL database is running and accessible by Airflow.
4. **Data Transformation**:
   - Use **PgAdmin** ([http://localhost:5050](http://localhost:5050)) for transformations.
   - Connect PgAdmin to PostgreSQL:
    - Use `docker ps` to retrieve container name
     - Use `docker inspect` to retrieve the container's IP address:
       ```
       docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_name>
       ```
     - Register the server in PgAdmin using the retrieved address.

## Pipeline Overview

The ELT pipeline performs the following steps:

1. **Extract CSV Data**:
   - Reads data from source files and saves temporary copies in `TMP_PATH`.
2. **Load Data to PostgreSQL**:
   - Creates tables (if they do not exist) and loads data from temporary CSV files.
3. **Transform Data**:
   - Executes placeholder SQL queries for data transformation (customize as needed).

## Notes

- **Temporary Files**:
  - Files are saved in `TMP_PATH`. Ensure sufficient disk space and appropriate permissions.
- **Custom Transformations**:
  - The provided SQL transformation is a placeholder and should be replaced with project-specific logic.
- **Code Review**:
  - All changes must undergo review before merging to production.
