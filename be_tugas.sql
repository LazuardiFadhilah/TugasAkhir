-- -------------------------------------------------------------
-- TablePlus 5.9.0(538)
--
-- https://tableplus.com/
--
-- Database: be_tugas
-- Generation Time: 2024-03-14 23:10:07.8340
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `Files`;
CREATE TABLE `Files` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `postcategories`;
CREATE TABLE `postcategories` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `postId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `categoryId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `postId` (`postId`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `postcategories_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `posts` (`id`),
  CONSTRAINT `postcategories_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `Posts`;
CREATE TABLE `Posts` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `thumbnail` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('Draft','Published') DEFAULT 'Draft',
  `slug` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `thumbnail` (`thumbnail`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`thumbnail`) REFERENCES `Files` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `SequelizeMeta`;
CREATE TABLE `SequelizeMeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` enum('Super Admin','Creator') DEFAULT 'Creator',
  `password` varchar(255) NOT NULL,
  `status` enum('Active','Suspend') DEFAULT 'Active',
  `avatar` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `avatar` (`avatar`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`avatar`) REFERENCES `Files` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Categories` (`id`, `title`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
('1aeb2051-fe8d-4a11-b3a6-4b9c17226644', 'laravel', '2024-03-11 14:07:43', '2024-03-11 14:25:32', NULL),
('48b7b542-0737-49de-934c-9a416cb10171', 'Backend', '2024-03-11 10:30:14', '2024-03-11 10:30:14', '2024-03-11 14:31:58'),
('6d09a3db-1962-4f33-8a61-0ac47e096eeb', 'FrontEnd', '2024-03-11 10:30:14', '2024-03-11 10:30:14', NULL),
('a677f1df-0e32-4685-bee5-322d5f67265c', 'flutter', '2024-03-11 14:04:59', '2024-03-11 14:04:59', NULL),
('c4522ac2-60f6-451f-81e9-18ec4ff0d851', 'Technology', '2024-03-11 10:30:14', '2024-03-11 10:30:14', NULL);

INSERT INTO `Files` (`id`, `filename`, `type`, `url`, `path`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
('5365a30b-6841-4f23-b9c6-e863ff653134', 'Screenshot 2024-03-11 at 13.38.30 (2).png', 'image/png', 'http://localhost:3000/src/uploads/1710230745681-Screenshot 2024-03-11 at 13.38.30 (2).png', 'src/uploads/1710230745681-Screenshot 2024-03-11 at 13.38.30 (2).png', '2024-03-12 08:05:45', '2024-03-12 08:05:45', NULL),
('76bda333-1734-4cc0-9778-230aee9bed9e', 'Screenshot 2024-03-11 at 13.38.30 (2).png', 'image/png', 'http://localhost:3000/src/uploads/1710229558589-Screenshot 2024-03-11 at 13.38.30 (2).png', 'src/uploads/1710229558589-Screenshot 2024-03-11 at 13.38.30 (2).png', '2024-03-12 07:45:58', '2024-03-12 07:45:58', NULL),
('9e3bafe4-d162-45f1-b581-40a4773a874b', 'Screenshot 2024-03-11 at 13.38.30 (2).png', 'image/png', 'http://localhost:3000/src/uploads/1710230705657-Screenshot 2024-03-11 at 13.38.30 (2).png', 'src/uploads/1710230705657-Screenshot 2024-03-11 at 13.38.30 (2).png', '2024-03-12 08:05:05', '2024-03-12 08:05:05', NULL),
('b694fdeb-815c-4d3d-8cac-3a42b93264cb', 'Screenshot 2024-03-11 at 13.38.30 (2).png', 'image/png', 'http://localhost:3000/src/uploads/1710230430091-Screenshot 2024-03-11 at 13.38.30 (2).png', 'src/uploads/1710230430091-Screenshot 2024-03-11 at 13.38.30 (2).png', '2024-03-12 08:00:30', '2024-03-12 08:00:30', NULL),
('becc3e2c-7021-46ef-975a-d017d336fb49', 'Screenshot 2024-03-11 at 13.38.30 (2).png', 'image/png', 'http://localhost:3000/src/uploads/1710230335219-Screenshot 2024-03-11 at 13.38.30 (2).png', 'src/uploads/1710230335219-Screenshot 2024-03-11 at 13.38.30 (2).png', '2024-03-12 07:58:55', '2024-03-12 07:58:55', NULL),
('c4d93335-28aa-48d7-87ac-2fa0acca2ee6', 'Screenshot 2024-03-11 at 13.38.30.png', 'image/png', 'http://localhost:3000/src/uploads/1710229294853-Screenshot 2024-03-11 at 13.38.30.png', 'src/uploads/1710229294853-Screenshot 2024-03-11 at 13.38.30.png', '2024-03-12 07:41:34', '2024-03-12 07:41:34', NULL),
('e768d5b3-7b82-4c50-aea3-7ee980184c34', 'Screenshot 2024-03-11 at 13.38.30 (2).png', 'image/png', 'http://localhost:3000/src/uploads/1710229460805-Screenshot 2024-03-11 at 13.38.30 (2).png', 'src/uploads/1710229460805-Screenshot 2024-03-11 at 13.38.30 (2).png', '2024-03-12 07:44:20', '2024-03-12 07:44:20', NULL);

INSERT INTO `postcategories` (`id`, `postId`, `categoryId`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
('03c9167a-9b37-4836-af55-966355324fba', '7aa17c4b-cee8-4b98-abc1-ef41f1e189cf', 'a677f1df-0e32-4685-bee5-322d5f67265c', '2024-03-14 09:35:10', '2024-03-14 09:35:10', NULL),
('50079b2d-9c1e-4542-972b-5fa39aa9bdc6', '7aa17c4b-cee8-4b98-abc1-ef41f1e189cf', 'a677f1df-0e32-4685-bee5-322d5f67265c', '2024-03-14 09:30:12', '2024-03-14 09:30:12', NULL),
('931ef458-e0f2-4c1b-b130-dee47db3e613', '7aa17c4b-cee8-4b98-abc1-ef41f1e189cf', 'a677f1df-0e32-4685-bee5-322d5f67265c', '2024-03-14 09:30:31', '2024-03-14 09:30:31', NULL),
('f85ad5ae-8a94-4f47-a6f6-5af279890be2', '7aa17c4b-cee8-4b98-abc1-ef41f1e189cf', 'a677f1df-0e32-4685-bee5-322d5f67265c', '2024-03-14 09:35:26', '2024-03-14 09:35:26', NULL);

INSERT INTO `Posts` (`id`, `title`, `description`, `thumbnail`, `status`, `slug`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
('0a0dfd53-74d8-43c1-9aef-482b48652a74', 'test first post 3', 'test description on first post', NULL, 'Published', 'test-first-post-3', '2024-03-14 11:43:13', '2024-03-14 11:43:13', NULL),
('7aa17c4b-cee8-4b98-abc1-ef41f1e189c2', 'test first post', 'test description on first post', 'c4d93335-28aa-48d7-87ac-2fa0acca2ee6', 'Published', 'test-first-post', '2024-03-12 06:49:20', '2024-03-12 06:49:20', '2024-03-14 08:10:46'),
('7aa17c4b-cee8-4b98-abc1-ef41f1e189cf', 'test post baru ? update 4', 'test post baru ? description update', 'c4d93335-28aa-48d7-87ac-2fa0acca2ee6', 'Published', 'test-post-baru-update-4', '2024-03-12 06:49:20', '2024-03-14 16:07:00', NULL),
('89c6a409-cba3-4802-81a8-98348e8d9358', 'test first post 5', 'test description on first post', NULL, 'Published', 'test-first-post-5', '2024-03-14 11:48:42', '2024-03-14 11:48:42', NULL),
('d4baf50c-0303-48a8-b630-fd48f83355f6', 'test first post 2', 'test description on first post', NULL, 'Published', 'test-first-post-2', '2024-03-14 11:41:57', '2024-03-14 11:41:57', NULL),
('e7815882-25c6-43c3-bb41-20f3f5d3f6e6', 'test first post 4', 'test description on first post', NULL, 'Published', 'test-first-post-4', '2024-03-14 11:43:48', '2024-03-14 11:43:48', NULL);

INSERT INTO `SequelizeMeta` (`name`) VALUES
('20240305135454-create-users.js'),
('20240311071346-create-posts.js'),
('20240311102321-create-category.js'),
('20240312065534-create-files.js'),
('20240312091900-change-avatar-in-users.js'),
('20240312093148-realation-users-with-files.js'),
('20240313140239-change-post-thumbnail-datatype.js'),
('20240313140350-relation-post-to-file.js'),
('20240314084419-create-postcategories.js');

INSERT INTO `Users` (`id`, `fullName`, `email`, `role`, `password`, `status`, `avatar`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
('03cc2170-2679-4ce7-80f8-1338ec5566a2', 'Ismael Mohr', 'Roy_Mohr28@hotmail.com', 'Super Admin', '$2b$10$AgHgLOm64uj6tNjHS2pdB.zP71jn/ZI7TZBBffk2DnxmAVu77fbm2', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', '2024-03-09 16:28:18'),
('04035b39-4ff3-4111-abf9-73be3a0eb436', 'Andikha', 'Andikha@email.com', 'Creator', '$2b$10$xMoh2MvkJ/Z9UPTVGyPYzehWPChrpAKt2Q./H8.5KmBqZN1pBaqoK', 'Active', NULL, '2024-03-05 14:27:43', '2024-03-06 14:46:29', NULL),
('0c4c4e5f-a434-472f-9aea-a3a3cf3e352e', 'Blanche Moore', 'Rey45@gmail.com', 'Super Admin', '$2b$10$edq1rHA.CAzOBPePJy9fF.OqKmqY/iMxuZWO0jjuDUPYb1MQ4JEcG', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', '2024-03-09 17:11:24'),
('0e178d0b-c7ec-4c2a-bb30-f0d38497493b', 'Carlton Durgan', 'Doris11@yahoo.com', 'Creator', '$2b$10$93wTqoZo/neJC8WpZrWjSOAbXDbEUt1hYgUFgxrIULczQ5eUvJ366', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('0fa57d4b-be74-47c0-8569-0b747d215e23', 'Rufus Grant', 'Jamal.Johnston-MacGyver@hotmail.com', 'Super Admin', '$2b$10$Z7NaRRfOhobBkyDRTdbpeOSITmCn1ION8eUXAHlrHjSitFYQwYc32', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('0ffed5e6-bf1a-4caf-b82b-e85d458ed8f4', 'Bessie Corwin', 'Ludie.Schaden47@gmail.com', 'Super Admin', '$2b$10$GymFFs1IEcM4.Cs8FKyoGOD6c4zHVJXohVm/krlp3yUVhJN1.RJQi', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('1248121c-1a62-475f-a780-57f0e3ef4643', 'Danielle Kassulke-Flatley', 'Gail7@hotmail.com', 'Super Admin', '$2b$10$5DwuXhnC/CI7fcK7CsmbFurYnFnXCvBcMZ4zc30AMpPDEgiFyIJ9i', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('16206b74-934b-485b-9c1a-cdb7064542d5', 'Linda', 'linda@email.com', 'Creator', '$2b$10$lBMZwvDiMyOfDqAhv0.Ek.7iS5zpIt9iVZINXKIIpmk1ygjn9BK12', 'Active', NULL, '2024-03-06 14:12:45', '2024-03-06 14:12:45', NULL),
('16cff705-b459-469a-9ec2-924727d22e03', 'Wanda Kozey', 'Dulce61@gmail.com', 'Super Admin', '$2b$10$WA.ftLZpxG1Degc.kdL3X.LuEeRC8hZ.jUoqkkqF7UG0KiXBEPIP2', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('171ca0c9-8b64-48ca-983d-84c62e648dfd', 'Verna Rosenbaum', 'Wiley_Rogahn40@yahoo.com', 'Super Admin', '$2b$10$Q.Cg6vtcqE334tmqNIfo4uxcKdpmfqvL0aK3p9B0px24r6sSaXWwq', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('19176e2a-3fe9-4173-88e4-3a31f0e53660', 'Gretchen Gleichner', 'Trenton37@gmail.com', 'Creator', '$2b$10$bvw63Jm3Z.5K0eKR4TVV4.WPVA0XfqVh3V8SPb8fzLUvkajjjfuFu', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('1a6dc139-bacb-40db-b0d9-b6aa2ead76af', 'Ruby Botsford', 'Santino.OKeefe59@hotmail.com', 'Creator', '$2b$10$w1DHQoC9Y9w15te2KyHELeemfN6zby7rXt0bDSip4P/wkIvWA9J46', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('1e85746a-b8cc-4a36-a3ac-c9bd8d510eaa', 'Pablo Stroman', 'Timmy.Shanahan@hotmail.com', 'Creator', '$2b$10$wO9cM4IfErRo5mtOnhLjbOSa3lilG1i8KWqXpiI5aNgdibPbEzvM.', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('211a59ac-5090-45e5-8e61-78fae2b959a0', 'Miriam Wisozk', 'Fermin_Quitzon@gmail.com', 'Super Admin', '$2b$10$7.OoQF5xXarK8UU77cNrNu5hyLQrS/uTUJ3qTOzFzfLH5NqaHtEsu', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('2198d3f2-eaf6-4236-990e-0b3e88bce435', 'Johnnie Collier', 'Nat_Turner@gmail.com', 'Creator', '$2b$10$xsyasgq8Z91ywI8pgbBkfezJ2Uy4Ctm7IU0NuNx0k7KsZH5nhJrku', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('250a53f8-085e-44ec-be6e-0799ed221f7f', 'Pete Klocko', 'Santino25@yahoo.com', 'Creator', '$2b$10$/eQO56jkv/nSlW98zN54pOvwwHDp3RfNF4qm3hPiN1Y9OzT9LWaiW', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('27bd6c35-5b4f-428d-87d7-01378dd4735f', 'Jacqueline Harber', 'Dedric.Rohan@yahoo.com', 'Super Admin', '$2b$10$bgb4Lyh57EmyT.XwNbVUn.zdOuNtZRKRe.ZNd7qG0nIz78ieDMnbS', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('2843245a-dca0-45e6-9e2d-36d496e75fe2', 'Earl Heaney', 'Haylie_Schimmel85@yahoo.com', 'Creator', '$2b$10$Tt/5ElS.GJ8VkIvfnYFWGuw32BJJ6rcZtqWJHe1d3OnvmG8eiXfH2', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('2bf79c47-31a1-44a6-88a1-5dca92e0c222', 'Marcus Toy-Rodriguez', 'Blaze.Hayes@hotmail.com', 'Super Admin', '$2b$10$/r643lOWdacV8aEH3G2/COro29f.TBkmvEVrLKx1Z8lFKxXW0MuGO', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('302700e1-5841-437a-9a60-d3c9b77a0245', 'Felicia Altenwerth', 'Kennedy23@yahoo.com', 'Creator', '$2b$10$f/eaATp7MADJUPphdAA6z.I4BPUouhLmAx9C8exFiFB1Y1vAb2QuC', 'Active', NULL, '2024-03-09 14:41:18', '2024-03-09 14:41:18', NULL),
('310ca79d-01d5-45a4-934b-091e96dec472', 'Mr. Ralph Fadel', 'Nash75@hotmail.com', 'Super Admin', '$2b$10$PLe52oOlHX.winbVidaXTuaa4VuHYFuDLYP5tj6/AYj0oNzT281u.', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('31a6bf46-9208-47fe-902e-1b3764c46b61', 'Marjorie Gerhold MD', 'Brendon.Cummerata27@gmail.com', 'Creator', '$2b$10$0ay5.3LSgBRPABVNNzmUauQ.1p9t05fOqGrq/4/QVO3sGEhw.Fa5K', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('328c55ec-9366-40ba-a3ac-e6cd87f2bdbd', 'Bonnie Oberbrunner', 'Stuart98@gmail.com', 'Super Admin', '$2b$10$sVRG8mW8y3oKcRfu0P25R.ojiXG/a3JxzHgHfCFSCeuaGAxaGc2O6', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('354cc8c8-7216-4b22-8350-b793498fe29a', 'Fidelia Rahayu', 'fidelia@email.com', 'Creator', '$2b$10$N4kLU7jwx67NOdZJGK8xROdR43pzT96ooGIWJC19qNl2t7GLuv7se', 'Active', NULL, '2024-03-06 14:08:37', '2024-03-06 14:08:37', NULL),
('36598760-1229-44df-8162-a808dc9bd37d', 'ardi13', 'ardi13@email.com', 'Creator', '$2b$10$KFNM4egb3m51w541bc0AXOb8G6lvzG3jba9lTqpuEgkCvzyI6rQPC', 'Active', NULL, '2024-03-09 13:50:28', '2024-03-09 13:50:28', NULL),
('39405400-5f7c-4328-ae73-09d3d8693faf', 'Leonard Schroeder', 'Isidro_Buckridge-Howe@gmail.com', 'Creator', '$2b$10$6/zR6OhaFYpEaNXVyk4xP.1DyGXwygBvI88C5epFu.QxH6w3ZZlKK', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('39e54c41-c23b-45c0-ba60-dcd6bba52b1c', 'Brendan Wilderman-Connelly', 'Franco_Gerhold87@gmail.com', 'Super Admin', '$2b$10$nZwelfR.D3WtaiVoP6K1HOTV56ELpqPfOHcv08jHgTqKDqOeqGoN2', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('3b88f194-eca6-4ae0-9819-f99bb5c7905f', 'Lazuardi Fadhilah', 'lazuardiFadhilah@email.com', 'Super Admin', '$2b$10$p3q0kjjWhoBb2.LbphelS.7/OiVKlfTJpomQaytBo3Tl8FtXlC4Rq', 'Active', 'c4d93335-28aa-48d7-87ac-2fa0acca2ee6', '2024-03-11 06:16:12', '2024-03-12 09:45:14', NULL),
('3b8c86f5-bc6d-46b8-80c6-4cdf3d8404df', 'Dr. Jerry Nader', 'Elody_Rice26@yahoo.com', 'Creator', '$2b$10$G66p1JtDhW9Ttf9YobLJUuVrNWBZ6yjdw2fh5OBW61rTufIu5QuOW', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('4079afa3-ddee-4d34-85e8-571fbd95dcb0', 'Merle Rutherford III', 'Maci.Abbott@hotmail.com', 'Creator', '$2b$10$laiKzQyni3QdkaUxceqF1OQ3DjBCeRpeOj//BwIASSR3FgpXXwc8u', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('43718014-4ab9-4109-b36f-baff1eef196d', 'Gayle Hilll', 'Maurine.Johnson97@yahoo.com', 'Creator', '$2b$10$x2Whsi9TzVhxTWotJvOOfOpzc.XfnmGO7/h2LpDdHzzbisvJ0jpP6', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('47e15515-5107-45bf-8498-b17d2d2329d4', 'Miranda Adams', 'Dorothea68@yahoo.com', 'Creator', '$2b$10$VvrwB5ziWHt9hh8E4Uv8Fu6lXbLMgj6Us9rPXiISVinHe0DJVVaYO', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('488049f8-96ca-479f-b98f-aa638f01b51c', 'Cheryl Reinger', 'Dayne_Rogahn22@yahoo.com', 'Creator', '$2b$10$TuP84nzY5tklxcR25wED5OiqjGEq7vhPcVQvOadg0AiWg6iZ/euEC', 'Active', NULL, '2024-03-09 14:41:18', '2024-03-09 14:41:18', NULL),
('4b751141-5712-46b3-ad52-5d2c9d6d8e56', 'Elmer Conroy', 'Haskell_Stehr@yahoo.com', 'Creator', '$2b$10$lynhq71k9lF6y1wyYOSsjuYGxKNGJqnMsP.Osd02Bp/4EqAu0PvMa', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('4eeb9ac5-c4a8-48e9-a791-e35559a198d4', 'Jackie Wilkinson', 'Brody_Aufderhar@yahoo.com', 'Creator', '$2b$10$sgXkOmXLFXC4Ek9T7wG0Z.taj86Hc/scCZ.a5HfIn8tlV8el1Sp/y', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('548cb639-74dd-4f56-811b-11955a26db3d', 'Constance Hammes Jr.', 'Verona97@hotmail.com', 'Creator', '$2b$10$esVDQbwl20n/HW4D/rg1j.LlmUeZ.L2TWN2AlqAQ27UcSPPC1eTH6', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('552e4df4-f8ad-4b58-8bf2-230bda87009f', 'Terry Bashirian', 'Walter_Block@hotmail.com', 'Creator', '$2b$10$nJaY0mZWkPP2Ink1ydrfQu9awc.ajBf2kmJCl/mfA/sLuvJLKkT02', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('55f4db3d-df1e-4239-8fc0-4cf359e6d814', 'Candace Rohan', 'Laron22@gmail.com', 'Super Admin', '$2b$10$H2DBADyzzfYpXSjQEw4YQOBp4YsSC6lS2SDfDIaQQrgIGNYJHnLBC', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('56dfab92-eaac-4687-8ec7-5c289115e6ec', 'Sherman Johnson', 'Kendrick30@hotmail.com', 'Super Admin', '$2b$10$JbC5q8uGRyJnVz7N7HBCtuN4eGb76AYZZjDk8QEl5ty9vE2PCMIXy', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('57e0d69a-6ba4-45f0-bbe4-14e67f53ffcc', 'Samuel Bayer', 'Sammie_OKeefe@gmail.com', 'Super Admin', '$2b$10$lA6OJ9/azyCfs1yP3ZJPRO/R9XA6owvGxEKCzXHhpBDVxqDo7PmHu', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('57eb551e-8e51-4fba-b254-66e20f9aa04f', 'Edna Zieme', 'Alva_Dietrich37@yahoo.com', 'Super Admin', '$2b$10$j15bebE72sayOpmi/vc2X.eP4VdqRo1pFfBJmznmd0Czy7vb.jSPK', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('5ee19d24-c524-4169-bf1b-81083d126ace', 'Dana Bernhard', 'Amanda17@gmail.com', 'Creator', '$2b$10$13iuEjLBFnBQMTotCBfvL.K7rzk8Wsl6n8U5xn2QVmyQNx0QD4I3.', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('5fe77173-530a-4725-96f2-7172717ae3f5', 'Mr. Charlie Oberbrunner', 'Kellie6@yahoo.com', 'Creator', '$2b$10$qmKIlQwHmqMORceIq32.5un6huULirbh.Aj4OftTcFB15hzSiL50W', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('61710eec-15ac-445d-a8b2-2def7fbbb0b3', 'Lionel Schmitt', 'Emmett.Cruickshank@hotmail.com', 'Super Admin', '$2b$10$CyZtTnEcNAfBuvDmwuwNQ.kL7QX/8LlotBBBP2bHgNd6/.qfNGLOy', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('64684fdd-b976-4ee3-a950-e2fb9d3e875d', 'Ervin Huels', 'Forest_Sporer@hotmail.com', 'Super Admin', '$2b$10$QAsu4y8zB.Z5Em7i7hlJ7u5EHmjyOvYNS.pBGCLKUChBeWeoZUuL2', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('650f7c70-cf83-44aa-86e7-bd9302461fc7', 'Valerie Goldner', 'Rupert_Runolfsson@gmail.com', 'Creator', '$2b$10$MgJK9fb19Y.dJrO7LvsKlusnJOTd3V7tvR3oHdHMfvxgFabawo0Pe', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('65bf74a4-471a-4e91-8881-301e1d087080', 'Rudolph Purdy', 'Matt.Crooks10@yahoo.com', 'Super Admin', '$2b$10$hSDXBIDNfz6hS67ehl72SODT3dqtv8sRQl9d1etVK2kLhqxj0jRcS', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('66ca0cec-4278-4149-a23e-22d9f3691b24', 'Connie Abernathy-O\'Connell', 'Dion60@yahoo.com', 'Super Admin', '$2b$10$kxl77Xy5II0QcdwKXbVux.7sHvIoWLQQrNEH4h..ffmAc90W7bILa', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('68c37077-4896-4a75-9a69-a694ed1a7e04', 'Tomas Cartwright', 'Edwina.Harris@hotmail.com', 'Super Admin', '$2b$10$/fm86RiYyABer5WCDKIozOMvqiLJ7FyVB0N0bIFSeMeNJVPll.8z2', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('708a2ba3-0b23-471d-a2ee-b78a629effc9', 'Ian Fritsch', 'Emerson72@gmail.com', 'Super Admin', '$2b$10$xGibJEV51YL5fIvcB0L4MOJte8AuYm7T./cGC39ld.hQG7Yp/FlB.', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('713637a2-ab72-43ec-9c65-24921e6002ec', 'Judith Bergnaum', 'Neva_Macejkovic@yahoo.com', 'Super Admin', '$2b$10$.jRR8T735ShoZwl3KaVVkuRMzNrhmYeQXlw7nfP/bRAJwhMiKNih6', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('71dfb195-c693-4af9-aac4-8f2657bd5b9b', 'Jeffery Hilpert II', 'Jeff.Cummings@gmail.com', 'Creator', '$2b$10$2pFVrxHWMxtaZKuHvsr2fO3pL.XUHFsErqKSTzTVb5w4U4xly8JcC', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('753dfa0e-ad9a-4ca1-aead-8f53f9ead18a', 'Johnny Grimes', 'Maxie_Rath33@hotmail.com', 'Super Admin', '$2b$10$cCLfCT6OQ.h9kQPNixLfgOAyc08hpjvkCME7FF.hJpb.kye5DiY1e', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('76a8185e-2d8c-4619-a77e-d0399fdf1a2e', 'Sheldon Huel-Walsh', 'Syble_Lowe78@hotmail.com', 'Super Admin', '$2b$10$xvrgYpRUdwogvWxMiBBTaeDMo7BUzGDSRZ8Q4xGZKIn1gze.zb53G', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('772e471b-33d3-4149-a924-8a2739b8399d', 'Ms. Johnnie Abernathy III', 'Jake.Braun@hotmail.com', 'Super Admin', '$2b$10$zENcAPCJ3kPXsge/5sVawue5GrKn.up95wVRNaPRXZxXvLR6bl5rG', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('7769ba15-ad32-4fff-b469-3564d12c0555', 'Christian Smith', 'Roger_Stanton@gmail.com', 'Creator', '$2b$10$vcom.QJE2TxW6JgJ85XP9uBgih08bjn.wxnG9PwUvyn9uV1CFpzOq', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('7808206d-ef15-4a8a-b31d-b1eda78bb121', 'Ms. Patsy Bernhard', 'Kitty60@gmail.com', 'Super Admin', '$2b$10$UojW3gENkMGtiBfqVSagFOida8aw4bKMyF11zZGxKRZhp9icl8Vzq', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('7a116ab9-e2a4-42f9-8311-6a1570be5a04', 'Pamela Hammes DDS', 'Brett.Schumm45@yahoo.com', 'Creator', '$2b$10$qcjBB96qkBJmeQR/zT2ewO9SG1WZBTdX0RW8n/NXniwgoYSqygp/K', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('7ef62a1d-e8a4-459c-8fde-60d846ec0bf8', 'Roberto Johnston', 'Lemuel76@yahoo.com', 'Creator', '$2b$10$ubfXemz2.7YmmIdLM9o71.Q9ta5KmUuffw8asA8K9tsAeybKFTi5a', 'Active', NULL, '2024-03-09 14:41:18', '2024-03-09 14:41:18', NULL),
('8002dc05-f3b3-44ea-b786-4d0670358fa6', 'Ruben Becker', 'Garrick66@hotmail.com', 'Creator', '$2b$10$k162ftgZ5YrwU/b/ek/peOFAfOPrE5D509vlms2SOVaSBxYDDILx2', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('80f9e94a-7a5f-49a3-b953-6182b236dada', 'Gordon Nienow', 'Nolan_Hyatt42@hotmail.com', 'Super Admin', '$2b$10$fppSm1jrPt3xlOmZI.wEI.ZxpdBYnRQuEowPQqaETs0fjcKQ9PSRm', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('837145a6-cedd-4f78-980b-025dda654781', 'Melissa Schuster', 'Heaven.Monahan@yahoo.com', 'Super Admin', '$2b$10$3xQ4F5tiJ4EwJSA9IWDYdecRA.TeInxJYwZKjqNjUtgnx9xHaypLG', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('843f0f81-097b-41ac-9f5e-3fa7c2d39b04', 'ardi12', 'ardi12@email.com', 'Creator', '$2b$10$yyGihHosNyrUx/9bqCsL4uAqdmUUinVainB60Lf8Zr8H1Ybp1Lq8u', 'Active', NULL, '2024-03-09 16:43:11', '2024-03-09 16:43:11', NULL),
('858e9eee-6ead-4cfa-ab7c-ca8647352f3b', 'Ms. Sherri Hickle', 'Larue.Langworth83@gmail.com', 'Super Admin', '$2b$10$Pp5al6Kwi4p/cc7yb7S1hOCI/d.Al9R/KNU9jJCvxHJqC.StNyYzy', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('85c74f03-5928-41c7-9287-a402b720cdc9', 'Annie Gleichner', 'Stephan66@hotmail.com', 'Creator', '$2b$10$J3K.gIyfZXKqn0IrC3FYyOfV8mLqIrgZe5Ku1jQFeOVDT8CWyGX.O', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('86653768-9b55-44ca-b8b4-3dad45ba0d47', 'Dewey Schroeder Jr.', 'Lavern29@hotmail.com', 'Super Admin', '$2b$10$y9tS7lDFAXs71Y9PoKpHtuNU1zN1dPvoiRS0nksP/206Di7n/Xg8u', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('87b3f34a-0b89-4ba2-8d0f-923198e8325a', 'Alison Jacobson', 'Maeve.Bruen30@gmail.com', 'Creator', '$2b$10$8LnU2sqRFbDUqi.AW8N.K.l2hpL6PrYt22tdZ2iV3v3BFke2lFYgG', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', '2024-03-09 16:34:29'),
('897f2b11-75c4-4a51-a7b7-e01969266b8a', 'Mathew Daugherty', 'Cara_Hegmann@hotmail.com', 'Creator', '$2b$10$cSFhbpPBI9XEEjEEENJXE.XbAt9MCtkV/pzxWsC5bJdiTVjb1EDgu', 'Active', NULL, '2024-03-09 14:41:18', '2024-03-09 14:41:18', NULL),
('8e5d8655-7e21-4227-aa00-1fa48a285fcf', 'Jose Treutel', 'Merritt_Altenwerth81@hotmail.com', 'Creator', '$2b$10$QGoT3ivo8DdRZCeAZBd3GuxHyGUimB2I4ffR75IfmgC9T1BQjGvhG', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('9053a3c9-f117-4e4c-83d1-2cf2f9fa6d14', 'Lana O\'Kon MD', 'Florencio.Bogan41@yahoo.com', 'Creator', '$2b$10$2SA1F.0B5bkkeloy6GhZTu1RpmTtdAQ6XY62lv5m4cAnYx9Aju4pu', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('97206074-d320-45e7-9934-654d4212f82c', 'James Kuvalis', 'Chelsea_Macejkovic@yahoo.com', 'Super Admin', '$2b$10$zUnCpDRNQsed3Y2KsyVHu.aOCcHwjia6ppKsJMK6UzL4azhIDXG6e', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('9a3e3ea4-202a-4c36-bc3f-826c6f42d591', 'Peter Lind', 'Deshawn7@yahoo.com', 'Creator', '$2b$10$2PL43UOPy8dAjJJG3z6nPOQupVAHKKzGad6BeCmeZO.MbgAEhoQ.W', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL),
('9ba611f6-ddf5-430a-b074-d9f8d25d64e7', 'Geneva Kunze', 'Eladio_Wilderman17@gmail.com', 'Super Admin', '$2b$10$KQrp0GVBkdiMhd4xFQsBTuw/QubiFOG0i/F8TTvDbvK2YQ2hmn4/a', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('a4309128-64b4-4f07-afb5-c3aeaee5669e', 'Ray Jast', 'Ivah_Kovacek@yahoo.com', 'Creator', '$2b$10$/5HrwN90dxjaMOCK8S0Mq.JSzIeVb1BogHprGZDpYKHL2AddXHaPa', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('a8754991-f47b-4cc4-8e0d-8863732da819', 'Dwayne Larkin PhD', 'Danial90@hotmail.com', 'Super Admin', '$2b$10$KKv.Lh8AqwdjCNFUvhvoY.MUTdWaVXAAQF.z1ZZ/Ki32fg7ByHvBS', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('a8ab66d1-8d54-4869-b954-3d36051d3d39', 'Wilma Grant', 'Keira_Prohaska67@hotmail.com', 'Super Admin', '$2b$10$c9PnpYz/OVMjNLCPujW/HeVVzZ2Mu5QT37E/u9PhA/TRULpTGdBQm', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('aa4b125f-b35f-4131-9cdf-f0233a7d83eb', 'Delbert Trantow', 'Marlene54@hotmail.com', 'Super Admin', '$2b$10$vmXwYHovdaKGFZtLm/UdH.Z4NufL/foT3C/dHTqYOStQL0t7mFwTC', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('aac83401-fe8d-4fa3-ae9d-2fb060ff4772', 'Mercedes Wiza', 'Destany_Kulas47@gmail.com', 'Creator', '$2b$10$9NXiolxG4Qql0BBwiwEpB.7xEfVh0vdyq6Gi8x8zUHZNvzjO3hUGO', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('ab64dfd2-a411-4aeb-8ae3-819b9b9581ac', 'Hannah Runolfsson', 'Hallie_Sporer@hotmail.com', 'Creator', '$2b$10$EIZBVFyf7FpJlr9v3jwayuey0W1tjCK/eORMhJ4dLRz1q.WjKkoby', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('ac13c604-edb0-485e-9520-96eec3df3521', 'Galih Baskoro', 'gal1@email.com', 'Creator', '$2b$10$kJE5HSPzd3qgYexoJkGhTukse/UeOzYLc2zPnryTQZG6u9X.NPd1W', 'Active', NULL, '2024-03-05 14:27:43', '2024-03-06 14:57:50', NULL),
('ac13c604-edb0-485e-9520-96eec3df352f', 'Lazuardi Fadhilah', 'Ardi@email.com', 'Super Admin', '$2b$10$gsIrF/rrwbVy/cM75JGrheKbwqaMwQrlA4DdLaHsyfe7pY5Zdo7UC', 'Active', NULL, '2024-03-05 14:27:43', '2024-03-05 14:27:43', NULL),
('ae6d5c56-ce5a-41e9-921f-283bf7eb828f', 'Jerald Grant', 'Logan_Pfeffer43@gmail.com', 'Creator', '$2b$10$ANU97grn7V3CEhFl/o3TWeDoMJAFHVdnPF4HdxzZFdIGeg/svT1p.', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('b80d846a-6892-4893-b928-236a95dd5283', 'Woodrow Lakin', 'Bryana_Doyle56@hotmail.com', 'Super Admin', '$2b$10$IvRSMabUO4ErChlVd2O7c.LjAIKNFtk2zbAediZNPesJiUUeN0NTW', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('ba7a83b7-ea28-431e-93d3-bf0fa42dbb00', 'Roy Kuhn', 'Alysa13@yahoo.com', 'Super Admin', '$2b$10$tYmRZ0NEB9DqUU/y8dFpN.n1ld0JqFZuls1fpB/xgfoGEW7x4tVTK', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('c289a811-4356-4220-baa0-eb478c4430e1', 'Yvette Gislason Jr.', 'Jennyfer32@yahoo.com', 'Super Admin', '$2b$10$HlhkDY.Z5scMAuoTCLsqP.LJy19YZ0/4o01TuTNeM3MrM0pge5/Ye', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('c3474f44-6f2b-4dd0-a505-6d0c0738f13f', 'Lazuardi Fadhilah', 'lazuardiFadhilah1@email.com', 'Creator', '$2b$10$4an9s0YKknWKEvanIdCHa.oDtYl21lOIakDf6TNzdwOXndtkvQPOO', 'Active', NULL, '2024-03-11 13:52:13', '2024-03-12 08:44:13', NULL),
('c5681735-1bc5-462f-b6d5-2c8369c38579', 'Darrell Carroll', 'Rebekah_Thompson6@gmail.com', 'Super Admin', '$2b$10$l8KiF3JhVwnpJtyTeTp9pee3lHURsA730gQJjXY43BaszNyOt6jMG', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('c7e436d5-c015-4868-a5c1-d8a6374ac52c', 'Zachary Wolf', 'Bethany8@yahoo.com', 'Creator', '$2b$10$LI8U9OpdNi/Jw1jIzsSMvOi5SGh7m/usfa3R/Htl31GtLj2KUQZ5a', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('c8f75510-a5e2-4ba5-a071-52c0bc7edb7d', 'Orlando Purdy', 'Trent.Emard16@yahoo.com', 'Creator', '$2b$10$L6DPX/t5JzK042Sylapz0.6uGyN1VTs3tmeubuBrpC7f.FCGBvnlG', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('cc919dcb-bc8c-49ea-8e7e-49346e72b6b2', 'Mrs. Kim Von', 'Michaela_Okuneva@hotmail.com', 'Creator', '$2b$10$M9AYznW4yJy3MHatm2YfUeesajZgbNy0w.QZnhAHCYAfXTSegcQG.', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('ccc14796-a7c8-44e0-86fa-748a3ffaff88', 'Janie Harris-Pfannerstill', 'Tomasa_Franey16@yahoo.com', 'Creator', '$2b$10$dQEG1fDW8AwexW5Q/WFVmOQbyV3scORp9nJ2RTkM0gHEk2ie9CceS', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('cf7d8d71-a54d-4633-ad39-4f99a05d7b88', 'Lauren Bosco', 'Earline43@hotmail.com', 'Super Admin', '$2b$10$2DyWSS4ZiysMC1g0FqIOfu6G7Vd/rrV7PTN6hTDydR0B4nbGgEd4m', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('cfb1de17-a705-4b83-85d2-78a7cc7ac288', 'Miss Pauline Gulgowski-Bins', 'Susan94@gmail.com', 'Creator', '$2b$10$QHbPPW.nH737KaT7TH3hhehyvbSfrOgdl1aZ4WGpDUA3RCqBQoDJO', 'Active', NULL, '2024-03-09 14:41:18', '2024-03-09 14:41:18', NULL),
('d0774bbf-75b1-4e5e-a2d6-fc078d33891d', 'Mr. Hector Cummings Sr.', 'Jalyn_Welch@gmail.com', 'Super Admin', '$2b$10$qwmYI6uHQW8n4UfV.Om26OCNWoiT5glJwY9hD2nY4S0Bfl9Yv/ysq', 'Active', NULL, '2024-03-09 14:41:11', '2024-03-09 14:41:11', NULL),
('d26042a6-cb5a-4baa-883b-58d06b02d0c8', 'Spencer Smitham', 'Emmet48@hotmail.com', 'Super Admin', '$2b$10$.u9bU1Lqyp4ZZUGCWJ2HuO1SMhE.nryUcbFcsTDjqD2h8N9MoHUyq', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('d49052c6-72c5-4ccf-b896-fa1f5a2e8920', 'Rochelle Murazik', 'Rosalinda.Emard12@hotmail.com', 'Creator', '$2b$10$DKoGCP9ZXdpt/IglgxgnTeUaWx/BGOwhzUx.C7gMh/DMKDXkFMOvK', 'Active', NULL, '2024-03-09 14:41:18', '2024-03-09 14:41:18', NULL),
('d61f2e8f-a54e-4d60-aca7-f617f859646c', 'Brandon Heathcote', 'Cecelia77@yahoo.com', 'Super Admin', '$2b$10$EHROSktF1/kPW3sxS7QWe.pEu3JFVimcLZiRaJRUL2pvjBGBkYmWq', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('d8437357-3d33-4370-8bae-92a054289126', 'ardi1', 'ardi1@email.com', 'Creator', '$2b$10$UxdXkfe/i.rPJXyhrJSj3e34HXEQN44aksTkepIepFzQR4S6YYQm2', 'Active', NULL, '2024-03-06 14:19:49', '2024-03-06 14:19:49', NULL),
('d990b582-90a3-4c41-8997-9000345a4a8d', 'Marsha Fahey', 'Kamron.OConner90@gmail.com', 'Creator', '$2b$10$0t8HVmyjV5HLVOYD7q/Tru99YKtvUW0rNvj0ORfZCIGNskKeBnzXS', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('d995284c-a35d-4f8c-adae-9e3a691166f4', 'Joe Rosenbaum', 'Lolita2@hotmail.com', 'Super Admin', '$2b$10$nP.zHhNHRlG72MkuWBpaB.DWLbMvSrPQGVGf7afPpipHVFKTqGMVK', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('dad4d169-c8a0-4786-a319-ede2309eae5e', 'Mr. Phillip Swift', 'Colleen_Cronin18@gmail.com', 'Creator', '$2b$10$YJH1WtoxzCeCPNb2XCM.O.WyXANvTi3qPEKUic06KGceDEb3I/kVm', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('e1219daa-a56a-43d0-ae42-815cd3159502', 'Amos Wunsch V', 'Gerard_Kunde-Emard64@gmail.com', 'Creator', '$2b$10$zbmrFqxQwmWsMyCwcx2SsedgVeCfrk3xqXDGdy/aCESYwLfkzlaLO', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', '2024-03-09 17:05:03'),
('e34e7223-7075-44b9-9123-e13a6a8c3657', 'Craig Stamm', 'Lawrence84@yahoo.com', 'Creator', '$2b$10$zqjBbizUgOfgqtawGFYZTeY4D5r2V0qFg75DuKy/f0rYGyxcXqWm2', 'Active', NULL, '2024-03-09 14:41:16', '2024-03-09 14:41:16', NULL),
('e4e9567e-b61a-43b7-a902-8785850d009b', 'Dr. Lance Howell', 'Lonnie_Ortiz@yahoo.com', 'Super Admin', '$2b$10$Fawi/t9P3SyuuldZcf1kaOpJsngd0CKPEO1f6j1F7o9/caEHZYaS6', 'Active', NULL, '2024-03-09 14:41:12', '2024-03-09 14:41:12', NULL),
('e5f623d1-b256-45a8-bbce-8cf25ec0b4f1', 'Byron Strosin', 'Randall_Dickinson-Hamill@hotmail.com', 'Creator', '$2b$10$OEtmXp.hGEIA9cte4VnBYec7mcbiq6XihYA.FLw4r6jzaRQJsPAC6', 'Active', NULL, '2024-03-09 14:41:18', '2024-03-09 14:41:18', NULL),
('ed2d5b35-619a-4c0f-81e3-6bc114bd967b', 'Victor Mraz', 'Kennedi.Keebler67@hotmail.com', 'Super Admin', '$2b$10$AON8JJwOr.7O/kto/vA2WOD0fQIMOyWc5zEJT/LfMhgvWpYxEm70C', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('f315b11b-0936-4800-899a-cc3d92a5b89e', 'Brandi Bruen', 'Maia66@hotmail.com', 'Creator', '$2b$10$4xGXftwndg2OjamH4lc0J.RkAoqT0BV2ChEqm1az9pS0zqzre2U9W', 'Active', NULL, '2024-03-09 14:41:17', '2024-03-09 14:41:17', NULL),
('fa11c192-afa5-47d7-8771-68787a5809c8', 'Jimmy Fisher', 'Susie36@gmail.com', 'Super Admin', '$2b$10$CEultiNgApdwcvpdhw02m.zcqXTTnB8qSDZAvciaezK7TA76jG51G', 'Active', NULL, '2024-03-09 14:41:14', '2024-03-09 14:41:14', NULL),
('fc98e220-915d-455c-922d-616be5fa8a12', 'Lamar Hodkiewicz', 'Kaycee.Boehm53@gmail.com', 'Super Admin', '$2b$10$JEbkS6G4cuhoacYGnkf/G.iUoKJV6wuvJ5hzuH9F0JFckGuv2VXj.', 'Active', NULL, '2024-03-09 14:41:13', '2024-03-09 14:41:13', NULL),
('fcc50ef9-f43a-4fca-b479-71c04e28a528', 'Benjamin Beer', 'Frida_Glover69@gmail.com', 'Creator', '$2b$10$3vacRA0zNEF.8yAdeCMZwexJSdYByuuMsxnDXpNWrQYFnZc45FFX.', 'Active', NULL, '2024-03-09 14:41:15', '2024-03-09 14:41:15', NULL);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;