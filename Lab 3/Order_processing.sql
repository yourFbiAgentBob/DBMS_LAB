CREATE DATABASE ORDER_PROCESSING;

USE ORDER_PROCESSING;

CREATE TABLE CUSTOMER(CUST_ID INT,CNAME VARCHAR(30),CITY VARCHAR(30),PRIMARY KEY(CUST_ID));
CREATE TABLE ORDERS(ORDER_ID INT,ORDER_DATE DATE,CUST_ID INT,ORDER_AMOUNT INT,PRIMARY KEY(ORDER_ID),
                           FOREIGN KEY(CUST_ID) REFERENCES CUSTOMER(CUST_ID) ON DELETE CASCADE);
CREATE TABLE ITEM(ITEM_ID INT,UNITPRICE INT,PRIMARY KEY(ITEM_ID));

CREATE TABLE ORDERITEM(ORDER_ID INT,ITEM_ID INT,QTY INT,
                  FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID) ON DELETE SET NULL,
                  FOREIGN KEY(ITEM_ID) REFERENCES ITEM(ITEM_ID) ON DELETE SET NULL);
CREATE TABLE WAREHOUSE(WAREHOUSE_ID INT,CITY VARCHAR(30),PRIMARY KEY(WAREHOUSE_ID));
CREATE TABLE SHIPMENT(ORDER_ID INT,WAREHOUSE_ID INT,SHIPDATE DATE,
				  FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID) ON DELETE CASCADE,
                  FOREIGN KEY(WAREHOUSE_ID) REFERENCES WAREHOUSE(WAREHOUSE_ID) ON DELETE CASCADE);


INSERT INTO CUSTOMER(CUST_ID,CNAME,CITY) VALUES (771, 'PUSHPA K','BANGALORE'),
												(772, 'SUMAN', 'MUMBAI'),
                                                (773,'SOURAV','CALICUT'),
												(774, 'LAILA', 'HYDERABAD'),
												(775, 'FAIZAL',' BANGALORE');
INSERT INTO ORDERS(ORDER_ID,ORDER_DATE,CUST_ID,ORDER_AMOUNT) VALUES (111, '2002-01-22', 771, 18000),
										                            (112, '2002-07-30', 774, 6000),
																	(113, '2003-04-03', 775, 9000),
																	(114, '2003-11-03', 775, 29000),
																	(115, '2003-12-10', 773, 29000),
                                                                    (116, '2004-08-19', 772, 56000),
																	(117, '2004-09-10', 771, 20000),
										                            (118, '2004-11-20',775, 29000),
																	(119, '2005-02-13', 774, 29000),
																	(120, '2005-10-13', 775 ,29000);
                                                                    
INSERT INTO ITEM(ITEM_ID, UNITPRICE) VALUES (5001, 503),
                                            (5002, 750),
                                            (5003, 150),
                                            (5004, 600),
                                            (5005, 890);

INSERT INTO ORDERITEM(ORDER_ID,ITEM_ID,QTY) VALUES    (111, 5001, 50),
                                                      (112, 5003, 20),
                                                      (113, 5002, 50),
                                                      (114, 5005, 60),
                                                      (115, 5004, 90),
                                                      (116, 5001, 10),
                                                      (117, 5003, 80),
                                                      (118, 5005, 50),
                                                      (119, 5002, 10),
                                                      (120, 5004, 45);

INSERT INTO WAREHOUSE(WAREHOUSE_ID,CITY) VALUES (1,'DELHI'),
                                                (2,'BOMBAY'),
                                                (3,'CHENNAI'),
                                                (4,'BANGALORE'),
                                                (5,'BANGALORE'),
                                                (6,'DELHI'),
                                                (7,'BOMBAY'),
                                                (8,'CHENNAI'),
                                                (9,'DELHI'),
                                                (10,'BANGALORE');
                                                
INSERT INTO SHIPMENT(ORDER_ID,WAREHOUSE_ID,SHIPDATE) VALUES (111,1,'2002-02-10'),
															(112, 5 ,'2002-09-10'),
															(113, 8 ,'2003-02-10'),
															(114, 3 ,'2003-12-10'),
															(115,9 ,'2004-01-19'),
															(116, 1, '2004-09-20'),
															(117, 5 ,'2004-09-10'),
															(118, 7 ,'2004-11-30'),
															(119, 7 ,'2005-04-30'),
															(120, 6 ,'2005-12-21');
                                                            
/* iii) Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total
 numbers of orders by the customer and the last column is the average order amount for that
 customer.
 */

SELECT C.CNAME,COUNT(O.ORDER_ID) AS TOTALORDERS,AVG(O.ORDER_AMOUNT) AS AVG_ORDER_AMT FROM CUSTOMER C,ORDERS O WHERE C.CUST_ID=O.CUST_ID GROUP BY O.CUST_ID;

/* iv) List the order# for orders that were shipped from all warehouses that the company has in a
 specific city.
 */
 
 
SELECT S.ORDER_ID FROM SHIPMENT S,WAREHOUSE W WHERE S.WAREHOUSE_ID=W.WAREHOUSE_ID AND W.CITY="BANGALORE";

/* v) Demonstrate how you delete item# 10 from the ITEM table and make that field null in the
ORDER_ITEM table.
*/


DELETE FROM ITEM WHERE ITEM_ID=5002;
SELECT * FROM ORDERITEM;