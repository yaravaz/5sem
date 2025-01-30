---- task 1 ----

--sqlnet.ora tnsnames.ora

---- task 2 ----

select name, type, value from v$parameter;

---- task 3 ----

--connect system/Qwerty12345@//localhost:1521/VYR_PDB.mshome.net

select * from dba_tablespaces;
select tablespace_name, file_name from dba_data_files
union
select tablespace_name, file_name from dba_temp_files;
select role from dba_roles;
select username, user_id from dba_users;

---- task 4 ----

--HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE

--INST_LOC
--Specifies the location of Oracle Universal Installer files.

---- task 5 ----

-- net manager
-- creating a string connection

---- task 6 ----

-- creating a connection as U1_VYR_PDB

---- task 7 ----

--drop table VYR_t;

select * from VYR_t;

---- task 8 ----

--sqlplus
help timing
timi start;
select * from dba_roles;
timi stop;

---- task 9 ----

--desc dba_users;

---- task 10 ----

select * from user_segments;

---- task 11 ----

--sys
select count(*) segments_amount, sum(extents) extends_amount, sum(blocks) blocks_amount, sum(bytes) / 1024 size_kb from user_segments;

