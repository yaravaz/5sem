---- task 1 ----

declare 
    teacher_val TEACHER.TEACHER%TYPE;
    teacher_name_val TEACHER.TEACHER_NAME%TYPE;
begin
    select TEACHER, TEACHER_NAME into teacher_val, teacher_name_val
    from TEACHER
    where TEACHER.TEACHER = 'СМЛВ';

    dbms_output.put_line('Преподаватель: ' || teacher_val || teacher_name_val);
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('Такого преподавателя нет');
    when others then
        dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 2 ----

select * from teacher;

declare
    teacher_row TEACHER%ROWTYPE;
begin
    select * into teacher_row from TEACHER;

    dbms_output.put_line('Teacher: ' || teacher_row.TEACHER);
    dbms_output.put_line('Teacher_name: ' || teacher_row.TEACHER_NAME);
    dbms_output.put_line('Pulpit: ' || teacher_row.PULPIT);
    dbms_output.put_line('Pulpit_name: ' || teacher_row.PULPIT_NAME);

exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 3 ----

declare
    teacher_row TEACHER%ROWTYPE;
begin
    select * into teacher_row from TEACHER;

    dbms_output.put_line('Teacher: ' || teacher_row.TEACHER);

exception
    when TOO_MANY_ROWS then
        dbms_output.put_line('Слишком много строк');
    when others then
        dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 4 ----

declare
    teacher_row TEACHER%ROWTYPE;
begin
    select * into teacher_row 
    from TEACHER
    where TEACHER = 'XXX';

    dbms_output.put_line('Teacher: ' || teacher_row.TEACHER);
    dbms_output.put_line('Teacher_name: ' || teacher_row.TEACHER_NAME);
    dbms_output.put_line('Pulpit: ' || teacher_row.PULPIT);
    dbms_output.put_line('Pulpit_name: ' || teacher_row.PULPIT_NAME);

exception
    when NO_DATA_FOUND then
        dbms_output.put_line('Такого преподавателя нет');
end;

select * from TEACHER where TEACHER = 'СМЛВ';

begin

    if sql%isopen then
        dbms_output.put_line('cursor is open');
    else
        dbms_output.put_line('cursor is not open');
    end if;

    delete TEACHER where TEACHER = 'XXX';
    if sql%found then
        dbms_output.put_line('there is foundf');
    else
        dbms_output.put_line('there is not foundf');
    end if;
    if sql%notfound then
        dbms_output.put_line('there is not foundf');
    else
        dbms_output.put_line('there is foundf');
    end if;  

    dbms_output.put_line('%rowcount:  ' || sql%rowcount);
    
    insert into TEACHER values('XXX', 'qwerty1', 'ИСиТ', 'Информационных систем и технологий ');

end;

---- task 5 ----

declare
    teach TEACHER%ROWTYPE;
begin
    select * into teach from TEACHER where TEACHER.TEACHER = 'XXX';
    
    dbms_output.put_line('До преобразований: ');
    dbms_output.put_line('ФИО: ' || teach.TEACHER_NAME);
    commit;
    
    update TEACHER set TEACHER_NAME='qwerty2' where TEACHER = 'XXX';
    rollback;
    select * into teach from TEACHER where TEACHER.TEACHER = 'XXX';
    dbms_output.put_line('После rollback: ');
    dbms_output.put_line('ФИО: ' || teach.TEACHER_NAME);
    
    update TEACHER set TEACHER_NAME='qwerty2' where TEACHER = 'XXX';
    commit;
    select * into teach from TEACHER where TEACHER.TEACHER = 'XXX';
    dbms_output.put_line('После commit: ');
    dbms_output.put_line('ФИО: ' || teach.TEACHER_NAME);
    
    update TEACHER set TEACHER_NAME='qwerty1' where TEACHER = 'XXX';
    commit;
end;

---- task 6 ----

begin 
    update TEACHER set teacher.pulpit = 'qwerty' where TEACHER = 'XXX';
    
exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode)); 
end;

---- task 7 ----

select * from TEACHER where TEACHER.TEACHER = 'XXX';

declare
    teach TEACHER%ROWTYPE;
begin    
    delete TEACHER where TEACHER.TEACHER = 'XXX';
    commit;
    insert into TEACHER values('XXX', 'qwerty1', 'ИСиТ', 'Информационных систем и технологий ');
    commit;
    select * into teach from TEACHER where TEACHER.TEACHER = 'XXX';
    dbms_output.put_line('После commit: ');
    dbms_output.put_line('ФИО: ' || teach.TEACHER_NAME);
    
    delete TEACHER where TEACHER.TEACHER = 'XXX';
    commit;
    insert into TEACHER values('XXX', 'qwerty1', 'ИСиТ', 'Информационных систем и технологий ');
    rollback;
    select * into teach from TEACHER where TEACHER.TEACHER = 'XXX';
    dbms_output.put_line('После rollback: ');
    dbms_output.put_line('ФИО: ' || teach.TEACHER_NAME);
exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode)); 
end;

insert into TEACHER values('XXX', 'qwerty1', 'ИСиТ', 'Информационных систем и технологий ');
commit;

---- task 8 ----

begin 
    insert into TEACHER values('XXX1', 'qwerty1', 'ИСиТdfg', 'Информационных систем и технологий ');
    
exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode)); 
end;

---- task 9 ----

declare
    teach TEACHER%ROWTYPE;
begin    
    delete TEACHER where TEACHER.TEACHER = 'XXX';
    rollback;
    select * into teach from TEACHER where TEACHER.TEACHER = 'XXX';
    dbms_output.put_line('После rollback: ');
    dbms_output.put_line('ФИО: ' || teach.TEACHER_NAME);
    
    delete TEACHER where TEACHER.TEACHER = 'XXX';
    commit;
    select * into teach from TEACHER where TEACHER.TEACHER = 'XXX';
    dbms_output.put_line('После commit: ');
    dbms_output.put_line('ФИО: ' || teach.TEACHER_NAME);
exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode)); 
end;

insert into TEACHER values('XXX', 'qwerty1', 'ИСиТ', 'Информационных систем и технологий ');
commit;

---- task 10 ----

begin 
    delete PULPIT where PULPIT.PULPIT = 'ИСиТ';
    
exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode)); 
end;

---- task 11 ----

select * from teacher;

declare
    cursor curs is select TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME from TEACHER;
    tech TEACHER.TEACHER%TYPE;
    tech_name TEACHER.TEACHER_NAME%TYPE;
    pulp TEACHER.PULPIT%TYPE;
    pulp_name TEACHER.PULPIT_NAME%TYPE;
begin
    open curs;
    loop
        fetch curs into tech, tech_name, pulp, pulp_name;
        exit when curs%notfound;
        dbms_output.put_line(tech || ' ' || tech_name || ' ' || pulp || ' ' || pulp_name || ';');
    end loop;
    close curs;
exception
    when others then
        dbms_output.put_line(sqlerrm);
end;

---- task 12 ----

select * from subject;

declare 
    cursor curs is select * from SUBJECT;
    rec SUBJECT%ROWTYPE;
begin
    open curs;
    fetch curs into rec;
    while(curs%found)
        loop
            dbms_output.put_line(rec.subject || ' ' || rec.subject_name || ' ' || rec.pulpit || ' ' || rec.pulpit_name || ';');
            fetch curs into rec;
        end loop;
    close curs;
exception 
    when others then
        dbms_output.put_line(sqlerrm);
end;

---- task 13 ----

declare
    cursor curs is select pulpit.pulpit, teacher.teacher_name
                          from pulpit join teacher on pulpit.pulpit = teacher.pulpit;
    rec curs%rowtype;
begin
    for rec in curs
        loop
            dbms_output.put_line(rec.pulpit || ' ' || rec.teacher_name);
        end loop;
exception
    when others then
        dbms_output.put_line(sqlerrm);
end;

---- task 14 ----

select * from auditorium;

declare
    cursor curs (capacity_from auditorium.auditorium_capacity%type, capacity_to auditorium.auditorium_capacity%type)
        is select auditorium, auditorium_name, auditorium_capacity, auditorium_type from auditorium
           where auditorium_capacity >= capacity_from
             and auditorium_capacity <= capacity_to;
    rec curs%rowtype;
begin

    dbms_output.put_line('<21 :');
    open curs(0, 20);
    fetch curs into rec;
    loop
        dbms_output.put_line(rec.auditorium || ' ' || rec.auditorium_name || ' ' || rec.auditorium_capacity || ' ' || rec.auditorium_type || ';');
        fetch curs into rec;
        exit when curs%notfound;
    end loop;
    close curs;
    
    dbms_output.put_line('21-30 :');
    open curs(21, 30);
    fetch curs into rec;
    while curs%found
        loop
            dbms_output.put_line(rec.auditorium || ' ' || rec.auditorium_name || ' ' || rec.auditorium_capacity || ' ' || rec.auditorium_type || ';');
            fetch curs into rec;
        end loop;
    close curs;

    dbms_output.put_line('31-60 :');
    for auditorium in curs(31, 60)
        loop
            dbms_output.put_line(auditorium.auditorium || ' ' || auditorium.auditorium_name || ' ' || auditorium.auditorium_capacity || ' ' || auditorium.auditorium_type || ';');
        end loop;

    dbms_output.put_line('61-80 :');
    for auditorium in curs(61, 80)
        loop
            dbms_output.put_line(auditorium.auditorium || ' ' || auditorium.auditorium_name || ' ' || auditorium.auditorium_capacity || ' ' || auditorium.auditorium_type || ';');
        end loop;

    
    dbms_output.put_line('81< :');
    for auditorium in curs(81, 1000)
        loop
            dbms_output.put_line(auditorium.auditorium || ' ' || auditorium.auditorium_name || ' ' || auditorium.auditorium_capacity || ' ' || auditorium.auditorium_type || ';');
        end loop;
        
   
exception
    when others
        then dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 15 ----

declare
    type curs_ref is ref cursor return auditorium%rowtype;
    curs curs_ref;
    curs_row curs%rowtype;
begin
    open curs for select * from auditorium;
    fetch curs into curs_row;
    loop
        exit when curs%notfound;
        dbms_output.put_line(curs_row.auditorium || ' ' || curs_row.auditorium_name || ' ' || curs_row.auditorium_capacity || ' ' || curs_row.auditorium_type || ';');
        fetch curs into curs_row;
    end loop;
    close curs;

exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 16 ----

declare
    cursor curs is
        select pulpit, cursor
                   (select teacher
                    from teacher teach
                    where teach.pulpit = pulp.pulpit)
        from pulpit pulp;
    curs_teacher sys_refcursor;
    teach teacher.teacher_name%type;
    pulp pulpit.pulpit%type;
    list varchar2(500);
begin
    open curs;
    fetch curs into pulp, curs_teacher;
    while(curs%found)
        loop
            list := rtrim(pulp) || ': ';
            loop
                fetch curs_teacher into teach;
                exit when curs_teacher%notfound;
                list := list || teach ||  ', ';
            end loop;

            dbms_output.put_line(list);
            fetch curs into pulp, curs_teacher;
        end loop;

    close curs;
exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 17 ----

select * from auditorium order by auditorium;

declare
    cursor curs_auditorium(capacity1 auditorium.auditorium%type, capacity2 auditorium.auditorium%type) is
        select auditorium, auditorium_capacity
        from auditorium
        where auditorium_capacity >= capacity1 and auditorium_capacity <= capacity2
        for update;
    aud auditorium.auditorium%type;
    capasity auditorium.auditorium_capacity%type;
begin
    open curs_auditorium(40, 80);
    fetch curs_auditorium into aud, capasity;

    while(curs_auditorium%found)
        loop
            capasity := capasity * 0.9;
            update auditorium set auditorium_capacity = capasity where current of curs_auditorium;
            dbms_output.put_line(' ' || aud || ' ' || capasity);
            fetch curs_auditorium into aud, capasity;
        end loop;

    close curs_auditorium;
    rollback;
exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 18 ----

select count(*) from auditorium;

declare
    cursor curs_auditorium(capacity1 auditorium.auditorium%type, capacity2 auditorium.auditorium%type) is
        select auditorium, auditorium_capacity
        from auditorium
        where auditorium_capacity >= capacity1 and auditorium_capacity <= capacity2
        for update;
    aud auditorium.auditorium%type;
    capacity auditorium.auditorium_capacity%type;
    c number(3) := 0;
begin
    open curs_auditorium(0, 20);
    fetch curs_auditorium into aud, capacity;

    while(curs_auditorium%found)
        loop
            capacity := capacity * 0.9;
            delete auditorium where current of curs_auditorium;
            fetch curs_auditorium into aud, capacity;
        end loop;
    close curs_auditorium;
    open curs_auditorium(0, 90);
        
    loop
        fetch curs_auditorium into aud, capacity;
        exit when curs_auditorium%NOTFOUND;
        c := c + 1;
    end loop;
        
    dbms_output.put_line(c);
    close curs_auditorium;
    rollback;
exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 19 ----

select * from teacher;
insert into TEACHER values('XXX', 'qwerty1', 'ИСиТ', 'Информационных систем и технологий ');
commit;

declare
    row_value rowid;
    teach TEACHER.TEACHER_NAME%TYPE;
begin
    select rowid into row_value from teacher where teacher = 'XXX';
    select teacher_name into teach from teacher where teacher = 'XXX';
    dbms_output.put_line('до update: ' || teach);

    update teacher set teacher_name = 'qwerty33' where rowid = row_value;
    select teacher_name into teach from teacher where teacher = 'XXX';
    dbms_output.put_line('после update: ' || teach);
    
    dbms_output.put_line('до delete: ' || teach);
    delete from teacher where rowid = row_value;

    select teacher_name into teach from teacher where teacher = 'XXX';
    
exception
    when others then
        dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 20 ----

declare
    cursor curs is select * from teacher;
    teach teacher%rowtype;
begin
    open curs;
    loop
        fetch curs into teach;
        exit when curs%notfound;
        dbms_output.put_line(teach.teacher || ' ' || teach.teacher_name || ' ' || teach.pulpit || ' ' || teach.pulpit_name);
        if (mod(curs%rowcount, 3) = 0) then
            dbms_output.put_line('-----------------------');
        end if;
    end loop;
    close curs;
exception
    when others
        then dbms_output.put_line(sqlerrm(sqlcode));
end;





