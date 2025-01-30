alter session set nls_date_format='dd-mm-yyyy hh24:mi:ss';

---- task 1 ----

create table TableFrom(
    num number,
    str nvarchar2(50)
);

create table TableTo(
    num number,
    str nvarchar2(50)
);

create table StatsWork(
    status nvarchar2(10),
    msg nvarchar2(50),
    time_job date default sysdate
);

begin
    for i in 1..30
        loop
            insert into TableFrom values(i, concat('str', i));
        end loop;
end;
commit;

select * from TableFrom;
select * from TableTo;

---- task 2-3 ----

--drop procedure copying_rows_procedure;
create or replace procedure copying_rows_procedure is
    cursor curs is select * from TableFrom where num > (select count(*) from TableFrom);
    message varchar2(500);
begin
    for r in curs
    loop
        insert into TableTo values (r.num, r.str);
        delete TableFrom where num = r.num;
    end loop;

    insert into StatsWork(status, msg) values ('OK', 'success');
    commit;
exception
    when others then
        message := sqlerrm;
        insert into StatsWork(status, msg) values ('ERROR', message);
        commit;
end copying_rows_procedure;


declare job_id user_jobs.job%type;
begin
  dbms_job.submit(job_id, 'begin copying_rows_procedure(); end;', sysdate, 'sysdate + 7');
  commit;
  dbms_output.put_line(job_id);
end;

select * from StatsWork;

---- task 4-5 ----
select job, what, last_date, last_sec, next_date, next_sec, broken from user_jobs;

begin
  dbms_job.run(64);
end;

begin
  dbms_job.remove(64);
end;

select * from StatsWork;

---- task 6 ----

begin
dbms_scheduler.create_schedule(
  schedule_name => 'schedule_1',
  start_date => sysdate,
  repeat_interval => 'FREQ=WEEKLY',
  comments => 'schedule_1 WEEKLY starts now'
);
end;

select * from user_scheduler_schedules;

begin
dbms_scheduler.create_program(
  program_name => 'copying',
  program_type => 'STORED_PROCEDURE',
  program_action => 'copying_rows_procedure',
  number_of_arguments => 0,
  enabled => true,
  comments => 'program_copying_rows'
);
end;

select * from user_scheduler_programs;

begin
    dbms_scheduler.create_job(
            job_name => 'job',
            program_name => 'copying',
            schedule_name => 'schedule_1',
            enabled => true
        );
end;

select * from user_scheduler_jobs;

begin
    dbms_scheduler.disable('job');
end;

begin
    dbms_scheduler.run_job('job');
end;

begin
    dbms_scheduler.drop_job(job_name => 'job');
end;