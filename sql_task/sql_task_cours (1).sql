use master
go

create database test;

go

use cours_db;
go



go

create table teachers(
                     id int identity(1,1) primary key,
					 first_name nvarchar(60) not null,
					 last_name nvarchar(60) not null,
					  father_name nvarchar(60) not null,
					  phone_number nvarchar(60) unique,
					  email nvarchar(60) unique
					)
go

select * from teachers

go

create table subjects (
                    id int identity(1,1) primary key,
					subject_name nvarchar(60) unique
					)

go

create table cours_type(id int identity(1,1) CONSTRAINT cours_type_id_pk primary key ,
                          cours_type_name nvarchar(60) CONSTRAINT cours_type_name_u unique ,
						  )
go

create table courses(id int identity(1,1) CONSTRAINT cours_id_pk primary key,
                     cours_name nvarchar(60) unique ,
					 cours_type_id int,
					 CONSTRAINT cours_type_id_fk FOREIGN KEY (cours_type_id)
					 REFERENCES cours_type(id),
					 )

go

create table cours_subject(
                             cours_id int,                            
							 subject_id int,
							  CONSTRAINT cours_subject_cours_id_fk FOREIGN KEY (cours_id)    REFERENCES courses(id),						
							   CONSTRAINT cours_subject_subject_id_fk FOREIGN KEY (subject_id) REFERENCES subjects(id)                                    
							  )

go
create table cours_teacher(
                             cours_id int,
                             teacher_id int ,							
						       CONSTRAINT cours_teacher_cours_id_fk FOREIGN KEY (cours_id)    REFERENCES courses(id),
							   CONSTRAINT cours_teacher_teacher_id_fk FOREIGN KEY (teacher_id) REFERENCES teachers(id),
							   )
go
create table teacher_subject( 
                              teacher_id int ,
							   subject_id int,
							   CONSTRAINT teacher_subject_teacher_id_fk FOREIGN KEY (teacher_id) REFERENCES teachers(id),
							   CONSTRAINT teacher_subject_subject_id_fk FOREIGN KEY (subject_id) REFERENCES subjects(id) 
                             )
go

create table groups(id int identity(1,1) primary key,
                     group_name nvarchar(60) unique,
					 cours_id int,
					 CONSTRAINT groups_cours_id_fk FOREIGN KEY (cours_id)    REFERENCES courses(id),
                      )
go

create table students(id int identity(1,1) primary key,
                      first_name nvarchar(60) not null,
					  last_name nvarchar(60) not null,
					  father_name nvarchar(60) not null,
					  phone_number nvarchar(60) unique,
					  email nvarchar(60) unique,
					  group_id int,
					  CONSTRAINT student_group_id_fk FOREIGN KEY (group_id)    REFERENCES groups(id)
					  )



drop database coursdb;




