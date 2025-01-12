-- We will have to use ACCOUNTADMIN ROLE. ACCOUNTADMIN role is like a super role in Snowflake
USE ROLE ACCOUNTADMIN;

--------------------
-- CREATE RESOURCES
--------------------
-- Create a warehouse with x-small size
CREATE WAREHOUSE dbt_wh with warehouse_size='x-small';

-- Create a database
CREATE DATABASE IF NOT EXISTS dbt_db;
--------------------


--------------------
-- ROLE AND GRANTS
--------------------
-- Create a New Role
CREATE ROLE IF NOT EXISTS dbt_role;

-- Grant Usage of the warehouse to the dbt_role
GRANT usage ON WAREHOUSE dbt_wh TO dbt_role;

-- Get your Users' name and classify who you want to give access to
SHOW USERS;

-- Grant Role to a particular user
GRANT ROLE dbt_role TO USER <GET YOUR OWN USER NAME FROM USERS>;

-- Grant Usage of the database to the dbt_role
GRANT ALL ON DATABASE dbt_db TO ROLE dbt_role;
--------------------


USE ROLE dbt_role;
--------------------
-- Create Schema using dbt_role
--------------------

-- A user may not create the database, but they should create the schema
CREATE SCHEMA IF NOT EXISTS dbt_db.dbt_schema;
--------------------


-- UNCOMMENT TO MANAGE RESOURCES
-- USE ROLE ACCOUNTADMIN;
-- --------------------
-- -- Manage Resources - You may want to drop to not incur cost
-- --------------------

-- -- Drop dbt_wh
-- DROP WAREHOUSE IF EXISTS dbt_wh;

-- -- Drop dbt_db
-- DROP DATABASE IF EXISTS dbt_db

-- -- DROP role
-- DROP role dbt_role




