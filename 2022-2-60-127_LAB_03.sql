SELECT branch_name,branch_city
FROM Branch
WHERE assets>1000000;




SELECT account_number, balance 
FROM Account 
WHERE branch_name='Downtown' or balance BETWEEN 600 and 750 ;



SELECT account_number
FROM Account, Branch
WHERE Account.branch_name=Branch.branch_name AND branch_city='Rye';




SELECT LOAN.LOAN_NUMBER
FROM LOAN, BORROWER ,CUSTOMER
WHERE LOAN.LOAN_NUMBER = BORROWER.LOAN_NUMBER AND BORROWER.CUSTOMER_NAME= CUSTOMER.CUSTOMER_NAME AND LOAN.AMOUNT >=1000 AND CUSTOMER.CUSTOMER_CITY = 'Harrison';



SELECT *
FROM Account
ORDER BY balance DESC ;



SELECT *
FROM Customer
ORDER BY customer_city ;




SELECT customer_name
FROM Customer , Account , Branch
WHERE Branch.branch_name=Account.branch_name AND Branch.branch_city=customer_city
INTERSECT 
SELECT customer_name
FROM Customer, Loan ,Branch
WHERE Branch.branch_name=Loan.branch_name AND Branch.branch_city=customer_city;




SELECT customer_name,customer_street,customer_city
FROM Customer,Account,Branch
WHERE Branch.branch_name=Account.branch_name And Branch.branch_city=customer_city
UNION
SELECT  customer_name,customer_street,customer_city
FROM Customer, Loan,Branch
WHERE Branch.branch_name=Loan.branch_name AND Branch.branch_city=customer_city;




SELECT customer_name,customer_city
FROM Loan,Customer,Branch
WHERE Branch.branch_name=Loan.branch_name AND branch_city=customer_city
MINUS
SELECT customer_name,customer_city
FROM Account,Customer,Branch
WHERE Branch.branch_name=Account.branch_name AND Branch.branch_city=customer_city;




SELECT count(assets) 
FROM Branch ;



SELECT avg(balance) AS AVG_BALANCE
FROM Account,Branch
WHERE Branch.branch_name=Account.branch_name;



SELECT Round(avg(balance),2) AS AVG_BALANCE
FROM Account,Branch
WHERE Branch.branch_name=Account.branch_name 
GROUP BY branch_city ;



SELECT min(amount) AS MIN_AMOUNT
FROM Loan , Branch
WHERE Loan.branch_name=Branch.branch_name;



SELECT count(loan_number) AS TOTAL_LOAN_NUMBER
FROM Loan,Branch
WHERE Branch.branch_name=Loan.branch_name;



SELECT CUSTOMER_NAME , ACCOUNT_NUMBER
FROM ACCOUNT NATURAL JOIN DEPOSITOR
WHERE BALANCE = (SELECT MAX(BALANCE) FROM ACCOUNT );


