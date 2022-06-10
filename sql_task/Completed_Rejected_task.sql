use BikeStores;

SELECT *
FROM
	( SELECT
		cstmrs.first_name as fn,
		cstmrs.last_name as ln,
		ordrs.order_status as os ,
		COUNT(*) Sayı
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	FROM
		sales.customers cstmrs
		LEFT JOIN sales.orders ordrs
		ON cstmrs.customer_id = ordrs.customer_id
	GROUP BY --
        cstmrs.first_name ,
        cstmrs.last_name ,
        ordrs.order_status
) nev
where fn='Adelle';

SELECT cstmrs.customer_id , cstmrs.first_name as fn, cstmrs.last_name as ln, ordrs.order_status as os , count(*) say

FROM sales.customers cstmrs
	inner JOIN sales.orders ordrs
	ON cstmrs.customer_id = ordrs.customer_id
where cstmrs.customer_id=1
group by cstmrs.customer_id,  
        cstmrs.first_name,
        cstmrs.last_name ,
        ordrs.order_status
;
SELECT cstmrs.first_name as fn, cstmrs.last_name as ln, ordrs.order_status as os , count(*) say

FROM sales.customers cstmrs
	inner JOIN sales.orders ordrs
	ON cstmrs.customer_id = ordrs.customer_id
group by   cstmrs.first_name,
        cstmrs.last_name ,
        ordrs.order_status
;




select *
from sales.customers sc
where sc.customer_id in (select customer_id
from sales.orders
where order_status=3)

;

select store_id, count(*)
from sales.orders
where order_status=3

group by store_id;

SELECT
	cstmrs.first_name as fn,
	cstmrs.last_name as ln,
	Category= case ordrs.order_status  
					when 1 then 'Pending'
					when 2 then 'Processing'
					when 3 then 'Rejected'
					else  'Completed'
					end

-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
FROM
	sales.customers cstmrs
	LEFT JOIN sales.orders ordrs
	ON cstmrs.customer_id = ordrs.customer_id




SELECT cstmrs.customer_id id, cstmrs.first_name as fn, cstmrs.last_name as ln

FROM sales.customers cstmrs
	inner JOIN sales.orders ordrs
	ON cstmrs.customer_id = ordrs.customer_id


SELECT cstmrs.customer_id id, cstmrs.first_name as fn, cstmrs.last_name as ln, ordrs.order_status, count(*)

FROM sales.customers cstmrs
	inner JOIN sales.orders ordrs
	ON cstmrs.customer_id = ordrs.customer_id

group by
					 cstmrs.customer_id,
				    cstmrs.first_name,
					cstmrs.last_name ,
					ordrs.order_status
having ordrs.order_status=1

select *
from (select *
	from sales.customers
	where city='Campbell') new
where  state='CA';

select t2.*, COALESCE(t1.rejected_count,0) rejected_count
from
	(SELECT cstmrs.customer_id id, cstmrs.first_name as fn, cstmrs.last_name as ln, count(*) rejected_count

	FROM sales.customers cstmrs
		inner JOIN sales.orders ordrs
		ON cstmrs.customer_id = ordrs.customer_id
	where ordrs.order_status =3
	group by
					 cstmrs.customer_id,
				    cstmrs.first_name,
					cstmrs.last_name 
				) t1
	right outer join

	(SELECT cstmrs.customer_id id, cstmrs.first_name as fn, cstmrs.last_name as ln, count(*) Completed_count

	FROM sales.customers cstmrs
		inner JOIN sales.orders ordrs
		ON cstmrs.customer_id = ordrs.customer_id
	where ordrs.order_status=4
	group by  
						cstmrs.customer_id ,
						cstmrs.first_name,
						cstmrs.last_name 				 
				) t2
	on t1.id=t2.id
--where ugurlu>ugursuz
order by  t1.rejected_count desc;