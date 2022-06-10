use master;
-- -----------------------------create statement------------------------------------------

drop database if exists UniversityDb;
create database UniversityDb

use UniversityDb;
drop table if exists universities;

create table universities(
					university_id smallint identity primary key,
					university_name varchar(100) unique not null);

drop table if exists faculties;
create table faculties(
						faculty_id int identity(1,1) primary key ,
						faculty_name nvarchar(100) unique not null,
						university_id smallint,
						constraint faculties_university_id_fk foreign key (university_id) 
						references universities(university_id)
						);

drop table if exists groups;

create table groups(
                    group_id int identity(1,1) primary key,
					group_name nvarchar(15),
					course char(1),
					faculty_id int ,
					CONSTRAINT groups_faculty_id_fk FOREIGN KEY (faculty_id)
					REFERENCES faculties(faculty_id)
					);

drop table if exists student_type;

create table student_type(
							type_id smallint primary key,
							type_name nvarchar(20) unique not null);

drop table if exists students;

create table students(
						student_id int identity(1,1) primary key,
						first_name nvarchar(50) not null,
						last_name nvarchar(50) not null,
						father_name nvarchar(50) not null,
						email nvarchar(60) unique not null,
						phone nvarchar(20) unique  not null,
						type_id smallint,
						group_id int,
						constraint students_type_id_fk foreign key (type_id) 
						references student_type(type_id),
						constraint students_group_id_fk foreign key (group_id) 
						references groups(group_id)
						);

select * from students;

drop table if exists departments;
create table departments(
						department_id smallint identity primary key ,
						department_name nvarchar(100) unique not null,
						faculty_id int ,
						constraint departments_faculty_id_fk foreign key (faculty_id) 
						references faculties(faculty_id)
						);
drop table if exists Subjects;

create table Subjects(
						Subject_id smallint primary key,
						Subject_name nvarchar(100) unique not null,
						department_id  smallint,
						constraint Subjects_department_id_fk foreign key (department_id)
						references departments(department_id));

drop table if exists Teachers;

create table Teachers(	teacher_id int identity primary key,
						first_name nvarchar(50) not null,
					    last_name nvarchar(50) not null,
						father_name nvarchar(50) not null,
						email nvarchar(60) unique not null,
						phone nvarchar(20) unique  not null,				
						);

drop table if exists department_teacher;
create table department_teacher(
								department_id smallint,
								teacher_id int ,
								constraint department_teacher_department_id foreign key (department_id)
								references  departments(department_id),
								constraint department_teacher_teacher_id foreign key (teacher_id)
								references  Teachers(teacher_id)
								)

drop table if exists teacher_subject;

create table teacher_subject(
								teacher_id int,
								subject_id smallint ,
								constraint teacher_subject_teacher_id foreign key (teacher_id)
								references  Teachers(teacher_id),
								constraint teacher_subject_subject_id foreign key (subject_id)
								references Subjects (subject_id)
								)
create table Group_Subject(
							group_id int,
							Subject_id smallint,
							constraint Group_Subject_group_id_fk foreign key (group_id) 
					  	        references groups(group_id),
							constraint Group_Subject_subject_id foreign key (subject_id)
								references Subjects (subject_id));

--  *****************************alter statment****************************************
drop table if exists status_types;
create table status_types(
							status_id smallint identity primary key,
						    title   nvarchar(20) unique not null );

alter table universities
drop column if exists status_id;

alter table universities
add status_id smallint constraint universities_status_id foreign key (status_id)
                        references status_types(status_id);

alter table faculties
drop column if exists status_id;

alter table faculties
add status_id smallint constraint faculties_status_id foreign key (status_id)
                        references status_types(status_id);

alter table groups
drop column if exists status_id;

alter table groups
add status_id smallint constraint groups_status_id foreign key (status_id)
                        references status_types(status_id)
						;
alter table student_type
drop column if exists status_id;

alter table student_type
add status_id smallint constraint student_type_status_id foreign key (status_id)
                        references status_types(status_id);

alter table students
drop column if exists status_id;

alter table students
add status_id smallint constraint students_status_id foreign key (status_id)
                        references status_types(status_id);


alter table departments
drop column if exists status_id;

alter table departments
add status_id smallint constraint departments_status_id foreign key (status_id)
                       references status_types(status_id);

alter table Subjects
drop column if exists status_id;

alter table Subjects
add status_id smallint constraint Subjects_status_id foreign key (status_id)
                      references status_types(status_id); 

alter table Teachers
drop column if exists status_id;

alter table Teachers
add status_id smallint constraint Teachers_status_id foreign key (status_id)
                        references status_types(status_id); 

alter table universities
drop column if exists desc_university;


alter table universities
add desc_university nvarchar(150);

alter table universities
alter column desc_university varchar(200);

