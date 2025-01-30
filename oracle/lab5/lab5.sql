---- task 1 ----

select sum(value) from v$sga;

---- task 2 ----

select component, current_size from v$sga_dynamic_components
where component like '%java%' OR component like '%large%' OR component like '%shared%' OR component like '%streams%' OR component like '%unified%';

---- task 3 ----

select component, granule_size from v$sga_dynamic_components;

---- task 4 ----

select current_size from v$sga_dynamic_free_memory;

---- task 5 ----

show parameter sga_max_size;
show parameter sga_target;

---- task 6 ----

select component, current_size from v$sga_dynamic_components
where component like '%KEEP%' OR component like '%DEFAULT%' OR component like '%RECYCLE%';

---- task 7 ----

create table VYR (k int) storage(buffer_pool keep) tablespace users;
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments
where segment_name in('VYR');

---- task 8 ----

create table VYR2 (k int) cache tablespace users;
insert into VYR2 value(2);
commit;
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments
where segment_name in('VYR2');

---- task 9 ----

show parameter log_buffer;

---- task 10 ----

select * from v$sgastat
where pool like '%large pool%' and name = 'free memory';

---- task 11 ----

select paddr, username, sid, status, server, osuser from v$session
where username is not null;

---- task 12 ----

select paddr, process, name, program, status
from v$bgprocess join v$session using (paddr)
where status = 'ACTIVE'  order by name;

---- task 13 ----

select p.addr, p.execution_type, p.pname, p.program, s.username
from v$session s join v$process p on s.paddr = p.addr;

---- task 14 ----

select count(*) from v$bgprocess where name like 'DBW%';

---- task 15 ----

select service_id, name, network_name, creation_date from v$services;

---- task 16 ----

select name, network, status, accept, idle, cpu from v$dispatcher;
show parameter dispatchers;

---- task 17 ----

--services.msc

---- task 18 ----

--C:\WINDOWS.X64_193000_db_home\network\admin\listener.ora

---- task 19 ----

-- start, stop, status, services, servalcs, version, reload, save_config, trace, quit, exit, set, show

---- task 20 ----

-- LSNRCTL> services












