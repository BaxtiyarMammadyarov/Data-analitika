use BikeStores;
go
create or alter procedure print_Customers( @customer_id int,@nameSurname varchar(50) output)
 
as
begin
 select @nameSurname=CONCAT(c.first_name,' ',c.last_name)  from sales.customers c where  c.customer_id=@customer_id;
 print ( @nameSurname+' salam');
 end;
 go

 declare @nameSurname varchar(50);
exec print_Customers 12,@nameSurname output;
select @nameSurname ;

select top(10) oi.product_id  from sales.orders o inner join sales.order_items oi
on(o.order_id=oi.order_id)
group by oi.product_id
order by count(*) desc

go
create or alter procedure f_Top_Product(
@producrt CURSOR VARYING OUTPUT)
as
begin
 set @producrt =cursor for
 select p.product_name,p.list_price from production.products p
 where product_id in (select top(10) oi.product_id  from sales.orders o inner join sales.order_items oi
on(o.order_id=oi.order_id)
group by oi.product_id
order by count(*) desc)
open @producrt;
end;
go

declare 
 @producrt cursor,
 @name varchar(100),
 @price decimal(10,2)

 exec  f_Top_Product  @producrt output;

 fetch next from  @producrt into  @name,@price
  while @@FETCH_STATUS=0
   begin
   PRINT @name+' : '+cast(@price as varchar(50));
   fetch next from  @producrt into  @name,@price
   end;

close @producrt;




go
create  or alter procedure store_Check(@producrt CURSOR VARYING OUTPUT)
as
begin
 set @producrt =cursor for
 select p.product_id, p.product_name,s.store_id,s.quantity from production.products p inner join production.stocks s
on (p.category_id=s.product_id)
where p.product_id in(select top(10) oi.product_id  from sales.orders o inner join sales.order_items oi
on(o.order_id=oi.order_id)
group by oi.product_id
order by count(*) desc)
open @producrt;
end;
go

create or alter procedure print_check_store
as
declare
 @v_producrt cursor,
 @v_p_id int,
 @name varchar(100),
 @v_s_id int,
 @v_count int;

 exec  store_Check  @v_producrt output;

 fetch next from  @v_producrt into @v_p_id , @name,@v_s_id,@v_count
  while @@FETCH_STATUS=0
   begin
    if @v_count<10
	   begin
          PRINT 'product_id '+cast(@v_p_id as varchar(12))+ ' producrt_name'+ @name+'  '+' store id : '+cast(@v_s_id as varchar(12))+' count'+cast(@v_count as varchar(12));
	   end
  fetch next from  @v_producrt into @v_p_id , @name,@v_s_id,@v_count
   end;

close @v_producrt;
go

exec print_check_store;

