-- Question 3. Count records
select count(1) from green_taxi_trips
where lpep_pickup_datetime::date='2019-09-18' and lpep_dropoff_datetime::date='2019-09-18';

-- Question 4. Largest trip for each day
select lpep_pickup_datetime::date as pickup_date, max(lpep_dropoff_datetime - lpep_pickup_datetime) as tirp_time
from green_taxi_trips
group by 1
order by tirp_time desc; 


-- Question 5. Three biggest pick up Boroughs
select  puz."Borough", sum(gtt.total_amount) total_amount_per_Borough 
from green_taxi_trips as gtt left join zones as puz
	on gtt."PULocationID" = puz."LocationID"
where lpep_pickup_datetime::date='2019-09-18' and puz."Borough" <> 'Unknown'
group by 1
order by total_amount_per_Borough desc;


-- Question 6. Largest tip
select doz."Zone", max(gtt.tip_amount) largest_tip
from green_taxi_trips as gtt 
	left join zones as puz on gtt."PULocationID" = puz."LocationID"
	left join zones as doz on gtt."DOLocationID" = doz."LocationID"
where extract(Month from  lpep_pickup_datetime) = '9' and
	puz."Zone" = 'Astoria'
group by 1
order by largest_tip desc
;
