-- ---------------------------------------------------------

--
-- Database: `library`
-- Authors: Marcin Sek - 18254187,
--          Jordan Marshall - 18256716,
--          Rioghan Lowry - 18226531,
--          Ademide Adenuga - 18220258
--

-- --------------------------------------------------------

DELIMITER //

-- --------------------------------------------------------

--
-- Functions
--

DROP FUNCTION IF EXISTS `isDateOkay`//

CREATE FUNCTION `isDateOkay`(`date_to_check` DATE, `due` BIT(1)) RETURNS bit(1)
BEGIN
	DECLARE result BIT(1);
	SET result = 1;
	IF date_to_check > now() OR date_to_check IS NULL AND due = 0
	THEN
		SET result = 0;
	ELSE
		IF date_to_check < now() OR date_to_check IS NULL AND due = 1
		THEN
			SET result = 0;
		END IF;
	END IF;
	RETURN result;
END//

-- --------------------------------------------------------

--
-- Procedures
--

DROP PROCEDURE IF EXISTS `setDate`//

CREATE PROCEDURE `setDate`(INOUT `out_date` DATE, INOUT `due_date` DATE, IN `id` INT(8))
BEGIN
	IF isDateOkay(out_date, 0) = 0 THEN
		SET out_date = now();
	END IF;
	
	IF isDateOkay(due_date, 1) = 0 THEN
		SET due_date = DATE_ADD(out_date, INTERVAL 1 WEEK);
	END IF; 
END//


-- --------------------------------------------------------

--
-- Triggers `product_types`
--

DROP TRIGGER IF EXISTS `setAcquiredDate`//

CREATE TRIGGER `setAcquiredDate` BEFORE INSERT ON `product_types` FOR EACH ROW
BEGIN
	IF (isDateOkay(NEW.date_acquired, 0) = 0)
	THEN
		SET NEW.date_acquired = now();
	END IF;
END//

-- ---------------------------------------------------------

--
-- Triggers `loans`
--

DROP TRIGGER IF EXISTS `loanedBook`//

CREATE TRIGGER `loanedBook` AFTER INSERT ON `loans` FOR EACH ROW
BEGIN
	UPDATE books SET quantity = quantity - 1 WHERE book_name = new.book_name;
END//

DROP TRIGGER IF EXISTS `returnedBook`//

CREATE TRIGGER `returnedBook` AFTER DELETE ON `loans` FOR EACH ROW
BEGIN
	UPDATE books SET quantity = quantity + 1 WHERE book_name = old.book_name;
END//

DROP TRIGGER IF EXISTS `setOutDate`//

CREATE TRIGGER `setOutDate` BEFORE INSERT ON `loans` FOR EACH ROW
BEGIN
	DECLARE date_1 date;
	DECLARE date_2 date;
	SET date_1 = NEW.date_out;
	SET date_2 = NEW.date_due;

	CALL setDate(date_1, date_2, NEW.loan_id);

	SET NEW.date_out = date_1;
	SET NEW.date_due = date_2;
END//

-- --------------------------------------------------------

--
-- Triggers `books`
--

DROP TRIGGER IF EXISTS `acquiredBook`//

CREATE TRIGGER `acquiredBook` AFTER INSERT ON `books` FOR EACH ROW
BEGIN
	UPDATE author SET number_of_books = number_of_books + 1 WHERE author_id = NEW.author_id;
END//

DROP TRIGGER IF EXISTS `deletedBook`//

CREATE TRIGGER `deletedBook` AFTER DELETE ON `books` FOR EACH ROW
BEGIN
	UPDATE author SET number_of_books = number_of_books - 1 WHERE author_id = OLD.author_id;
END//

-- --------------------------------------------------------
