---- task 1 ----
select * from teacher;
select * from faculty;

declare 
    procedure GET_TEACHERS(PCODE TEACHER.PULPIT%TYPE) is
    cursor GetTeachers is
        select teacher, teacher_name, pulpit from teacher where pulpit = PCODE;
    
    teacher_v teacher.teacher%type;
    teacher_name_v teacher.teacher_name%type;
    pulpit_v teacher.pulpit%type;
begin
    open GetTeachers;
    fetch GetTeachers into teacher_v, teacher_name_v, pulpit_v;
    while(GetTeachers%found) loop
        dbms_output.put_line(teacher_v || ' ' || teacher_name_v || ' ' || pulpit_v);
        fetch GetTeachers into teacher_v, teacher_name_v, pulpit_v;
    end loop;
    close GetTeachers;
end GET_TEACHERS;

begin
    GET_TEACHERS('ИСиТ');
end;

---- task 2 ----

declare 
    function GET_NUM_TEACHERS(PCODE TEACHER.PULPIT%TYPE) return number 
    is res number;
begin
    select count(*) into res from teacher where pulpit = PCODE;
    return res;
end GET_NUM_TEACHERS;

begin
    dbms_output.put_line(GET_NUM_TEACHERS('ИСиТ'));
end;

---- task 3 ----

--drop procedure GET_TEACHERS;

create or replace procedure GET_TEACHERS_F(FCODE FACULTY.FACULTY%TYPE) is
    cursor GetTeachers is
        select teacher, teacher_name, t.pulpit from teacher t join pulpit p on t.pulpit = p.pulpit where p.faculty = FCODE;
    
    teacher_v teacher.teacher%type;
    teacher_name_v teacher.teacher_name%type;
    pulpit_v teacher.pulpit%type;
begin
    open GetTeachers;
    fetch GetTeachers into teacher_v, teacher_name_v, pulpit_v;
    while(GetTeachers%found) loop
        dbms_output.put_line(teacher_v || ' ' || teacher_name_v || ' ' || pulpit_v);
        fetch GetTeachers into teacher_v, teacher_name_v, pulpit_v;
    end loop;
    close GetTeachers;
end GET_TEACHERS_F;

begin
    GET_TEACHERS_F('ИДиП');
end;

select * from Subject;

create or replace procedure GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) is
    cursor GetSubjects is
        select subject, subject_name, pulpit from subject where pulpit = PCODE;
    
    subject_v subject.subject%type;
    subject_name_v subject.subject_name%type;
    pulpit_v subject.pulpit%type;
begin
    open GetSubjects;
    fetch GetSubjects into subject_v, subject_name_v, pulpit_v;
    while(GetSubjects%found) loop
        dbms_output.put_line(subject_v || ' ' || subject_name_v || ' ' || pulpit_v);
        fetch GetSubjects into subject_v, subject_name_v, pulpit_v;
    end loop;
    close GetSubjects;
end GET_SUBJECTS;

begin
    GET_SUBJECTS('ИСиТ');
end;


---- task 4 ----

declare 
    function GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) return number 
    is res number;
begin
    select count(*) into res from teacher t join pulpit p on t.pulpit = p.pulpit where p.faculty = FCODE;
    return res;
end GET_NUM_TEACHERS;

begin
    dbms_output.put_line(GET_NUM_TEACHERS('ИДиП'));
end;

declare 
    function GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) return number 
    is res number;
begin
    select count(*) into res from subject where pulpit = PCODE;
    return res;
end GET_NUM_SUBJECTS;

begin
    dbms_output.put_line(GET_NUM_SUBJECTS('ИСиТ'));
end;

---- task 5 ----

create or replace package TEACHERS as
    FCODE FACULTY.FACULTY%type;
    PCODE SUBJECT.PULPIT%type;
    procedure PROC_GET_TEACHERS(FCODE FACULTY.FACULTY%type);
    procedure PROC_GET_SUBJECTS (PCODE SUBJECT.PULPIT%type);
    function FUNC_GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%type) return number;
    function FUNC_GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%type) return number;
end TEACHERS;

create or replace package body TEACHERS is
    procedure PROC_GET_TEACHERS(FCODE FACULTY.FACULTY%TYPE) is
    cursor GetTeachers is
        select teacher, teacher_name, t.pulpit from teacher t join pulpit p on t.pulpit = p.pulpit where p.faculty = FCODE;
    teacher_v teacher.teacher%type;
    teacher_name_v teacher.teacher_name%type;
    pulpit_v teacher.pulpit%type;
    begin
        open GetTeachers;
        fetch GetTeachers into teacher_v, teacher_name_v, pulpit_v;
        while(GetTeachers%found) loop
            dbms_output.put_line(teacher_v || ' ' || teacher_name_v || ' ' || pulpit_v);
            fetch GetTeachers into teacher_v, teacher_name_v, pulpit_v;
        end loop;
        close GetTeachers;
    end PROC_GET_TEACHERS;
    
    procedure PROC_GET_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) is
    cursor GetSubjects is
        select subject, subject_name, pulpit from subject where pulpit = PCODE;
    subject_v subject.subject%type;
    subject_name_v subject.subject_name%type;
    pulpit_v subject.pulpit%type;
    begin
        open GetSubjects;
        fetch GetSubjects into subject_v, subject_name_v, pulpit_v;
        while(GetSubjects%found) loop
            dbms_output.put_line(subject_v || ' ' || subject_name_v || ' ' || pulpit_v);
            fetch GetSubjects into subject_v, subject_name_v, pulpit_v;
        end loop;
        close GetSubjects;
    end PROC_GET_SUBJECTS;

    function FUNC_GET_NUM_TEACHERS(FCODE FACULTY.FACULTY%TYPE) return number 
    is res number;
    begin
        select count(*) into res from teacher t join pulpit p on t.pulpit = p.pulpit where p.faculty = FCODE;
        return res;
    end FUNC_GET_NUM_TEACHERS;
    
    function FUNC_GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT%TYPE) return number 
    is res number;
    begin
        select count(*) into res from subject where pulpit = PCODE;
        return res;
    end FUNC_GET_NUM_SUBJECTS;

begin
    null;
end TEACHERS;

---- task 6 ----

begin
    dbms_output.put_line('Преподаватели на факультете ИДиП: ');
    TEACHERS.PROC_GET_TEACHERS('ИДиП');
    dbms_output.put_line('');
    dbms_output.put_line('Предметы на кафедре ИСиТ: ');
    TEACHERS.PROC_GET_SUBJECTS('ИСиТ');
    dbms_output.put_line('');
    dbms_output.put_line('Кол-во преподавателей на факультете ИДиП: ' || TEACHERS.FUNC_GET_NUM_TEACHERS('ИДиП'));
    dbms_output.put_line('Кол-во предметов на кафедре ИСиТ: ' || TEACHERS.FUNC_GET_NUM_SUBJECTS('ИСиТ'));
end;