--创建数据库、数据表
--1. 创建一个数据库 books 采用utf8编码
--2. 在该数据库下创建一个数据表book，字段如下：
 --  id title author price publication(出版社) comment(评论)
 --字段类型及约束条件自己拟定

 CREATE DATABASE `books` CHARACTER SET utf8;
 CREATE TABLE book (
        id int primary key auto_increment,
        title varchar(30) not null ,
        author varchar(30) not null ,
        price decimal (6,2) ,
        publication varchar(50) not null ,
        comment    text
);

 
 ## 在数据表中 `book` 中插入几条数据

-   作者：老舍、鲁迅、钱钟书、沈从文、冰心、韩寒、郭敬明
-   价格：30 -- 120
-   出版社：中国文学出版社、中国教育出版社、机械工业出版社

1.  查找价格30多的图书
2.  查找出版社为中国教育出版社的
3.  查找老舍写的，中国文学出版社的
4.  查找备注不为空的
5.  查找价格超过60的，只看书名和价格
6.  查找价格超过100的活着鲁迅写的

insert into book (title,author,price,publication,comment) values
('骆驼祥子','老舍',23,'中国文学出版社','好书1'),
('茶馆','老舍',70,'中国教育出版社','好书1'),
('闰土','鲁迅',99.99,'中国文学出版社','好书2'),
('管锥编','钱钟书',88.88,'中国教育出版社','好书3'),
('边城','沈从文',56,'机械工业出版社','小城故事多'),
('繁星','冰心',23.99,'中国教育出版社','好书5'),
('三重门','韩寒',100.98,'中国 文学出版社','好书6'),
('幻城','郭敬明',120,'中国 机械工业出版社','好书7');

select * from book where publication = '中国教育出版社';



create table maratho (
    id int primary key auto_increment,
    name varchar(50) not null,
    birthday date,
    registeration_time datetime,
    performance time
);

insert into maratho values
(1, "金宝", "1990-12-10", "2020/8/5 15:13:20", "2:18:25"),
(2, "佳璇", "1991-12-10", "2020/7/5 12:13:20", "2:10:25"),
(3, "家乐", "1999-12-10", "2020/8/4 12:15:20", "1:59:59");

-- 查看时间函数
select now();

select * from maratho where performance < "02:30:00";

-- 运算
select * from maratho where (performance - interval 10 minute) < "02:10:00";


--使用`book` 表完成

--1.  将林家铺子的价格修改为45元
updata book set price = 45 where title = '骆驼祥子';
--2.  增加一个字段，出版日期，类型为`date`，放在价格后面
alter table book add publication_data data after price;
updata book set publication_data = '2012-5-4' ;
--3.  删除所有老舍的图书的出版日期为2012-5-4
delete from book where publication_data = '2012-05-04' and author = '老舍';
--4.  删除所有价格在80元以上的图书
delete from book where price > 80;
--5.  修改价格的字段类型`decimal(5,2)`
alter table book modify price decimal(5,2);