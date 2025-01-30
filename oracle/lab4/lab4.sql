---- task 1 ----

select file_name, tablespace_name, status from dba_data_files
union
select file_name, tablespace_name, status from dba_temp_files;

---- task 2 ----

create tablespace VYR_QDATA 
    datafile 'VYR_QDATA.dbf'
    size 10M
    offline;
    
alter tablespace VYR_QDATA online;

create user C##VYR identified by 12345
default tablespace VYR_QDATA quota 2M on VYR_QDATA;
grant connect, create session, create table, insert any table to C##VYR;

-- myuser

-- drop table VYR_T1
create table VYR_T1(
    id number(20),
    s nvarchar2(10),
    constraint id_PK primary key(id)
);

insert into VYR_T1 values(1, 'x');
insert into VYR_T1 values(2, 'xx');
insert into VYR_T1 values(3, 'xxx');

select * from VYR_T1;

---- task 3 ----
-- sys

select * from dba_segments
where tablespace_name = 'VYR_QDATA';

---- task 4 ----
--vyr 

drop table VYR_T1;

--sys
select * from dba_segments
where tablespace_name = 'VYR_QDATA';

--vyr
select * from user_recyclebin;

---- task 5 ----

flashback table VYR_T1 to before drop;

---- task 6 ----

begin
for x in 4..1004
loop 
insert into VYR_T1 values(x, 'str');
end loop;
end;

---- task 7 ----

select * from user_segments;
select * from user_extents;

---- task 8 ----
--sys 

drop tablespace VYR_QDATA including contents and datafiles;
drop user C##VYR cascade;

---- task 9 ----

select * from v$log;

---- task 10 ----

select * from v$logfile;

---- task 11 ----

alter system switch logfile;
select * from v$log;

---- task 12 ----

alter database add logfile
group 4
'C:\OracleDB\oradata\ORCL\REDO04.LOG'
size 50m
blocksize 512;

alter database add logfile
member
'C:\OracleDB\oradata\ORCL\REDO04_1.LOG'
to group 4;

alter database add logfile
member
'C:\OracleDB\oradata\ORCL\REDO04_2.LOG'
to group 4;

select * from v$log;
select * from v$logfile;

alter system switch logfile;
select * from v$log;

---- task 13 ----

--alter system checkpoint;
alter database drop logfile member 'C:\OracleDB\oradata\ORCL\REDO04_2.LOG';
alter database drop logfile member 'C:\OracleDB\oradata\ORCL\REDO04_1.LOG';
alter database drop logfile group 4;

select * from v$log;
select * from v$logfile;

---- task 14 ----

select dbid, name, log_mode, controlfile_type from v$database;
select instance_number, instance_name, archiver, active_state from v$instance;

---- task 15 ----

select * from v$archived_log;

---- task 16 ----

-- shutdown immediate;
-- startup mount;
-- alter database archivelog;
-- alter database open;

select dbid, name, log_mode, controlfile_type from v$database;
select instance_number, instance_name, archiver, active_state from v$instance;

---- task 17 ----

alter system set LOG_ARCHIVE_DEST_1 ='LOCATION=C:\OracleDB\oradata\ORCL\archive';
alter system switch LOGFILE;
select * from v$archived_log;
select * from v$log;

---- task 18 ----

-- shutdown immediate;
-- startup mount;
-- alter database noarchivelog;
-- alter database open;

select dbid, name, log_mode, controlfile_type from v$database;
select instance_number, instance_name, archiver, active_state from v$instance;

---- task 19 ----

select * from v$controlfile;

---- task 20 ----

select type, record_size, records_total from v$controlfile_record_section;

---- task 21 ----

show parameter spfile;

---- task 22 ----

create pfile = 'VYR_PFILE.ora' from spfile;

---- task 23 ----

show parameter passwordfile;
select * from v$pwfile_users;

---- task 24 ----

select * from v$diag_info;

---- task 25 ----

-- C:\OracleDB\diag\rdbms\orcl\orcl\alert\log.xml
-- current









