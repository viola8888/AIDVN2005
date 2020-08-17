-- 创建库 gx
create database gx charset=utf8;

use gx;
-- 部门表
create table dept (
    id int primary key auto_increment,
    dname varchar(50) not null
);

-- 员工表
create table person(
    id int primary key auto_increment,
    name varchar(32) not null,
    age tinyint,
    sex enum('w', 'm'),
    salary decimal(9,2),
    hire_date date,
    dept_id int
);

-- 插入数据
insert into 
    dept
values
    (1,'总裁办'),(2,'财务部'),(3,'技术部'),(4,'人事部');

insert into
    person
values
    (1,'Alex',33,'m',28000,'2017-3-5',2),
    (2,'Tom',23,'m',8000,'2018-4-2',3),
    (3,'Lucy',25,'w',18000,'2019-5-1',3),
    (4,'Lily',30,'w',25000,'2020-5-5',1);
select * from person;
-- 未添加索引 会插入成功
insert into person values (6,'Lily',30,'w',25000,'2020-5-5',5);

-- 建立外键约束
delete from person where id=6;
-- 添加外键
alter table 
    person add 
    constraint dept_fk
    foreign key (dept_id) 
    references dept(id);

desc person; -- MUL
show create table person;

-- 添加外键之后，插入不会成功
insert into person values (6,'Lily',30,'w',25000,'2020-5-5',5);


-- 删除外键
alter table person drop foreign key dept_fk;
desc person; -- 查看索引标志是否还在

-- 删除索引标志
drop index dept_fk on person;
desc person; -- 查看索引标志是否还在

-- 级联动作
-- 1. restrict --> on delete restrict on update restrict
alter table person add
constraint dept_fk foreign key (dept_id) references dept(id);

delete from dept where id=3;
update dept set id=5 where id = 3;

-- 2. `cascade `：数据级联更新  `on delete cascade  on update cascade`  
-- 删除之前的级联动作
alter table person drop foreign key dept_fk;
-- 重新建立外键
alter table person add
constraint dept_fk foreign key (dept_id) references dept(id)
on delete cascade on update cascade;
-- 更新
update dept set id=9 where id = 3;

-- 3. `set null`：`on delete set null    on update set null `
-- 删除之前的级联动作
alter table person drop foreign key dept_fk;
-- 重新建立
alter table person add
constraint dept_fk foreign key (dept_id) references dept(id)
on delete set null on update set null;
-- 跟新
update dept set id=9 where id = 3;


-- 主表和从表的区别
1. 被约束的表成为附表，约束别人的表成为主表，外键是在从表上的
2. 主表被参开的字段通常设置为主键
3. 级联操作：
3.1 restrict(默认): 当主表删除、更新时，如果从表中与相关联的级联则不允许主表删除、更新
3.2 cascade: 当主表删除、更新字段的值时，从表会更新
3.3 set null: 当主表删除、更新数据的时候，从表外键会变为null