use BikeStores;

select * from sales.customers;




 begin 
   EXEC sp_executesql N'select * from sales.customers';
 end ;


go
create or alter proc selectByTablename(@table_name VARCHAR(128))
AS
DECLARE
@sql nvarchar(500);
BEGIN
 set @sql=N'select * from '+@table_name;
 exec sp_executesql @sql;
 end;


 EXEC selectByTablename @table_name='sales.customers';


 ---SQL INJECTION RUNING
 EXEC selectByTablename @table_name=';select * from sales.customers;';

go
 create or alter proc selectByNameOrSurname(@p_name nvarchar(100), @p_surname nvarchar(100))
 AS
 begin 
 declare @sql nvarchar(max);

    set @sql=N'select* from sales.customers where  first_name = @name and last_name=@surname';
    exec sp_executesql @sql,N'@name nvarchar(100),@surname nvarchar(100)',@name =@p_name,@surname=@p_surname;
 end;




 exec selectByNameOrSurname @p_name='Debra',@p_surname='Burks';
  ---SQL INJECTION DON'T RUNING
 exec selectByNameOrSurname @p_name=';select * from sales.customers;',@p_surname='Burks';

 select * from sales.customers;

 go
 CREATE OR ALTER PROC usp_query
 (
    @schema NVARCHAR(128),
	@table NVARCHAR(128)
 )
 AS
	BEGIN 
		DECLARE
			@sql NVARCHAR(MAX);

			SET @sql= N'SELECT * FROM '+QUOTENAME(@schema)+'.'+QUOTENAME(@table);
		EXEC sp_executesql @sql;

	END;
 go

  ---SQL INJECTION DON'T RUNING
 EXEC usp_query 'production',';select * from sales.customers;';

 EXEC usp_query 'production','brands';


 declare @v_value nvarchar(100),
 @v_str nvarchar(100)='last_name,first_name,;drop table user;,price',
 @v_count INT;
 DECLARE str_tbl CURSOR FOR  select value from string_split(@v_str,',');
 BEGIN
		
		open str_tbl;
		FETCH NEXT FROM str_tbl INTO @v_value
		WHILE @@FETCH_STATUS=0
		 BEGIN
			  SELECT @v_count= COUNT(*) FROM string_split(@v_value,' ') ;
				IF @v_count>1
					 BEGIN
						PRINT 'SQL INJECTION';
					 END;
				ELSE 
					 PRINT 'SUCCSES';
			FETCH NEXT FROM str_tbl INTO @v_value
		END;
	CLOSE str_tbl;
	DEALLOCATE str_tbl;
  END;


--  CREATE FUNCTION dbo.ParseColumnList
--(
--  @List NVARCHAR(MAX)
--)
--RETURNS TABLE
--AS
--  RETURN 
--  (
--    SELECT i, 
--      c = LTRIM(CONVERT(SYSNAME, SUBSTRING(@List, i, CHARINDEX(',', @List + ',', i) - i)))
--    FROM (SELECT ROW_NUMBER() OVER (ORDER BY [object_id]) FROM sys.all_columns) AS n(i)
--    WHERE i <= LEN(@List) AND SUBSTRING(',' + @List, i, 1) = ','
--  );
  