CREATE OR REPLACE DATABASE FSDA_ASSIGNMENTS; 

USE FSDA_ASSIGNMENTS;


CREATE TABLE shopping_history(
    product VARCHAR NOT NULL ,
    quantity INTEGER NOT NULL,
    unit_price INTEGER NOT NULL
);

INSERT INTO shopping_history(product,quantity,unit_price) VALUES('milk',3,10);
INSERT INTO shopping_history(product,quantity,unit_price) VALUES('bread',7,3);
INSERT INTO shopping_history(product,quantity,unit_price) VALUES('bread',5,2);


SELECT * FROM transactions;
SELECT * FROM shopping_history;

-- Task 01
SELECT product , sum(quantity*unit_price) as total_price 
FROM shopping_history
group by product;

-- Task 02
CREATE TABLE PHONES(
    name VARCHAR(20) NOT NULL UNIQUE,
    phone_number integer NOT NULL UNIQUE
);

CREATE TABLE CALLS(
    ID INTEGER NOT NULL,
    caller INTEGER NOT NULL,
    CALLEE INTEGER NOT NULL,
    DURATION INTEGER NOT NULL,
    UNIQUE(ID)
);


INSERT INTO PHONES(name,phone_number) VALUES('JACK',1234);
INSERT INTO PHONES(name,phone_number) VALUES('LENA',3333);
INSERT INTO PHONES(name,phone_number) VALUES('MARK',9999);
INSERT INTO PHONES(name,phone_number) VALUES('ANNA',7582);

INSERT INTO CALLS(ID,caller,CALLEE,DURATION) VALUES(25,1234,7582,8);
INSERT INTO CALLS(ID,caller,CALLEE,DURATION) VALUES(7,9999,7582,1);
INSERT INTO CALLS(ID,caller,CALLEE,DURATION) VALUES(18,9999,3333,4);
INSERT INTO CALLS(ID,caller,CALLEE,DURATION) VALUES(2,7582, 3333,3);
INSERT INTO CALLS(ID,caller,CALLEE,DURATION) VALUES(3,3333,1234,1);
INSERT INTO CALLS(ID,caller,CALLEE,DURATION) VALUES(21,3333,1234,1);

SELECT * FROM PHONES;
SELECT * FROM CALLS;

-- TASK 02:
CREATE TABLE TASK_02_CALER (CALLER INTEGER,DURATION INTEGER)AS 
SELECT CALLER ,SUM(DURATION) FROM (
    SELECT CALLER,(DURATION) FROM CALLS
    UNION ALL
    SELECT CALLEE,(DURATION) FROM CALLS
) GROUP BY CALLER
;


SELECT * FROM TASK_02_CALER;

SELECT PHONES.NAME FROM PHONES 
LEFT OUTER JOIN TASK_02_CALER T2 ON T2.CALLER=PHONES.PHONE_NUMBER
WHERE T2.DURATION >=10;

--- TASK 03
CREATE TABLE transactions(
    Amount INTEGER NOT NULL,
    Date DATE NOT NULL
);


INSERT INTO transactions(Amount,Date) VALUES(1000,'2020-01-06'); 
INSERT INTO transactions(Amount,Date) VALUES(-10,'2020-01-14');
INSERT INTO transactions(Amount,Date) VALUES(-75,'2020-01-20');
INSERT INTO transactions(Amount,Date) VALUES(-5,'2020-01-25');
INSERT INTO transactions(Amount,Date) VALUES(-4,'2020-01-29');
INSERT INTO transactions(Amount,Date) VALUES(2000,'2020-03-10');
INSERT INTO transactions(Amount,Date) VALUES(-75,'2020-03-12');
INSERT INTO transactions(Amount,Date) VALUES(-20,'2020-03-15');
INSERT INTO transactions(Amount,Date) VALUES(40,'2020-03-15');
INSERT INTO transactions(Amount,Date) VALUES(-50,'2020-03-17');
INSERT INTO transactions(Amount,Date) VALUES(200,'2020-10-10');
INSERT INTO transactions(Amount,Date) VALUES(-200,'2020-10-10'); 


SELECT * FROM transactions;

CREATE TABLE T1 AS
(SELECT SUM(amount) AS total , 'A' AS name FROM  transactions  );


CREATE TABLE T2 AS (
    SELECT  COUNT(amount) AS cnt  , 'A' AS name
    FROM transactions 
    WHERE amount <0 
    GROUP BY month(date) 
    HAVING NOT(COUNT(amount) <3 OR  SUM(amount) >-100)
);


SELECT( SUM(T1.total) - (12- COUNT(T2.cnt ))*5 ) AS result 
FROM  T1  
LEFT OUTER JOIN T2 ON T1.name = T2.name ;