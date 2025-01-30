alter session set nls_date_format = 'DD-MM-YYYY';

---- task 1 ----

select * from TEACHER;

alter table TEACHER add BIRTHDAY date;
alter table TEACHER add SALARY number;

declare 
    cursor curs is select teacher, birthday, salary from teacher for update;
    v_row_count NUMBER := 0;
    v_start_date date := TO_DATE('01-01-1970', 'DD-MM-YYYY');
    v_salary_to_add number := 1500;
begin
    for rec in (select rowid from teacher) 
        loop
            v_row_count := v_row_count + 1;
            update teacher set birthday = add_months(v_start_date, (v_row_count - 1) * 13)
            where ROWID = rec.ROWID;
            update teacher set salary = v_row_count*10 + v_salary_to_add where ROWID = rec.ROWID;
        end loop;

        commit;
exception
    when others then
        rollback;
end;

---- task 2 ----
 
select concat(regexp_substr(teacher_name, '(\S+)(\s)', 1, 1), 
       concat(substr(regexp_substr(teacher_name, '(\S+)', 1, 2), 1, 1)|| '. ', substr(regexp_substr(teacher_name, '(\S+)', 1, 3), 1, 1) || '. ')) as ФИО
from teacher;

---- task 3 ----

select * from teacher where to_char(birthday, 'D') = 2;

---- task 4 ----

--drop view born_next_month

create or replace view born_next_month as
select * from teacher
where to_char(birthday, 'mm') = extract(month from add_months(sysdate, 1));

select * from born_next_month;

---- task 5 ----

--drop view number_months
create or replace view teachs_months as
select to_char(birthday, 'Mon') as Mon, count(*) as Count from teacher
group by to_char(birthday, 'Mon')
order by Count;

select * from teachs_months;

---- task 5 ----

declare
    cursor curs return teacher%rowtype is
        select * from teacher where mod((to_char(sysdate, 'yyyy') - to_char(birthday, 'yyyy') + 1), 5) = 0;
    teacher_row TEACHER%rowtype;
begin
    dbms_output.put_line('Юбилей в следующем году у');
    open curs;
    fetch curs into teacher_row;
    while (curs%found)
        loop
            dbms_output.put_line(teacher_row.teacher);
            fetch curs into teacher_row;
        end loop;

    close curs;
end;

---- task 7 ----

declare
    cursor avg_salary_by_pulpit is
        select pulpit, floor(avg(salary)) as avg_salary from TEACHER group by pulpit;
    cursor avg_salary_by_faculty is
        select faculty, avg(salary) from teacher join pulpit p on teacher.pulpit = p.pulpit group by faculty;
    cursor avg_salary_by_faculties is
        select avg(salary) from teacher;
    pulpit_v TEACHER.PULPIT%type;
    salary_v TEACHER.SALARY%type;
    faculty_v PULPIT.FACULTY%type;
begin

    dbms_output.put_line('pulpit: ');
    open avg_salary_by_pulpit;
    fetch avg_salary_by_pulpit into pulpit_v, salary_v;

    while (avg_salary_by_pulpit%found)
        loop
            dbms_output.put_line(pulpit_v || salary_v);
            fetch avg_salary_by_pulpit into pulpit_v, salary_v;
        end loop;
    close avg_salary_by_pulpit;

    dbms_output.put_line('faculty: ');
    open avg_salary_by_faculty;
    fetch avg_salary_by_faculty into faculty_v, salary_v;

    while (avg_salary_by_faculty%found)
        loop
            dbms_output.put_line(faculty_v || salary_v);
            fetch avg_salary_by_faculty into faculty_v, salary_v;
        end loop;
    close avg_salary_by_faculty;

    dbms_output.put_line('faculties: ');
    open avg_salary_by_faculties;
    fetch avg_salary_by_faculties into salary_v;
    dbms_output.put_line(salary_v);
    close avg_salary_by_faculties;
end;

---- task 8 ----

declare
    type AuthorType is record 
    (
        Name nvarchar2(60),
        Hometown nvarchar2(50)
    );
    type BookType is record 
    (
        Title nvarchar2(100),
        Price number,
        Genre nvarchar2(30),
        Author AuthorType
    );
    author AuthorType;
    book BookType;

begin
    author := AuthorType('Луиза Мэй Олкотт', 'Джермантаун');
    book := BookType('Маленькие женщины', 10.56, 'Роман воспитания', author);

    dbms_output.put_line(book.Title || ' (' || book.Genre || ') ' || ': ' || book.Price || '   ' || book.author.Name || '— ' || book.author.Hometown);
end;