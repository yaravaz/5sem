                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ---- task 1 ----

--drop table NewTable; 
create table NewTable(
    num number(20) primary key,
    str nvarchar2(50) not null
);

---- task 2 ----

begin
    for i in 1..10
        loop
            insert into NewTable values(i, concat('str', i));
        end loop;
end;

insert all
    into NewTable values(11, 'str11')
    into NewTable values(12, 'str12')
    into NewTable values(13, 'str13')
select * from dual;
update NewTable set str = 'str15' where num >= 11;
delete NewTable where num >= 11;

select * from NewTable;

---- task 3-4 ----

create or replace trigger before_operator_trigger
before insert or update or delete
on NewTable
begin
    if INSERTING then 
        dbms_output.put_line('before_operator_trigger: insert');
    elsif UPDATING then
        dbms_output.put_line('before_operator_trigger: update');
    elsif DELETING then
        dbms_output.put_line('before_operator_trigger: delete');
    end if;
end;

---- task 5-6 ----

create or replace trigger before_row_trigger
before insert or update or delete
on NewTable
for each row
begin
    if INSERTING then 
        dbms_output.put_line('before_row_trigger: insert');
    elsif UPDATING then
        dbms_output.put_line('before_row_trigger: update');
    elsif DELETING then
        dbms_output.put_line('before_row_trigger: delete');
    end if;
end;

----- task 7 ----

create or replace trigger after_operator_trigger
after insert or update or delete
on NewTable
begin
    if INSERTING then 
        dbms_output.put_line('after_operator_trigger: insert');
    elsif UPDATING then
        dbms_output.put_line('after_operator_trigger: update');
    elsif DELETING then
        dbms_output.put_line('after_operator_trigger: delete');
    end if;
end;

---- task 8 ----

create or replace trigger after_row_trigger
after insert or update or delete
on NewTable
for each row
begin
    if INSERTING then 
        dbms_output.put_line('after_row_trigger: insert');
    elsif UPDATING then
        dbms_output.put_line('after_row_trigger: update');
    elsif DELETING then
        dbms_output.put_line('after_row_trigger: delete');
    end if;
end;

---- task 9 ----

create table AUDITS(
    OperationDate date,
    OperationType varchar2(50),
    TriggerName   varchar2(50),
    Data          varchar2(40)
);

---- task 10 ---

create or replace trigger before_row_trigger
before insert or update or delete
on NewTable
for each row
begin
    if INSERTING then 
        dbms_output.put_line('before_row_trigger: insert');
        insert into AUDITS values(sysdate, 'insert', 'before_row_trigger', :new.num  || '-' || :new.str);
    elsif UPDATING then
        dbms_output.put_line('before_row_trigger: update');
        insert into AUDITS values(sysdate, 'update', 'before_row_trigger', :old.num || '-' || :old.str || ': ' || :new.num || '-' || :new.str);
    elsif DELETING then
        dbms_output.put_line('before_row_trigger: delete');
        insert into AUDITS values(sysdate, 'delete', 'before_row_trigger', :old.num || '-' || :old.str);
    end if;
end;

create or replace trigger after_row_trigger
after insert or update or delete
on NewTable
for each row
begin
    if INSERTING then 
        dbms_output.put_line('after_row_trigger: insert');
        insert into AUDITS values(sysdate, 'insert', 'after_row_trigger', :new.num  || '-' || :new.str);
    elsif UPDATING then
        dbms_output.put_line('after_row_trigger: update');
        insert into AUDITS values(sysdate, 'update', 'after_row_trigger', :old.num || '-' || :old.str || ': ' || :new.num || '-' || :new.str);
    elsif DELETING then
        dbms_output.put_line('after_row_trigger: delete');
        insert into AUDITS values(sysdate, 'delete', 'after_row_trigger', :old.num || '-' || :old.str);
    end if;
end;

insert all
    into NewTable values(11, 'str11')
    into NewTable values(12, 'str12')
    into NewTable values(13, 'str13')
select * from dual;
update NewTable set str = 'str15' where num >= 11;
delete NewTable where num >= 11;

select * from AUDITS;

---- task 11 ----

insert into NewTable values(1, 'sss');

---- task 12 ----

drop table NewTable;

create table NewTable(
    num number(20) primary key,
    str nvarchar2(50) not null
);

begin
    for i in 1..10
        loop
            insert into NewTable values(i, concat('str', i));
        end loop;
end;

--drop trigger prohibits_drop_table
create or replace trigger prohibits_drop_table
before drop
on U1_VYR_PDB.schema
begin
    if DICTIONARY_OBJ_NAME = 'NEWTABLE' then
        raise_application_error(-20000, 'Sorry, you cant to drop the table');
    end if;
end;

---- task 13 ----

drop table AUDITS;

---- task 14 ----

--drop view NewTable_view;
create or replace view NewTable_view
as select * from NewTable;

create or replace trigger insted_of_insert
instead of insert
on NewTable_view
begin
    if inserting then
        dbms_output.put_line('insted_of_insert');
        insert into NewTable values (20, 'str20');
    end if;
end insted_of_insert;

insert into NewTable_view values(15, 'str15');

select * from NewTable_view;


