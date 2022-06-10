use master;
go
drop database if exists courseDb;
create database courseDb;
go
use courseDb;
go

drop table if exists statuses ;

create table statuses(
						id int identity(1,1) primary key,
						title nvarchar(50),
						descriptions nvarchar(150)
						);
go
drop table if exists user_types;

create table user_types(
						id int identity(1,1) primary key,
						title nvarchar(50),
						status_id int,
						descriptions nvarchar(150),
						constraint user_types_status_id_fk foreign key(status_id)
						references statuses(id)
						);
go

drop table if exists users;

create table users(
						id int identity(1,1) primary key,
						first_name nvarchar(30),
						last_name nvarchar(30),
						age smallint ,
						phone varchar(15),
						status_id int,
						userType_id int,
						descriptions nvarchar(150),
						constraint users_status_id_fk foreign key(status_id)
						references statuses(id),
						constraint users_userType_id_fk foreign key(userType_id)
						references user_types(id)
						);
go
create table subjects(
						id int identity(1,1) primary key,
						title nvarchar(50),
						grade nvarchar(20),
						status_id int,
						descriptions nvarchar(150),
						constraint subjects_status_id_fk foreign key(status_id)
						references statuses(id)
						);
go
create table teacher_subject(
						id int identity(1,1) primary key,
						user_id int,
						subject_id int,
						status_id int,
						descriptions nvarchar(150),
						constraint teacher_subject_status_id_fk foreign key(status_id)
						references statuses(id),
						constraint teacher_subject_user_id_fk foreign key(user_id)
						references users(id),
						constraint teacher_subject_id_fk foreign key(subject_id)
						references subjects(id)
						);

go

create table Bundle(
						id int identity(1,1) primary key,
						title nvarchar(50),
						bundle_price smallmoney,
						status_id int,
						descriptions nvarchar(150),
						constraint Bundle_status_id_fk foreign key(status_id)
						references statuses(id)
						);
go
create table Bundle_subjects(
						id int identity(1,1) primary key,
						bundle_id int,
						teacher_subject_id int,
						status_id int,
						descriptions nvarchar(150),
						constraint Bundle_subjects_status_id_fk foreign key(status_id)
						references statuses(id),
						constraint Bundle_subjects_bundle_id_fk foreign key(bundle_id)
						references bundle(id),
						constraint Bundle_subjects_teacher_subject_id_fk foreign key(teacher_subject_id)
						references teacher_subject(id)
						
						);

go

create table Student_bundles(
						id int identity(1,1) primary key,
						bundle_subject_id int,
						user_id int,
						status_id int,
						descriptions nvarchar(150),
						constraint Student_bundles_status_id_fk foreign key(status_id)
						references statuses(id),
						constraint Student_bundles_bundle_subject_id_fk foreign key(bundle_subject_id)
						references bundle_subjects(id),
						constraint Student_bundles_user_id_fk foreign key(user_id)
						references users(id)
						
						);



go 
create table Time_table(
					id int identity(1,1) primary key,
					Student_bundle_id int,
					start_date datetime, 
					end_date datetime,
					descriptions nvarchar(150),
					constraint Time_table_Student_bundle_id_fk foreign key(Student_bundle_id)
					references bundle_subjects(id)
					);


go
create table discount(
								id int identity primary key,
								titte nvarchar(50),
								discount float,
								bundle_id int,
								status_id int,
								descriptions nvarchar(150),
								constraint discount_status_id_fk foreign key(status_id)
						references statuses(id),
								constraint payment_discount_bundle_id_fk foreign key(bundle_id)
									references bundle(id),
								)
go 

--create table payments(
--						id int identity primary key,
--						Student_bundle int,
--						discount_id int,
--						descriptions nvarchar(150),
--						status_id int,
--						constraint payments_status_id_fk foreign key(status_id)
--						references statuses(id),
--						constraint payment_Student_bundle_id_fk foreign key (Student_bundle)
--						references Student_bundles(id),
--						constraint payment_discount_id_fk foreign key (discount_id)
--						references discount(id)


--						);




