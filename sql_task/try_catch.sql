use BikeStores;

select * from sys.messages where message_id=10000;
/*
severity[0-25]
[0-10] user input exception
[11-16] programing exception
[17] stack over floovr error
[18] mssql bag error
[19] mssql technical limitation error
[20-25] mssql server error


*/
go
create or alter proc usr_show_error_info
as
select  ERROR_NUMBER() ERROR_NUMBER,
		ERROR_MESSAGE() ERROR_MESSAGE,
		ERROR_LINE() ERROR_LINE,
		ERROR_STATE() ERROR_STATE,
		ERROR_PROCEDURE() ERROR_PROCEDURE,
		ERROR_SEVERITY() ERROR_SEVERITY;
go
begin try 

select 1/0
end try
begin catch
 exec usr_show_error_info;
end catch;


go


go
drop table users;
create table users(id int identity primary key ,username varchar(30),email varchar(50),user_password nvarchar(30));

go

  create or alter proc usr_insert_user_table(@username nvarchar(100),@email nvarchar(100),@password nvarchar(100))
  as
  begin
     declare @v_sql nvarchar(max)=N'insert into users(username,email,user_password) values(@username,@email,@password)';
	 begin try
	      if len(@username)>30
		    begin
			   print  concat( 'username check ',@username);
			    RAISERROR (
				            'username should not exceed 30 characters', --error message 
							16, -- Severity.  
							1 -- State.  
						  ); 
			end;
		 
		
		 if len(@email)>100
			begin
					print  concat( 'email check ',@email);
					RAISERROR (
				    'email should not exceed 100 characters.', --error message 
					16, -- Severity.  
					1 -- State.  
					); 
			end;
		 if len(@password)>100
				begin 
					print  concat( 'password check ',@password);
					RAISERROR (
				    'password should not exceed 100 characters', --error message 
					16, -- Severity.  
					1 -- State.  
					); 
		end;
			
		exec sp_executesql @v_sql,N'@username,@email,@password',@username,@email,@password;

	 end try
	 begin catch
	     exec usr_show_error_info;
	 end catch;
	 
  end;

go

create or alter proc sign_in_user(@username nvarchar(100),@email nvarchar(100),@password nvarchar(100))
as
 
begin 
	begin try
		if len(@username)<5
		begin
			print 'username check';
			print len(@username);
				RAISERROR (
				        'username should not be less than 5 characters.', --error message 
						16, -- Severity.  
						1 -- State.  
						); 
		end;
			
		if len(@password)<8
			begin
				print 'password check';
				print len(@password);
				RAISERROR (
				    'password should not be less than 8 characters.', --error message 
					16, -- Severity.  
					1 -- State.  
					);
			end;
            
			  
		   exec usr_insert_user_table @username,@email,@password;
			  
			 
	end try
	begin catch
		exec usr_show_error_info;
	end catch;

end;

go

begin
exec sign_in_user 'test','testemail','12345';
exec sign_in_user 'test12gj','testemail','12345';
exec sign_in_user 'test12gjhsfkshfkhdkjshdwjdoijdksadkhiehfkajhdkjwoifhkajhklfi','testemail','1234545646';
end;

select * from users;