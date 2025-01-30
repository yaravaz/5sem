---- task 1 ----

-- sys_pdb
grant create sequence, create cluster, create synonym, create public synonym, create materialized view to U1_VYR_PDB;
grant select on sys.dba_clusters to U1_VYR_PDB;
grant select on sys.dba_tables to U1_VYR_PDB;
grant execute on dbms_mview to U1_VYR_PDB;

---- task 2 ----

drop sequence U1_VYR_PDB.S1;
drop sequence U1_VYR_PDB.S2;
drop sequence U1_VYR_PDB.S3;
drop sequence U1_VYR_PDB.S4;

--U1_VYR_PDB
create sequence U1_VYR_PDB.S1 
increment by 10
start with 1000
nomaxvalue
nominvalue
nocycle
nocache
noorder;

select S1.nextval from dual;
select S1.currval from dual;

---- task 3 ----

create sequence U1_VYR_PDB.S2 
increment by 10
start with 10
maxvalue 100
nocycle;

select S2.nextval from dual;
select S2.currval from dual;

---- task 4 ----

create sequence U1_VYR_PDB.S3 
increment by -10
start with 10
minvalue -100
maxvalue 10
nocycle
order;

select S3.nextval from dual;
select S3.currval from dual;


---- task 5 ----

create sequence U1_VYR_PDB.S4
increment by 1
start with 1
maxvalue 10
cycle
cache 5
noorder;

select S4.nextval from dual;
select S4.currval from dual;

---- task 6 ----

select * from user_sequences;

---- task 7 ----

--drop table T1;
create table T1(
    N1 number(20),
    N2 number(20),
    N3 number(20),
    N4 number(20)
) cache storage (buffer_pool keep);

begin
    for i in 1..7
        loop
            insert into T1 values(S1.nextval, S2.nextval, S3.nextval, S4.nextval);
        end loop;
end;

select * from T1;

---- task 8 ----

--drop cluster U1_VYR_PDB.ABC;
create cluster U1_VYR_PDB.ABC (
    X number(10),
    V varchar2(12))
    hashkeys 200
    tablespace VYR_PDB_TS;

---- task 9 ----

--drop table A;
create table A(
    XA number(10),
    VA varchar2(12),
    S number(5)
) cluster U1_VYR_PDB.ABC (XA, VA);

---- task 10 ----

--drop table B;
create table B(
    XB number(10),
    VB varchar2(12),
    S number(5)
) cluster U1_VYR_PDB.ABC (XB, VB);

---- task 11 ----

--drop table Ñ;
create table C(
    XC number(10),
    VC varchar2(12),
    S number(5)
) cluster U1_VYR_PDB.ABC (XC, VC);

---- task 12 ----

select owner, table_name from dba_tables
where cluster_name like 'ABC';
select owner, cluster_name from dba_clusters
where cluster_name = 'ABC';

---- task 13 ----

--drop synonym SYNC;
create synonym SYNC for U1_VYR_PDB.C;

insert into SYNC values(10, 'x', 2);
select * from SYNC; 

---- task 14 ----

--drop synonym SYNB;
create public synonym SYNB for U1_VYR_PDB.B;

insert into SYNB values (12, 'xx', 1);
select * from SYNB;

---- task 15 ----

--drop table Table1;
create table Table1(
    id number(30),
    num number(20),
    str nvarchar2(50),
    constraint ID_PK primary key (id)
);

--drop table Table2
create table Table2(
    qwerty nvarchar2(30),
    id2 number(20),
    constraint ID2_FK foreign key (id2) references Table1(id)
);

insert into Table1 values(1, 10, 'str1');
insert into Table1 values(2, 20, 'str2');
insert into Table1 values(3, 30, 'str3');
insert into Table2 values('string1', 1);
insert into Table2 values('string2', 2);
insert into Table2 values('string3', 3);

--drop view VI

create view V1 as
select * 
from Table1 inner join Table2 on Table1.id = Table2.id2;

select * from V1;

---- task 16 ----

--drop materialized view MV;

create materialized view MV
    build immediate
    refresh complete on demand
    start with sysdate
    next sysdate + numtodsinterval(5, 'second')
as
select * from Table1 inner join Table2 on Table1.id = Table2.id2;

execute dbms_mview.refresh('MV');

select * from MV;
select * from Table1;
select * from Table2;

delete Table2 where id2 = 4;
delete Table1 where id = 4;

insert into Table1 values(4, 40, 'str4');
insert into Table2 values('string4', 4);
commit;






