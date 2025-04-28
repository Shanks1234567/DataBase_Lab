CREATE TABLE instructor_2022260127(

    id NUMBER(10),
    name VARCHAR2(20),
    dept_name VARCHAR2(20),
    salary NUMBER(10),
    PRIMARY KEY (id)
);
DROP TABLE instructor_2022260127;


CREATE TABLE course_2022260127(

   course_id VARCHAR2(30),
    title VARCHAR2(30),
    dept_name VARCHAR2(30),
    credits NUMBER(10)
);
DROP TABLE course_2022260127;


INSERT INTO instructor_2022260127 VALUES(10101,'srinivasan','comp.sci',65000);
INSERT INTO instructor_2022260127 VALUES(12121,'Wu','Finance',90000);
INSERT INTO instructor_2022260127 VALUES(15151,'Mozart','Music',40000);
INSERT INTO instructor_2022260127 VALUES(22222,'Einstein','Physics',95000);
INSERT INTO instructor_2022260127 VALUES(32343,'El said','History',60000);
INSERT INTO instructor_2022260127 VALUES(33456,'Gold ','Physics',87000);
INSERT INTO instructor_2022260127 VALUES(45565,'Katz','comp.sci',75000);
INSERT INTO instructor_2022260127 VALUES(58583,'Califieri','history',62000);
INSERT INTO instructor_2022260127 VALUES(76543,'singh','Finance',80000);
INSERT INTO instructor_2022260127 VALUES(76766,'crick','Biology',72000);
INSERT INTO instructor_2022260127 VALUES(83821,'Brandt','comp.sci',92000);
INSERT INTO instructor_2022260127 VALUES(98345,'Kim','Elc.Eng',80000);



INSERT INTO course_2022260127 VALUES('BIO-101','Intro. to Biology','Biology',4);
INSERT INTO course_2022260127 VALUES('BIO-301','Genetics','Biology',4);
INSERT INTO course_2022260127 VALUES('BIO-399','Computational Biology','Biology',3);
INSERT INTO course_2022260127 VALUES('CS-301','Intro. to Computer Science','Comp.Sci',4);
INSERT INTO course_2022260127 VALUES('CS-190','Game Design ','Comp.Sci',4);
INSERT INTO course_2022260127 VALUES('CS-315','Robotics','Comp.Sci',3);
INSERT INTO course_2022260127 VALUES('CS-319','Image Processing','Comp.Sci',3);
INSERT INTO course_2022260127 VALUES('CS-347','Data Base System Concepts','Comp.Sci',3);
INSERT INTO course_2022260127 VALUES('EE-181','Intro. to DIgital System','Elc.Eng',3);
INSERT INTO course_2022260127 VALUES('FIN-201','Investment Banking ','Finance',3);
INSERT INTO course_2022260127 VALUES('HIS-351','World History ','History',3);
INSERT INTO course_2022260127 VALUES('MU-199','Music Video Production ','Music',3);
INSERT INTO course_2022260127 VALUES('PHY-101','Physical Priciples','Physics',4);

SELECT name FROM instructor_2022260127;

SELECT course_id,title FROM course_2022260127;

SELECT name,dept_name,id FROM instructor_2022260127
WHERE id=22222;

SELECT title,credits FROM course_2022260127
WHERE dept_name='Comp.Sci';




SELECT name,dept_name FROM instructor_2022260127
WHERE salary>70000;

SELECT title FROM course_2022260127
WHERE credits=4;

SELECT name,dept_name FROM instructor_2022260127
WHERE salary>=80000 AND salary<=100000 ;

SELECT title,credits FROM course_2022260127
WHERE dept_name!='Comp.Sci';

SELECT *FROM instructor_2022260127;

SELECT title FROM course_2022260127
WHERE dept_name='Biology' AND credits!=4;