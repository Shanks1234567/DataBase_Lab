1. Find all customer related information who have an account in a branch, located in the same city as they live. (write this query without using subqueries and then using a subquery)
(without subquery) 
SELECT c.*
FROM Customer c, Account a, Branch b, depositor d
WHERE c.customer_city = b.branch_city
AND a.branch_name = b.branch_name
AND c.customer_name = d.customer_name;

(with subquery)
SELECT *
FROM Customer c
WHERE customer_city IN (
    SELECT branch_city
    FROM Branch b, Account a, depositor d
    WHERE a.branch_name = b.branch_name
    AND d.customer_name = c.customer_name
);

2. Find all customer related information who have a loan in a branch, located in the same city as they live. (write this query without using subqueries and then using a subquery)
(without subqueries)
SELECT c.*
FROM Customer c, Loan l, Branch b, depositor d
WHERE c.customer_city = b.branch_city
AND l.branch_name = b.branch_name
AND c.customer_name = d.customer_name;
(with subqueries)
SELECT *
FROM Customer c
WHERE customer_city IN (
    SELECT branch_city
    FROM Branch b, Loan l, depositor d
    WHERE l.branch_name = b.branch_name
    AND d.customer_name = c.customer_name
);

3. For each branch city, find the average balance of all the accounts opened in a branch located in that branch city. Do not include any branch city in the result where the total balance of all accounts opened in a branch located in that city is less than 1000. (Write this query with and without using ‘having’ clause)
i. 
SELECT branch_city, AVG(balance) AS avg_balance
FROM Branch b, Account a
WHERE b.branch_name = a.branch_name
GROUP BY branch_city
HAVING SUM(balance) >= 1000;
ii.
SELECT b.branch_city, AVG(a.balance) AS avg_balance
FROM Branch b
JOIN Account a ON b.branch_name = a.branch_name
GROUP BY b.branch_city
HAVING AVG(a.balance) * COUNT(a.account_number) >= 1000;


4. For each branch city, find the average amount of all the loans opened in a branch located in that branch city. Do not include any branch city in the result where the average amount of all loans opened in a branch located in that city is less than 1500. (write this query with and without using ‘having’ clause)

i.
 SELECT b.branch_city, AVG(l.amount) AS avg_loan_amount
FROM Branch b
JOIN Loan l ON b.branch_name = l.branch_name
GROUP BY b.branch_city
HAVING AVG(l.amount) >= 1500;
ii. 
SELECT branch_city, avg_loan_amount
FROM (
    SELECT b.branch_city,
        AVG(l.amount) AS avg_loan_amount
    FROM 
        Branch b
    JOIN 
        Loan l ON b.branch_name = l.branch_name
    GROUP BY 
        b.branch_city
) AS sub
WHERE 
    avg_loan_amount >= 1500;


 5. Find the customer name, customer street, customer city of the account which has the highest balance among all the accounts. (Write this query with and without using all keyword)
i. SELECT c.customer_name, c.customer_street, c.customer_city
FROM Customer c, Account a
WHERE (a.balance) >= ALL (SELECT balance FROM Account)
AND c.customer_name IN (SELECT customer_name FROM Depositor WHERE account_number = a.account_number);

ii.SELECT c.customer_name, c.customer_street, c.customer_city
FROM Customer c
JOIN Depositor d ON c.customer_name = d.customer_name
JOIN Account a ON d.account_number = a.account_number
WHERE a.balance = (SELECT MAX(balance) FROM Account);


6. Find the customer name, customer street, customer city of the loan which has the lowest
amount among all the loans. (write this query with and without using all keyword)
i. 
SELECT c.customer_name, c.customer_street, c.customer_city
FROM Customer c, Loan l
WHERE (l.amount) <= ALL (SELECT amount FROM Loan)
AND c.customer_name IN (SELECT customer_name FROM Borrower WHERE loan_number = l.loan_number);

ii. 
SELECT c.customer_name, c.customer_street, c.customer_city
FROM Customer c
JOIN Borrower b ON c.customer_name = b.customer_name
JOIN Loan l ON b.loan_number = l.loan_number
WHERE l.amount = (SELECT MIN(amount) FROM Loan);

7. Find the distinct branches (name and city) that have opened both accounts and loans. (Write this query using in and exists keyword)
i. 
SELECT DISTINCT branch_name, branch_city
FROM Branch
WHERE branch_name IN (
    SELECT branch_name
    FROM Account
) AND branch_name IN (
    SELECT branch_name
    FROM Loan
);
ii. 
SELECT DISTINCT branch_name, branch_city
FROM Branch b
WHERE EXISTS (
    SELECT 1
    FROM Account a
    WHERE a.branch_name = b.branch_name
) AND EXISTS (
    SELECT 1
    FROM Loan l
    WHERE l.branch_name = b.branch_name
);

8. Find the distinct customers (name and city) who do not have loans but have accounts. (write this query using not in and not exists keyword)
i.SELECT DISTINCT customer_name, customer_city
FROM Customer
WHERE customer_name NOT IN (
    SELECT DISTINCT c.customer_name
    FROM Customer c
    JOIN Borrower b ON c.customer_name = b.customer_name
);
ii.SELECT DISTINCT customer_name, customer_city
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM Borrower b
    WHERE b.customer_name = c.customer_name
);

9. Find those branch names which have total account balance greater than the average of total balance among all the branches. (write this query with and without using with clause)
i.WITH branch_balances AS (
    SELECT branch_name, SUM(balance) AS total_balance
    FROM Account
    GROUP BY branch_name
)
SELECT branch_name
FROM branch_balances
WHERE total_balance > (
    SELECT AVG(total_balance)
    FROM branch_balances
);
ii.SELECT branch_name
FROM Account 
GROUP BY branch_name
HAVING SUM(balance) > (
    SELECT AVG(total_balance)
    FROM (
        SELECT SUM(balance) AS total_balance
        FROM Account
        GROUP BY branch_name)
    AS branch_balances
);

10. Find those branch names which have total loan amount less than the average of total loan
amount among all the branches. (write this query with and without using with clause)

i. WITH branch_loan_amounts AS (
    SELECT branch_name, SUM(amount) AS total_amount
    FROM Loan
    GROUP BY branch_name
)
SELECT branch_name
FROM branch_loan_amounts
WHERE total_amount < (
    SELECT AVG(total_amount)
    FROM branch_loan_amounts
);
ii.SELECT branch_name
FROM Loan
GROUP BY branch_name
HAVING SUM(amount) < (
    SELECT AVG(total_amount)
    FROM (
        SELECT SUM(amount) AS total_amount
        FROM Loan
        GROUP BY branch_name
    ) AS branch_loan_amounts
);
