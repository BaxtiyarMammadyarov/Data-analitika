use BikeStores;

select * from sales.customers;

select state ,count(*) as count_row from sales.customers
group by state;

select so.customer_id,count(*) from sales.orders as so
group by so.customer_id;

select 
      first_name,
	  last_name,
	  min(order_date) as first_order,
	  max(order_date) as last_order,
	  count(*) as order_count 
	  from sales.orders so inner join sales.customers sc
on so.customer_id=sc.customer_id
group by first_name,last_name,email;

select * from production.products

select b.brand_name,count(*) from production.products p inner join production.categories c
on p.category_id=c.category_id
inner join production.brands b
on p.brand_id=b.brand_id
group by b.brand_name;

select * from sales.order_items;

select c.first_name f_name,
       c.last_name l_name,
	   c.email email,
	   o.order_date o_date,
	   oi.list_price price,
	   p.product_name p_name,
	   b.brand_name b_name,
	   pc.category_name c_name
from sales.customers c inner join sales.orders o
on c.customer_id = o.customer_id
inner join sales.order_items oi
on o.order_id=oi.order_id
inner join production.products p  
on oi.product_id=p.product_id
inner join production.brands b
on p.brand_id=b.brand_id
inner join production.categories pc
on p.category_id=pc.category_id;


select f_name,l_name,email , min(o_date),min(price) from 
 (select c.first_name f_name,
       c.last_name l_name,
	   c.email email,
	   o.order_date o_date,
	   oi.list_price price,
	   p.product_name p_name,
	   b.brand_name b_name,
	   pc.category_name c_name
from sales.customers c inner join sales.orders o
on c.customer_id = o.customer_id
inner join sales.order_items oi
on o.order_id=oi.order_id
inner join production.products p  
on oi.product_id=p.product_id
inner join production.brands b
on p.brand_id=b.brand_id
inner join production.categories pc
on p.category_id=pc.category_id) as new
where c_name='Cruisers Bicycles'
group by f_name,l_name,email


select f_name,l_name,email ,b_name, min(o_date) first_order_date,min(price) min_price from 
 (select c.first_name f_name,
       c.last_name l_name,
	   c.email email,
	   o.order_date o_date,
	   oi.list_price price,
	   p.product_name p_name,
	   b.brand_name b_name,
	   pc.category_name c_name
from sales.customers c inner join sales.orders o
on c.customer_id = o.customer_id
inner join sales.order_items oi
on o.order_id=oi.order_id
inner join production.products p  
on oi.product_id=p.product_id
inner join production.brands b
on p.brand_id=b.brand_id
inner join production.categories pc
on p.category_id=pc.category_id) as new
where b_name in
               (select brand_name from production.brands
			      where len(brand_name)<5
			   )
group by f_name,l_name,email,b_name
order by min_price;


select f_name,l_name,email ,b_name, min(o_date) first_order_date,max(o_date) last_order_date,avg(price) avg_price from 
 (select c.first_name f_name,
       c.last_name l_name,
	   c.email email,
	   o.order_date o_date,
	   oi.list_price price,
	   p.product_name p_name,
	   b.brand_name b_name,
	   pc.category_name c_name
from sales.customers c inner join sales.orders o
on c.customer_id = o.customer_id
inner join sales.order_items oi
on o.order_id=oi.order_id
inner join production.products p  
on oi.product_id=p.product_id
inner join production.brands b
on p.brand_id=b.brand_id
inner join production.categories pc
on p.category_id=pc.category_id) as new
where b_name in
               (select brand_name from production.brands
			      where len(brand_name)<5
			   )
group by f_name,l_name,email,b_name
order by avg_price;

select * from (
     select 
     f_name,
	 l_name,
	 email ,
	 b_name,
	 count(*) count_order,
	 min(o_date) first_order_date,
	 max(o_date) last_order_date,
	 avg(price) avg_price from 
                          (select c.first_name f_name,
                                  c.last_name l_name,
	                              c.email email,
	                              o.order_date o_date,
	                              oi.list_price price,
	                              p.product_name p_name,
	                              b.brand_name b_name,
	                              pc.category_name c_name
                                  from sales.customers c inner join sales.orders o
                                  on c.customer_id = o.customer_id
                                  inner join sales.order_items oi
                                  on o.order_id=oi.order_id
                                  inner join production.products p  
                                  on oi.product_id=p.product_id
                                  inner join production.brands b
                                  on p.brand_id=b.brand_id
                                  inner join production.categories pc
                                  on p.category_id=pc.category_id) as new
                                  where b_name in
                                                (select brand_name from production.brands
			                                      where len(brand_name)<5
			                                     )
                           group by f_name,l_name,email,b_name
                          ) new_table
where first_order_date<>last_order_date


select * from (
     select 
     f_name,
	 l_name,
	 email ,
	 b_name,
	 count(*) count_order,
	 min(o_date) first_order_date,
	 max(o_date) last_order_date,
	 avg(price) avg_price from 
                          (select c.first_name f_name,
                                  c.last_name l_name,
	                              c.email email,
	                              o.order_date o_date,
	                              oi.list_price price,
	                              p.product_name p_name,
	                              b.brand_name b_name,
	                              pc.category_name c_name
                                  from sales.customers c inner join sales.orders o
                                  on c.customer_id = o.customer_id
                                  inner join sales.order_items oi
                                  on o.order_id=oi.order_id
                                  inner join production.products p  
                                  on oi.product_id=p.product_id
                                  inner join production.brands b
                                  on p.brand_id=b.brand_id
                                  inner join production.categories pc
                                  on p.category_id=pc.category_id) as new
                                  where b_name in
                                                (select brand_name from production.brands
			                                      where len(brand_name)<5
			                                     )
                           group by f_name,l_name,email,b_name
                          ) new_table
where count_order>1;



with newtable as (select c.first_name f_name,
                                  c.last_name l_name,
	                              c.email email,
	                              o.order_date o_date,
	                              oi.list_price price,
	                              p.product_name p_name,
	                              b.brand_name b_name,
	                              pc.category_name c_name
                                  from sales.customers c inner join sales.orders o
                                  on c.customer_id = o.customer_id
                                  inner join sales.order_items oi
                                  on o.order_id=oi.order_id
                                  inner join production.products p  
                                  on oi.product_id=p.product_id
                                  inner join production.brands b
                                  on p.brand_id=b.brand_id
                                  inner join production.categories pc
                                  on p.category_id=pc.category_id)
SELECT * FROM newtable;


with newtable as (select c.first_name f_name,
                                  c.last_name l_name,
	                              c.email email,
	                              o.order_date o_date,
	                              oi.list_price price,
	                              p.product_name p_name,
	                              b.brand_name b_name,
	                              pc.category_name c_name
                                  from sales.customers c inner join sales.orders o
                                  on c.customer_id = o.customer_id
                                  inner join sales.order_items oi
                                  on o.order_id=oi.order_id
                                  inner join production.products p  
                                  on oi.product_id=p.product_id
                                  inner join production.brands b
                                  on p.brand_id=b.brand_id
                                  inner join production.categories pc
                                  on p.category_id=pc.category_id)
SELECT * FROM newtable
where price>any(select price from newtable where price between 1000 and 2000);


with newtable as (select c.first_name f_name,
                                  c.last_name l_name,
	                              c.email email,
	                              o.order_date o_date,
	                              oi.list_price price,
	                              p.product_name p_name,
	                              b.brand_name b_name,
	                              pc.category_name c_name
                                  from sales.customers c inner join sales.orders o
                                  on c.customer_id = o.customer_id
                                  inner join sales.order_items oi
                                  on o.order_id=oi.order_id
                                  inner join production.products p  
                                  on oi.product_id=p.product_id
                                  inner join production.brands b
                                  on p.brand_id=b.brand_id
                                  inner join production.categories pc
                                  on p.category_id=pc.category_id)
SELECT * FROM newtable
where price>all(select price from newtable where price between 1000 and 2000);


select * from sales.customers
where exists (select customer_id, count(*) as order_count from sales.orders
group by customer_id
having count(*)>5)
;

select * from (
	(select  staff_id,customer_id,COUNT(*) as order_count_staff from sales.orders
	group by staff_id,customer_id) staff_group
	inner join
	(select  store_id,customer_id,COUNT(*) as order_count_store from sales.orders
	group by  store_id,customer_id) store_group
	on staff_group.customer_id= staff_group.customer_id)
	
;