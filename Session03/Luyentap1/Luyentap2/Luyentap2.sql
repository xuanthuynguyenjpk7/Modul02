CREATE TABLE session03_books (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(100),
    author VARCHAR(100)
);

CREATE TABLE session03_readers (
    reader_id INT PRIMARY KEY,
    reader_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE session03_borrowings (
    borrowing_id INT PRIMARY KEY,
    reader_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,

    FOREIGN KEY (reader_id)
    REFERENCES session03_readers(reader_id),

    FOREIGN KEY (book_id)
    REFERENCES session03_books(book_id)
);