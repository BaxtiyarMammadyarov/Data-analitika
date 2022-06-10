use master;
go
drop database studentsDb;
create database studentsDb;
use studentsDb;

go
create table group_table(id int identity primary key,name nvarchar(20) not null );

go
insert into group_table values('A'),('B');
select * from group_table;
go
--CREATE CLUSTERED INDEX group_table_id on studentsDb.dbo.group_table(id);
CREATE NONCLUSTERED INDEX GROUP_TABLE_NAME_INDEX ON studentsDb.dbo.group_table(name);
go 
create table status(id tinyint identity primary key, title nvarchar(10) );
insert into status values('deactive'),('active');
go
drop table students;
create table Students(
                      id int  identity primary key,
					  name nvarchar(20) not null,
					  price tinyint,
					  price_category char(1),
					  status_id tinyint,
					  group_id int ,
					  constraint Students_status_id_fk foreign key (status_id )
					  references status(id ),
					  constraint Students_group_id_fk foreign key (group_id )
					  references group_table(id ));
go
CREATE UNIQUE INDEX STUDENT_INDEX ON studentsDb.dbo.students(id,name,group_id);

go
---------------------------trigger----------------------------

create trigger Insert_Student
on studentsDb.dbo.students
after insert
as
update students 
set status_id=2,
   price_category=(select case
							when s.price>90 then 'A'
							when s.price>80 then 'B'
							when s.price>70 then 'C'
							when s.price>60 then 'D'
							when s.price>50 then 'E'
							else 'F'
							end
                              from  inserted s
							   where students.id=s.id);

go

alter trigger deleteStudent 
on studentsDb.dbo.students
after delete
as
declare @id int =(select id from deleted);
begin
rollback;
update Students
set status_id=(select id from studentsDb.dbo.status where title='deactive')
where id=@id
end;






go 

create trigger isertGroup_table
on studentsDb.dbo.group_table
INSTEAD OF INSERT
as
SET NOCOUNT ON;
insert into studentsDb.dbo.group_table(name)
select i.name from inserted i
where i.name not in(select name from studentsDb.dbo.group_table);


---------------------------------------insert---------------------------
Truncate table Students;

insert into Students(name,price,group_id) (select first_name ,(10*customer_id+41),1from BikeStores.sales.customers where customer_id<6);

select * from Students;
go
delete from Students
where id=2;

insert into group_table(name)
values('A')

select * from group_table;
go