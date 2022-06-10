use BikeStores;
GO
CREATE OR ALTER PROC first_name_select(
										@first_name nvarchar(100),
										@db_name nvarchar(100),
										@schema_name nvarchar(100),
										@table_name nvarchar(100))
as
begin 
declare @v_sql nvarchar(max)=N'select '+@first_name+N' from '+@db_name+N'.'+@schema_name+N'.'+@table_name;
exec sp_executesql @v_sql;

end;

exec first_name_select 'first_name','BikeStores','sales','customers';

go
CREATE OR ALTER PROC first_name_select_test(
										@first_name nvarchar(100),
										@db_name nvarchar(100),
										@schema_name nvarchar(100),
										@table_name nvarchar(100))
as
begin 
declare @v_sql nvarchar(max)=N'select '+@first_name+' from '+QUOTENAME(@db_name)+'.'+QUOTENAME(@schema_name)+'.'+QUOTENAME(@table_name);
exec sp_executesql @v_sql;

end;

exec first_name_select '(select * from sys.messages)','BikeStores','sales','customers';

go
create or alter proc groupby_proc(
								@column_name nvarchar(100),
								@db_name nvarchar(100),
								@schema_name nvarchar(100),
								@table_name nvarchar(100))
as 
begin 
declare @v_sql nvarchar(max)=N'select '
							+@column_name+',count(*) as '
							+@column_name+'_count'+ ' from '
							+@db_name+N'.'+@schema_name+N'.'
							+@table_name+' group by '+@column_name;
exec sp_executesql @v_sql;
end;

exec groupby_proc 'state','BikeStores','sales','customers';

exec groupby_proc 'staff_id','BikeStores','sales','orders'

select * from sales.orders

