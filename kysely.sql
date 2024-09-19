-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 19.09.2024 klo 11:31
-- Palvelimen versio: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kysely`
--

-- --------------------------------------------------------

--
-- Rakenne taululle `answers`
--

CREATE TABLE `answers` (
  `id` int(11) NOT NULL,
  `related_question` int(11) NOT NULL,
  `answer_title` varchar(255) NOT NULL,
  `is_correct` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `answers`
--

INSERT INTO `answers` (`id`, `related_question`, `answer_title`, `is_correct`) VALUES
(1, 1, '13', 0),
(2, 1, '14', 0),
(3, 1, '16', 0),
(4, 1, '17', 0),
(5, 2, 'gstrhsyjdesar', 1),
(6, 2, 'bstjsths5', 0);

-- --------------------------------------------------------

--
-- Rakenne taululle `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `question_title` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `questions`
--

INSERT INTO `questions` (`id`, `question_title`) VALUES
(1, 'Kuinka vanha Antti on?'),
(2, 'Abc, abc, abc!');

-- --------------------------------------------------------

--
-- Rakenne taululle `scores`
--

CREATE TABLE `scores` (
  `id` int(11) NOT NULL,
  `group_name` varchar(60) NOT NULL,
  `score` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `related_question` (`related_question`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scores`
--
ALTER TABLE `scores`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `scores`
--
ALTER TABLE `scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


-- juhanias 19.9
-- add image_src to questions
ALTER TABLE `questions`
  ADD `image_src` varchar(255) NOT NULL;
  
--
-- Rajoitteet vedostauluille
--

--
-- Rajoitteet taululle `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`related_question`) REFERENCES `questions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
