---- 1 task ----

declare
    v_dummy number;
begin
    null;
end;

---- 2 task ----

begin
    dbms_output.put_line('Hello, world');
end;

---- 3 task ----

declare
    v_number number(5, 2);
begin
    v_number := 10 / 0;
exception
    when ZERO_DIVIDE then
        dbms_output.put_line(sqlerrm(sqlcode));
        dbms_output.put_line('Код ошибки: ' || sqlcode);
end;

---- task 4 ----

declare
    x number(3) := 10;
    y number(3) := 0;
    z number(5, 2);
begin
    dbms_output.put_line('x = ' ||  x  ||  ', y = ' || y);
    begin
        z := x / y;
    exception
        when others
            then dbms_output.put_line(sqlerrm(sqlcode));
                 dbms_output.put_line('Код ошибки: ' || sqlcode);
    end;
    dbms_output.put_line('z = ' || z);
exception
        when others
            then dbms_output.put_line('ошибка');
end;


---- task 5 ----

--show parameter plsql_warnings;
select name, value from v$parameter
where name = 'plsql_warnings';
--alter system set plsql_warnings='ENABLE:INFORMATIONAL';

---- task 6 ----

select keyword from v$reserved_words
where length = 1;

---- task 7 ----

select keyword from v$reserved_words
where length > 1;

---- task 8 ----

select name, value from v$parameter
where name like 'plsql%';
--show parameter plsql;

----- task 9-17 ----

declare
    num1       number(3)      := 12;
    num2       number(3)      := 5;
    diff_num   number(3);
    mult_num   number(5);
    dev_num    number(5, 2);
    fixed_num  number(10, 2)  := 7.92;
    r_num      number(7, -4)  := 123456.99;
    bf_var     binary_float   := 123456789.123456789;
    bd_var     binary_double  := 123456789.123456789;
    e_num      number(38, 10) := 4321E+10;
    bool_var   boolean        := true;
begin
    diff_num := num1 - num2;
    mult_num := num1 * num2;
    dev_num := mod(num1, num2);

    dbms_output.put_line('num1 = ' || num1 || ' num2 = ' || num2);
    dbms_output.put_line('diff: ' || diff_num);
    dbms_output.put_line('mult: ' || mult_num);
    dbms_output.put_line('remains: ' || dev_num);
    dbms_output.put_line('fixed_num: ' || fixed_num);
    dbms_output.put_line('r_num: ' || r_num);
    dbms_output.put_line('bf_var: ' || bf_var);
    dbms_output.put_line('bd_var: ' || bd_var);
    dbms_output.put_line('e_num: ' || e_num);
    if bool_var
    then
        dbms_output.put_line('bool_var: true');
    end if;
    
end;

---- task 18 ----

declare
    num_c       constant number       := 34;
    varchar2_c  constant varchar2(10) := 'Varchar2';
    char_c      constant char(5)      := 'Char';
    res         number(10);
begin
    res := num_c * num_c - num_c;
    dbms_output.put_line(num_c);
    dbms_output.put_line(varchar2_c);
    dbms_output.put_line(char_c);
    dbms_output.put_line('res of num_c * num_c - num_c ' || res || ' - ' ||  varchar2_c);
exception
    when others
        then dbms_output.put_line('error = ' || sqlerrm);
end;

---- task 19 ----

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

---- task 20 ----

select * from teacher;

declare
    teacher_row TEACHER%ROWTYPE;
begin
    select * into teacher_row
    from TEACHER
    where TEACHER.TEACHER = 'СМЛВ';

    dbms_output.put_line('Teacher: ' || teacher_row.TEACHER);
    dbms_output.put_line('Teacher_name: ' || teacher_row.TEACHER_NAME);
    dbms_output.put_line('Pulpit: ' || teacher_row.PULPIT);
    dbms_output.put_line('Pulpit_name: ' || teacher_row.PULPIT_NAME);

exception
    when NO_DATA_FOUND then
        dbms_output.put_line('Такого преподавателя нет');
    when others then
        dbms_output.put_line(sqlerrm(sqlcode));
end;

---- task 21-22 -----

declare
    capasity AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
begin
    select AUDITORIUM_CAPACITY into capasity
    from AUDITORIUM
    where AUDITORIUM = '324-1';
    if capasity < 50 then
        dbms_output.put_line('вместительность меньше 50');
    elsif capasity > 50 then
        dbms_output.put_line('вместительность больше 50');
    else
        dbms_output.put_line('вместительность равна 50');
    end if;
end;

---- task 23 ----

declare
    capasity AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
begin
    select AUDITORIUM_CAPACITY into capasity
    from AUDITORIUM
    where AUDITORIUM = '324-1';
    case
        when capasity between 10 and 30 then dbms_output.put_line('вместительность от 10 до 30');
        when capasity between 31 and 60 then dbms_output.put_line('вместительность от 31 до 60');
        else dbms_output.put_line('вместительность слишком большая');
        end case;
end;

---- task 24 ----

declare 
    counter number(3) := 0;
begin
    loop
        counter := counter + 1;
        dbms_output.put_line('counter = ' || counter);
        
        exit when counter = 10;
    end loop;
end;

---- task 25 ----

declare 
    counter number(3) := 0;
begin
    while counter < 10 loop
        counter := counter + 1;
        dbms_output.put_line('counter = ' || counter);
    end loop;
end;

---- task 26 ----

begin
    for counter in 1..10 loop
        dbms_output.put_line('counter = ' || counter);
    end loop;
end;
