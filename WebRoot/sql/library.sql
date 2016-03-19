

CREATE DATABASE library;


CREATE TABLE administrator(id INT  ,adminname VARCHAR(20) ,sex VARCHAR(1),adminpassword  VARCHAR(20),phone INT,addr VARCHAR(100),
                           rdate DATETIME,isroot INT,admindesc VARCHAR(100),PRIMARY KEY(id) );
                           

CREATE TABLE category(id INT AUTO_INCREMENT , pid INT, catename VARCHAR(20),grade INT ,isleaf INT,pdate DATETIME,catedesc VARCHAR(100),PRIMARY KEY(id));-- isleaf：0叶子节点，1非叶子节点


CREATE TABLE  book(id INT AUTO_INCREMENT,cateid INT,bookname VARCHAR(20),authorname VARCHAR(20),bookversion VARCHAR(20),booksum INT,unusebooksum INT,pdate DATETIME,bdesc VARCHAR(100),
                   PRIMARY KEY(id),FOREIGN KEY(cateid) REFERENCES category(id));
                   
                   
                   
CREATE TABLE reader(id VARCHAR(20) ,rname VARCHAR(20),sex VARCHAR(1),rpassword VARCHAR(20),phone INT,email VARCHAR(50),addr VARCHAR(100),rdate DATETIME,
                    rdscr VARCHAR(100),PRIMARY KEY(id));



CREATE TABLE borrowbook(id INT AUTO_INCREMENT ,rid VARCHAR(20) ,odate DATETIME,bbdesc VARCHAR(100),PRIMARY KEY(id),FOREIGN KEY(rid) REFERENCES reader(id));

                               
CREATE TABLE borrowbookitem(id INT AUTO_INCREMENT ,bbid INT ,bid INT,state INT ,osuccessdate DATETIME , overduedate DATETIME,returnbookdate DATETIME,
                            bbidesc VARCHAR(100),PRIMARY KEY(id), FOREIGN KEY(bbid) REFERENCES borrowbook(id));-- state0:预约状态,1:借书成功状态，2：超期状态;Osuccessdate 3：已还书 --预约成功时间;Osuccessdate --预约成功时间
                                 


CREATE TABLE ticket(id INT AUTO_INCREMENT ,rid VARCHAR(20),state INT,opendate DATETIME,deletedate DATETIME,tdesc VARCHAR(100),PRIMARY KEY(id),FOREIGN KEY(rid) REFERENCES reader(id));
                                                          -- -----state 0:未纳款，1：已纳款

CREATE TABLE ticketitem(id INT AUTO_INCREMENT ,tid INT , bid INT ,money DOUBLE,tidesc VARCHAR(100),PRIMARY KEY(id),FOREIGN KEY(tid)  REFERENCES ticket(id));


-- -- ------------------------------insert into-------------------------------------------------------------------------------------------------------------------------------
DROP TABLE book;
DROP TABLE category;


--    category------------------------------------------------------

INSERT INTO category VALUES(NULL,0,'政治',1,0,NOW(),'无');


INSERT INTO category VALUES(NULL,0,'经济',1,0,NOW(),'无');




INSERT INTO category VALUES(NULL,0,'文化',1,0,NOW(),'无');

INSERT INTO category VALUES(NULL,0,'历史',1,1,NOW(),'无');

INSERT INTO category VALUES(NULL,4,'明朝',2,1,NOW(),'无');


INSERT INTO category VALUES(NULL,4,'唐朝',2,0,NOW(),'无');


INSERT INTO category VALUES(NULL,5,'洪武时期',3,0,NOW(),'无');
INSERT INTO category VALUES(NULL,5,'嘉靖时期',3,0,NOW(),'无');


INSERT INTO category VALUES(NULL,0,'科学',1,0,NOW(),'无');


--    book------------------------------------------------------
-- 政治
INSERT INTO book VALUES(NULL,1,'资本论','马克思','1.1',20,20,NOW(),'无');

INSERT INTO book VALUES(NULL,1,'共产党宣言','马克思','1.1',20,20,NOW(),'无');


-- 经济


INSERT INTO book VALUES(NULL,2,'大数据时代','迈尔-舍恩伯格','1.1',20,20,NOW(),'无');




INSERT INTO book VALUES(NULL,2,'我的营销心得','史玉柱','1.1',20,20,NOW(),'无');

-- 文化

INSERT INTO book VALUES(NULL,3,'胡适文存','胡适','1.1',20,20,NOW(),'无');

INSERT INTO book VALUES(NULL,3,'中国佛教史','任继愈','1.1',20,20,NOW(),'无');

-- 历史


INSERT INTO book VALUES(NULL,4,'魏晋南北朝史论拾遗','唐长儒','1.1',20,20,NOW(),'无');

INSERT INTO book VALUES(NULL,4,'万历十五年','黄仁宇','1.1',20,20,NOW(),'无');

-- 科学


INSERT INTO book VALUES(NULL,9,'时间简史','霍金','1.1',20,18,NOW(),'无');

INSERT INTO book VALUES(NULL,9,'相对论','爱因斯坦','1.1',20,20,NOW(),'无');







--    reader------------------------------------------------------

INSERT INTO reader VALUES('04120001','小明','男','123456',1234567890,'123456789@qq.com','jluzh',NOW(),'无' );

INSERT INTO reader VALUES('04120002','小刚','男','123456',1234567890,'123456789@qq.com','jluzh',NOW(),'无' );

--    borrowBook------------------------------------------------------

INSERT INTO borrowBook VALUES(NULL,'04120001',NOW(),'无' );

INSERT INTO borrowBook VALUES(NULL,'04120002',NOW(),'无' );




--    borrowBookitem------------------------------------------------------
INSERT INTO borrowBookitem VALUES(NULL,1,0,9,NULL,NULL,NULL,'无' );

INSERT INTO borrowBookitem VALUES(NULL,2,2,9,NULL,NULL,NULL,'无' );

--    ticket------------------------------------------------------
INSERT INTO ticket VALUES(NULL,'04120002',0,NOW(),NULL,'无' );


--    ticketitem------------------------------------------------------
INSERT INTO ticketitem VALUES(NULL,1,9,30.8,'无' );


--    adminnistrator------------------------------------------------------



INSERT INTO administrator VALUES(100001,'杨明','男','123456',1234567890,'jluzh',NOW(),1,'无' );
INSERT INTO administrator VALUES(100002,'王海','男','123456',1234567890,'jluzh',NOW(),0,'无' );



-- -表删除顺序 ----------------------------------------------------------------------------------


DROP TABLE ticketitem;
DROP TABLE ticket;

DROP TABLE borrowBookitem;
DROP TABLE borrowBook;

DROP TABLE reader;

DROP TABLE book;bookbook

DROP TABLE category;

DROP TABLE administrator;

-- 往borrowbookitem增加一字段----------------------------------------------------------------------------------------------------------

ALTER TABLE borrowbookitem ADD returnbookdate DATETIME AFTER overduedate

ALTER TABLE ticket ADD deletedate  DATETIME AFTER opendate 
-- select多表连接 --- ------------------------------------------------------------------------------------------------

SELECT * FROM ticketitem,ticket WHERE ticketitem.tid=ticket.id ;
SELECT * FROM ticket,reader WHERE ticket.rid=reader.id;

SELECT * FROM borrowbookitem,borrowbook WHERE  borrowbookitem.bbid=borrowbook.id ;

SELECT * FROM borrowbook,reader WHERE borrowbook.rid=reader.id;

SELECT * FROM book,category WHERE book.id=category.id;


-- -----------------------------------------------------------------------------------------------------------------------




SELECT * FROM category;

SELECT * FROM book;


SELECT * FROM reader ;



SELECT * FROM borrowBook;

SELECT * FROM borrowBookitem;


SELECT * FROM ticket;

SELECT * FROM ticketitem;

SELECT * FROM book WHERE cateid=70  AND bookname='d'


SELECT * FROM administrator;


-- -------------------------------------------------------------------------------------------------------------
SELECT * FROM reader WHERE id='04120003' AND rpassword='123456'
SELECT  * FROM administrator WHERE id=100001  AND adminpassword='123456'
SELECT  * FROM administrator WHERE 1=1  AND id IN(10004)  AND sex LIKE '%男%'  AND isroot=1 LIMIT 0 ,10

UPDATE SET id=5555 WHERE id=5555



SELECT (YEAR(NOW())-YEAR(osuccessdate))*360+(MONTH(NOW())- MONTH(osuccessdate))*30+ DAY(NOW())-DAY(osuccessdate)
 FROM borrowbook,borrowbookitem WHERE borrowbook.id=borrowbookitem.bbid AND state=1
 
 
SELECT bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* FROM borrowbook bbook,borrowbookitem bbitem WHERE bbook.id=bbitem.bbid AND state=1 AND DATEDIFF(NOW(),bbitem.osuccessdate)>=6  ORDER BY rid

 
SELECT DATEDIFF(osuccessdate,NOW()) FROM borrowbook,borrowbookitem WHERE borrowbook.id=borrowbookitem.bbid AND state=1
 

AND  (YEAR(NOW()-YEAR(osuccessdate))*360+(MONTH(NOW())- MONTH(osuccessdate))*30+DAY(osuccessdate)- DAY(NOW())
 MONTH(osuccessdate) DAY(osuccessdate)

SELECT    YEAR(NOW()) 年, MONTH(NOW()) 月, DAY(NOW()) 日

 SELECT CURDATE() , CURTIME()


SELECT bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* FROM borrowbook bbook,borrowbookitem bbitem WHERE bbook.id=bbitem.bbid AND state=1 AND DATEDIFF(NOW(),bbitem.osuccessdate)>=1 ORDER BY bbook.rid