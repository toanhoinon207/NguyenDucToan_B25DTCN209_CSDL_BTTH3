create database edu_pro;
use edu_pro;

create table teachers(
    teacher_id int primary key auto_increment,
    full_name varchar(100) not null,
    salary decimal(10, 2) check (salary >= 0)
);

create table courses (
    course_id int primary key auto_increment,
    course_name varchar(100) not null,
    teacher_id int null,
    credits int check (credits > 0),
    tuition_fee decimal(10, 2) check (tuition_fee >= 0),
    foreign key (teacher_id) references teachers(teacher_id)
);

create table students(
    student_id int primary key auto_increment,
    full_name varchar(100) not null,
    dob date,
    gender enum('Male','Female','Other')
);

create table enrollments(
    id int primary key auto_increment,
    student_id int,
    course_id int,
    date date,
    score decimal(4, 2) null check (score between 0 and 10),
    foreign key (student_id) references students(student_id),
    foreign key (course_id) references courses(course_id)
);

insert into teachers(full_name, salary)
values
	('Nguyen Văn A - IT', 1000),
	('Trần Thị B - Marketing', 900),
	('Lê Văn C - IT', 1200);
    
insert into courses(course_name, teacher_id, credits, tuition_fee)
values
	('SQL Basics', 1, 3, 500),
	('Advanced Java', 1, 4, 800),
	('Digital Marketing', 2, 3, 600),
	('Data Structures', 3, 4, 700),
	('Web Development', 3, 3, 650),
	('Soft Skills', null, 2, 300);
    
insert into students(full_name, dob, gender)
values
	('student 1', '2000-01-01', 'Male'),
	('student 2', '2001-02-02', 'Female'),
	('student 3', '2000-03-03', 'Male'),
	('student 4', '2001-04-04', 'Female'),
	('student 5', '2000-05-05', 'Male'),
	('student 6', '2001-06-06', 'Female'),
	('student 7', '2000-07-07', 'Male'),
	('student 8', '2001-08-08', 'Female'),
	('student 9', '2000-09-09', 'Male'),
	('student 10', '2001-10-10', 'Female');
    
insert into enrollments(student_id, course_id, date, score)
values
	(1, 1, '2026-01-01', 8),
	(2, 1, '2026-01-01', 7),
	(3, 2, '2026-01-02', 9),
	(4, 2, '2026-01-02', 6),
	(5, 3, '2026-01-03', 8),
	(6, 3, '2026-01-03', 7),
	(7, 4, '2026-01-04', 9),
	(8, 4, '2026-01-04', 8),
	(9, 5, '2026-01-05', 7),
	(10, 5, '2026-01-05', 6),
	(1, 2, '2026-01-06', null),
	(2, 3, '2026-01-06', null),
	(3, 4, '2026-01-07', 8),
	(4, 5, '2026-01-07', 7),
	(5, 1, '2026-01-08', 9);

select t.full_name, count(c.course_id) as totalCourse
from teachers t
left join courses c on c.teacher_id = t.teacher_id
group by t.teacher_id, t.full_name;

select c.course_name, count(e.id) * c.tuition_fee as totalRevenue
from courses c
left join enrollments e on e.course_id = c.course_id
group by c.course_id, c.course_name;

select s.full_name, count(e.course_id) as totalCourse
from students s
join enrollments e on e.student_id = s.student_id
group by s.student_id, s.full_name
having count(e.course_id) >= 3;

select c.course_name, avg(e.score) as avgScore
from courses c
join enrollments e on e.course_id = c.course_id
where e.score is not null
group by c.course_id, c.course_name
having avg(e.score) < 5.0;