CREATE DATABASE BOOKDEALER;

SHOW DATABASES;

USE BOOKDEALER;

CREATE TABLE AUTHOR(
	AUTHOR_ID INT,
    NAME VARCHAR(30),
    CITY VARCHAR(30),
    COUNTRY VARCHAR(30),
    PRIMARY KEY(AUTHOR_ID)
    );
    
SELECT * FROM AUTHOR;

CREATE TABLE PUBLISHER(
	PUBLISHER_ID INT,
    NAME VARCHAR(30),
    CITY VARCHAR(30),
    COUNTRY VARCHAR(30),
    PRIMARY KEY(PUBLISHER_ID)
    );
    
SELECT * FROM PUBLISHER;

CREATE TABLE CATEGORY(
	CATEGORY_ID INT,
    DESCRIPTION VARCHAR(50),
    PRIMARY KEY(CATEGORY_ID)
    );
    
SELECT * FROM CATEGORY;

CREATE TABLE CATALOG(
	BOOK_ID INT,
    TITLE VARCHAR(30),
    AUTHOR_ID INT,
    YEAR INT,
    PRICE INT,
    PUBLISHER_ID INT,
    CATEGORY_ID INT,
    PRIMARY KEY(BOOK_ID),
    FOREIGN KEY(AUTHOR_ID) REFERENCES AUTHOR(AUTHOR_ID) ON DELETE CASCADE,
    FOREIGN KEY(PUBLISHER_ID) REFERENCES PUBLISHER(PUBLISHER_ID) ON DELETE CASCADE,
    FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID) ON DELETE CASCADE
    );
    
SELECT * FROM CATALOG;

CREATE TABLE ORDER_DETAILS(
	ORDER_NO INT,
    BOOK_ID INT,
    QUANTITY INT,
    PRIMARY KEY(ORDER_NO),
    FOREIGN KEY(BOOK_ID) REFERENCES CATALOG(BOOK_ID)
    );
    
SELECT * FROM ORDER_DETAILS;

INSERT INTO AUTHOR(AUTHOR_ID, NAME, CITY, COUNTRY) VALUES (1001,'TERAS CHAN','CA','USA'),(1002,'STEVENS','ZOMBI','UGANDA'),(1003,'M MANO','CAIR','CANADA'),(1004,'KARTHIK BP','NEW YORK','USA'),(1005,'STRALLINGS','LAS VEGAS','USA');

SELECT * FROM AUTHOR;

INSERT INTO PUBLISHER(PUBLISHER_ID, NAME, CITY, COUNTRY) VALUES (1, 'PEARSON', 'NEW YORK', 'USA'), (2, 'EEE', 'NEW SOUTH_VALES', 'USA'), (3, 'PHI', 'DELHI', 'INDIA'), (4, 'WILLEY', 'BERLIN', 'GERMANY'), (5, 'MGH', 'NEW_YORK', 'USA');

SELECT * FROM PUBLISHER;    


INSERT INTO CATEGORY(CATEGORY_ID, DESCRIPTION) VALUES (1001, 'COMPUTER_SCIENCE'), (1002, 'ALGORITHM_DESIGN'), (1003, 'ELECTRONICS'), (1004, 'PROGRAMMING'), (1005, 'OPERATING_SYSTEMS');

SELECT * FROM CATEGORY;

INSERT INTO CATALOG(PRICE, BOOK_ID, TITLE, AUTHOR_ID,  PUBLISHER_ID, CATEGORY_ID, YEAR) VALUES (251, 11, 'Unix_System_Prg', 1001, 1, 1001, 2000), (425, 12, 'Digital_Signals', 1002, 2, 1003, 2001), (225, 13, 'Logic_Design', 1003, 3, 1002, 1999), (333, 14, 'Server_Prg', 1004, 4, 1004, 2001), (326, 15, 'Linux_OS', 1005, 5, 1005, 2003),(526, 16, 'C++ Bible', 1005, 5, 1001, 2000),(658, 17, 'COBOL Handbook', 1005, 4, 1001, 2000);

SELECT * FROM CATALOG;

INSERT INTO ORDER_DETAILS(ORDER_NO, BOOK_ID, QUANTITY) VALUES (1, 11, 5), (2, 12, 8), (3, 13, 15), (4, 14, 22), (5, 15, 3), (12, 17, 10);

SELECT * FROM ORDER_DETAILS;

-- DETAILS OF AUTHOR HAVING ATLEAST 2 BOOKS AND YEAR OF PUB AFTER 2000.

SELECT * FROM AUTHOR WHERE AUTHOR_ID IN(
SELECT AUTHOR_ID FROM CATALOG WHERE YEAR >= 2000 GROUP BY AUTHOR_ID  HAVING COUNT(AUTHOR_ID) >=2   );

-- AUTHOR OF BOOKS WITH MAX SALES

SELECT A.NAME FROM AUTHOR A,CATALOG C,ORDER_DETAILS O WHERE A.AUTHOR_ID=C.AUTHOR_ID AND C.BOOK_ID=O.BOOK_ID AND O.QUANTITY=(SELECT MAX(QUANTITY) FROM ORDER_DETAILS);


-- INCREASE PRICE OF THE BOOK WITH SPECIFIED PUBLISHER BY 10%

UPDATE CATALOG SET PRICE=(PRICE+PRICE*0.1) WHERE PUBLISHER_ID=5;

SELECT * FROM CATALOG;


																									