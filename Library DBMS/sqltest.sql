-- 1. Give me the list of books with year of publications before 2000

SELECT * FROM books WHERE publication_year < 2000;

-- 2. List all the books which has more than two versions in Physics genre. 

SELECT b.title, COUNT(c.copy_id) AS num_versions
FROM books b
INNER JOIN copies c ON b.book_id = c.book_id
WHERE b.genre = 'Physics'
GROUP BY b.book_id
HAVING COUNT(c.copy_id) > 2;


-- 3. List all the borowers who didn't return the books within the due time.

SELECT b.name
FROM borrowers b
INNER JOIN transactions t ON b.borrower_id = t.borrower_id
WHERE t.date_returned IS NULL AND t.date_due < CURDATE();


-- 4. Give me the list of authors along with number of books they written. 
SELECT a.author_name, COUNT(b.book_id) AS num_books
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id
GROUP BY a.author_name;

-- 5. List all the books which starts with "what"
SELECT * FROM books WHERE title LIKE 'what%';

-- 6. Give me the total count of books in each genre
SELECT genre, COUNT(book_id) AS total_books
FROM books
GROUP BY genre;

-- 7. Give me the count of books in each genere which is in library and borrowed. 
SELECT
    b.genre,
    SUM(CASE WHEN c.availability = 'available' THEN 1 ELSE 0 END) AS in_library,
    SUM(CASE WHEN c.availability = 'borrowed' THEN 1 ELSE 0 END) AS borrowed
FROM
    books b
INNER JOIN
    copies c ON b.book_id = c.book_id
GROUP BY
    b.genre;

-- 8. Give me the total count of books in each language 
SELECT COUNT(book_id) AS total_books, language
FROM books
GROUP BY language;

-- 9. Give me the author who wrote more number of books in each genre. 
SELECT 
    b.genre,
    a.author_name,
    COUNT(*) AS num_books
FROM 
    books b
JOIN 
    authors a ON b.author_id = a.author_id
GROUP BY 
    b.genre, a.author_name
HAVING 
    COUNT(*) = (
        SELECT 
            MAX(book_count)
        FROM (
            SELECT 
                COUNT(*) AS book_count
            FROM 
                books b_inner
            JOIN 
                authors a_inner ON b_inner.author_id = a_inner.author_id
            WHERE 
                b_inner.genre = b.genre
            GROUP BY 
                a_inner.author_name
        ) AS book_counts
    );


-- 10. List all the books which are not returned and overdue for more than 5 days as of now. 

SELECT 
    b.title,
    b.genre,
    b.publication_year,
    t.date_borrowed,
    t.date_due,
    DATEDIFF(NOW(), t.date_due) AS days_overdue
FROM 
    transactions t
JOIN 
    books b ON t.book_id = b.book_id
WHERE 
    t.date_returned IS NULL
    AND DATEDIFF(NOW(), t.date_due) > 5;
