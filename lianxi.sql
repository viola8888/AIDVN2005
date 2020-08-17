--编写函数和存储过程
--使用`cls`表完成
-- 编写一个函数，传入两个参数，分别是两个记录id 返回两个人的分数之差
-- 编写一个存储过程，传入学生id，通过out类型的参数 返回到这个学生的年龄

delimiter //
create function cls_01(uid1 int , uid2 int)
begin
    set @a=select score from class_1 where id=uid01);
    set @b=select score from class_1 where id=uid01);
    set @res=@a-@b
    return @res;
end //
delimiter ;

select cls_01(1,2)

delimiter //
create procedure cls_02(in uid int ,out num int)
declare val int;
select age from class_1 where id = uid into val
set num = val
end //
delimiter ;
