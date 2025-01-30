grant create tablespace, drop tablespace to U1_VYR_PDB;

drop tablespace tbs1 including contents and datafiles;
drop tablespace tbs2 including contents and datafiles;
drop tablespace tbs3 including contents and datafiles;
drop tablespace tbs4 including contents and datafiles;

create tablespace tbs1
    datafile 'tbs1_U1_VYR_PDB.dbf'
    size 7 m
    autoextend on
    maxsize unlimited
    extent management local;
    
create tablespace tbs2
    datafile 'tbs2_U1_VYR_PDB.dbf'
    size 7 m
    autoextend on
    maxsize unlimited
    extent management local;
    
create tablespace tbs3
    datafile 'tbs3_U1_VYR_PDB.dbf'
    size 7 m
    autoextend on
    maxsize unlimited
    extent management local;
    
create tablespace tbs4
    datafile 'tbs4_U1_VYR_PDB.dbf'
    size 7 m 
    autoextend on
    maxsize unlimited
    extent management local;
    
alter user U1_VYR_PDB quota unlimited on tbs1;
alter user U1_VYR_PDB quota unlimited on tbs2;
alter user U1_VYR_PDB quota unlimited on tbs3;
alter user U1_VYR_PDB quota unlimited on tbs4;
    
---- task 1 ----

create table T_RANGE(
    num_id number,
    time_id date
)
partition by range (num_id)(
    partition n1 values less than(20) tablespace tbs1,
    partition n2 values less than(50) tablespace tbs2,
    partition n3 values less than(70) tablespace tbs3,
    partition nmax values less than(maxvalue) tablespace tbs4
);

begin
    for i in 1..100
        loop
            insert into T_RANGE values(i, sysdate);
        end loop;
end;

select * from T_RANGE partition (n1);
select * from T_RANGE partition (n2);
select * from T_RANGE partition (n3);
select * from T_RANGE partition (nmax);

select table_name, partition_name, high_value, tablespace_name from user_tab_partitions where table_name = 'T_RANGE';

---- task 2 ----

--drop table T_INTERVAL;
create table T_INTERVAL(
    num_id number,
    time_id date
)
partition by range(time_id)
interval (numtoyminterval(1, 'month'))(
    partition t1 values less than (to_date('1-1-1995', 'dd-mm-yyyy')) tablespace tbs1,
    partition t2 values less than (to_date('1-1-2000', 'dd-mm-yyyy')) tablespace tbs2,
    partition t3 values less than (to_date('1-1-2005', 'dd-mm-yyyy')) tablespace tbs3,
    partition t4 values less than (to_date('1-1-2010', 'dd-mm-yyyy')) tablespace tbs4
)

declare
    n number := 0;
    time_v date := '1-1-1990';
begin
    for i in 1..200
        loop
        n := n+1;
            insert into T_INTERVAL values(i, add_months(time_v, n));
        end loop;
end;

select * from T_INTERVAL partition(t1);
select * from T_INTERVAL partition(t2);
select * from T_INTERVAL partition(t3);
select * from T_INTERVAL partition(t4);

select table_name, partition_name, high_value, tablespace_name from user_tab_partitions where table_name = 'T_INTERVAL';

---- task 3 ----

--drop table T_HASH;
create table T_HASH(
    num_id number,
    str_id varchar2(110)
)
partition by hash(str_id)(
    partition h1 tablespace tbs1,
    partition h2 tablespace tbs2,
    partition h3 tablespace tbs3,
    partition h4 tablespace tbs4
)

declare
    str varchar2(110); 
begin
    for i in 1..100
        loop
            str:= concat(str, 'a');
            insert into T_HASH values(i, str);
        end loop;
end;

select * from T_HASH partition(h1);
select * from T_HASH partition(h2);
select * from T_HASH partition(h3);
select * from T_HASH partition(h4);

---- task 4 ----

create table T_LIST (
    num_id number,
    char_id char(3)
)
partition by list(char_id)(
    partition c1 values('a') tablespace tbs1,
    partition c2 values('b') tablespace tbs2,
    partition c3 values('c') tablespace tbs3,
    partition c4 values(default) tablespace tbs4
)

insert all
    into T_LIST values(1, 'a')
    into T_LIST values(2, 'b')
    into T_LIST values(3, 'c')
    into T_LIST values(4, 'd')
    into T_LIST values(5, 'a')
    into T_LIST values(6, 'b')
    into T_LIST values(7, 'c')
    into T_LIST values(8, 'g')
select * from dual;

select * from T_LIST partition(c1);
select * from T_LIST partition(c2);
select * from T_LIST partition(c3);
select * from T_LIST partition(c4);

commit;

---- task 6 ----

select * from T_RANGE partition(n1);
select * from T_RANGE partition(nmax);
update T_RANGE set num_id=101 where num_id=10;
rollback;

alter table T_INTERVAL enable row movement;
select * from T_INTERVAL partition(t1);
select * from T_INTERVAL partition(t4);
update T_INTERVAL set time_id='1-1-2008' where num_id=10;
rollback;

alter table T_HASH enable row movement;
select * from T_HASH partition(h1);
select * from T_HASH partition(h2);
update T_HASH set str_id='aa' where num_id=5;
rollback;

alter table T_LIST enable row movement;
select * from T_LIST partition(c1);
select * from T_LIST partition(c2);
update T_LIST set char_id='a' where num_id=2;
rollback;

---- task 7 ----

alter table T_RANGE merge partitions n1, n2 into partition n5 tablespace tbs4;
select * from T_RANGE partition(n5);

---- task 8 ----

alter table T_RANGE split partition n5 at (20)
into (partition n1 tablespace tbs1, partition n2 tablespace tbs2);
select * from T_RANGE partition(n5);
select * from T_RANGE partition(n1);
select * from T_RANGE partition(n2);

---- task 9 ----

create table T_RANGE_EX(
    num_id number,
    time_id date
);
alter table T_RANGE exchange partition n2 with table T_RANGE_EX without validation;
select * from T_RANGE partition (n2);
select * from T_RANGE_EX;






