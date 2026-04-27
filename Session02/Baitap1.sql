-- Tạo database (nếu chưa có)
CREATE DATABASE IF NOT EXISTS STUDENT;
USE STUDENT;

-- Xoá bảng nếu đã tồn tại (tránh lỗi khi chạy lại)
DROP TABLE IF EXISTS STUDENTS;

-- Tạo bảng STUDENTS
CREATE TABLE STUDENTS (
    StudentId INT AUTO_INCREMENT PRIMARY KEY,
    -- Id tự tăng, ko trùng
    
    FullName VARCHAR(100) NOT NULL,
    -- Not Null: bắt buộc nhập
    DOB DATE NOT NULL,
    
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    -- ENUM: giới hạn giá trị
    Email VARCHAR(200) UNIQUE,
    -- UNIQUE: ko trùng nhau
    MarriedStatus ENUM('Single', 'Married') DEFAULT 'Single',
    -- DEFAULT: mặc định là SGL
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    -- Tự luu thời gian tạo
);