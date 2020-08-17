--进入数据库
mysql -uroot -p

--查看有多少库   注意单词后有 -s-；
show databases;

--删除数据库
drop database books;

--创建库
create database class  character set utf8;

--创建班级
create table class_1(
    id int primary key auto_increment,
    name varchar(30) not null,
    age tinyint unsigned not null,
    sex enum('w','M') not null,
    score float default 0.1
);

--创建兴趣班  id   name    hobby   level    price    remark
create table interest(
    id int primary key auto_increment,
    name varchar(30) not null,
    hobby set('sing','dance','draw'),
    level char not null,
    price decimal(6,2) 
);

--查看库中数据表;
show tables;

--查看已有表的字符集；
show create table class_1;
show create table interest;

--查看表结构
desc  class_1;
desc  interest;

--创建一个库books ，表 book，字段 id title author price publication  comment
create database books character set utf8;

create table book_1  (
    id int primary key auto_increment,
    title varchar(30) not null,
    author varchar(30) default '佚名',
    publication varchar(30) not null,
    price decimal(6,2),
    comment text 
);

--在class_1表中插入数据
insert into class_1 value 
(1,'Baron',10,'w',91),
(2,'Jame',12,'M',99);

insert into class_1 (name,age,sex,score)
value 
('Sam',11,'M',68),
('Susu',13,'w',100);


--查询数据
  --算数运算符 +  -  *  /或DIV  %或MOD
  --比较运算符   in not in  <  >  = != 等等
  --逻辑运算符   and or not或!   XOR(异或)
  select * from class_1 where score -10 > 80;

  --在book表中插入几条数据
  --作者：老舍  鲁迅   钱钟书   沈从文   冰心   韩寒   郭敬明
  --价格：30-120之间
  --出版社：中国文学   中国教育   机械工业

  insert into book_1 (title,author,publication,price,comment)
  values
  ('骆驼祥子','老舍','中国文学',120,'没有一位语言艺术大师是脱离群众的，也没有一位这样的大师是记录人民语言，而不给它加工的'),
  ('四世同堂','老舍','中国教育',60,'老舍的语言俗白精致，雅俗共赏'),
  ('呐喊','鲁迅','中国教育',110,'民主战士'),
  ('彷徨','鲁迅','机械工业',65,'左联盟主'),
  ('管锥编','钱钟书','中国文学',72,'风雅之士'),
  ('围城','钱钟书','机械工业',99,'才高八斗'),
  ('老实人','沈从文','中国文学',108,'创作风格趋向浪漫主义'),
  ('蜜柑','沈从文','机械工业',98,'以湘西生活为题材'),
  ('闲情','冰心','中国文学',79,'题材广泛，寓意深邃。'),
  ('繁星','冰心','机械工业',88,'对少年儿童的爱和希望');

  --查找 90元以上的图书；
  select * from book_1 where price > 90;
  --查找出版社是中国教育出版社的；
  select * from book_1 where publication = '中国教育';
  --查找老舍，并文学出版社的
  select * from book_1 where publication = '中国文学' and author = '老舍';
  --查找备注不为空的
  select * from book_1 where comment is not null;
  --查看价格超过100 ，只显示书名和价格
  select title , price from book_1 where price > 100;
  --查找价格超过100 或鲁迅写的
  select * from book_1 where price > 100 XOR author = '鲁迅';
   
--将呐喊的价格改为54元；
update book_1 set price = 54 where title = '骆驼祥子';
--增加一个字段，出版日期，类型为date，放在价格后面；
alter table book_1 add publication_date date after price;
--修改老舍所有书的出版日期为2012-5-4
update book_1 set publication_date = '2012-5-4' where author = '老舍';
--修改文学出版社的日期为2016-10-6，老舍不修改；
update book_1 set publication_date = '2016-10-6' where publication = '中国文学' and author != '老舍';
--删除所有价格在109元以上的书籍；
delete from book_1 where price > 109;

--修改价格字段类型decimal(5,2)
alter table book_1 modify price decimal(5,2);


   --功能，类似QQ群功能
   --有人进入聊天室，需要输入姓名；
   --有人进入聊天室时，其他人会收到提示：×××  进入聊天室
   --一个人发送消息，其他人会×××  ：××××
   --有人退出聊天室，其他人会收到 ：×××退出聊天室
   --扩展功能：服务器可以向所有用户发送公告：管理员消息：××××


   --创建库  hero
   --创建表  sanguo
   --字段：id   name   gender   country  attack(>100)   defense(0-100)
   --数据：
      --魏：曹操   司马懿   夏侯渊   张辽   甄姬
      --蜀：刘备    关羽   赵云   诸葛亮   张飞   孙尚香
      --吴：周瑜   大乔   小乔   陆逊   吕蒙

create database hero  character set utf8;
create  table  sanguo  (
    id int  primary key  auto_increment ,
    name varchar(30) not null,
    country enum('魏','蜀','吴'),
    gender enum('男','女'),
    attack int not null,
    defense int not null
);

insert  into sanguo (name,country,gender,attack ,defense)
values
('曹操','魏','男',120,88),
('司马懿','魏','男',110,46),
('夏侯渊','魏','男',280,98),
('张辽','魏','男',128,58),
('甄姬','魏','女',101,10),
('刘备','蜀','男',110,68),
('关羽','蜀','男',180,98),
('赵云','蜀','男',210,96),
('诸葛亮','蜀','男',190,98),
('张飞','蜀','男',200,88),
('孙尚香','蜀','女',201,10),
('周瑜','吴','男',370,98),
('大乔','吴','女',106,55),
('小乔','吴','女',108,66),
('陆逊','吴','男',300,98),
('吕蒙','吴','女',301,90);

--查询所有蜀国人的信息，按照攻击力排名
select * from sanguo where country = '蜀' order by attack;
--将赵云的攻击力设为360，防御力设置为70
update sanguo set attack = 360,defense = 70 where name = '赵云';
--吴国英雄攻击力超过300的改为300（最多给2个）
update sanguo set attack = 300 where attack > 300 and country = '吴' limit 2;
--查找攻击力高于250的魏国英雄的名字和攻击力；
select name ,attack from sanguo where attack > 250 and country = '魏';
--将所有英雄攻击力按照降序排序，如果攻击力相同，则按照防御力降序排列
select * from sanguo order by attack desc , defense desc;
--查找名字为3各自的英雄；
select * from  sanguo where name  like '___';
--找到魏国防御力前2名的英雄；
select * from sanguo where country = '魏'  order by defense desc limit 2;
--找到攻击力比魏国最高攻击力者还要高的蜀国英雄;
select * from sanguo where country = '蜀' and attack > (select attack from sanguo where country = '魏' order by attack desc limit 1);
--找过所有女性角色中攻击力比诸葛亮还要高的英雄；
select * from sanguo where gender = '女' and attack > (select attack from sanguo where name = '诸葛亮');


--计算每位作家的书价格之和
select sum(price),author from book_1 group by author;
--统计每个出版社的图书的平均价格
select avg(price),publication from book_1 group by publication;
--刷选出每个出版社图书最高价格大于60的出版社；
select publication from book_1 group by publication
having
max(price) > 60
--查看总共有多少个作者
select distinct  author  from book_1;
--统计所有有出版时间的图书的平均价格
select avg(price) from book_1 where publication_date is not null;

--建立用户，朋友圈，评论点赞信息的表关系
--将book数据表拆分，书籍信息，作者信息，出版社信息 ，画出E-R图
--使用cls表，编写一个函数，传入两个参数，分别是两个记录的ID，计算两个ID的分数之差（使用函数）
--编写一个存储过程，传入学生ID，通过out类型的参数，传出这个学生的年龄
--pymysql模块   在dict数据库中建立word表存储单词，将dict.txt文件中的单词写入到words数据表中
--pymysql模块    编写一个类，实例化对象时，可以连接数据库，通过该对象调用犯法可以模拟完成简单的登入注册功能；



                



