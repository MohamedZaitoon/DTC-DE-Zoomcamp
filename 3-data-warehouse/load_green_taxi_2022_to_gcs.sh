#!/bin/bash

for mon in $(seq 1 12); do
# Pad text to 10 characters with leading zeros
    month=$(printf "%02d" "$mon")
    wget "https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-$month.parquet"
# echo "https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_$year-$month.csv.gz"
done


# upload data into gcs
gcloud storage cp *.parquet gs://ny-taxi-bucket-de-zoomcamp/green/