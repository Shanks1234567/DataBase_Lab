CREATE TABLE Patient_2022_2_60_127(
    PatientID NUMBER,
    Name VARCHAR2(40),
    Gender VARCHAR2(10),
    Age NUMBER,
    ContactNumber NUMBER,
    
    PRIMARY KEY(PatientID)
    );



CREATE TABLE Doctors_2022_2_60_127(
    DoctorID NUMBER,
    Name VARCHAR2(40),
    Specialization VARCHAR2(40),
    ContactNumber NUMBER,
    YearsExperience NUMBER,
    
    PRIMARY KEY(DoctorID)
    );


CREATE TABLE Appointments_2022_2_60_127(
    AppointmentID NUMBER,
    AppointmentDate DATE ,
    PatientID NUMBER,
    DoctorID NUMBER,
    
    PRIMARY KEY(AppointmentID),
    FOREIGN KEY (PatientID) REFERENCES Patient_2022_2_60_127,
    FOREIGN KEY (DoctorID) REFERENCES Doctors_2022_2_60_127
    );

ALTER TABLE Appointments_2022_2_60_127 ADD AppointmentStatus VARCHAR2(40);





CREATE TABLE Billing_2022_2_60_127(
    BillID NUMBER,
    AppointmentID NUMBER ,
    BillAmount VARCHAR2(40),
    BillStatus VARCHAR2(40),
   
    
    PRIMARY KEY(BillID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments_2022_2_60_127
    
    );




INSERT INTO Patient_2022_2_60_127 VALUES(101,'Junaeid','Male',24,016472);
INSERT INTO Patient_2022_2_60_127 VALUES(102,'Nafisa','Female',23,01452);
INSERT INTO Patient_2022_2_60_127 VALUES(103,'Akash','Male',29,016392);
INSERT INTO Patient_2022_2_60_127 VALUES(104,'Arash','Male',32,018462);
INSERT INTO Patient_2022_2_60_127 VALUES(105,'Tahmina','Female',19,015682);
INSERT INTO Patient_2022_2_60_127 VALUES(106,'Rafi','MALE',29,016682);
INSERT INTO Patient_2022_2_60_127 VALUES(107,'ifat','male',20,015672);


INSERT INTO Doctors_2022_2_60_127 VALUES(201,'Ali','Gynecology',016472,2);
INSERT INTO Doctors_2022_2_60_127 VALUES(202,'Shifa','Oncology',01452,4);
INSERT INTO Doctors_2022_2_60_127 VALUES(203,'Atik','Anesthesiologists',016392,6);
INSERT INTO Doctors_2022_2_60_127 VALUES(204,'Mehedi','Oncology',018462,1);
INSERT INTO Doctors_2022_2_60_127 VALUES(205,'Tahmina','Gynecology',015682,9);
INSERT INTO Doctors_2022_2_60_127 VALUES(206,'Tahmid','Cardiology',015682,9);
INSERT INTO Doctors_2022_2_60_127 VALUES(207,'Asif','Cardiology',015922,10);
INSERT INTO Doctors_2022_2_60_127 VALUES(208,'ishan','Cardiology',015682,3);



INSERT INTO Appointments_2022_2_60_127 VALUES(301,'04-03-2024',101,201,'Completed');
 INSERT INTO Appointments_2022_2_60_127 VALUES(302,'3-21-2024',103,206,'Completed');
INSERT INTO Appointments_2022_2_60_127 VALUES(303,'3-24-2024',102,202,'Completed');
INSERT INTO Appointments_2022_2_60_127 VALUES(304,'3-19-2024',105,203,'Pending');
INSERT INTO Appointments_2022_2_60_127 VALUES(305,'3-25-2024',104,204,'Not Complete');
INSERT INTO Appointments_2022_2_60_127 VALUES(306,'4-24-2024',104,204,' Complete');
INSERT INTO Appointments_2022_2_60_127 VALUES(307,'3-24-2024',103,204,' Complete');
INSERT INTO Appointments_2022_2_60_127 VALUES(308,'3-24-2024',105,206,' Complete');
INSERT INTO Appointments_2022_2_60_127 VALUES(309,'3-20-2024',106,205,' Complete');
INSERT INTO Appointments_2022_2_60_127 VALUES(310,'3-14-2024',107,206,' Complete');
INSERT INTO Appointments_2022_2_60_127 VALUES(311,'3-20-2024',107,201,' Complete');

INSERT INTO Billing_2022_2_60_127 VALUES(401,301,900,'Paid');
 INSERT INTO Billing_2022_2_60_127 VALUES(402,302,1100,'Paid');
INSERT INTO Billing_2022_2_60_127 VALUES(403,303,2100,'Pending');
INSERT INTO Billing_2022_2_60_127 VALUES(404,304,1750,'Pending');
INSERT INTO Billing_2022_2_60_127 VALUES(405,305,2700,'Paid');

 
SELECT Name , ContactNumber
FROM Patient_2022_2_60_127 
WHERE Age=(SELECT MAX(Age)
            FROM Patient_2022_2_60_127);



SELECT Specialization,AppointmentDate, Count(AppointmentID) AS NUMBER_OF_APPOINTMENT
FROM Doctors_2022_2_60_127 D,Appointments_2022_2_60_127 A
WHERE D.DoctorID=A.DoctorID   
GROUP BY Specialization,AppointmentDate
HAVING Specialization='Oncology'AND AppointmentDate='3-24-2024';



SELECT  P.Name,P.ContactNumber
FROM Doctors_2022_2_60_127 D ,Patient_2022_2_60_127 P, Appointments_2022_2_60_127  A
WHERE D.DoctorID=A.DoctorID    AND P.PatientID=A.PatientID AND D.Specialization='Cardiology' AND  A.AppointmentDate='3-24-2024';

SELECT  DISTINCT DoctorID , NAME,ContactNumber
FROM Appointments_2022_2_60_127 NATURAL JOIN Doctors_2022_2_60_127  
WHERE AppointmentStatus='Completed' AND AppointmentDate  BETWEEN '3-19-2024' AND '3-21-2024'
ORDER BY Name DESC ;



SELECT  DoctorID , NAME
FROM Doctors_2022_2_60_127  NATURAL LEFT  JOIN Appointments_2022_2_60_127  
WHERE AppointmentID is NULL ;

SELECT temp.*,ROWNUM
FROM (SELECT * 
 FROM Billing_2022_2_60_127
ORDER BY BillAmount)temp
WHERE ROWNUM<=3;


SELECT PatientID,Name,ContactNumber,COUNT(AppointmentID)
FROM Patient_2022_2_60_127 NATURAL JOIN Appointments_2022_2_60_127
GROUP BY PatientID,Name,ContactNumber
HAVING COUNT(AppointmentID)>=2;


SELECT Specialization, ROUND(AVG(YearsExperience),2) AS AVG_YEARS_EXP
FROM Doctors_2022_2_60_127
GROUP BY Specialization;


SELECT DoctorID,(SELECT COUNT(AppointmentStatus)
FROM Appointments_2022_2_60_127 A
WHERE A.DoctorID =D.DoctorID AND AppointmentStatus = 'Completed') AS
NUM_OF_COMPLETED_APPOINTMENT
FROM Doctors_2022_2_60_127 D;


UPDATE Billing_2022_2_60_127
SET BillAmount = (CASE
WHEN BillAmount<1000 THEN BillAmount-BillAmount*0.15
WHEN BillAmount>=1000 AND BillAmount<2500 THEN BillAmount-BillAmount*0.1
ELSE BillAmount-BillAmount*0.05

END);


ALTER TABLE Patient_2022_2_60_127 ADD Address VARCHAR2(40);


CREATE VIEW GynecologyAppointment AS
SELECT Appointments_2022_2_60_127.*
FROM Appointments_2022_2_60_127,Doctors_2022_2_60_127
WHERE Appointments_2022_2_60_127.DoctorID=Doctors_2022_2_60_127.DoctorID AND Doctors_2022_2_60_127.Specialization='Gynecology';

SELECT * FROM GynecologyAppointment;


CREATE USER ALICE IDENTIFIED BY CSE302;
GRANT CREATE SESSION,CONNECT,CREATE TABLE,CREATE VIEW,UNLIMITED TABLESPACE TO ALICE;
GRANT SELECT ON GynecologyAppointment TO ALICE;


SELECT * FROM SYSTEM.GynecologyAppointment;


