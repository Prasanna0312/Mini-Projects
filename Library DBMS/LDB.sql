CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
   
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT NOT NULL,
    isbn VARCHAR(13),
    publication_year INT,
    genre VARCHAR(100),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);



CREATE TABLE borrowers (
    borrower_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255)
  
);


CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    borrower_id INT NOT NULL,
    date_borrowed DATE NOT NULL,
    date_due DATE NOT NULL,
    date_returned DATE,
  
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (borrower_id) REFERENCES borrowers(borrower_id)
);


CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(255) NOT NULL,
    location VARCHAR(255)
   
);


CREATE TABLE copies (
    copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    branch_id INT NOT NULL,
    availability ENUM('available', 'borrowed') DEFAULT 'available',
  
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);


