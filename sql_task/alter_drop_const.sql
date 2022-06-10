drop table if exists status;

create table status(
					id int identity(1,1) primary key,
					status_name nvarchar(60),
					descrip nvarchar(150));


alter table teachers
drop  constraint if exists teacher_status_id_fk ;
alter table teachers
drop column if exists status_id ;
alter table teachers
add  status_id int constraint teacher_status_id_fk foreign key(status_id) references status(id)  ;
select * from students;

alter table students
drop  constraint if exists students_status_id_fk ;
alter table students
drop column if exists status_id ;
alter table students
add  status_id int constraint students_status_id_fk foreign key(status_id) references status(id)  ;

alter table cours_type
drop  constraint if exists cours_type_status_id_fk ;
alter table cours_type
drop column if exists status_id ;
alter table cours_type
add  status_id int constraint cours_type_status_id_fk foreign key(status_id) references status(id)  ;

alter table courses
drop  constraint if exists courses_type_status_id_fk ;
alter table courses
drop column if exists status_id ;
alter table courses
add  status_id int constraint courses_type_status_id_fk foreign key(status_id) references status(id)  ;

alter table groups
drop  constraint if exists groups_type_status_id_fk ;
alter table groups
drop column if exists status_id ;
alter table groups
add  status_id int constraint groups_type_status_id_fk foreign key(status_id) references status(id)  ;

alter table subjects
drop  constraint if exists subjects_type_status_id_fk ;
alter table subjects
drop column if exists status_id ;
alter table subjects
add  status_id int constraint subjects_type_status_id_fk foreign key(status_id) references status(id)  ;


--ALTER TABLE status RENAME COLUMN descrip to description;