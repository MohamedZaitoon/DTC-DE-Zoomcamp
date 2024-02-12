-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-411916.ny_taxi.external_greeen_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://ny-taxi-bucket-de-zoomcamp/green/green_tripdata_2022-*.parquet']
  
);

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE de-zoomcamp-411916.ny_taxi.green_tripdata_non_partitoned AS
SELECT * FROM `de-zoomcamp-411916.ny_taxi.external_greeen_tripdata`;


select distinct PULocationID  from `de-zoomcamp-411916.ny_taxi.external_greeen_tripdata`
;

select distinct PULocationID  from de-zoomcamp-411916.ny_taxi.green_tripdata_non_partitoned
;


select count(1) from de-zoomcamp-411916.ny_taxi.green_tripdata_non_partitoned where fare_amount = 0;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE de-zoomcamp-411916.ny_taxi.green_tripdata_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM de-zoomcamp-411916.ny_taxi.green_tripdata_non_partitoned;


select distinct PULocationID  from de-zoomcamp-411916.ny_taxi.green_tripdata_non_partitoned
where  Date(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30'
;

select distinct PULocationID  from de-zoomcamp-411916.ny_taxi.green_tripdata_partitoned_clustered
where  Date(lpep_pickup_datetime) between '2022-06-01' and '2022-06-30'
;



SELECT count(*) from de-zoomcamp-411916.ny_taxi.green_tripdata_non_partitoned;
