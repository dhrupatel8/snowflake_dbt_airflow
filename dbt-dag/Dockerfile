FROM quay.io/astronomer/astro-runtime:12.6.0

RUN python -m venv venv && source venv/bin/activate &&\
    pip install --no-cache-dir dbt-snowflake && deactivate