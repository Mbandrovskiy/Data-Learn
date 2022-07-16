--Total Sales, profit, ratio and count returns per month
select
	extract(year from o.order_date) as year
	, extract(month from	o.order_date) as month
	,	count(distinct o.order_id) as count_orders
	,	Round(SUM(o.sales), 2) as Sales
	,	Round(sum(profit), 2) as Profit
	,	Round(sum(profit)/ SUM(o.sales) * 100, 2) as Profit_ratio
	,	Count(distinct r.order_id) as Returned_count_orders
from
	orders o
join
people p on
	o.region = p.region
left join
returns r on
	o.order_id = r.order_id
group by
	extract(year from	o.order_date),
	extract(month from	o.order_date)
order by
	1,
	2

	
--Sales, profit and ratio per category ang subcateory
select
extract(year from o.order_date) as year
, o.category as category
, o.subcategory as subcategory
, Round(SUM(o.sales), 2) as Sales
, Round(sum(profit), 2) as Profit
, Round(sum(profit)/ SUM(o.sales) * 100, 2) as Profit_ratio
FROM
orders o
group by extract(year from o.order_date), o.category, o.subcategory
order by 1, 4 desc

--Sales, profit and ratio per segment
select
extract(year from o.order_date) as year
, o.segment as segment
, Round(SUM(o.sales), 2) as Sales
, Round(sum(profit), 2) as Profit
, Round(sum(profit)/ SUM(o.sales) * 100, 2) as Profit_ratio
FROM
orders o
group by extract(year from o.order_date), o.segment
order by 1, 3 desc

--Sales, profit and ratio per region and state
select
	extract(year from o.order_date) as year
	, o.region as region
	, o.state as state
	, Round(SUM(o.sales), 2) as Sales
	, Round(sum(profit), 2) as Profit
	, Round(sum(profit)/ SUM(o.sales) * 100, 2) as Profit_ratio
FROM
	orders o
group by extract(year from o.order_date), o.region, o.state 
order by 1, 2, 4 desc
