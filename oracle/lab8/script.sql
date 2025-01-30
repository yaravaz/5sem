drop table AUDITORIUM_TYPE;
drop table AUDITORIUM;
drop table FACULTY;
drop table PULPIT;
drop table TEACHER;
drop table SUBJECT;

---- AUDITORIUM_TYPE ----

create table AUDITORIUM_TYPE (
    AUDITORIUM_TYPE      char(10)        constraint AUDITORIUM_TYPE_PK primary key,
    AUDITORIUM_TYPENAME  varchar2(100)   constraint AUDITORIUM_TYPENAME_NOT_NULL not null
);

--truncate table AUDITORIUM_TYPE;
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('��',   '����������');
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('��-�', '������������ �����');
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('��-�', '���������� � ���. ������������');
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('��-X', '���������� �����������');
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('��-��','����. ������������ �����');

---- AUDITORIUM ---

create table AUDITORIUM (
    AUDITORIUM          char(10) primary key, 
    AUDITORIUM_NAME     varchar2(200),        
    AUDITORIUM_CAPACITY number(4),           
    AUDITORIUM_TYPE     char(10) not null,
    constraint AUDITORIUM_TYPE_FK foreign key(AUDITORIUM_TYPE) references AUDITORIUM_TYPE (AUDITORIUM_TYPE)
);

--truncate table AUDITORIUM;
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('206-1', '206-1', '��-�', 15);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('301-1', '301-1', '��-�', 15);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('236-1', '236-1', '��',   60);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('313-1', '313-1', '��',   60);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('324-1', '324-1', '��',   50);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('413-1', '413-1', '��-�', 15);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('423-1', '423-1', '��-�', 90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('408-2', '408-2', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('103-4', '103-4', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('105-4', '105-4', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('107-4', '107-4', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('110-4', '110-4', '��',   30);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('111-4', '111-4', '��',   30);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('114-4', '114-4', '��-�', 90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('132-4', '132-4', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('02�-4', '02�-4', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('229-4', '229-4', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('304-4', '304-4', '��-�', 90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('314-4', '314-4', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('320-4', '320-4', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('429-4', '429-4', '��',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('311-1', '311-1', '��',   90);

---- FACULTY ----

create table FACULTY (
    FACULTY      char(10) not null constraint PK_FACULTY primary key,
    FACULTY_NAME varchar2(100)
);

--truncate table FACULTY;
insert into FACULTY (FACULTY, FACULTY_NAME) values ('����', '����������� ���� � ����������');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('����', '���������� ���������� � �������');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('���',  '����������������� ���������');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('���',  '���������-������������� ���������');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('����', '���������� � ������� ������ ��������������');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('���',  '���������� ������������ �������');

---- PULPIT ----

create table PULPIT (
    PULPIT      char(20) not null,
    PULPIT_NAME varchar2(160),
    FACULTY     char(10) not null,
    constraint FK_PULPIT_FACULTY foreign key(FACULTY) references FACULTY (FACULTY),
    constraint PK_PULPIT primary key (PULPIT, PULPIT_NAME)
);

--truncate table PULPIT;
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('����',    '�������������� ������ � ���������� ', '����');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('������',  '���������������� ������������ � ������ ��������� ���������� ', '����');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('��',      '�����������', '���');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('��',      '������������', '���');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('��',      '��������������', '���');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('�����',   '���������� � ����������������', '���');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('������',  '������������ �������������� � ������-��������� �������������', '���');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('��',      '���������� ����', '����');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('�����',   '������ ����� � ���������� �������������', '����');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('��',      '������������ �����', '���');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('��������','���������� ���������������� ������� � ����������� ���������� ����������', '���');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('�������', '���������� �������������� ������� � ����� ���������� ���������� ', '����');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('��������','�����, ���������� ����������������� ����������� � ���������� ����������� �������', '����');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('����',    '������������� ������ � ����������', '���');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('����',    '����������� � ��������� ������������������', '���');

---- TEACHER ----

create table TEACHER (
    TEACHER      char(20) not null,
    TEACHER_NAME varchar2(100),
    PULPIT       char(20) not null,
    PULPIT_NAME  varchar2(160),
    constraint PK_TEACHER primary key (TEACHER),
    constraint FK_TEACHER_PULPIT foreign key (PULPIT, PULPIT_NAME) references PULPIT(PULPIT, PULPIT_NAME)
);

--truncate table TEACHER;
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('����',   '������ �������� �������������',     '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('�����',  '�������� ��������� ��������',       '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('�����',  '���������� ������ ����������',      '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('����',   '������ ���� �����������',           '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('����',   '������� �������� ��������',         '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('�����',  '�������� ������ ���������',         '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('���',    '����� ��������� ����������',        '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('���',    '������� ��������� �����������',     '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('���',    '��������� ����� ��������',          '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('����',   '��������� ������� ����������',      '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('������', '����������� ������� ����������',    '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('?',      '�����������',                       '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('���',    '����� ������� ��������',            '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('���',    '����� ������� �������������',       '����',     '�������������� ������ � ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('������', '���������� ��������� �������������','������',   '���������������� ������������ � ������ ��������� ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('�����',  '������� ������ ����������',         '������',   '���������������� ������������ � ������ ��������� ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('������', '����������� ��������� ��������',    '����',     '������������� ������ � ����������');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('����',   '������� ��������� ����������',      '����',     '����������� � ��������� ������������������');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('����',   '������ ������ ��������',            '��',       '������������');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('����',   '������� ������ ����������',         '������',   '������������ �������������� � ������-��������� �������������');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('������', '���������� �������� ��������',      '��',       '��������������');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('���',    '������ ���������� ������������',    '��',       '�����������');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('�����',  '��������� �������� ���������',      '�����',    '���������� � ����������������');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('������', '���������� �������� ����������',    '��',       '������������ �����');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('������', '��������� ������� ���������',       '��������', '���������� ���������������� ������� � ����������� ���������� ����������');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('�����',  '�������� ������ ����������',        '��',       '���������� ����');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('���',    '����� ������ ��������',             '�����',    '������ ����� � ���������� �������������');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('����',   '������ ������� ���������',          '�������',  '���������� �������������� ������� � ����� ���������� ���������� ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('����',   '������� ���� ����������',           '��������', '�����, ���������� ����������������� ����������� � ���������� ����������� �������');

---- SUBJECT ----

create table SUBJECT (
    SUBJECT      char(20)      not null,
    SUBJECT_NAME varchar2(100) not null,
    PULPIT       char(20)      not null,
    PULPIT_NAME varchar2(160),
    constraint PK_SUBJECT primary key (SUBJECT),
    constraint FK_SUBJECT_PULPIT foreign key (PULPIT, PULPIT_NAME) references PULPIT (PULPIT, PULPIT_NAME)
);

--truncate table SUBJECT;
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('����',     '������� ���������� ������ ������',                  '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '���� ������',                                       '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('���',      '�������������� ����������',                         '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('����',     '������ �������������� � ����������������',          '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '������������� ������ � ������������ ��������',      '����',    '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('���',      '��������������� ������� ����������',                '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('����',     '������������� ������ ��������� ����������',         '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('���',      '�������������� �������������� ������',              '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '������������ ��������� ',                           '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('�����',    '��������������� ������, �������� � �������� �����', '������',  '���������������� ������������ � ������ ��������� ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('���',      '������������ �������������� �������',               '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('���',      '����������� ���������������� ������������',         '������',   '���������������� ������������ � ������ ��������� ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '���������� ���������',                              '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '�������������� ����������������',                   '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('����',     '���������� ������ ���',                             '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('���',      '��������-��������������� ����������������',         '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '��������� ������������������',                      '����',     '����������� � ��������� ������������������');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '������������� ������',                              '����',     '�������������� ������ � ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('������OO', '�������� ������ ������ � ���� � ���. ������.',      '��',       '������������');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('�������',  '������ ��������������� � ������������� ���������',  '������',   '������������ �������������� � ������-��������� �������������');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '���������� �������� ',                              '��',       '��������������');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '�����������',                                       '�����',    '���������� � ����������������');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('��',       '������������ �����',                                '��',       '������������ �����');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('���',      '���������� ��������� �������',                      '��������', '���������� ���������������� ������� � ����������� ���������� ����������');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('���',      '������ ��������� ����',                             '��',       '���������� ����');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('����',     '���������� � ������������ �������������',           '�����',    '������ ����� � ���������� �������������');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('����',     '���������� ���������� �������� ���������� ',        '�������',  '���������� �������������� ������� � ����� ���������� ���������� ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('���',      '���������� ������������',                           '��������', '�����, ���������� ����������������� ����������� � ���������� ����������� �������');















