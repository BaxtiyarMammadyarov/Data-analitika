use BikeStores;
go
select * from production.brands;
go 
select * from production.categories;
go 
select * from production.products;
go 
select count(*)from production.products;
go
select * from production.stocks;
go 

select COUNT(*) from production.stocks;

go 

select * from production.products
order by list_price
OFFSET 9 rows;

go

select * from production.products
order by list_price
OFFSET 9 rows
FETCH NEXT 10 ROWS ONLY;

go 

select * from sales.customers;

go 
select COUNT(*) as customers_row_count from sales.customers;

go

select * from sales.order_items;
go
select * from sales.orders;
go 
select * from sales.staffs;
go 
select * from sales.stores;

go

select * from sales.customers
where state='TX';

go 
select * from sales.customers
where state='TX' or state='CA';

go

select * from sales.customers
where state='TX' and city='Houston';

go
select * from sales.customers
where  city in('Houston','Hollis','Mahopac')
order by city;
go

select * from sales.orders
where shipped_date between '2016-04-05' and '2016-05-05';

go
select top 10 city from sales.customers
where  city in('Houston','Hollis','Mahopac')
order by city;

go 

select * from sales.orders;

go
--inner join
select * from sales.orders as so  inner join sales.staffs as ss on (so.staff_id=ss.staff_id);
go
--inner join
select ss.first_name,ss.last_name,ss.email,ss.phone,so.order_status,so.required_date 
from sales.orders as so  inner join sales.staffs as ss 
on (so.staff_id=ss.staff_id)
order by so.required_date
offset 1 rows
fetch next 5 rows only;

go
--left join
select * from sales.orders so left join sales.stores ss on(so.store_id=ss.store_id);

go
--left join
select * from sales.orders so left join sales.stores ss on(so.store_id=ss.store_id)
where ss.state='CA'
order by so.shipped_date
;
go
--left join
select so.* from sales.orders so left outer join sales.stores ss on(so.store_id=ss.store_id)
where ss.state='CA'
order by ss.zip_code

go
--right join
select so.* ,ss.zip_code,ss.phone from sales.orders so right join sales.stores ss on(so.store_id=ss.store_id)
where ss.state='CA'
order by ss.zip_code

go
--cross join
select * from production.products cross join sales.orders;

go

select * from sales.staffs

go 
--self join
select 
ss2.staff_id,
ss2.first_name,
ss2.last_name ,
ss2.manager_id,
ss1.staff_id,
ss1.first_name,
ss1.last_name
from sales.staffs ss1 inner join sales.staffs ss2
on ss1.staff_id=ss2.manager_id
order by ss1.staff_id;

go 
select * from production.products
go
select * from production.stocks
go
select * from production.categories
go
--full outer join
select * from production.products p full outer join production.categories c
on p.category_id= c.category_id
go
--full outer join
select * from production.products p full outer join production.stocks s
on p.category_id= s.product_id