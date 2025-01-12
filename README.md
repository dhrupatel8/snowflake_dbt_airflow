# Snowflake-DBT-Airflow

This project demonstrates how to set up and integrate Snowflake, dbt, and Airflow for building and running a robust data pipeline. Follow the step-by-step guide below to replicate the project.

---

## What We Are Doing in This Project

We are creating an ELT pipeline using Snowflake, dbt, and Airflow.

### Data

**TPC-H Benchmark**: TPC-H is a decision support benchmark consisting of a suite of business-oriented ad hoc queries and concurrent data modifications. It is designed to illustrate decision support systems that:
- Examine large volumes of data
- Execute queries with high complexity
- Answer critical business questions

More details can be found [here](https://docs.snowflake.com/en/user-guide/sample-data-tpch).

### Pipeline Overview

**Type of Data Pipeline**: Batch Processing  
**Source**: Snowflake Sample Data  
**Volume**: Approximately 1 million rows

#### Steps in the Pipeline

1. **Ingestion**:
   - Retrieve data from Snowflake Sample Data (e.g., `orders` and `lineitem` tables).
   - Select specific columns from these tables.
   - Add a surrogate key to the `lineitem` table for later reference.
   - Store the selected data in the "Staging" layer as Views (data remains within the Snowflake ecosystem).

2. **Transformation**:
   - **Dimension Modeling**:
      1. Transform data from the Staging layer and load it into the "Marts" layer.
      2. Create an `order_item` table combining orders and items for detailed item information.
      3. Generate an order items summary table using macros to create a User Defined Function (UDF) called `discounted_amount`.
      4. Combine the order items summary with the orders table to create a fact table.
   - **Validation Tests**:
      - Generic tests on the fact table:
         - Ensure values are unique.
         - Validate non-null fields.
         - Check status codes against a predefined list.
      - Business logic tests:
         - Discounts must be greater than 0.
         - Dates must be after `1990-01-01`.

3. **Serving**:
   - The transformed data is now ready for downstream stakeholders, such as Machine Learning Engineers, Data Analysts, and Data Scientists.

4. **Orchestration with Airflow**:
   - Use Airflow to run the pipeline daily.
   - Visualize the data flow from the source through transformations to the final destination.

---

## Table of Contents
1. [Environment Setup](#1-environment-setup)
2. [Snowflake Configuration](#2-snowflake-configuration)
3. [Initialize the dbt Project](#3-initialize-the-dbt-project)
4. [Install Additional dbt Packages](#4-install-additional-dbt-packages)
5. [Run and Test dbt Models](#5-run-and-test-dbt-models)
6. [Set Up Airflow with Astro](#6-set-up-airflow-with-astro)
7. [Configure Airflow for Snowflake](#7-configure-airflow-for-snowflake)
8. [Notes](#8-notes)
9. [License](#9-license)

---

## 1. Environment Setup

1. Activate the virtual environment:
   ```bash
   source venv/bin/activate
   ```
2. Install dbt-core and dbt-snowflake:
   ```bash
   pip install dbt-core
   pip install dbt-snowflake
   ```

---

## 2. Snowflake Configuration

1. Create the required role, warehouse, database, and schema in Snowflake.
2. Use the `snowflake_init.sql` script:
   - Open the script and execute it in Snowflake.
   - After completing the project, uncomment the "Manage Resources" section in the script to remove unnecessary resources and reduce costs.

---

## 3. Initialize the dbt Project

1. Run the following command to initialize the dbt project:
   ```bash
   dbt init
   ```
2. Follow the prompts:
   - **Project Name**: `data_pipeline`
   - **Database Selection**: Choose the appropriate number for Snowflake (e.g., `2`).
   - **Account**: Enter the account identifier (found in **Admin → Accounts**).
   - **User**: Provide the username (from the `SHOW USERS;` command in Snowflake).
   - **Authentication**: Choose "Password" (password is securely stored outside the project).
   - **Role**: Use `dbt_role`.
   - **Warehouse**: Use `dbt_wh`.
   - **Database**: Use `dbt_db`.
   - **Schema**: Use `dbt_schema`.
   - **Threads**: Enter `4`.

---

## 4. Install Additional dbt Packages

1. Add the required packages to the `packages.yml` file.
2. Install the packages:
   ```bash
   dbt deps
   ```
> **Note:** Ensure you are in the `data_pipeline` directory when running this command.

---

## 5. Run and Test dbt Models

1. To run the dbt models:
   ```bash
   dbt run
   ```
2. To test the models:
   ```bash
   dbt test
   ```

---

## 6. Set Up Airflow with Astro

1. Install Astro CLI:
   ```bash
   brew install astro
   ```
2. Initialize an Astro project:
   ```bash
   astro dev init
   ```
3. Start the Astro development environment:
   ```bash
   astro dev start --wait 2m
   ```

---

## 7. Configure Airflow for Snowflake

1. Open the Airflow UI.
2. Add a new Snowflake connection with the following details:
   - **Username**: Your Snowflake username.
   - **Password**: Your Snowflake password.
   - **Warehouse**: `dbt_wh`
   - **Database**: `dbt_db`
   - **Schema**: `dbt_schema`
   - **Account Name**: Snowflake account identifier.

---

## 8. Notes

- Ensure Snowflake resources are effectively managed to avoid incurring unnecessary costs.
- Follow best practices for dbt development and testing.

---

Enjoy building your data pipeline! 🎉
