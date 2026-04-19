create database miniprj;
use miniprj;

create table students (
	stu_id int primary key auto_increment,
    stu_name varchar(100) not null ,
    stu_date date not null ,
    stu_email varchar(100) unique not null,
    stu_list_number int default 20
    
);

create table Instructor(
	tea_id int primary key auto_increment,
    tea_name varchar(100) not null ,
    tea_can_teach varchar(100)
);


-- một gaiáo viên có thể dạy nhiều khoá học nên để khoá ngoại là giáo viên với khoá học 


create table Course(
	cou_id int primary key auto_increment,
    cou_name varchar(100) not null, 
    cou_text text ,
--     cou_lesson,
	cou_list_number int default 20 ,
    
    tea_id int ,
	foreign key (tea_id) references Instructor(tea_id)
);

-- một sinh viên có thể đăng ký nhiều môn học 
create table Enrollment(
	enro_id  int primary key auto_increment ,
    
    stu_id int,
    FOREIGN KEY (stu_id) REFERENCES students(stu_id),
    
    cou_id INT,
    FOREIGN KEY (cou_id) REFERENCES Course(cou_id),
    
    enro_turn datetime default current_timestamp
);

create table  Result (
	stu_id int,
    foreign key (stu_id) references students(stu_id),
    
    cou_id int,
    foreign key (cou_id) references Course(cou_id),
    
    midterm FLOAT NOT NULL CHECK(midterm >= 0 AND midterm <= 10 ),
    end_of_term FLOAT NOT NULL CHECK(end_of_term >= 0 AND end_of_term <= 10 )
    
    
);

-- insert into 
-- Thêm ít nhất 5 sinh viên
INSERT INTO students (stu_name, stu_date, stu_email) 
VALUES 
('Ta Phuc Minh Hieu', '2005-01-01', 'hieu@email.com'),
('Nguyen Van Nam', '2005-05-12', 'nam@email.com'),
('Tran Thi Lan', '2004-08-20', 'lan@email.com'),
('Le Minh Long', '2005-11-30', 'long@email.com'),
('Pham Hoang Yen', '2006-02-15', 'yen@email.com');


-- Thêm ít nhất 5 giảng viên 
INSERT INTO Instructor (tea_name, tea_can_teach) 
VALUES 
('Nguyen Van A', 'SQL, Java'),
('Tran Thi B', 'Python, AI'),
('Le Van C', 'Front-end, React'),
('Pham Minh D', 'Database Design'),
('Hoang Anh E', 'C++, Data Structure');


-- Thêm ít nhất 5 khóa học
INSERT INTO Course (cou_name, cou_text, tea_id) 
VALUES 
('SQL Basic', 'Hoc ve database co ban', 1),
('Java Core', 'Lap trinh Java tu dau', 1),
('Python for Data', 'Phan tich du lieu voi Python', 2),
('Web Design', 'HTML, CSS va JS', 3),
('C++ Advanced', 'Cau truc du lieu giai thuat', 5);

-- them dang ky cho sinh vien  vs dang ky mon
INSERT INTO Enrollment (stu_id, cou_id) 
VALUES 
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5);

-- Kết quả học tập 
INSERT INTO Result (stu_id, cou_id, midterm, end_of_term) VALUES 

(1, 1, 8, 9), (1, 2, 7, 8), (1, 3, 9, 10), (1, 4, 6, 7), (1, 5, 8, 8),

(2, 1, 5, 6), (2, 2, 8, 8), (2, 3, 7, 7), (2, 4, 9, 9), (2, 5, 4, 5),

(3, 1, 10, 9), (3, 2, 9, 10), (3, 3, 8, 8), (3, 4, 7, 7), (3, 5, 6, 8),

(4, 1, 7, 7), (4, 2, 6, 6), (4, 3, 5, 8), (4, 4, 8, 9), (4, 5, 9, 10),

(5, 1, 8, 8), (5, 2, 7, 9), (5, 3, 6, 7), (5, 4, 10, 10), (5, 5, 5, 6);


-- update
-- cật nhập email cho một sinh viên  
SET SQL_SAFE_UPDATES = 0;
update students
set stu_email = 'hta85055@gmail.com'
where stu_name = 'Ta Phuc Minh Hieu';

set SQL_SAFE_UPDATES = 0;
update  Course
set cou_text = 'Hoc ve database co ban cho nguoi moi lam quen' 
where cou_name = 'SQL Basic';

-- cật nhật sinh viên 1, môn học 1 có điểm cuối kỳ từ 9 xuống 8 
set SQL_SAFE_UPDATES = 0;
update Result
set end_of_term = '8'
where stu_id = '1'
and cou_id ='1';


-- delete
-- xoá sinh viên đăng ký không hợp lệ - giả sử sinh viên id 2 chỉ được đăng ký 4 môn 
delete from Result
where stu_id = 2 
and cou_id = 3; 

-- xét kết quả học tập lọc ra tất cả các sinh viên có điểm cuối kỳ > 8
delete  from Result
where end_of_term < 8;

-- select
-- lấy danh sách của tất cả sinh viên  
select stu_id, stu_name, stu_date, stu_email, stu_list_number
from students;

-- lấy danh sách giảng viên 
select tea_id, tea_name, tea_can_teach
from Instructor;

-- lấy danh sách các khoá học 
select cou_id, cou_name, cou_text, cou_list_number, tea_id
from  Course;

-- lấy danh sách thông tin các lượt đăng ký đăng ký khoá  học 
select enro_id, enro_turn, stu_id, cou_id
from  Enrollment;

-- láy thông tinh đánh giá kết quả
select  stu_id, cou_id, midterm, end_of_term
from  Result ;



