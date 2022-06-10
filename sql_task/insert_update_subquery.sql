use coursdb;
go

select * from teachers;

select customer_id,first_name,last_name,phone,email from BikeStores.sales.customers
where phone IS NOT Null;

insert into teachers(					
					first_name,
					last_name,
					father_name,
					phone_number,
					email)
					(select 
						first_name,
						last_name,
						last_name+first_name,
						phone,
						email 
						from BikeStores.sales.customers
						where phone IS NOT Null and customer_id<60);

select * from cours_type;

insert into cours_type(cours_type_name)
values ('Abituriyent');
insert into cours_type(cours_type_name)
values ('Dövlət Qulluğuna hazırlıq');
insert into cours_type(cours_type_name)
values ('Magistratura');
insert into cours_type(cours_type_name)
values ('IELTS');
insert into cours_type(cours_type_name)
values ('Məktəbəqədər hazırlıq');

select * from courses;

insert into courses(cours_name,cours_type_id)
values ('1-ci qrup hazirllıq',1);
insert into courses(cours_name,cours_type_id)
values ('2-ci qrup hazirllıq',1);
insert into courses(cours_name,cours_type_id)
values ('3-ci qrup hazirllıq',1);
insert into courses(cours_name,cours_type_id)
values ('4-ci qrup hazirllıq',1);
insert into courses(cours_name,cours_type_id)
values ('Gömrük orqanlarina hazirllıq',2);
insert into courses(cours_name,cours_type_id)
values ('Hüquq mühafizə orqanlarina hazirllıq',2);
insert into courses(cours_name,cours_type_id)
values ('Maliyə və Vergi orqanlarina hazirllıq',2);

Select * from groups;
--truncate table groups;
delete groups;
insert into groups(group_name,cours_id)
values ('Qrup_A_1',1);
insert into groups(group_name,cours_id)
values ('Qrup_B_1',1);
insert into groups(group_name,cours_id)
values ('Qrup_C_1',1);
insert into groups(group_name,cours_id)
values ('Qrup_A_2',2);
insert into groups(group_name,cours_id)
values ('Qrup_B_2',2);
insert into groups(group_name,cours_id)
values ('Qrup_C_2',2);
insert into groups(group_name,cours_id)
values ('Qrup_A_3',3);
insert into groups(group_name,cours_id)
values ('Qrup_B_3',3);
insert into groups(group_name,cours_id)
values ('Qrup_C_3',3)
insert into groups(group_name,cours_id)
values ('Qrup_A_4',4);
insert into groups(group_name,cours_id)
values ('Qrup_B_4',4);
insert into groups(group_name,cours_id)
values ('Qrup_C_5',5);
insert into groups(group_name,cours_id)
values ('Qrup_A_5',5);
insert into groups(group_name,cours_id)
values ('Qrup_B_6',6);

select * from students;

insert into students (
					first_name,
					last_name,
					father_name,
					phone_number,
					email)

				(select 
						first_name,
						last_name,
						last_name+first_name,
						phone,
						email 
						from BikeStores.sales.customers
						where phone IS NOT Null and customer_id>60 );

select * from students;

update students 
set group_id=(select id from groups where id=15)
where id<=13;
update students 
set group_id=(select id from groups where id=16)
where id between 14 and 27;

update students 
set group_id=(select id from groups where id=17)
where id between 28 and 41;

update students 
set group_id=(select id from groups where id=18)
where id between 42 and 55;

update students 
set group_id=(select id from groups where id=19)
where id between 56 and 69;
update students 
set group_id=(select id from groups where id=20)
where id between 70 and 83 ;

update students 
set group_id=(select id from groups where id=21)
where id between 84 and 97 ;
update students 
set group_id=(select id from groups where id=22)
where id between 98 and 111 ;

update students 
set group_id=(select id from groups where id=23)
where id between 112 and 125 ;
update students 
set group_id=(select id from groups where id=24)
where id between 126 and 139 ;

update students 
set group_id=(select id from groups where id=25)
where id between 140 and 153 ;
update students 
set group_id=(select id from groups where id=26)
where id between 154 and 169 ;

select * from students;







