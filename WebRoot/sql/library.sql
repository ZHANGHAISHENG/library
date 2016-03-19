

CREATE DATABASE library;


CREATE TABLE administrator(id INT  ,adminname VARCHAR(20) ,sex VARCHAR(1),adminpassword  VARCHAR(20),phone INT,addr VARCHAR(100),
                           rdate DATETIME,isroot INT,admindesc VARCHAR(100),PRIMARY KEY(id) );
                           

CREATE TABLE category(id INT AUTO_INCREMENT , pid INT, catename VARCHAR(20),grade INT ,isleaf INT,pdate DATETIME,catedesc VARCHAR(100),PRIMARY KEY(id));-- isleaf��0Ҷ�ӽڵ㣬1��Ҷ�ӽڵ�


CREATE TABLE  book(id INT AUTO_INCREMENT,cateid INT,bookname VARCHAR(20),authorname VARCHAR(20),bookversion VARCHAR(20),booksum INT,unusebooksum INT,pdate DATETIME,bdesc VARCHAR(100),
                   PRIMARY KEY(id),FOREIGN KEY(cateid) REFERENCES category(id));
                   
                   
                   
CREATE TABLE reader(id VARCHAR(20) ,rname VARCHAR(20),sex VARCHAR(1),rpassword VARCHAR(20),phone INT,email VARCHAR(50),addr VARCHAR(100),rdate DATETIME,
                    rdscr VARCHAR(100),PRIMARY KEY(id));



CREATE TABLE borrowbook(id INT AUTO_INCREMENT ,rid VARCHAR(20) ,odate DATETIME,bbdesc VARCHAR(100),PRIMARY KEY(id),FOREIGN KEY(rid) REFERENCES reader(id));

                               
CREATE TABLE borrowbookitem(id INT AUTO_INCREMENT ,bbid INT ,bid INT,state INT ,osuccessdate DATETIME , overduedate DATETIME,returnbookdate DATETIME,
                            bbidesc VARCHAR(100),PRIMARY KEY(id), FOREIGN KEY(bbid) REFERENCES borrowbook(id));-- state0:ԤԼ״̬,1:����ɹ�״̬��2������״̬;Osuccessdate 3���ѻ��� --ԤԼ�ɹ�ʱ��;Osuccessdate --ԤԼ�ɹ�ʱ��
                                 


CREATE TABLE ticket(id INT AUTO_INCREMENT ,rid VARCHAR(20),state INT,opendate DATETIME,deletedate DATETIME,tdesc VARCHAR(100),PRIMARY KEY(id),FOREIGN KEY(rid) REFERENCES reader(id));
                                                          -- -----state 0:δ�ɿ1�����ɿ�

CREATE TABLE ticketitem(id INT AUTO_INCREMENT ,tid INT , bid INT ,money DOUBLE,tidesc VARCHAR(100),PRIMARY KEY(id),FOREIGN KEY(tid)  REFERENCES ticket(id));


-- -- ------------------------------insert into-------------------------------------------------------------------------------------------------------------------------------
DROP TABLE book;
DROP TABLE category;


--    category------------------------------------------------------

INSERT INTO category VALUES(NULL,0,'����',1,0,NOW(),'��');


INSERT INTO category VALUES(NULL,0,'����',1,0,NOW(),'��');




INSERT INTO category VALUES(NULL,0,'�Ļ�',1,0,NOW(),'��');

INSERT INTO category VALUES(NULL,0,'��ʷ',1,1,NOW(),'��');

INSERT INTO category VALUES(NULL,4,'����',2,1,NOW(),'��');


INSERT INTO category VALUES(NULL,4,'�Ƴ�',2,0,NOW(),'��');


INSERT INTO category VALUES(NULL,5,'����ʱ��',3,0,NOW(),'��');
INSERT INTO category VALUES(NULL,5,'�ξ�ʱ��',3,0,NOW(),'��');


INSERT INTO category VALUES(NULL,0,'��ѧ',1,0,NOW(),'��');


--    book------------------------------------------------------
-- ����
INSERT INTO book VALUES(NULL,1,'�ʱ���','���˼','1.1',20,20,NOW(),'��');

INSERT INTO book VALUES(NULL,1,'����������','���˼','1.1',20,20,NOW(),'��');


-- ����


INSERT INTO book VALUES(NULL,2,'������ʱ��','����-�������','1.1',20,20,NOW(),'��');




INSERT INTO book VALUES(NULL,2,'�ҵ�Ӫ���ĵ�','ʷ����','1.1',20,20,NOW(),'��');

-- �Ļ�

INSERT INTO book VALUES(NULL,3,'�����Ĵ�','����','1.1',20,20,NOW(),'��');

INSERT INTO book VALUES(NULL,3,'�й����ʷ','�μ���','1.1',20,20,NOW(),'��');

-- ��ʷ


INSERT INTO book VALUES(NULL,4,'κ���ϱ���ʷ��ʰ��','�Ƴ���','1.1',20,20,NOW(),'��');

INSERT INTO book VALUES(NULL,4,'����ʮ����','������','1.1',20,20,NOW(),'��');

-- ��ѧ


INSERT INTO book VALUES(NULL,9,'ʱ���ʷ','����','1.1',20,18,NOW(),'��');

INSERT INTO book VALUES(NULL,9,'�����','����˹̹','1.1',20,20,NOW(),'��');







--    reader------------------------------------------------------

INSERT INTO reader VALUES('04120001','С��','��','123456',1234567890,'123456789@qq.com','jluzh',NOW(),'��' );

INSERT INTO reader VALUES('04120002','С��','��','123456',1234567890,'123456789@qq.com','jluzh',NOW(),'��' );

--    borrowBook------------------------------------------------------

INSERT INTO borrowBook VALUES(NULL,'04120001',NOW(),'��' );

INSERT INTO borrowBook VALUES(NULL,'04120002',NOW(),'��' );




--    borrowBookitem------------------------------------------------------
INSERT INTO borrowBookitem VALUES(NULL,1,0,9,NULL,NULL,NULL,'��' );

INSERT INTO borrowBookitem VALUES(NULL,2,2,9,NULL,NULL,NULL,'��' );

--    ticket------------------------------------------------------
INSERT INTO ticket VALUES(NULL,'04120002',0,NOW(),NULL,'��' );


--    ticketitem------------------------------------------------------
INSERT INTO ticketitem VALUES(NULL,1,9,30.8,'��' );


--    adminnistrator------------------------------------------------------



INSERT INTO administrator VALUES(100001,'����','��','123456',1234567890,'jluzh',NOW(),1,'��' );
INSERT INTO administrator VALUES(100002,'����','��','123456',1234567890,'jluzh',NOW(),0,'��' );



-- -��ɾ��˳�� ----------------------------------------------------------------------------------


DROP TABLE ticketitem;
DROP TABLE ticket;

DROP TABLE borrowBookitem;
DROP TABLE borrowBook;

DROP TABLE reader;

DROP TABLE book;bookbook

DROP TABLE category;

DROP TABLE administrator;

-- ��borrowbookitem����һ�ֶ�----------------------------------------------------------------------------------------------------------

ALTER TABLE borrowbookitem ADD returnbookdate DATETIME AFTER overduedate

ALTER TABLE ticket ADD deletedate  DATETIME AFTER opendate 
-- select������� --- ------------------------------------------------------------------------------------------------

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
SELECT  * FROM administrator WHERE 1=1  AND id IN(10004)  AND sex LIKE '%��%'  AND isroot=1 LIMIT 0 ,10

UPDATE SET id=5555 WHERE id=5555



SELECT (YEAR(NOW())-YEAR(osuccessdate))*360+(MONTH(NOW())- MONTH(osuccessdate))*30+ DAY(NOW())-DAY(osuccessdate)
 FROM borrowbook,borrowbookitem WHERE borrowbook.id=borrowbookitem.bbid AND state=1
 
 
SELECT bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* FROM borrowbook bbook,borrowbookitem bbitem WHERE bbook.id=bbitem.bbid AND state=1 AND DATEDIFF(NOW(),bbitem.osuccessdate)>=6  ORDER BY rid

 
SELECT DATEDIFF(osuccessdate,NOW()) FROM borrowbook,borrowbookitem WHERE borrowbook.id=borrowbookitem.bbid AND state=1
 

AND  (YEAR(NOW()-YEAR(osuccessdate))*360+(MONTH(NOW())- MONTH(osuccessdate))*30+DAY(osuccessdate)- DAY(NOW())
 MONTH(osuccessdate) DAY(osuccessdate)

SELECT    YEAR(NOW()) ��, MONTH(NOW()) ��, DAY(NOW()) ��

 SELECT CURDATE() , CURTIME()


SELECT bbook.id bbookid,bbook.rid,bbook.odate,bbook.bbdesc,bbitem.* FROM borrowbook bbook,borrowbookitem bbitem WHERE bbook.id=bbitem.bbid AND state=1 AND DATEDIFF(NOW(),bbitem.osuccessdate)>=1 ORDER BY bbook.rid