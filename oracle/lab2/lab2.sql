---- 1 task ----

--sys

create tablespace TS_VYR
    datafile 'TS_VYR.dbf'
    size 7M
    autoextend on next 5M
    maxsize 20M;
-- drop tablespace TS_VYR including contents and datafiles;

---- 2 task ----

create temporary tablespace TS_VYR_TEMP
    tempfile 'TS_VYR_TEMP.dbf'
    size 5M
    autoextend on next 3M
    maxsize 30M;
-- drop tablespace TS_VYR_TEMP including contents and datafiles;

---- 3 task ----

select * from SYS.dba_tablespaces;
select file_name, file_id, tablespace_name, bytes from dba_data_files
union
select file_name, file_id, tablespace_name, bytes from dba_temp_files;

---- 4 task ----

-- drop role C##RL_VYRCORE
create role C##RL_VYRCORE;

grant connect, 
        create session,
        create any table, drop any table,
        create any view, drop any view,
        create any procedure, drop any procedure to C##RL_VYRCORE;
        
---- 5 task ----

select * from dba_roles
where role = 'C##RL_VYRCORE';

select * from dba_sys_privs
where grantee = 'C##RL_VYRCORE';

---- 6 task ----

-- drop profile C##PF_VYRCORE;
create profile C##PF_VYRCORE limit
    password_life_time 180
    sessions_per_user 3
    failed_login_attempts 7
    password_lock_time 1
    password_grace_time default
    connect_time 180
    idle_time 30;
commit;

---- 7 task ----

select profile from dba_profiles;

select * from dba_profiles
where profile= 'C##PF_VYRCORE';

select * from dba_profiles
where profile= 'DEFAULT';

---- 8 task ----

--drop user C##VYRCORE
create user C##VYRCORE identified by 12345
default tablespace TS_VYR quota unlimited on TS_VYR
temporary tablespace TS_VYR_TEMP
profile C##PF_VYRCORE
account unlock
password expire;

grant create session to C##VYRCORE;

---- 9 task ----

-- re-creating a password in sqlplus

---- 10 task ----

grant C##RL_VYRCORE to C##VYRCORE;

-- user VYRCORE

--drop table TEST_t;
create table TEST_t(
     a number(3),
     b nvarchar2(50)
);

insert into TEST_t(a, b) values (1, 'a');
insert into TEST_t(a, b) values (2, 's');
insert into TEST_t(a, b) values (3, 'd');
insert into TEST_t(a, b) values (4, 'f');

select * from TEST_t;

--drop view TEST_v;
create view TEST_v as
    select a, b from TEST_t
    where a < 3;
    
select * from TEST_v;

---- 11 task ----

-- sys

--drop tablespace VYR_QDATA including contents and datafiles;
create tablespace VYR_QDATA
    datafile 'VYR_QDATA.dbf'
    size 10M
    offline;
    
select tablespace_name, status from dba_tablespaces
where tablespace_name like '%VYR%';

alter tablespace VYR_QDATA online;

alter user C##VYRCORE quota 2M on VYR_QDATA;

-- VYRCORE

--drop table VYR_t1;
create table VYR_t1(
    a number(3),
    b nvarchar2(50),
    c date
);

insert all
    into VYR_t1(a, b, c) values(1, 'a', TO_DATE('2001/05/03', 'yyyy/mm/dd'))
    into VYR_t1(a, b, c) values(2, 's', TO_DATE('2002/05/03', 'yyyy/mm/dd'))
    into VYR_t1(a, b, c) values(3, 'd', TO_DATE('2003/05/03', 'yyyy/mm/dd'))
select * from dual;

select * from VYR_t1;