﻿use master;
GO
DROP DATABASE IF EXISTS EMP_DB;
CREATE DATABASE EMP_DB;
GO
USE EMP_DB;

GO
-- **********************************EMP-LOG**************************************
DROP TRIGGER IF EXISTS EMP_DDL;
CREATE TABLE EMP_DB_LOG(
						ID INT IDENTITY PRIMARY KEY,
						EVENT_DATA XML NOT NULL,
						EVENT_USER_NAME SYSNAME  NOT NULL,
						EVENT_TIME DATETIME NOT NULL
						);
GO
CREATE TRIGGER EMP_DDL
ON DATABASE
for ALTER_TABLE,CREATE_TABLE,DROP_TABLE
AS 
BEGIN
   INSERT INTO EMP_DB_LOG(EVENT_DATA,EVENT_USER_NAME,EVENT_TIME)
   VALUES(EVENTDATA(),USER,GETDATE());
END;
-- **********************************EMP-LOG END**************************************
GO

DROP TABLE IF EXISTS STATUSES;
CREATE TABLE STATUSES(
						STATUS_ID TINYINT IDENTITY PRIMARY KEY,
						TITLE NVARCHAR(30) UNIQUE NOT NULL);
GO

DROP TABLE IF EXISTS DEPARTMENTS;
CREATE TABLE DEPARTMENTS(
						DEPARTMENT_ID INT IDENTITY PRIMARY KEY,
						NAME NVARCHAR(30) UNIQUE NOT NULL,
						STATUS_ID TINYINT,
						CONSTRAINT DEPARTMENTS_STATUS_ID_FK FOREIGN KEY (STATUS_ID)
						REFERENCES STATUSES(STATUS_ID),);

GO
DROP TABLE IF EXISTS EMPLOYEES;
CREATE TABLE EMPLOYEES(
						EMPLOYEE_ID INT IDENTITY PRIMARY KEY,
						NAME NVARCHAR(30)  NOT NULL,
						SURNAME NVARCHAR(30)  NOT NULL,
						SALARY MONEY NOT NULL CHECK(SALARY>300),
						SOSIAL_FEE MONEY,
						BONUS MONEY,
						DEPARTMENT_ID INT,
						STATUS_ID TINYINT,
						CONSTRAINT EMPLOYEES_STATUS_ID_FK FOREIGN KEY (STATUS_ID)
						REFERENCES STATUSES(STATUS_ID),
						CONSTRAINT EMPLOYEES_DEPARTMENT_ID_FK FOREIGN KEY (DEPARTMENT_ID)
						REFERENCES DEPARTMENTS(DEPARTMENT_ID) );










--UPDATE EMPLOYEES 
--SET SOSIAL_FEE=(SELECT E2.SALARY*0.03 FROM EMPLOYEES E2 WHERE EMPLOYEES.EMPLOYEE_ID=E2.EMPLOYEE_ID),
--    BONUS=(
--	SELECT
--	ROUND(
--	E1.SALARY/(SELECT COUNT(*) FROM EMPLOYEES E2  GROUP BY E2.DEPARTMENT_ID HAVING EMPLOYEES.DEPARTMENT_ID=E2.DEPARTMENT_ID)*0.3,2)
--	FROM EMPLOYEES E1 WHERE EMPLOYEES.EMPLOYEE_ID=E1.EMPLOYEE_ID);

--*******************************************TRIGER  DDL****************************************************
GO

--CREATE TABLE TEST(ID INT);
--*******************************************TRIGER  INSTEAD OF****************************************************

DROP TRIGGER IF EXISTS EMP_INSERT;
GO
CREATE TRIGGER EMP_INSERT
ON EMP_DB.DBO.EMPLOYEES
INSTEAD OF INSERT
AS
DECLARE
  @FIRST_I_COUNT INT =(SELECT COUNT(*) FROM EMPLOYEES),
  @I_COUNT INT=(SELECT COUNT(*) FROM inserted)
 
 IF @I_COUNT>0  AND @FIRST_I_COUNT=0
	 BEGIN
		PRINT('INSERT FIRST '+STR(@I_COUNT) +' '+ STR(@FIRST_I_COUNT));
		INSERT INTO EMPLOYEES(NAME,SURNAME,SALARY,DEPARTMENT_ID,SOSIAL_FEE,BONUS,STATUS_ID)
				SELECT
					I.NAME,
					I.SURNAME,
					I.SALARY,
					I.DEPARTMENT_ID,
					I.SALARY*0.03,
					ROUND(I.SALARY/(SELECT COUNT(*) FROM inserted E  GROUP BY E.DEPARTMENT_ID HAVING I.DEPARTMENT_ID=E.DEPARTMENT_ID)*0.3,2),
					(SELECT STATUS_ID FROM STATUSES WHERE TITLE='ACTIVE')
					FROM inserted I;
				 PRINT('INSERT FIRST END');
			END
			
		 ELSE
		       BEGIN
				 PRINT('INSERT  '+STR(@I_COUNT) +' '+  STR(@FIRST_I_COUNT));
				INSERT INTO EMPLOYEES(NAME,SURNAME,SALARY,DEPARTMENT_ID,SOSIAL_FEE,BONUS,STATUS_ID)
						SELECT
							I.NAME,
							I.SURNAME,
							I.SALARY,
							I.DEPARTMENT_ID,
							I.SALARY*0.03,
							ROUND(I.SALARY/(SELECT COUNT(*)+1 FROM EMPLOYEES E  GROUP BY E.DEPARTMENT_ID HAVING I.DEPARTMENT_ID=E.DEPARTMENT_ID)*0.3,2),
							(SELECT STATUS_ID FROM STATUSES WHERE TITLE='ACTIVE')
							FROM inserted I;
				END;

--***********************************************************************************************
GO
--*******************************************TRIGER AFTER ****************************************************
CREATE TRIGGER EMP_UPDATE
ON  EMP_DB.DBO.EMPLOYEES
AFTER INSERT,UPDATE
AS
 PRINT('UPDATE TRIGER');
 UPDATE EMPLOYEES 
       SET DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM inserted I WHERE EMPLOYEES.EMPLOYEE_ID=I.EMPLOYEE_ID)
	   WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM deleted);
     UPDATE EMPLOYEES 
       SET SOSIAL_FEE=(SELECT I.SALARY*0.03 FROM inserted I WHERE EMPLOYEES.EMPLOYEE_ID=I.EMPLOYEE_ID)
	   WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM inserted)  AND STATUS_ID=(SELECT STATUS_ID FROM STATUSES WHERE TITLE='ACTIVE');
      UPDATE EMPLOYEES 
       SET BONUS=(
	   SELECT
	   ROUND(
	   E1.SALARY/(
	             SELECT COUNT(*) FROM EMPLOYEES E2 
				 WHERE STATUS_ID=(SELECT STATUS_ID FROM STATUSES WHERE TITLE='ACTIVE')
				 GROUP BY E2.DEPARTMENT_ID 
				 HAVING EMPLOYEES.DEPARTMENT_ID=E2.DEPARTMENT_ID 				
				 )*0.3,2)
	   FROM EMPLOYEES E1 WHERE EMPLOYEES.EMPLOYEE_ID=E1.EMPLOYEE_ID )
        WHERE 
		DEPARTMENT_ID IN(SELECT DEPARTMENT_ID FROM inserted) 
		OR DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM deleted);
--******************************************* ****************************************************		
GO
DROP TRIGGER IF EXISTS EMP_DEL;
GO
--*******************************************TRIGER DELETE  ****************************************************	
CREATE TRIGGER EMP_DEL
ON EMP_DB.DBO.EMPLOYEES
INSTEAD OF DELETE
AS
UPDATE EMPLOYEES
SET STATUS_ID=(SELECT STATUS_ID FROM STATUSES WHERE TITLE='DEACTIVE' )
WHERE EMPLOYEE_ID IN (SELECT D.EMPLOYEE_ID FROM deleted D)
     
--******************************************* ****************************************************
GO

------------------------------INSERTED-------------------------------
INSERT INTO STATUSES(TITLE)
VALUES ('ACTIVE'),('DEACTIVE')
INSERT INTO DEPARTMENTS(NAME,STATUS_ID)
VALUES ('Administration',1),('Marketing',1),('Shipping',1),('IT',1);

INSERT INTO EMPLOYEES(NAME,SURNAME,SALARY ,DEPARTMENT_ID,STATUS_ID)
VALUES ('Donald','OConnell',2600,1,1),
		('Michael','Hartstein',3000,1,1),
		('Jennifer','Whalen',4400,1,1),
		('Pat','Fay',6000,2,1),
		('Susan','Mavris',6500,2,1),
		('Hermann','Baer',5000,2,1),
		('William','Gietz',7000,3,1),
		('Steven','King',6000,3,1),
		('Neena','Kochhar',5500,3,1),
		('William','Gietz',12000,4,1),
		('Steven','King',16000,4,1),
		('Neena','Kochhar',5500,4,1);
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID=1;
--*****************************************INSERT***************************************************************
INSERT INTO EMPLOYEES(NAME,SURNAME,SALARY ,DEPARTMENT_ID,STATUS_ID)
VALUES ('Bruce','Ernst',6000,1,1),
		('David','Austin',4800,2,1),
		('Valli','Pataballa',9000,3,1),
		('John','Everett',9000,4,1);


--*****************************************DELETE***************************************************************
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID =1;
DELETE FROM EMPLOYEES
WHERE EMPLOYEE_ID=1;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID =1;

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID  IN(1,2);
UPDATE EMPLOYEES
SET DEPARTMENT_ID=2
WHERE EMPLOYEE_ID=3;

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID  IN(1,2);

SELECT * FROM EMP_DB_LOG;

