-- 函数定义
delimiter //
create function st2()  -- 创建函数 
returns int -- 声明返回类型
begin
    return (select score from class_1 where id=1);
end // 
delimiter ;
-- 调用函数
select su();
select * from class_1 where score=st2();

-- 多条语句 --> 有插入的 --> 错误
delimiter //
create function st3()
returns int
begin
    insert into class_1 values(5,'Lee',15,'m',98);
    set @a=(select age from class_1 where id=1);
    return @a;
end //
delimiter ;

-- 有参数
delimiter //
create function st4(uid int) returns int
begin
    return (select score from class_1 where id=uid);
end //
delimiter ;
-- 函数特点：
-- 1. 函数的返回值有且只有一个
-- 2. 函数中尽量不要写增删改语句
-- 3. 传参需指明参数类型

-- 存储过程
delimiter //
create procedure st()
begin
    select name,age from class_1;
    update class_1 set score=100 where id=1;
    select * from class_1;
end //
delimiter ;

-- in 类型
delimiter //
create procedure p_in1(in num1 int) -- 声明参数类型 形参名称 形参类型
begin
    select num1;
    set num1=100;
    select num1;
end //
delimiter ;
set @num1=10; -- 设置用户变量
call p_in1(@num1); -- 调用存储过程
select @num1; -- 外部调用

-- out 类型
delimiter //  
create procedure p_out1(out num1 int)
begin   
    select num1;
    set num1=100;
    select num1;
end //
delimiter ;

call p_out1(@num1);
select @num1;

-- inout 类型
delimiter //
create procedure p_inout1(inout num1 int)
begin
    select num1;
    set num1=10000;
    select num1;
end //
delimiter ;
call p_inout1;
-- in：传入的参数在存储过程内部可以使用，但是在存储过程内部的修改无法传递到外部
-- out：接收的变量不能在存储过程内部使用(内部为null)，但是可以在存储过程内对这个变量进行修改
-- inout：变量可以在存储过程内部使用，在存储过程内部的修改也会传递到外部。

























