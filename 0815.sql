-- 创建school数据库
create database school charset=utf8;
use school;
-- 创建四张表
create table student(
    s_id varchar(10),
    s_name varchar(20),
    s_age date,
    s_sex varchar(10)
);

create table course(
    c_id varchar(10),
    c_name varchar(20),
    t_id varchar(10)
);

create table teacher (
t_id varchar(10),
t_name varchar(20)
);

create table score (
    s_id varchar(10),
    c_id varchar(10),
    score varchar(10)
);

-- 往表里插值
insert into student (s_id, s_name, s_age, s_sex)
values  ('01' , '赵雷' , '1990-01-01' , '男'),
        ('02' , '钱电' , '1990-12-21' , '男'),
        ('03' , '孙风' , '1990-05-20' , '男'),
        ('04' , '李云' , '1990-08-06' , '男'),
        ('05' , '周梅', '1991-12-01' , '女'),
        ('06' , '吴兰', '1992-03-01' , '女'),
        ('07' , '郑竹', '1989-07-01' , '女'),
        ('08' , '王菊', '1990-01-20' , '女');

insert into course (c_id, c_name, t_id)
values  ('01' , '语文' , '02'),
        ('02' , '数学' , '01'),
        ('03' , '英语' , '03');

insert into teacher (t_id, t_name)
values  ('01' , '张三'),
        ('02' , '李四'),
        ('03' , '王五');

insert into score (s_id, c_id, score)
values  ('01' , '01' , 80),
        ('01' , '02' , 90),
        ('01' , '03' , 99),
        ('02' , '01' , 70),
        ('02' , '02' , 60),
        ('02' , '03' , 80),
        ('03' , '01' , 80),
        ('03' , '02' , 80),
        ('03' , '03' , 80),
        ('04' , '01' , 50),
        ('04' , '02' , 30),
        ('04' , '03' , 20),
        ('05' , '01' , 76),
        ('05' , '02' , 87),
        ('06' , '01' , 31),
        ('06' , '03' , 34),
        ('07' , '02' , 89),
        ('07' , '03' , 98);
-- 看下建好的四张表

-- 创建一张总总表
create table total(
    select
        a.s_id as s_id,
        a.s_name as s_name,
        a.s_age as s_age,
        a.s_sex as s_sex,
        b.c_id as c_id,
        b.score as score,
        c.t_id as t_id,
        d.t_name as t_name
    from student a
        left join
            score  b on a.s_id=b.s_id
        left join
            course c on b.c_id=c.c_id
        left join
            teacher d on c.t_id=d.t_id
);
-- 1.查询所有同学的学生编号.学生姓名.选课总数.所有课程的总成绩

--Mysql 5.5.5及以上版本：ERROR 1055 (42000): Expression #2 
select s_id ,s_name,count(c_id) as c_num,sum(score) as s_num
from total 
group by s_id，s_name;


-- 2.查询"李"姓老师的数量
select count(t_name) from teacher where t_name like '李%';

-- 3.查询学过"张三"老师授课的同学的信息
select distinct s_id,s_name,s_age,s_sex 
from total
where t_name = '张三';

-- 4.查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息
select * 
from student
where s_id in 
    (select s_id from score where c_id = '01')
    and 
    s_id in 
    (select s_id form score where c_id = '02')

-- 5.查询没有学全所有课程的同学的信息
select  s_id,s_name,s_age,s_sex 
from total
group by s_id,s_name,s_age,s_sex
having count(c_id) < (select count(*) from course);

-- 6.查询没学过"张三"老师讲授的任一门课程的学生姓名
select s_name from student
having
s_id not in (select distinct s_id from total where t_name = '张三 ');

-- 7.查询不同老师所教不同课程平均分从高到低显示
select t_id ,t_name ,c_id,avg(score) as avg_score
from total
group by t_id ,t_name ,c_id
order by avg_score desc

-- 8.查询每门课程被选修的学生数
select c_id ,count(s_id) as '选修人数'
from score
group by  c_id;

-- 9.查询男生.女生人数
select s_sex,count(s_sex) from student group by s_sex;

-- 10.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号
select c_id,avg(score)  as a from score group by c_id  order by a desc,c_id;

-- 11.查询任何一门课程成绩在70分以上的姓名.课程名称和分数
select s_name,t_name,score 
from total 
where 
t.score > 70;


-- 12.查询不及格的课程
select score.c_id ,course.c_name,score
from score
    left join course on score.c_id = course.c_id 
where score < 60;