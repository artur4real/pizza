-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 02 2024 г., 17:16
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `online_pizzeria`
--

-- --------------------------------------------------------

--
-- Структура таблицы `ingred`
--

CREATE TABLE `ingred` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `ingred`
--

INSERT INTO `ingred` (`id`, `name`) VALUES
(1, 'Сырные бортики'),
(2, 'Бекон '),
(3, 'Шампиньоны');

-- --------------------------------------------------------

--
-- Структура таблицы `ingred_dop`
--

CREATE TABLE `ingred_dop` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `ingred_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `ingred_dop`
--

INSERT INTO `ingred_dop` (`id`, `order_id`, `ingred_id`) VALUES
(6, 2, 3),
(7, 4, 2),
(8, 5, 2),
(9, 6, 3),
(10, 7, 1),
(11, 7, 3),
(12, 8, 1),
(13, 9, 1),
(14, 10, 1),
(15, 11, 2),
(16, 12, 1),
(17, 13, 2),
(18, 14, 2),
(19, 15, 1),
(20, 16, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `pizza`
--

CREATE TABLE `pizza` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `pizza`
--

INSERT INTO `pizza` (`id`, `name`, `price`) VALUES
(1, 'Маргарита', 500),
(2, '4 сыра', 450),
(3, 'Пиперони', 600),
(4, ' Гавайская', 100);

-- --------------------------------------------------------

--
-- Структура таблицы `pizza_order`
--

CREATE TABLE `pizza_order` (
  `id` int NOT NULL,
  `pizza_id` int NOT NULL,
  `size_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `pizza_order`
--

INSERT INTO `pizza_order` (`id`, `pizza_id`, `size_id`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 2, 1),
(4, 1, 3),
(5, 2, 1),
(6, 2, 2),
(7, 2, 3),
(8, 2, 2),
(9, 2, 1),
(10, 2, 1),
(11, 2, 1),
(12, 3, 1),
(13, 2, 1),
(14, 2, 1),
(15, 2, 1),
(16, 2, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `sizes`
--

CREATE TABLE `sizes` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` decimal(50,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `sizes`
--

INSERT INTO `sizes` (`id`, `name`, `price`) VALUES
(1, '33', '200'),
(2, '24', '10'),
(3, '28', '100');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `ingred`
--
ALTER TABLE `ingred`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ingred_dop`
--
ALTER TABLE `ingred_dop`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `ingred_id` (`ingred_id`);

--
-- Индексы таблицы `pizza`
--
ALTER TABLE `pizza`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `pizza_order`
--
ALTER TABLE `pizza_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pizza_id` (`pizza_id`),
  ADD KEY `size_id` (`size_id`);

--
-- Индексы таблицы `sizes`
--
ALTER TABLE `sizes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `ingred`
--
ALTER TABLE `ingred`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `ingred_dop`
--
ALTER TABLE `ingred_dop`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `pizza`
--
ALTER TABLE `pizza`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `pizza_order`
--
ALTER TABLE `pizza_order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `sizes`
--
ALTER TABLE `sizes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `ingred_dop`
--
ALTER TABLE `ingred_dop`
  ADD CONSTRAINT `ingred_dop_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `pizza_order` (`id`),
  ADD CONSTRAINT `ingred_dop_ibfk_2` FOREIGN KEY (`ingred_id`) REFERENCES `ingred` (`id`);

--
-- Ограничения внешнего ключа таблицы `pizza_order`
--
ALTER TABLE `pizza_order`
  ADD CONSTRAINT `pizza_order_ibfk_1` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  ADD CONSTRAINT `pizza_order_ibfk_2` FOREIGN KEY (`pizza_id`) REFERENCES `pizza` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
