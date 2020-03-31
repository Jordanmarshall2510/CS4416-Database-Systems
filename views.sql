-- ---------------------------------------------------------

--
-- Database: `library`
-- Authors: Marcin Sek - 18254187,
--          Jordan Marshall - 18256716,
--          Rioghan Lowry - 18226531,
--          Ademide Adenuga - 18220258
--

-- --------------------------------------------------------

--
-- Overdue books View
--

CREATE OR REPLACE VIEW overdueBooks AS
SELECT loans.date_due, customers.firstname, customers.lastname, customers.phone_number, loans.book_name, IF(5 * DATEDIFF(now(), loans.date_due) > 100, 100, 5 * DATEDIFF(now(), loans.date_due))  AS 'fees (EURO)'
FROM loans
INNER JOIN customers ON customers.customer_id = loans.customer_id
GROUP BY loans.date_due
HAVING loans.date_due < now();

-- --------------------------------------------------------

--
-- Book Availablity View
--

CREATE OR REPLACE VIEW bookAvailability AS
SELECT books.book_name, books.quantity AS 'IN', tb2.OUT
FROM books
INNER JOIN (SELECT book_name, count(*) AS 'OUT' FROM loans GROUP BY(book_name)) tb2
ON books.book_name =  tb2.book_name;

-- --------------------------------------------------------

--
-- Book Details View
--

CREATE OR REPLACE VIEW booksDetails AS
SELECT authors.name, authors.country_of_origin, tb2.book_name, tb2.genre, tb2.type
FROM authors
INNER JOIN (SELECT books.author_id, books.book_name, books.genre, product_types.type
  FROM books
  INNER JOIN product_types
  ON product_types.book_name = books.book_name
) tb2
ON tb2.author_id = authors.author_id;

-- --------------------------------------------------------