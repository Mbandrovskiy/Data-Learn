
-- �������� ������ � ������� module2.shipping_dim - ������� 4 ������
insert into module2.shipping_dim 
		(ship_mode) 
	select distinct 
		ship_mode 
	from 
		de101.orders

-- �������� ������ � ������� module2.segment_dim  -- ������� 3 ������
insert	into module2.segment_dim 
		(segment_name)
	select distinct 
		segment
	from
		de101.orders;

-- �������� ������ � ������� module2.returned_dim  -- ������� 296 ������
insert into module2.returned_dim 
		(order_id
		, returned)
	select distinct  
		order_id
		, true 
	from 
		de101."returns";

-- �������� ������ � ������� module2.product_dim  -- ������� 1 894 ������
insert into module2.product_dim 
		(product_id
		, category
		, subcategory
		, product_name)
	select distinct 
		product_id
		, category
		, subcategory
		, product_name 
	from 
		de101.orders;

-- �������� ������ � ������� module2.location_dim -- ������� 632 ������
insert into module2.location_dim 
		(country
		, region
		, state
		, city
		, postal_code
		, manager_full_name)
	select distinct 
		o.country
		, o.region
		, o.state
		, o.city
		, o.postal_code
		, p.person
	from 
		de101.orders o
			join de101.people p 
				on o.region = p.region;


-- �������� ������ � ������� module2.customer_dim -- ������� 793 ������
insert into module2.customer_dim 
		(customer_id
		, castomer_name)
	select distinct
		customer_id
		, customer_name
	from
		de101.orders;

-- �������� ������ � ������� module2.calendar_dim -- ������� 3 472 ������
insert into module2.calendar_dim 
		(date
		, ship_date
		, year
		, month)
	select distinct 
		o.order_date
		, o.ship_date
		, EXTRACT(year  from o.order_date)
		, EXTRACT(MONTH from o.order_date)
	from 
		de101.orders o;

-- �������� ������ � ������� module2.sales_fact -- ������� 9 994 ������
insert into module2.sales_fact 
		(order_id
		, segment_id
		,location_id
		, shipping_id
		, customer_id
		, product_id
		, date
		, sales_amount
		, profit
		, quantity
		, discount
		, ship_date
		, product_name)
	select 
		o.order_id
		, sd.segment_id
		, ld.location_id
		, shd.shipping_id
		, o.customer_id
		, o.product_id
		, o.order_date
		, o.sales
		, o.profit
		, o.quantity
		, o.discount
		, o.ship_date
		, o.product_name 
	from 
		de101.orders o
			left join module2.segment_dim sd 
				on sd.segment_name = o.segment
			join module2.location_dim ld 
				on (ld.state = o.state and ld.city = o.city and ld.postal_code = o.postal_code::varchar)
				or (ld.state = o.state and ld.city = o.city and ld.postal_code is null) 
			left join module2.shipping_dim shd 
				on shd.ship_mode = o.ship_mode
;