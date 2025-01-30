---- 9 task ----
create table VYR_t(
    x number(3),
    s varchar2(50)
);
---- 11 task ----

insert all
    into VYR_t(x, s) values(1, 'x')
    into VYR_t(x, s) values(2, 'xx')
    into VYR_t(x, s) values(3, 'xxx')
select * from dual;
commit;

---- 12 task ----

update VYR_t set x = 11 where s = 'x';
update VYR_t set s = 'xyz' where x = .3;
commit;

---- 13 task ----

select sum(case
                when length(s) >= 2 then x
                else 0
                end)
from VYR_t;

---- 14 task ----

delete VYR_t where x = 11;
commit;

---- 15 task ----

alter table VYR_t
add CONSTRAINT x_PK primary key(x);

create table VYR_t1(
    x2 number(3),
    str nvarchar2(50),
    foreign key (x2) references VYR_t(x)
);

insert all
    into VYR_t1(x2, str) values(2, 'yy')
    ---into VYR_t1(x2, str) values(3, 'yyy')
select * from dual;
commit;

---- 16 task ----

select * from VYR_t left join VYR_t1 on VYR_t.x = VYR_t1.x2;
select * from VYR_t right join VYR_t1 on VYR_t.x = VYR_t1.x2;
select * from VYR_t join VYR_t1 on VYR_t.x = VYR_t1.x2;

---- 17 task ----

drop table VYR_t1;
drop table VYR_t;
commit;



