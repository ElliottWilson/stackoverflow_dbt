# stackoverflow_dbt

This repo is for a anayltics pipeline from the pulblic big query stackoverflow database. It contains the following:
1. dbt pipeline for tranforming the raw data into a star schema
2. dbt schema tests
3. Refrences to the raw sources from the publically avialble big query dataset 

# Requeriments
1. dbt will need to be installed locally you can follow these instructions to do this: https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/installation/

2. You may need to set up the source and destination databases with the correct permissions in big query this is how you set up the database: - - https://cloud.google.com/bigquery/docs/how-to
https://docs.getdbt.com/reference/resource-configs/bigquery-configs/
https://cloud.google.com/source-repositories/docs/viewing-users-and-permissions

3. You need to set up your ./dbt_profile with the relvent database credentials it will look some thing like this after:

default:\
  outputs:\
   bigquery:\
    type: bigquery\
     threads: 4\
     host: ????\
     port: ????\
     user: ????\
     pass: ????\
     dbname: ????\
     schema: ????\
   target: bigquery
   
 4. Once the credentials are set up you should navigate to the ./stackoverflow_dbt directory and run the command dbt run in the command line.
 
