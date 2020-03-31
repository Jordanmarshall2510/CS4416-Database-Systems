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
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;

CREATE TABLE IF NOT EXISTS `authors` (
  `author_id` int(8) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `number_of_books` int(4) DEFAULT NULL,
  `country_of_origin` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` (`author_id`, `name`, `number_of_books`, `country_of_origin`) VALUES
(0, 'Suzanne Collins', 3, 'USA'),
(1, 'Veronica Roth', 3, 'USA'),
(2, 'E. L. James', 1, 'UK'),
(3, 'Jeff Kinney', 1, 'USA'),
(4, 'Dr.Seuss', 1, 'USA');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;

CREATE TABLE IF NOT EXISTS `books` (
  `book_name` varchar(128) NOT NULL,
  `author_id` int(8) DEFAULT NULL,
  `genre` varchar(32) NOT NULL DEFAULT '',
  `date_published` date DEFAULT NULL,
  `quantity` int(4) DEFAULT '1',
  PRIMARY KEY (`book_name`),
  KEY `Author` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_name`, `author_id`, `genre`, `date_published`, `quantity`) VALUES
('Hunger Games', 0, 'Dystopian fiction', '2008-09-14', 4),
('Hunger Games: Catching Fire', 0, 'Dystopian fiction', '2009-09-01', 5),
('Hunger Games: Mockingjay', 0, 'Dystopian fiction', '2010-08-24', 4),
('Divergent', 1, 'Adventure fiction', '2011-04-26', 3),
('Insurgent', 1, 'Adventure fiction', '2012-06-01', 5),
('Allegiant', 1, 'Adventure fiction', '2013-10-22', 5),
('Fifty Shades of Grey', 2, '	Erotic romance', '2019-06-11', 7),
('Diary of a Wimpy Kid', 3, 'Comedy', '2001-04-07', 5),
('Green Eggs and Ham', 4, 'Comedy', '2019-08-12', 4);

--
-- Adding Constraints for table `books`
--

ALTER TABLE `books` ADD CONSTRAINT `Author` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;

CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` int(8) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(32) DEFAULT NULL,
  `lastname` varchar(32) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone_number` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18256717 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `firstname`, `lastname`, `address`, `email`, `phone_number`) VALUES
(18256716, 'Jordan', 'Marshall', '2 The Square Gort, Gort, Galway', '18256716@studentmail.ul.ie', '353837564196'),
(18220258, 'Demi', 'Adenuga', '57 Clontarf Rd, Sky Bus. Centre, Dublin', '18220258@studentmail.ul.ie', '08645379463'),
(18236987, 'Angel', 'Maher', '1 The Broadcast Centre Ardkeen, Newtown, Waterford', '18236987@studentmail.ul.ie', '0841297632'),
(18254187, 'Marcin', 'Sek', '29 Lighthouse, Fenit, Kerry', '18254187@studentmail.ul.ie', '0851465793'),
(18226531, 'Rioghan', 'Lowry', '11 Market sq Portlaoise, Laois', '18226531@studentmail.ul.ie', '0884561289');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
CREATE TABLE IF NOT EXISTS `loans` (
  `loan_id` int(8) NOT NULL AUTO_INCREMENT,
  `customer_id` int(8) NOT NULL,
  `book_name` varchar(128) NOT NULL,
  `date_out` date DEFAULT NULL,
  `date_due` date DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `Customer` (`customer_id`),
  KEY `Book` (`book_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`loan_id`, `customer_id`, `book_name`, `date_out`, `date_due`) VALUES
(1, 18256716, 'Hunger Games: Mockingjay', '2019-11-05', '2019-11-12'),
(2, 18220258, 'Divergent', '2019-11-15', '2019-11-22'),
(3, 18236987, 'Divergent', '2019-11-16', '2019-11-23'),
(4, 18254187, 'Hunger Games', '2019-12-25', '2020-01-01'),
(5, 18226531, 'Fifty Shades of Grey', '2019-12-30', '2020-01-06');

--
-- Adding Constraints for table `loans`
--

ALTER TABLE `loans` ADD CONSTRAINT `loaning_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
ALTER TABLE `loans` ADD CONSTRAINT `loaned_book` FOREIGN KEY (`book_name`) REFERENCES `books` (`book_name`);

-- --------------------------------------------------------

--
-- Table structure for table `product_types`
--

DROP TABLE IF EXISTS `product_types`;
CREATE TABLE IF NOT EXISTS `product_types` (
  `product_id` int(8) NOT NULL AUTO_INCREMENT,
  `book_name` varchar(128) NOT NULL,
  `type` varchar(6) DEFAULT NULL,
  `date_acquired` date DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `product_book` (`book_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_types`
--

INSERT INTO `product_types` (`product_id`, `book_name`, `type`, `date_acquired`) VALUES
(1, 'Hunger Games', 'book', '2016-02-10'),
(2, 'Hunger Games: Catching Fire', 'book', '2016-02-10'),
(3, 'Hunger Games: Mockingjay', 'book', '2016-02-10'),
(4, 'Divergent', 'book', '2016-01-10'),
(5, 'Insurgent', 'book', '2016-01-10'),
(6, 'Allegiant', 'book', '2016-01-10'),
(7, 'Fifty Shades of Grey', 'book', '2019-11-14'),
(8, 'Diary of a Wimpy Kid', 'book', '2019-11-14'),
(9, 'Green Eggs and Ham', 'book', '2019-11-14');

--
-- Adding Constraints for table `loans`
--

ALTER TABLE `product_types` ADD CONSTRAINT `product_book` FOREIGN KEY (`book_name`) REFERENCES `books` (`book_name`);

-- --------------------------------------------------------
