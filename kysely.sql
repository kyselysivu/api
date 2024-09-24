-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 24.09.2024 klo 09:18
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
(7, 3, 'Hän kytkee tulostimen verkkoon ', 1),
(8, 3, 'Hän korjaa paperitukokset ', 1),
(9, 3, 'Hän vie ja asentaa sen työpaikalle ', 1),
(10, 3, 'Hän tekee ohjeen, miten tätä käytetään ', 1),
(11, 3, 'Hän opastaa koneen käyttäjiä ', 1),
(12, 4, 'Muisti', 0),
(13, 4, 'Tietokoneen kotelo', 1),
(14, 4, 'Kiintolevy', 0),
(15, 4, 'Virtalähde', 0),
(16, 4, 'Emolevy', 0),
(17, 5, 'Ohjelmistokehittäjä', 0),
(18, 5, 'It-tukihenkilö', 1),
(19, 5, 'Elektroniikka-asentaja', 0),
(20, 5, 'Tietoverkkoasentaja', 0),
(21, 5, 'Hyvinvointiteknologia-asentaja', 0),
(22, 6, 'Asentaa etäyhteydellä sovelluksen asiakkaan tietokoneeseen', 1),
(23, 6, 'Neuvoo firman toimitusjohtajaa tulostusongelmassa ', 1),
(24, 6, 'Korjaa koodia pelikehitys-tiimissä ', 0),
(25, 6, 'Pelaa nettipeliä kollegan kanssa ', 0),
(26, 7, 'Toteuttaa itsenäisesti asiakkaan toivomaa työtehtävää', 1),
(27, 7, 'Ongelmanratkaisukykyinen', 1),
(28, 7, 'Sosiaalinen', 1),
(29, 7, 'Utelias', 1),
(30, 7, 'Näppärä käsistään', 1),
(31, 7, 'On taitava tietokonepelien pelaaja', 0),
(32, 8, '0,02 V', 0),
(33, 8, '12 V', 1),
(34, 8, '4,04 V', 0),
(35, 8, '1,2 V', 0),
(36, 8, '0,5 V', 0),
(37, 9, '5,6 kΩ', 0),
(38, 9, '470 Ω', 0),
(39, 9, '360 Ω', 1),
(40, 9, '1 kΩ', 0),
(41, 10, 'Oikein', 1),
(42, 10, 'Väärin', 0),
(43, 11, 'Noin 800 °C', 0),
(44, 11, 'Noin 300 °C', 1),
(45, 11, 'Noin 100 °C', 0),
(60, 12, '0 kertaa', 0),
(61, 12, '1 kerran', 0),
(62, 12, '10 kertaa', 0),
(63, 12, 'Ikuisesti', 1),
(64, 15, '(234 % 10) * 10', 0),
(65, 15, '(234 * 10) % 10', 0),
(66, 15, '(234 % 100) / 10', 1),
(67, 15, '(234 % 10) / 10', 0),
(68, 13, 'Kokonaisluku', 0),
(69, 13, 'Liukuluku', 0),
(70, 13, 'Merkkijono', 1),
(71, 13, 'Totuusarvo', 0),
(72, 14, 'True', 0),
(73, 14, 'False', 1);

-- --------------------------------------------------------

--
-- Rakenne taululle `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `question_title` text NOT NULL,
  `image_src` varchar(255) NOT NULL,
  `additional_html` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vedos taulusta `questions`
--

INSERT INTO `questions` (`id`, `question_title`, `image_src`, `additional_html`) VALUES
(3, 'Miten kuvan tulostin liittyy IT-tukihenkilön työhön?', '/tulostin.jpg', ''),
(4, 'Mikä tietokoneen osa kuvasta puuttuu? ', '/tietokone.png', ''),
(5, 'Mihin ammattiin liittyy seuraavat: Azure, Intune, Debian, M365 ja Hyper-V ', '', ''),
(6, 'Mitä kuvan it-tukihenkilö tekee? ', '/ittuki.png', ''),
(7, 'Minkälaisia ominaisuuksia IT-tukihenkilöllä olisi hyvä olla? ', '', ''),
(8, 'Mikä on Ohmin lain mukaan jännitteen arvo, kun R = 220 Ω ja I = 54,5 mA?', '', ''),
(9, 'Vastuksen ja punaisen ledin sarjakytkentään syöttää virtaa 9 V:n paristo, Mikä tule vastuksen resistanssiarvon olla, jotta se rajoittaisi myötäsuuntaiseksi virraksi 20 mA? Ledin kynnysjännite on 1,8 V.', '', ''),
(10, 'Onko oheisessa kuvassa esitetty kytkentä diodin testaamiseksi oikein vai väärin?', '/diodi.png', ''),
(11, 'Valitse sopivin juottimen käytönaikainen lämpötila', '', ''),
(12, 'Tarkastele seuraavaa ohjelmakoodia: \r\nKuinka monta kertaa ohjelma toistaa tekstin \"Lasketaan yhdestä kymmeneen\"?', '', '<code>i = 0<br>while i < 10:<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbspprint(\"Lasketaan yhdestä kymmeneen\")<br>print(\"Valmis!\")</code>'),
(13, 'Mitä tietotyyppiä seuraava arvo edustaa?', '', '<code>\"Tervehdys!\"</code>'),
(14, 'Mikä totuusarvo tulee tulokseksi seuraavasta Boolean-lausekkeesta?', '', '<code>5 < 10 and not 20 > 10</code>'),
(15, 'Moduloa (%) eli jakojäännöstä käyttäen voimme selvittää luvun viimeisen numeron, esim: 234 % 10 = 4. Millaisella laskutoimituksella saamme luvun toiseksi viimeisen numeron?', '', '');

-- --------------------------------------------------------

--
-- Rakenne taululle `scores`
--

CREATE TABLE `scores` (
  `id` int(11) NOT NULL,
  `group_name` varchar(60) NOT NULL,
  `score` int(11) NOT NULL,
  `time` int(11) NOT NULL,
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `scores`
--
ALTER TABLE `scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
