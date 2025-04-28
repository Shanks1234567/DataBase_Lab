CREATE TABLE account_2022260127(
account_no CHAR(5),
balance NUMBER NOT NULL,
PRIMARY KEY(account_no),
CHECK(balance>0 )


);
DROP TABLE account_2022260127;

DESC account_2022260127;


CREATE TABLE customer_2022260127(
customer_no CHAR(5),
customer_name VARCHAR2(20) NOT NULL,
customer_city VARCHAR2(10),
PRIMARY KEY (customer_no)

);

DROP TABLE customer_2022260127;

DESC customer_2022260127;


CREATE TABLE depositor_2022260127(
account_no CHAR(5),
customer_no CHAR(5),
PRIMARY KEY (account_no,customer_no)


);

DROP TABLE depositor_2022260127;

DESC depositor_2022260127;



ALTER TABLE customer_2022260127 ADD DATE_OF_BIRTH DATE;
DESC customer_2022260127;

ALTER TABLE customer_2022260127 DROP COLUMN DATE_OF_BIRTH;
DESC customer_2022260127;

ALTER TABLE depositor_2022260127 RENAME COLUMN account_NO TO A_NO;
DESC depositor_2022260127;

ALTER TABLE depositor_2022260127 RENAME COLUMN customer_NO TO C_NO;
DESC depositor_2022260127;

ALTER TABLE depositor_2022260127 ADD CONSTRAINT depositor_fk1
FOREIGN KEY (A_NO)
REFERENCES account_2022260127;

ALTER TABLE depositor_2022260127 ADD CONSTRAINT depositor_fk2
FOREIGN KEY (C_NO)
REFERENCES customer_2022260127;

DESC depositor_2022260127;


INSERT INTO account_2022260127 VALUES ('A-101',12000);
INSERT INTO account_2022260127 VALUES ('A-102',6000);
INSERT INTO account_2022260127 VALUES ('A-103',2500);

SELECT * FROM account_2022260127;

INSERT INTO customer_2022260127 VALUES ('C-101','ALICE','DHAKA');
INSERT INTO customer_2022260127 VALUES ('C-102','ANIE','DHAKA');
INSERT INTO customer_2022260127 VALUES ('C-103','BOB','CHITTAGONG');
INSERT INTO customer_2022260127 VALUES ('C-104','CHARLIE','KHULNA');

SELECT * FROM customer_2022260127;

INSERT INTO depositor_2022260127 VALUES ('A-101','C-101');
INSERT INTO depositor_2022260127 VALUES ('A-103','C-102');
INSERT INTO depositor_2022260127 VALUES ('A-103','C-104');
INSERT INTO depositor_2022260127 VALUES ('A-102','C-103');

SELECT * FROM depositor_2022260127;

SELECT customer_name,customer_city
FROM customer_2022260127;

SELECT DISTINCT customer_city
FROM customer_2022260127;



SELECT account_no
FROM account_2022260127
WHERE balance>7000;

SELECT customer_no,customer_name
FROM customer_2022260127
WHERE customer_city='KHULNA';


SELECT customer_no,customer_name
FROM customer_2022260127
WHERE customer_city!='DHAKA';

SELECT c.customer_name, c.customer_city
FROM account_2022260127 a ,customer_2022260127 c ,depositor_2022260127 d
WHERE a.account_no = d.A_NO AND d.C_NO = c.customer_no AND a.balance>7000;

SELECT c.customer_name, c.customer_city
FROM account_2022260127 a ,customer_2022260127 c ,depositor_2022260127 d
WHERE a.account_no = d.A_NO AND d.C_NO = c.customer_no AND a.balance>7000 AND c.customer_city!='KHULNA';

SELECT a.account_no, balance
FROM account_2022260127 a ,customer_2022260127 c ,depositor_2022260127 d
WHERE a.account_no = d.A_NO AND d.C_NO = c.customer_no AND c.customer_no='C-102';

SELECT a.account_no, balance
FROM account_2022260127 a ,customer_2022260127 c ,depositor_2022260127 d
WHERE a.account_no = d.A_NO AND d.C_NO = c.customer_no AND (c.customer_city='DHAKA' OR c.customer_city='KHULNA');

SELECT c.customer_name
FROM account_2022260127 a ,customer_2022260127 c ,depositor_2022260127 d
WHERE a.account_no = d.A_NO AND d.C_NO = c.customer_no AND a.account_no IS NULL;