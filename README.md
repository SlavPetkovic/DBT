# DBT Project: Employee Data Pipeline

This repository contains a **dbt** project designed to transform and prepare employee-related data for analytical purposes. The goal is to create a reliable and efficient data pipeline using **FiveTran**, **Snowflake**, and **dbt**.

## Project Overview

This project demonstrates the creation of an end-to-end data pipeline to support employee data analysis, including:
- **Data Loading**: Using FiveTran to sync data from CSV files into Snowflake.
- **Data Transformation**: Utilizing dbt to transform raw data into a structured, analytical model.
- **Business Need**: Support building an employee fluctuation report, as showcased in this [Tableau Public demo](https://public.tableau.com/app/profile/starschema/viz/Fluctuationreport/Fluctuationreport).

## Key Features

- **Source Data**: Employee-related datasets, including departments, employees, salaries, titles, and departures.
- **Star Schema**: Organized data into fact and dimension tables for easy analysis.
- **Transformations**:
  - Deduplication of employee records.
  - Assignment of a single department per employee.
  - Aggregated metrics for employee tenure and salary trends.

## Requirements

### Tools
- **FiveTran**: For syncing data to Snowflake.
- **Snowflake**: Cloud-based data warehouse for storing and querying data.
- **dbt (Data Build Tool)**: For data transformations and modeling.
- **Tableau** (optional): For visualization and reporting.

### Prerequisites
- **Python 3.8+** installed locally.
- A **Snowflake** account.
- A **FiveTran** account (trial is acceptable).
- dbt CLI or dbt Cloud setup.

## Setup Instructions

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/SlavPetkovic/DBT.git
    cd DBT
    ```

2. **Install Dependencies**:
    Ensure `dbt` is installed locally. Use the following command to install dbt with the Snowflake adapter:
    ```bash
    pip install dbt-snowflake
    ```

3. **Configure dbt**:
    Update the `profiles.yml` file with your Snowflake credentials:
    ```yaml
    default:
      target: dev
      outputs:
        dev:
          type: snowflake
          account: <your_account>
          user: <your_user>
          password: <your_password>
          role: <your_role>
          database: <your_database>
          warehouse: <your_warehouse>
          schema: <your_schema>
    ```

4. **Sync Data**:
    Use **FiveTran** to sync the provided CSV datasets into your Snowflake database.

5. **Run dbt Commands**:
    - Compile the dbt models:
        ```bash
        dbt run
        ```
    - Run the tests:
        ```bash
        dbt test
        ```

6. **Analyze Data**:
    - Explore the transformed data in Snowflake.
    - Use Tableau (or another BI tool) to create visualizations.

## Project Structure

```plaintext
.
├── analyses/               # Custom SQL analyses
├── macros/                 # Reusable macros for transformations
├── models/                 # dbt models
│   ├── marts/              # Fact and dimension models
│   ├── staging/            # Staging models
├── seeds/                  # Seed CSV files (static datasets)
├── snapshots/              # Snapshot definitions for slowly changing dimensions
├── tests/                  # Data quality tests
├── dbt_project.yml         # dbt project configuration
└── README.md               # Project documentation
