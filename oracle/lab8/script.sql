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
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('ЛК',   'Лекционная');
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('ЛБ-К', 'Компьютерный класс');
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('ЛК-К', 'Лекционная с уст. компьютерами');
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('ЛБ-X', 'Химическая лаборатория');
insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values ('ЛБ-СК','Спец. компьютерный класс');

---- AUDITORIUM ---

create table AUDITORIUM (
    AUDITORIUM          char(10) primary key, 
    AUDITORIUM_NAME     varchar2(200),        
    AUDITORIUM_CAPACITY number(4),           
    AUDITORIUM_TYPE     char(10) not null,
    constraint AUDITORIUM_TYPE_FK foreign key(AUDITORIUM_TYPE) references AUDITORIUM_TYPE (AUDITORIUM_TYPE)
);

--truncate table AUDITORIUM;
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('206-1', '206-1', 'ЛБ-К', 15);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('301-1', '301-1', 'ЛБ-К', 15);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('236-1', '236-1', 'ЛК',   60);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('313-1', '313-1', 'ЛК',   60);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('324-1', '324-1', 'ЛК',   50);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('413-1', '413-1', 'ЛБ-К', 15);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('423-1', '423-1', 'ЛБ-К', 90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('408-2', '408-2', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('103-4', '103-4', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('105-4', '105-4', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('107-4', '107-4', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('110-4', '110-4', 'ЛК',   30);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('111-4', '111-4', 'ЛК',   30);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('114-4', '114-4', 'ЛК-К', 90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('132-4', '132-4', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('02Б-4', '02Б-4', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('229-4', '229-4', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('304-4', '304-4', 'ЛБ-К', 90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('314-4', '314-4', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('320-4', '320-4', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('429-4', '429-4', 'ЛК',   90);
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) values ('311-1', '311-1', 'ЛК',   90);

---- FACULTY ----

create table FACULTY (
    FACULTY      char(10) not null constraint PK_FACULTY primary key,
    FACULTY_NAME varchar2(100)
);

--truncate table FACULTY;
insert into FACULTY (FACULTY, FACULTY_NAME) values ('ИДиП', 'Издателькое дело и полиграфия');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('ХТиТ', 'Химическая технология и техника');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('ЛХФ',  'Лесохозяйственный факультет');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('ИЭФ',  'Инженерно-экономический факультет');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('ТТЛП', 'Технология и техника лесной промышленности');
insert into FACULTY (FACULTY, FACULTY_NAME) values ('ТОВ',  'Технология органических веществ');

---- PULPIT ----

create table PULPIT (
    PULPIT      char(20) not null,
    PULPIT_NAME varchar2(160),
    FACULTY     char(10) not null,
    constraint FK_PULPIT_FACULTY foreign key(FACULTY) references FACULTY (FACULTY),
    constraint PK_PULPIT primary key (PULPIT, PULPIT_NAME)
);

--truncate table PULPIT;
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ИСиТ',    'Информационных систем и технологий ', 'ИДиП');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ПОиСОИ',  'Полиграфического оборудования и систем обработки информации ', 'ИДиП');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ЛВ',      'Лесоводства', 'ЛХФ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ОВ',      'Охотоведения', 'ЛХФ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ЛУ',      'Лесоустройства', 'ЛХФ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ЛЗиДВ',   'Лесозащиты и древесиноведения', 'ЛХФ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ЛПиСПС',  'Ландшафтного проектирования и садово-паркового строительства', 'ЛХФ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ТЛ',      'Транспорта леса', 'ТТЛП');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ЛМиЛЗ',   'Лесных машин и технологии лесозаготовок', 'ТТЛП');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ОХ',      'Органической химии', 'ТОВ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ТНХСиППМ','Технологии нефтехимического синтеза и переработки полимерных материалов', 'ТОВ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ТНВиОХТ', 'Технологии неорганических веществ и общей химической технологии ', 'ХТиТ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ХТЭПиМЭЕ','Химии, технологии электрохимических производств и материалов электронной техники', 'ХТиТ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('ЭТиМ',    'экономической теории и маркетинга', 'ИЭФ');
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY) values ('МиЭП',    'Менеджмента и экономики природопользования', 'ИЭФ');

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
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('СМЛВ',   'Смелов Владимир Владиславович',     'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('АКНВЧ',  'Акунович Станислав Иванович',       'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('КЛСНВ',  'Колесников Леонид Валерьевич',      'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ГРМН',   'Герман Олег Витольдович',           'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ЛЩНК',   'Лащенко Анатолий Пвалович',         'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('БРКВЧ',  'Бракович Андрей Игорьевич',         'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ДДК',    'Дедко Александр Аркадьевич',        'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('КБЛ',    'Кабайло Александр Серафимович',     'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('УРБ',    'Урбанович Павел Павлович',          'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('РМНК',   'Романенко Дмитрий Михайлович',      'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ПСТВЛВ', 'Пустовалова Наталия Николаевна',    'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('?',      'Неизвестный',                       'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ГРН',    'Гурин Николай Иванович',            'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ЖЛК',    'Жиляк Надежда Александровна',       'ИСиТ',     'Информационных систем и технологий ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('БРТШВЧ', 'Барташевич Святослав Александрович','ПОиСОИ',   'Полиграфического оборудования и систем обработки информации ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ЮДНКВ',  'Юденков Виктор Степанович',         'ПОиСОИ',   'Полиграфического оборудования и систем обработки информации ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('БРНВСК', 'Барановский Станислав Иванович',    'ЭТиМ',     'экономической теории и маркетинга');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('НВРВ',   'Неверов Александр Васильевич',      'МиЭП',     'Менеджмента и экономики природопользования');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('РВКЧ',   'Ровкач Андрей Иванович',            'ОВ',       'Охотоведения');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ДМДК',   'Демидко Марина Николаевна',         'ЛПиСПС',   'Ландшафтного проектирования и садово-паркового строительства');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('МШКВСК', 'Машковский Владимир Петрович',      'ЛУ',       'Лесоустройства');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ЛБХ',    'Лабоха Константин Валентинович',    'ЛВ',       'Лесоводства');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ЗВГЦВ',  'Звягинцев Вячеслав Борисович',      'ЛЗиДВ',    'Лесозащиты и древесиноведения');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('БЗБРДВ', 'Безбородов Владимир Степанович',    'ОХ',       'Органической химии');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ПРКПЧК', 'Прокопчук Николай Романович',       'ТНХСиППМ', 'Технологии нефтехимического синтеза и переработки полимерных материалов');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('НСКВЦ',  'Насковец Михаил Трофимович',        'ТЛ',       'Транспорта леса');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('МХВ',    'Мохов Сергей Петрович',             'ЛМиЛЗ',    'Лесных машин и технологии лесозаготовок');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ЕЩНК',   'Ещенко Людмила Семеновна',          'ТНВиОХТ',  'Технологии неорганических веществ и общей химической технологии ');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, PULPIT_NAME) values ('ЖРСК',   'Жарский Иван Михайлович',           'ХТЭПиМЭЕ', 'Химии, технологии электрохимических производств и материалов электронной техники');

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
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('СУБД',     'Системы управления базами данных',                  'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('БД',       'Базы данных',                                       'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ИНФ',      'Информацтонные технологии',                         'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ОАиП',     'Основы алгоритмизации и программирования',          'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ПЗ',       'Представление знаний в компьютерных системах',      'ИСиТ',    'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ПСП',      'Пограммирование сетевых приложений',                'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('МСОИ',     'Моделирование систем обработки информации',         'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ПИС',      'Проектирование информационных систем',              'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('КГ',       'Компьютерная геометрия ',                           'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ПМАПЛ',    'Полиграфические машины, автоматы и поточные линии', 'ПОиСОИ',  'Полиграфического оборудования и систем обработки информации ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('КМС',      'Компьютерные мультимедийные системы',               'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ОПП',      'Организация полиграфического производства',         'ПОиСОИ',   'Полиграфического оборудования и систем обработки информации ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ДМ',       'Дискретная матеатика',                              'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('МП',       'Математисеское программирование',                   'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ЛЭВМ',     'Логические основы ЭВМ',                             'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ООП',      'Объектно-ориентированное программирование',         'ИСиТ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ЭП',       'Экономика природопользования',                      'МиЭП',     'Менеджмента и экономики природопользования');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ЭТ',       'Экономическая теория',                              'ЭТиМ',     'Информационных систем и технологий ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('БЛЗиПсOO', 'Биология лесных зверей и птиц с осн. охотов.',      'ОВ',       'Охотоведения');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ОСПиЛПХ',  'Основы садовопаркового и лесопаркового хозяйства',  'ЛПиСПС',   'Ландшафтного проектирования и садово-паркового строительства');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ИГ',       'Инженерная геодезия ',                              'ЛУ',       'Лесоустройства');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ЛВ',       'Лесоводство',                                       'ЛЗиДВ',    'Лесозащиты и древесиноведения');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ОХ',       'Органическая химия',                                'ОХ',       'Органической химии');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ТРИ',      'Технология резиновых изделий',                      'ТНХСиППМ', 'Технологии нефтехимического синтеза и переработки полимерных материалов');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ВТЛ',      'Водный транспорт леса',                             'ТЛ',       'Транспорта леса');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ТиОЛ',     'Технология и оборудование лесозаготовок',           'ЛМиЛЗ',    'Лесных машин и технологии лесозаготовок');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ТОПИ',     'Технология обогащения полезных ископаемых ',        'ТНВиОХТ',  'Технологии неорганических веществ и общей химической технологии ');
insert into SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT, PULPIT_NAME) values ('ПЭХ',      'Прикладная электрохимия',                           'ХТЭПиМЭЕ', 'Химии, технологии электрохимических производств и материалов электронной техники');















