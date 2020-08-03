-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 20, 2018 at 05:40 AM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinema`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_plan_cinema_status` (IN `plan_id` INT)  BEGIN
	DECLARE find_plan int;
    DECLARE show_date DATE;
    SET find_plan = 0;
    
    SELECT plan_cinemas.show_date INTO show_date
    FROM plan_cinemas
    WHERE plan_cinemas.id = plan_id;
    
    IF show_date <= CURRENT_DATE THEN
        SELECT COUNT(*) INTO find_plan
        FROM plan_cinemas
        WHERE plan_cinemas.id = plan_id
            AND plan_cinemas.show_date >= CURRENT_DATE
            AND plan_cinemas.time_begin >= CURRENT_TIME;
    ELSE
    	SELECT COUNT(*) INTO find_plan
        FROM plan_cinemas
        WHERE plan_cinemas.id = plan_id
            AND plan_cinemas.show_date >= CURRENT_DATE;
    END IF;        
    SELECT find_plan AS find_plan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cinema_with_plan` (IN `movie_id` INT, IN `proj_id` INT, IN `show_date` DATE)  BEGIN
	SELECT `cinemas`.`name` AS `cinema_name`, cinemas.id AS `cinema_id`, rooms.id AS `room_id` FROM `cinemas`, rooms, plan_cinemas WHERE plan_cinemas.room_id = rooms.id AND cinemas.id = rooms.cinema_id AND plan_cinemas.movie_id = movie_id AND plan_cinemas.type_projector_id = proj_id AND plan_cinemas.show_date = show_date GROUP BY cinemas.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_full_info_plan_by plan` (IN `plan_id` INT)  NO SQL
BEGIN
	SELECT plan_cinemas.*, rooms.name AS `room_name`, cinemas.name AS cinema_name, type_projectors.name AS projector_name, movies.name AS movie_name, movies.slug_name AS movie_slug, movies.image AS movie_image
    FROM `plan_cinemas`, `rooms`, `cinemas`, `type_projectors`, `movies` 
    WHERE plan_cinemas.room_id = rooms.id
        AND plan_cinemas.type_projector_id = type_projectors.id
        AND plan_cinemas.movie_id = movies.id
        AND rooms.cinema_id = cinemas.id
        AND plan_cinemas.id = plan_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_info_cinema_by_room` (IN `room_id` INT)  BEGIN
	SELECT cinemas.*
    FROM cinemas, rooms
    WHERE rooms.cinema_id = cinemas.id
    	AND rooms.id = room_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_movies_coming_soon` ()  BEGIN
	SELECT *
    FROM movies
    WHERE movies.release_date > CURRENT_DATE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_movies_now_showing` ()  BEGIN
	SELECT movies.*
    FROM movies, plan_cinemas
    WHERE movies.id = plan_cinemas.movie_id
    	AND plan_cinemas.show_date >= CURDATE()
    GROUP BY movies.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_plan_cinema_by_movie` (IN `movie_id` INT, IN `date` DATE, IN `proj_id` INT)  BEGIN
	IF date <= CURRENT_DATE THEN
    	SELECT plan_cinemas.*, rooms.cinema_id
        FROM plan_cinemas, rooms
        WHERE rooms.id = plan_cinemas.room_id
        AND plan_cinemas.show_date = date
        AND plan_cinemas.movie_id = movie_id
        AND plan_cinemas.type_projector_id = proj_id
        AND plan_cinemas.time_begin >= CURRENT_TIME;
    ELSE
    	SELECT plan_cinemas.*, rooms.cinema_id
        FROM plan_cinemas, rooms
        WHERE rooms.id = plan_cinemas.room_id
        AND plan_cinemas.show_date = date
        AND plan_cinemas.movie_id = movie_id
        AND plan_cinemas.type_projector_id = proj_id;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_seats_booked_by_plan` (IN `plan_id` INT)  BEGIN
	SELECT seats.row_name, seats.col_name, tickets.id as ticket_id, seats.id FROM seats, tickets WHERE seats.id = tickets.seat_id AND tickets.plan_cinema_id = plan_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_seat_none` (IN `plan_id` INT)  BEGIN
	DECLARE seat1, seat2 int DEFAULT 0;
    SELECT view_rooms.max_seat INTO seat1
    FROM rooms, plan_cinemas, view_rooms
    WHERE rooms.id = plan_cinemas.room_id
    	AND view_rooms.id = rooms.view_id
    	AND plan_cinemas.id = plan_id;
    
    SELECT COUNT(*) INTO seat2
    FROM tickets
    WHERE tickets.plan_cinema_id = plan_id;
    SELECT seat1 - seat2 AS seat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_view_by_plan` (IN `plan_id` INT)  BEGIN
	SELECT view_rooms.*
    FROM plan_cinemas, rooms, view_rooms
    WHERE plan_cinemas.id = plan_id AND plan_cinemas.room_id = rooms.id AND rooms.view_id = view_rooms.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `HelloWorld` (IN `Name` VARCHAR(255))  BEGIN
	SELECT * FROM cinemas;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `locnguyen` (IN `date_in` DATE)  NO SQL
BEGIN
	IF date_in = CURRENT_DATE THEN
    	SELECT 'hihihi';
    ELSE
    	SELECT 'haahah';
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'loc nguyen', 'vanloctechdemo@gmail.com', '$2y$12$q5sOJOTFo/FPcscIZ2bafOydb6Gww/3hq/4qm7VyzizXVCH2y1vHG', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link_redirect` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0 la ko show, 1 show',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `name`, `image`, `link_redirect`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Suất chiếu sớm venom', 'https://files.betacorp.vn/files/ecm/2018/10/08/cover-facebook-1702x621-10-113031-081018-79.jpg', 'https://fb.com/vanloctech', 1, NULL, '2018-10-08 16:10:12'),
(2, 'Kế hoạch đổi chồng', 'https://files.betacorp.vn/files/ecm/2018/09/28/khdc-final-1720x621-082848-280918-50.jpg', 'https://fb.com/vanloctech', 1, NULL, '2018-10-08 16:10:26'),
(3, 'Xem chân nhỏ nhận quà chân to', 'https://www.cgv.vn/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/9/8/980x448_44.jpg', 'https://fb.com/vanloctech', 1, NULL, '2018-10-08 16:11:16'),
(4, 'Xem thả ga, ăn thả ga', 'https://www.cgv.vn/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/w/e/web_980x448_16.jpg', '', 1, NULL, '2018-10-08 16:10:54'),
(5, 'Liên hoan phim quốc tế', 'https://www.cgv.vn/media/banner/cache/1/b58515f018eb873dafa430b6f9ae0c1e/c/g/cgv_shortfilm_app-banner_180620_2.jpg', '', 1, NULL, '2018-10-08 16:11:25');

-- --------------------------------------------------------

--
-- Table structure for table `cinemas`
--

CREATE TABLE `cinemas` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `province_id` tinyint(4) NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cinemas`
--

INSERT INTO `cinemas` (`id`, `name`, `province_id`, `address`, `phone`, `created_at`, `updated_at`) VALUES
(1, 'Cinema 1', 2, 'Q.Thu Duc', '0808080808', NULL, NULL),
(2, 'Cinema 2', 2, 'Q1', '0808080809', NULL, NULL),
(3, 'Cinema 3', 2, 'Q2', '0808080807', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sex` tinyint(4) NOT NULL,
  `id_card_number` int(11) NOT NULL,
  `province_id` int(11) NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `total_usd` double NOT NULL,
  `buy_date` date NOT NULL,
  `employee_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0 chua nhan ve, 1 da nhan ve',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `total`, `total_usd`, `buy_date`, `employee_id`, `user_id`, `payment_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 534534, 162626, '2018-10-10', 1, 123, 0, 0, '2018-10-09 17:41:29', '2018-10-09 17:41:29'),
(2, 2147483647, 162626, '2018-10-10', 1, 123, 0, 0, '2018-10-09 17:45:07', '2018-10-09 17:45:07'),
(3, 463000, 162626, '2018-10-10', 1, 123, 0, 0, '2018-10-09 17:47:22', '2018-10-09 17:47:22'),
(4, 495000, 21.193, '2018-10-10', 1, 1, 0, 0, '2018-10-09 17:48:19', '2018-10-09 17:48:19'),
(5, 10000, 0.43, '2018-10-10', 1, 1, 0, 0, '2018-10-10 01:28:11', '2018-10-10 01:28:11'),
(6, 10000, 0.43, '2018-10-10', 1, 1, 0, 0, '2018-10-10 01:29:50', '2018-10-10 01:29:50'),
(7, 100000, 4.302, '2018-10-10', 1, 1, 0, 0, '2018-10-10 01:35:36', '2018-10-10 01:35:36'),
(8, 95000, 4.09, '2018-10-10', 1, 1, 0, 0, '2018-10-10 03:47:00', '2018-10-10 03:47:00'),
(9, 95000, 4.09, '2018-10-10', 1, 1, 0, 0, '2018-10-10 03:49:16', '2018-10-10 03:49:16'),
(10, 9500, 0.41, '2018-10-10', 1, 1, 0, 0, '2018-10-10 03:52:14', '2018-10-10 03:52:14'),
(11, 11000, 0.47, '2018-10-10', 1, 1, 0, 0, '2018-10-10 04:24:02', '2018-10-10 04:24:02'),
(12, 34000, 1.46, '2018-10-16', 1, 1, 0, 0, '2018-10-16 03:22:51', '2018-10-16 03:22:51'),
(13, 11000, 0.47, '2018-10-16', 1, 1, 0, 0, '2018-10-16 03:27:37', '2018-10-16 03:27:37'),
(14, 14000, 0.6, '2018-10-17', 1, 1, 13, 0, '2018-10-17 03:56:48', '2018-10-17 03:56:48'),
(15, 34000, 1.46, '2018-10-17', 1, 1, 14, 0, '2018-10-17 04:19:50', '2018-10-17 04:19:50'),
(16, 39400, 1.69, '2018-10-17', 1, 1, 15, 0, '2018-10-17 04:50:08', '2018-10-17 04:50:08'),
(17, 29500, 1.26, '2018-10-17', 1, 1, 16, 0, '2018-10-17 04:51:32', '2018-10-17 04:51:32'),
(18, 17400, 0.75, '2018-10-17', 1, 1, 17, 0, '2018-10-17 04:53:28', '2018-10-17 04:53:28'),
(19, 36000, 1.54, '2018-10-17', 1, 1, 18, 0, '2018-10-17 05:00:13', '2018-10-17 05:00:13'),
(20, 25000, 1.07, '2018-10-19', 1, 1, 19, 0, '2018-10-19 10:50:28', '2018-10-19 10:50:28');

-- --------------------------------------------------------

--
-- Table structure for table `invoice_details`
--

CREATE TABLE `invoice_details` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `invoice_details`
--

INSERT INTO `invoice_details` (`id`, `invoice_id`, `product_id`, `qty`, `price`, `created_at`, `updated_at`) VALUES
(1, 4, 1, 3, 95000, '2018-10-09 17:48:19', '2018-10-09 17:48:19'),
(2, 4, 4, 3, 20000, '2018-10-09 17:48:19', '2018-10-09 17:48:19'),
(3, 8, 4, 1, 20000, '2018-10-10 03:47:01', '2018-10-10 03:47:01'),
(4, 9, 4, 1, 20000, '2018-10-10 03:49:16', '2018-10-10 03:49:16'),
(5, 10, 4, 1, 2000, '2018-10-10 03:52:14', '2018-10-10 03:52:14'),
(6, 11, 4, 1, 2000, '2018-10-10 04:24:02', '2018-10-10 04:24:02'),
(7, 12, 1, 2, 9500, '2018-10-16 03:22:51', '2018-10-16 03:22:51'),
(8, 13, 4, 1, 2000, '2018-10-16 03:27:37', '2018-10-16 03:27:37'),
(9, 12, 2, 2, 9500, '2018-10-16 03:22:51', '2018-10-16 03:22:51'),
(10, 14, 2, 1, 5000, '2018-10-17 03:56:48', '2018-10-17 03:56:48'),
(11, 15, 1, 2, 9500, '2018-10-17 04:19:50', '2018-10-17 04:19:50'),
(12, 16, 1, 1, 9500, '2018-10-17 04:50:08', '2018-10-17 04:50:08'),
(13, 16, 2, 1, 5000, '2018-10-17 04:50:08', '2018-10-17 04:50:08'),
(14, 16, 3, 1, 9900, '2018-10-17 04:50:08', '2018-10-17 04:50:08'),
(15, 17, 1, 1, 9500, '2018-10-17 04:51:32', '2018-10-17 04:51:32'),
(16, 17, 2, 1, 5000, '2018-10-17 04:51:32', '2018-10-17 04:51:32'),
(17, 18, 3, 1, 9900, '2018-10-17 04:53:28', '2018-10-17 04:53:28'),
(18, 19, 1, 3, 9500, '2018-10-17 05:00:13', '2018-10-17 05:00:13'),
(19, 20, 2, 2, 5000, '2018-10-19 10:50:28', '2018-10-19 10:50:28');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `movies`
--

CREATE TABLE `movies` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `link_trailer` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `director` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cast` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `genre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `language` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `release_date` date NOT NULL,
  `rated` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `show_home` tinyint(1) NOT NULL COMMENT '0 ko show, 1 show',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `movies`
--

INSERT INTO `movies` (`id`, `name`, `slug_name`, `image`, `duration`, `link_trailer`, `director`, `cast`, `genre`, `language`, `release_date`, `rated`, `content`, `show_home`, `created_at`, `updated_at`) VALUES
(1, 'SHIN - CẬU BÉ BÚT CHÌ KUNGFU - BOY MÌ RAMEN ĐẠI CHIẾN', 'shin-cau-be-but-chi', '400x633-103744-041018-96.jpg', 104, 'https://www.youtube.com/embed/8XHHCcWQGNM', 'Wataru Takahashi', 'Akiko Yajima, Toshiyuki Morikawa, Daisuke Sakaguchi,..', '1', 'Tiếng Nhật với phụ đề tiếng Việt', '2018-09-21', '0', 'Cơn cuồng mì Ramen tấn công thành phố Kasukabe, bởi một âm mưu tàn độc Black Panda Ramen. Người dân trong thành phố bị cuồng mì Ramen và trở nên bạo lực không thể kiểm soát. Shinchan và các bạn đến học Kung-fu tại khu phố người Hoa tại Kasukabe với tuyệt chiêu Punipuni. Quyết tâm bảo về bình yên cho thành phố Kasukabe, Shin và các bạn đã chăm chỉ tập luyện Kung-fu và trải qua nhiều thử thách.', 0, NULL, '2018-10-08 16:19:38'),
(2, 'QUÁI THÚ VÔ HÌNH', 'the-predator', '', 110, 'https://youtu.be/9OSM_LwH0zg', 'Shane Black', 'Sterling K. Brown, Boyd Holbrook, Keegan‑Michael Key,...', '1', 'Tiếng Anh với phụ đề tiếng Việt', '2018-09-14', '18', 'Những thợ săn bí ẩn từ không gian bỗng xuất hiện ở Trái Đất. Chính quyền cử một đội đặc nhiệm truy tìm và lùng bắt những thợ săn này nhưng liệu ai mới thật sự là kẻ đi săn. Bí ẩn về giống loài tiên tiến này dần được hé lộ.', 0, NULL, NULL),
(3, 'A-X-L CHÚ CHÓ ROBOT', 'axl', '', 100, 'https://youtu.be/FZGNwR6cl4E', 'Oliver Daly', 'Alex Neustaedter, Becky G, Alex MacNicoll', '1', 'Tiếng Anh với phụ đề tiếng Việt', '2018-09-21', '13', '', 0, NULL, '2018-09-26 03:14:31'),
(4, 'Kế hoạch đổi chồng', 'ke-hoach-doi-chong', 'https://files.betacorp.vn/files/media/images/2018/09/19/khdc-final-400x633-093154-190918-75.jpg', 90, 'https://www.youtube.com/embed/5zbFTZMpsTE', 'Trần Nhân Kiên', 'Quang Đăng, Hoàng Yến Chibi, Trương Thanh Long,...', 'Tình cảm', '', '2018-09-28', '16', 'Cưới nhau nhanh mà chán nhau cũng chóng. Chỉ sau một năm kết hôn, Quân đã cảm thấy phát sợ cô vợ đanh đá, nói nhiều, thô lỗ của mình. Vì không đủ dũng cảm nói trực tiếp nên Quân phải tìm mọi cách để có lý do ly dị Thu Dung. Sau nhiều lần thất bạt, cuối cùng Quân quyết định chi một số tiền lớn thuê một tay chơi khét tiếng tán tỉnh vợ mình. Anh thầm nghĩ chỉ cần bắt được Thu Dung ngoại tình là có thể kết thúc cuộc hôn nhân này. Liệu Quân đã hiểu hết vợ mình chưa? Hay còn điều gì ẩn giấu sau tính cách quái gở của Thu Dung?', 1, NULL, '2018-10-08 16:15:50'),
(5, 'Venom', 'venom', 'https://files.betacorp.vn/files/media/images/2018/10/08/400x633-2-104654-081018-52.jpg', 115, 'https://www.youtube.com/embed/LxVtxf0-NX8', 'Wataru Takahashi', 'Tom Hardy, Michelle Williams, Riz Ahmed...', 'Hành động', 'Tiếng anh với phụ đề việt', '2018-10-08', '16', 'Là một phóng viên lành nghề, Eddie Brook bắt đầu bí mật điều tra những hành vi tội phạm của Drake. Anh dần tìm cách cận và dần khám phá ra một bí mật khủng khiếp. Song, anh chàng đã vô tình nhiễm phải Symbiote vào cơ thể. Từ đây, Eddie bắt đầu sở hữu những siêu năng lực và nhân cách tàn bạo của Venom. Eddie phải trải qua sự biến đổi kinh hoàng cả về thể chất lẫn tinh thần và cùng lúc đó phải chiến đấu với sự truy đuổi gắt gao của Life Foundation.', 1, NULL, '2018-10-08 16:15:53'),
(6, 'Chân Nhỏ, Bạn Ở Đâu?', 'chan-nho-ban-o-dau', 'https://files.betacorp.vn/files/media/images/2018/09/18/small-foot-chan-nho-ban-o-dau-095404-180918-74.jpg', 96, 'https://www.youtube.com/embed/T-pOb8pHGWw', 'Karey Kirkpatrick', 'LeBron James, Channing Tatum, Zendaya', 'Hoạt hình, Gia đình', 'Tiếng anh với phụ đề Việt, Tiếng anh với thuyết minh tiếng Việt', '2018-09-28', '0', 'Sau lần chạm trán với Percy, một sinh vật với đôi chân bé nhỏ, người tuyết Migo quyết tâm thực hiện chuyến phiêu lưu của mình đến vùng đất xa xôi để chứng minh với cộng đồng của mình rằng Chân Nhỏ là có thật. Liệu Chân Nhỏ có thật sự đáng sợ như họ đã nghĩ? Hãy cùng Migo đi tìm sinh vật huyền bí này vào tháng 9 nhé!', 1, NULL, '2018-10-08 16:15:57'),
(7, 'Ác Quỷ Ma Sơ', 'ac-quy-ma-so', 'https://files.betacorp.vn/files/media/images/2018/07/19/the-nun-new-094817-190718-19.jpg', 100, 'https://www.youtube.com/embed/2Fl6XSBjQvE', 'Corin Hardy', 'Bonnie Aarons, Taissa Farmiga, Charlotte Hope', 'Kinh dị', 'Tiếng anh với phụ đề Việt', '2018-09-07', '18', 'Lấy bối cảnh một tu viện thuộc Romania năm 1952, trước những sự kiện diễn ra trong \"The Conjuring\" và \"Annabelle\". Sau cái chết kỳ dị và bí ẩn của một nữ tu trẻ ở tu viện, một linh mục với quá khứ ám ảnh và một mục sư chưa thực hiện lời tuyên thệ cuối cùng được Vatican cử đến để điều tra sự việc. Họ đã cùng nhau khám phá ra một sự thật khủng khiếp. Không chỉ gặp nguy hiểm đe dọa mạng sống, cả hai còn phải đối mặt với sự đe dọa về đức tin lẫn linh hồn trước một thế lực tàn độc đội lốt một nữ tu ma quỷ.', 1, NULL, '2018-10-08 16:15:55'),
(8, 'Johnny English: Tái Xuất Giang Hồ', 'johnny-english-tai-xuat-giang-ho', 'https://files.betacorp.vn/files/media/images/2018/07/18/jonhny-enghlish-400x633-092916-180718-51.jpg', 89, 'https://www.youtube.com/embed/goh-FbUbSA0', 'David Kerr', 'Rowan Atkinson, Olga Kurylenko', 'Hành động, Hài hước', 'Tiếng Anh với phụ đề Việt', '2018-09-21', '13', 'JOHNNY ENGLISH: TÁI XUẤT GIANG HỒ là phần thứ ba của loạt phim hài Johnny English, với Rowan Atkinson trong vai một gã bỗng dưng trở thành một điệp viên bí mật. Cuộc phiêu lưu mới bắt đầu khi một vụ điều tra hệ thống an ninh mạng cho thấy danh tính của tất cả các điệp viên đang hoạt động tại Anh, và Johnny là hy vọng cuối cùng để điều tra bí mật ấy. Dù được biết là một điệp viên nghỉ hưu nhưng đây là lần đầu tiên gã giang hồ này bắt tay động với sứ mệnh tìm kiếm kẻ tấn công. Là một người với kỹ năng ít ỏi và năng lực hạn chế, Johnny English có phải vượt qua được những thách thức trong thời buổi công nghệ hiện đại để hoàn thành sứ mệnh này thành công hay không?', 1, NULL, '2018-10-08 16:16:07'),
(9, 'VÌ SAO VỤT SÁNG', 'vi-sao-vut-sang', 'http://www.movienewsletters.net/photos/VNM_241805R1.jpg', 140, 'https://www.youtube.com/embed/hIbMYWyn7hQ', 'Bradley Cooper', 'Lady Gaga, Bradley Cooper, Sam Elliott, Dave Chappelle', 'Tâm Lý, Tình cảm', 'Tiếng Anh với phụ đề tiếng Việt', '2018-10-05', '18', 'Tháng 10 này, hãy để tâm hồn bạn bay bổng cùng cảm xúc lãng mạn với câu chuyện tình yêu lấp lánh của Vì Sao Vụt Sáng. Chàng nghệ sỹ nhạc đồng quê Jackson Maine (Bradley Cooper) và ca sỹ vô danh Ally (Lady GaGa) sẽ khiến bạn đắm chìm trong thế giới âm nhạc rực rỡ và rung động đến từng phút giây. Liệu định mệnh sẽ viết nên cái kết nào cho cả hai khi đứng giữa tình yêu và sự nghiệp?Đừng bỏ lỡ màn nhập vai được cho là tuyệt vời nhất của Lady Gaga từ trước đến nay!', 1, NULL, '2018-10-08 17:05:45'),
(10, 'sấd', 'd', 'd', 1, 'd', 'd', 'd', 'd', 'd', '2018-10-10', '12', 'd', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `news_offers`
--

CREATE TABLE `news_offers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `date_begin` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `news_offers`
--

INSERT INTO `news_offers` (`id`, `name`, `slug_name`, `image`, `content`, `date_begin`, `date_end`, `created_at`, `updated_at`) VALUES
(1, 'MUA VÉ “CHÂN NHỎ” SĂN QUÀ “CHÂN TO”', 'smallfoot-promotion', 'https://www.cgv.vn/media/wysiwyg/Newsoffer2/OCT18/350x495.jpg', 'Từ 5/10 khi mua vé xem phim “Chân Nhỏ bạn ở đâu?” khách hàng sẽ được tặng móc khóa hoặc áo mưa xinh xắn\r\n\r\n \r\n\r\nTặng Móc Khóa Migo hoặc Meechee khi mua 2 vé. Áp dụng tại\r\n\r\n- CGV Vincom Times City\r\n\r\n- CGV Vivo City\r\n\r\n- CGV Thu Duc\r\n\r\n- CGV Vincom Go Vap\r\n\r\n- CGV Vincom Da Nang\r\n\r\n- CGV Pearl Plaza\r\n\r\n- CGV Aeon Canary Binh Duong\r\n\r\n- CGV Binh Duong Square\r\n\r\n- CGV Aeon Binh Tan\r\n\r\n- CGV Crescent Mall\r\n\r\n- CGV Vincom Dong Khoi\r\n\r\n- CGV Pandora\r\n\r\n- CGV Vinh Trung Plaza\r\n\r\n- CGV Artemis\r\n\r\n- CGV Liberty Hoang Van Thu\r\n\r\n- CGV CT Plaza\r\n\r\n- CGV Ho Guom Plaza\r\n\r\n \r\n\r\n\r\nTặng Áo Mưa Migo khi mua 4 vé. Áp dụng tại\r\n\r\n- CGV Su Van Hanh\r\n\r\n- CGV Vincom Tower\r\n\r\n- CGV Aeon Long Bien\r\n\r\n- CGV Vincom Nguyen Chi Thanh\r\n\r\n- CGV Vincom Landmark\r\n\r\n- CGV Vincom Royal City\r\n\r\n- CGV Tan Phu Celadon\r\n\r\n- CGV Indochina Plaza Hanoi\r\n\r\n \r\n\r\n\r\nSố lượng quà tặng có hạn\r\n\r\nChương trình kết thúc khi hết quà\r\n\r\nKhông áp dụng cùng lúc với các chương trình khuyến mãi khác của CGV và đối tác', '0000-00-00', '0000-00-00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `paypalPaymentId` text COLLATE utf8_unicode_ci NOT NULL,
  `create_time` text COLLATE utf8_unicode_ci NOT NULL,
  `update_time` text COLLATE utf8_unicode_ci NOT NULL,
  `state` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `amount` decimal(6,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `userId`, `paypalPaymentId`, `create_time`, `update_time`, `state`, `amount`, `currency`, `created_at`, `updated_at`) VALUES
(1, 1, '1', '1', '1', '1', '122.00', 'USD', '2018-10-10 01:35:35', '2018-10-10 01:35:35'),
(2, 1, 'PAY-3AL91352AS339680ALO6V7IY', '2018-10-10T02:10:43Z', '2018-10-10T02:10:44Z', 'created', '0.95', 'USD', '2018-10-10 02:10:34', '2018-10-10 02:10:34'),
(3, 1, 'PAY-46R522568G852162XLO6WEPQ', '2018-10-10T02:21:50Z', '2018-10-10T02:21:52Z', 'created', '0.95', 'USD', '2018-10-10 02:21:42', '2018-10-10 02:21:42'),
(4, 1, 'PAY-06N73997TS9441932LO6WHBQ', '2018-10-10T02:27:18Z', '2018-10-10T02:27:19Z', 'created', '0.95', 'USD', '2018-10-10 02:27:10', '2018-10-10 02:27:10'),
(5, 1, 'PAY-251878460H537745YLO6W3WA', '2018-10-10T03:12:36Z', '2018-10-10T03:12:34Z', 'approved', '14.63', 'USD', '2018-10-10 03:12:27', '2018-10-10 03:12:27'),
(6, 1, 'PAY-71G20499JF3134629LO6XBNY', '2018-10-10T03:24:19Z', '2018-10-10T03:24:16Z', 'approved', '8.17', 'USD', '2018-10-10 03:24:10', '2018-10-10 03:24:10'),
(7, 1, 'PAY-7FP61083HH4283743LO6XMGQ', '2018-10-10T03:47:10Z', '2018-10-10T03:47:07Z', 'approved', '4.09', 'USD', '2018-10-10 03:47:00', '2018-10-10 03:47:00'),
(8, 1, 'PAY-18B399036L336811SLO6XNKI', '2018-10-10T03:49:26Z', '2018-10-10T03:49:23Z', 'approved', '4.09', 'USD', '2018-10-10 03:49:16', '2018-10-10 03:49:16'),
(9, 1, 'PAY-6R096680W3230380NLO6XOSA', '2018-10-10T03:52:22Z', '2018-10-10T03:52:16Z', 'approved', '0.41', 'USD', '2018-10-10 03:52:14', '2018-10-10 03:52:14'),
(10, 1, 'PAY-2TM28654587290905LO6X47Q', '2018-10-10T04:24:11Z', '2018-10-10T04:24:08Z', 'approved', '0.47', 'USD', '2018-10-10 04:24:02', '2018-10-10 04:24:02'),
(11, 1, 'PAY-41J30661UR8774735LPCVSYI', '2018-10-16T03:23:09Z', '2018-10-16T03:23:07Z', 'approved', '1.46', 'USD', '2018-10-16 03:22:51', '2018-10-16 03:22:51'),
(12, 1, 'PAY-3S1291927X2096848LPCVVKA', '2018-10-16T03:27:56Z', '2018-10-16T03:27:54Z', 'approved', '0.47', 'USD', '2018-10-16 03:27:37', '2018-10-16 03:27:37'),
(13, 1, 'PAY-0LE27115RT278524NLPDLFKA', '2018-10-17T03:57:08Z', '2018-10-17T03:57:06Z', 'approved', '0.60', 'USD', '2018-10-17 03:56:48', '2018-10-17 03:56:48'),
(14, 1, 'PAY-18L4527733464573ULPDLQYI', '2018-10-17T04:20:11Z', '2018-10-17T04:20:09Z', 'approved', '1.46', 'USD', '2018-10-17 04:19:50', '2018-10-17 04:19:50'),
(15, 1, 'PAY-869474939A162681DLPDL66I', '2018-10-17T04:50:29Z', '2018-10-17T04:50:27Z', 'approved', '1.69', 'USD', '2018-10-17 04:50:08', '2018-10-17 04:50:08'),
(16, 1, 'PAY-03T65931YR727045VLPDL7VA', '2018-10-17T04:51:52Z', '2018-10-17T04:51:51Z', 'approved', '1.26', 'USD', '2018-10-17 04:51:32', '2018-10-17 04:51:32'),
(17, 1, 'PAY-36P861931L906804JLPDMAQQ', '2018-10-17T04:53:49Z', '2018-10-17T04:53:47Z', 'approved', '0.75', 'USD', '2018-10-17 04:53:28', '2018-10-17 04:53:28'),
(18, 1, 'PAY-90T63544VB238372ELPDMDPQ', '2018-10-17T05:00:33Z', '2018-10-17T05:00:32Z', 'approved', '1.54', 'USD', '2018-10-17 05:00:13', '2018-10-17 05:00:13'),
(19, 1, 'PAY-63080700SS692083NLPE3NHA', '2018-10-19T10:50:28Z', '2018-10-19T10:50:24Z', 'approved', '1.07', 'USD', '2018-10-19 10:50:28', '2018-10-19 10:50:28');

-- --------------------------------------------------------

--
-- Table structure for table `plan_cinemas`
--

CREATE TABLE `plan_cinemas` (
  `id` int(11) NOT NULL,
  `show_date` date NOT NULL,
  `time_begin` time NOT NULL,
  `price_ticket` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `type_projector_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `plan_cinemas`
--

INSERT INTO `plan_cinemas` (`id`, `show_date`, `time_begin`, `price_ticket`, `movie_id`, `room_id`, `type_projector_id`, `created_at`, `updated_at`) VALUES
(1, '2018-09-26', '11:10:00', 90000, 1, 1, 2, NULL, NULL),
(2, '2018-09-26', '14:00:00', 90000, 1, 1, 2, NULL, '2018-09-26 04:20:21'),
(3, '2018-09-26', '14:00:00', 90000, 3, 2, 2, NULL, '2018-09-26 13:43:19'),
(4, '2018-09-26', '16:00:00', 80000, 2, 2, 3, NULL, '2018-09-27 18:51:05'),
(5, '2018-09-26', '14:00:00', 90000, 1, 3, 2, NULL, '2018-09-26 04:20:21'),
(6, '2018-09-28', '15:00:00', 90000, 1, 3, 3, NULL, '2018-10-06 05:14:07'),
(7, '2018-09-28', '14:00:00', 90000, 1, 1, 2, NULL, '2018-10-06 05:12:12'),
(8, '2018-10-09', '18:20:00', 60000, 5, 1, 2, NULL, '2018-10-08 17:10:00'),
(9, '2018-10-09', '13:20:00', 90000, 1, 1, 2, NULL, '2018-10-06 05:12:12'),
(10, '2018-10-09', '16:20:00', 90000, 1, 2, 2, NULL, '2018-10-06 05:12:12'),
(11, '2018-10-10', '23:50:00', 90000, 1, 2, 2, NULL, '2018-10-09 16:26:31'),
(12, '2018-10-17', '15:20:00', 50000, 5, 2, 2, NULL, '2018-10-17 03:54:36'),
(13, '2018-10-16', '05:20:00', 50000, 5, 2, 2, NULL, '2018-10-16 04:14:40'),
(14, '2018-10-20', '16:20:00', 50000, 5, 2, 2, NULL, '2018-10-19 10:47:12');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `show_booking` tinyint(1) NOT NULL COMMENT '0 ko show, 1 show',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `image`, `price`, `description`, `show_booking`, `created_at`, `updated_at`) VALUES
(1, 'Combo 2 nước 1 bắp', '1.png', 9500, '!!! Tiết kiệm hơn khi mua online 1 Bắp (M) + 1 Nước (L) + Nâng cấp vị phô mai/caramel miễn phí. Nhận trong ngày xem phim', 1, NULL, '2018-10-10 03:50:45'),
(2, '1 nước 1 bắp', '2.png', 5000, '!!! Tiết kiệm hơn khi mua online 1 Bắp (M) + 1 Nước (L) + Nâng cấp vị phô mai/caramel miễn phí. Nhận trong ngày xem phim', 1, NULL, '2018-10-10 03:50:51'),
(3, 'Combo mùa hè bất tận (1 nước lớn 1 bắp vị phô mai)', '3.png', 9900, '!!! Tiết kiệm hơn khi mua online 1 Bắp (M) + 1 Nước (L) + Nâng cấp vị phô mai/caramel miễn phí. Nhận trong ngày xem phim', 1, NULL, '2018-10-10 03:50:50'),
(4, 'Nước lớn', '4.png', 2000, '!!! Tiết kiệm hơn khi mua online 1 Bắp (M) + 1 Nước (L) + Nâng cấp vị phô mai/caramel miễn phí. Nhận trong ngày xem phim', 1, NULL, '2018-10-10 03:50:48');

-- --------------------------------------------------------

--
-- Table structure for table `provinces`
--

CREATE TABLE `provinces` (
  `id` tinyint(4) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `provinces`
--

INSERT INTO `provinces` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Hà Nội', NULL, NULL),
(2, 'Hồ Chí Minh', NULL, NULL),
(3, 'Đồng Nai', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `view_id` int(11) NOT NULL,
  `cinema_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `name`, `view_id`, `cinema_id`, `created_at`, `updated_at`) VALUES
(1, 'C1', 1, 1, NULL, '2018-10-08 05:59:11'),
(2, 'C2', 2, 1, NULL, '2018-10-08 05:59:16'),
(3, 'C1', 1, 2, NULL, '2018-10-08 05:59:20'),
(4, 'C2', 1, 2, NULL, '2018-10-08 05:59:24');

-- --------------------------------------------------------

--
-- Table structure for table `seats`
--

CREATE TABLE `seats` (
  `id` int(11) NOT NULL,
  `row_name` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `col_name` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `room_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `seats`
--

INSERT INTO `seats` (`id`, `row_name`, `col_name`, `room_id`, `created_at`, `updated_at`) VALUES
(1, 'A', '1', 1, NULL, NULL),
(2, 'A', '2', 1, NULL, NULL),
(3, 'A', '3', 1, NULL, NULL),
(4, 'A', '4', 1, NULL, NULL),
(5, 'B', '1', 1, NULL, NULL),
(6, 'B', '2', 1, NULL, NULL),
(7, 'B', '3', 1, NULL, NULL),
(8, 'B', '4', 1, NULL, NULL),
(9, 'C', '1', 1, NULL, NULL),
(10, 'C', '2', 1, NULL, NULL),
(11, 'C', '3', 1, NULL, NULL),
(12, 'C', '4', 1, NULL, NULL),
(13, 'D', '1', 1, NULL, NULL),
(14, 'D', '2', 1, NULL, NULL),
(15, 'D', '3', 1, NULL, NULL),
(16, 'D', '4', 1, NULL, NULL),
(17, 'A', '1', 2, NULL, NULL),
(18, 'A', '2', 2, NULL, NULL),
(19, 'A', '3', 2, NULL, NULL),
(20, 'A', '4', 2, NULL, NULL),
(21, 'B', '1', 2, NULL, NULL),
(22, 'B', '2', 2, NULL, NULL),
(23, 'B', '3', 2, NULL, NULL),
(24, 'B', '4', 2, NULL, NULL),
(25, 'C', '1', 2, NULL, NULL),
(26, 'C', '2', 2, NULL, NULL),
(27, 'C', '3', 2, NULL, NULL),
(28, 'C', '4', 2, NULL, NULL),
(29, 'D', '1', 2, NULL, NULL),
(30, 'D', '2', 2, NULL, NULL),
(31, 'D', '3', 2, NULL, NULL),
(32, 'D', '4', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `spendings`
--

CREATE TABLE `spendings` (
  `id` int(11) NOT NULL,
  `year` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `total` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `buy_date` date NOT NULL,
  `plan_cinema_id` int(11) NOT NULL,
  `seat_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `buy_date`, `plan_cinema_id`, `seat_id`, `invoice_id`, `created_at`, `updated_at`) VALUES
(1, '2018-09-28', 4, 17, 1, NULL, NULL),
(2, '2018-09-28', 4, 18, 1, NULL, NULL),
(3, '2018-09-28', 1, 2, 2, NULL, NULL),
(6, '2018-09-29', 4, 19, 1, '2018-09-29 07:47:06', '2018-09-29 07:47:06'),
(7, '2018-09-29', 4, 23, 1, '2018-09-29 07:47:06', '2018-09-29 07:47:06'),
(8, '2018-09-29', 4, 24, 1, '2018-09-29 07:47:06', '2018-09-29 07:47:06'),
(9, '2018-10-02', 4, 27, 1, '2018-10-02 04:55:37', '2018-10-02 04:55:37'),
(10, '2018-10-02', 4, 31, 1, '2018-10-02 04:55:37', '2018-10-02 04:55:37'),
(11, '2018-10-02', 4, 21, 1, '2018-10-02 04:55:51', '2018-10-02 04:55:51'),
(12, '2018-10-02', 4, 22, 1, '2018-10-02 04:55:51', '2018-10-02 04:55:51'),
(13, '2018-10-02', 4, 21, 1, '2018-10-02 04:56:21', '2018-10-02 04:56:21'),
(14, '2018-10-02', 4, 22, 1, '2018-10-02 04:56:21', '2018-10-02 04:56:21'),
(15, '2018-10-10', 11, 23, 1, '2018-10-09 17:40:26', '2018-10-09 17:40:26'),
(16, '2018-10-10', 11, 24, 1, '2018-10-09 17:40:26', '2018-10-09 17:40:26'),
(17, '2018-10-10', 11, 27, 1, '2018-10-09 17:45:07', '2018-10-09 17:45:07'),
(18, '2018-10-10', 11, 31, 1, '2018-10-09 17:45:07', '2018-10-09 17:45:07'),
(19, '2018-10-10', 11, 32, 1, '2018-10-09 17:47:22', '2018-10-09 17:47:22'),
(20, '2018-10-10', 11, 30, 1, '2018-10-09 17:48:19', '2018-10-09 17:48:19'),
(21, '2018-10-10', 11, 29, 1, '2018-10-09 17:48:19', '2018-10-09 17:48:19'),
(22, '2018-10-10', 11, 17, 9, '2018-10-10 03:49:17', '2018-10-10 03:49:17'),
(23, '2018-10-10', 11, 18, 10, '2018-10-10 03:52:14', '2018-10-10 03:52:14'),
(24, '2018-10-10', 11, 19, 11, '2018-10-10 04:24:02', '2018-10-10 04:24:02'),
(25, '2018-10-16', 12, 23, 12, '2018-10-16 03:22:51', '2018-10-16 03:22:51'),
(26, '2018-10-16', 12, 24, 12, '2018-10-16 03:22:51', '2018-10-16 03:22:51'),
(27, '2018-10-16', 12, 19, 13, '2018-10-16 03:27:37', '2018-10-16 03:27:37'),
(28, '2018-10-17', 12, 20, 14, '2018-10-17 03:56:48', '2018-10-17 03:56:48'),
(29, '2018-10-17', 12, 26, 15, '2018-10-17 04:19:50', '2018-10-17 04:19:50'),
(30, '2018-10-17', 12, 27, 15, '2018-10-17 04:19:50', '2018-10-17 04:19:50'),
(31, '2018-10-17', 12, 17, 16, '2018-10-17 04:50:08', '2018-10-17 04:50:08'),
(32, '2018-10-17', 12, 18, 16, '2018-10-17 04:50:08', '2018-10-17 04:50:08'),
(33, '2018-10-17', 12, 21, 17, '2018-10-17 04:51:32', '2018-10-17 04:51:32'),
(34, '2018-10-17', 12, 22, 17, '2018-10-17 04:51:32', '2018-10-17 04:51:32'),
(35, '2018-10-17', 12, 30, 18, '2018-10-17 04:53:28', '2018-10-17 04:53:28'),
(36, '2018-10-17', 12, 29, 19, '2018-10-17 05:00:13', '2018-10-17 05:00:13'),
(37, '2018-10-19', 14, 24, 20, '2018-10-19 10:50:28', '2018-10-19 10:50:28'),
(38, '2018-10-19', 14, 23, 20, '2018-10-19 10:50:28', '2018-10-19 10:50:28');

-- --------------------------------------------------------

--
-- Table structure for table `type_projectors`
--

CREATE TABLE `type_projectors` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `type_projectors`
--

INSERT INTO `type_projectors` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, '2D Lồng tiếng Việt', NULL, NULL),
(2, '2D phụ đề Việt', NULL, NULL),
(3, '3D', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `type_seats`
--

CREATE TABLE `type_seats` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `symbol` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `show_status` tinyint(1) NOT NULL COMMENT '0: khong show, 1: show',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `type_seats`
--

INSERT INTO `type_seats` (`id`, `name`, `slug_name`, `color`, `price`, `symbol`, `show_status`, `created_at`, `updated_at`) VALUES
(1, 'Đã đặt', 'unavailable', '#472B34', 0, 'c', 0, NULL, '2018-09-29 14:42:40'),
(2, 'Đã chọn', 'selected', '#91268F', 0, 'c', 0, NULL, '2018-09-29 14:39:19'),
(3, 'Thường', 'normal', '#3A78C3', 7500, 'a', 1, NULL, '2018-10-10 03:51:03'),
(4, 'Vip', 'vip', '#D00000', 9000, 'b', 1, NULL, '2018-10-10 03:51:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` tinyint(4) NOT NULL,
  `sex` tinyint(4) NOT NULL COMMENT '1 nam, 2 nu',
  `birthday` date DEFAULT NULL,
  `province` tinyint(4) NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_card_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_card_member` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `point` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `phone`, `level`, `sex`, `birthday`, `province`, `address`, `id_card_number`, `id_card_member`, `point`, `created_at`, `updated_at`) VALUES
(1, 'loc nguyen', 'vanloctech@gmail.com', '$2y$12$Vtrw/cnR7E/1z2LiRvPwL.kalBf.d4P629MUM1HU8dnqIy4yE1nTm', '1aqe6Axoa3zODCW4nlKfgNtn8LX4cdKOr22Ns29MjioS5yWlEnrwoHxWo4q8', '0355609955', 0, 1, '1998-06-08', 3, 'Long Thành', '272605417', '1234567890123456', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `view_rooms`
--

CREATE TABLE `view_rooms` (
  `id` int(11) NOT NULL,
  `view` text COLLATE utf8_unicode_ci NOT NULL,
  `row` text COLLATE utf8_unicode_ci NOT NULL,
  `col` text COLLATE utf8_unicode_ci NOT NULL,
  `max_seat` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `view_rooms`
--

INSERT INTO `view_rooms` (`id`, `view`, `row`, `col`, `max_seat`, `created_at`, `updated_at`) VALUES
(1, 'aaaaaaaaaa__,aaaaaaaaaaaa,__________aa,aaaaaaaa__aa,aaaaaaaaaaaa,aaaaaaaaaa__,aaaaaaaaaaaa,aaaaaaaaaaaa,aaaaaaaaaa_a,__aaaaaa____', 'A,B,C,D,E,F,G,H,I,J', '1,2,3,4,5,6,7,8,9,10,11,12', 97, NULL, '2018-10-08 05:58:34'),
(2, 'aa_bb,aa_aa,_a_a_,aa_aa', 'A,B,C,D', '1,2,,3,4', 14, NULL, '2018-10-08 05:56:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cinemas`
--
ALTER TABLE `cinemas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news_offers`
--
ALTER TABLE `news_offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `plan_cinemas`
--
ALTER TABLE `plan_cinemas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `spendings`
--
ALTER TABLE `spendings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `type_projectors`
--
ALTER TABLE `type_projectors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `type_seats`
--
ALTER TABLE `type_seats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `view_rooms`
--
ALTER TABLE `view_rooms`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cinemas`
--
ALTER TABLE `cinemas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `invoice_details`
--
ALTER TABLE `invoice_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `movies`
--
ALTER TABLE `movies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `news_offers`
--
ALTER TABLE `news_offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `plan_cinemas`
--
ALTER TABLE `plan_cinemas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `provinces`
--
ALTER TABLE `provinces`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `seats`
--
ALTER TABLE `seats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `spendings`
--
ALTER TABLE `spendings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `type_projectors`
--
ALTER TABLE `type_projectors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `type_seats`
--
ALTER TABLE `type_seats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `view_rooms`
--
ALTER TABLE `view_rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
