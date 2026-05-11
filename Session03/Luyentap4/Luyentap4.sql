CREATE TABLE session03_users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    status VARCHAR(20) DEFAULT 'active'
);

ALTER TABLE session03_users
ADD CONSTRAINT chk_status
CHECK (status IN ('active', 'inactive', 'banned'));