select * from sales.customers;

select * from sales.order_items;

select p.*, COALESCE(oi.quantity,0) quantity,COALESCE(oi.discount,0) discount from production.products p full join sales.order_items oi
on p.product_id=oi.product_id
order by oi.list_price ;


CREATE VIEW sales.product_sell AS
select 
		p.*, 
		COALESCE(oi.quantity,0) quantity,
		COALESCE(oi.discount,0) discount
		from production.products p left join sales.order_items oi
on p.product_id=oi.product_id
 ;



CREATE or ALTER VIEW sales.product_sell AS
select 
		p.*, 
		COALESCE(oi.quantity,0) quantity,
		COALESCE(oi.discount,0) discount,
		oi.list_price*oi.quantity*(1-oi.discount) sell
		from production.products p left join sales.order_items oi
on p.product_id=oi.product_id

 select ps.* from sales.product_sell ps
 where model_year=2019
 order by sell ;



 select model_year,COALESCE(sum(sell),0) sellSum from sales.product_sell
 group by model_year;

 select model_year,product_name,COALESCE(sum(sell),0) sellSum from sales.product_sell
 group by model_year,product_name
 order by sellSum desc;


SELECT product_name,COALESCE([2016],0)  AS '2016', COALESCE([2017],0)  AS '2017', COALESCE([2018],0)  AS '2018', COALESCE([2019],0)  AS '2019'  
FROM   
(SELECT model_year, product_name, sell  
FROM sales.product_sell) ps  
PIVOT  
(  
sum(sell)
FOR model_year IN  
( [2016], [2017], [2018], [2019] )  
) AS pvt  
ORDER BY pvt.product_name;



select * from sales.customers;

select * from sales.orders;


	select 
		concat(c.first_name,' ',c.last_name ) fullname,
		year(o.order_date) years,
		o.order_id order_id 
		from sales.customers c left join sales.orders o
	on c.customer_id= o.customer_id;


SELECT fullname,[2016]  AS '2016', [2017]  AS '2017',[2018]  AS '2018', [2019]  AS '2019'  
FROM   
(	select 
		concat(c.first_name,' ',c.last_name ) fullname,
		year(o.order_date) years,
		o.order_id order_id 
		from sales.customers c left join sales.orders o
	on c.customer_id= o.customer_id) ps  
PIVOT  
(  
count(order_id)
FOR years  IN  
( [2016], [2017], [2018], [2019] )  
) AS pvt  
ORDER BY pvt.fullname;


