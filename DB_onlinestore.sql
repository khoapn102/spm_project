/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50623
Source Host           : localhost:3306
Source Database       : onlinestore

Target Server Type    : MYSQL
Target Server Version : 50623
File Encoding         : 65001

Date: 2015-12-09 15:34:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `cid` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `type_name` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('acc', 'Phụ Kiện Nội Thất');
INSERT INTO `category` VALUES ('bed', 'Nội Thất Phòng Ngủ');
INSERT INTO `category` VALUES ('kit', 'Nội Thất Nhà Bếp');
INSERT INTO `category` VALUES ('liv', 'Nội Thất Phòng Khách');
INSERT INTO `category` VALUES ('off', 'Nội Thất Văn Phòng');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `cmid` int(255) NOT NULL AUTO_INCREMENT,
  `ucid` int(255) NOT NULL,
  `pid` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `content` text COLLATE utf8_vietnamese_ci,
  `date_post` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `time_post` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  PRIMARY KEY (`cmid`),
  KEY `pid` (`pid`),
  KEY `ucid` (`ucid`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`ucid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('38', '159', 'bed1', 'Bạn báo giá giúp mình nhé', '2015-12-09', '04:19:16');
INSERT INTO `comment` VALUES ('39', '159', 'bed1', 'Cho mình hỏi sản phẩm có hàng sẵn không admin', '2015-12-09', '04:19:57');
INSERT INTO `comment` VALUES ('40', '159', 'bed1', 'Xin chào cửa hàng', '2015-12-09', '04:29:34');
INSERT INTO `comment` VALUES ('41', '159', 'bed1', 'Sản Phẩm được sản xuất bằng gỗ gì?', '2015-12-09', '13:42:51');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `mid` int(255) NOT NULL,
  `point` int(255) DEFAULT NULL,
  `date_join` varchar(255) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  PRIMARY KEY (`mid`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('159', '8299', '1992-02-03');
INSERT INTO `member` VALUES ('161', '0', '2015-12-9');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `mid` int(255) NOT NULL,
  `pid` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `odate` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `otime` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `quantity` int(255) NOT NULL,
  PRIMARY KEY (`mid`,`pid`,`odate`,`otime`),
  KEY `pid` (`pid`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`mid`) REFERENCES `member` (`mid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('159', 'bed1', '2015-12-5', '10:1:25', '1');
INSERT INTO `orders` VALUES ('159', 'bed1', '2015-12-5', '10:1:55', '1');
INSERT INTO `orders` VALUES ('159', 'bed1', '2015-12-5', '10:17:16', '1');
INSERT INTO `orders` VALUES ('159', 'bed1', '2015-12-5', '10:19:22', '1');
INSERT INTO `orders` VALUES ('159', 'bed1', '2015-12-5', '9:47:42', '2');
INSERT INTO `orders` VALUES ('159', 'bed1', '2015-12-5', '9:58:58', '1');
INSERT INTO `orders` VALUES ('159', 'bed1', '2015-12-7', '8:24:40', '1');
INSERT INTO `orders` VALUES ('159', 'bed1', '2015-12-9', '4:35:13', '1');
INSERT INTO `orders` VALUES ('159', 'bed2', '2015-12-5', '10:17:48', '1');
INSERT INTO `orders` VALUES ('159', 'bed2', '2015-12-9', '14:11:49', '2');
INSERT INTO `orders` VALUES ('159', 'bed2', '2015-12-9', '14:8:42', '2');
INSERT INTO `orders` VALUES ('159', 'bep1', '2015-12-5', '9:57:44', '1');
INSERT INTO `orders` VALUES ('159', 'bep1', '2015-12-9', '14:13:54', '1');
INSERT INTO `orders` VALUES ('159', 'bep1', '2015-12-9', '4:35:13', '1');
INSERT INTO `orders` VALUES ('159', 'bep3', '2015-12-9', '14:11:49', '1');
INSERT INTO `orders` VALUES ('159', 'bep3', '2015-12-9', '14:8:42', '1');
INSERT INTO `orders` VALUES ('159', 'bep3', '2015-12-9', '4:37:16', '1');
INSERT INTO `orders` VALUES ('159', 'off1', '2015-12-9', '14:13:54', '1');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `pid` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `cid` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `pname` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `pdesc` text COLLATE utf8_vietnamese_ci NOT NULL,
  `price` int(255) NOT NULL,
  `quantity` int(255) NOT NULL,
  `rating` int(255) NOT NULL,
  `view` int(255) NOT NULL,
  `p_img` varchar(500) COLLATE utf8_vietnamese_ci NOT NULL,
  `discount` double(255,0) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `cid` (`cid`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('bed1', 'bed', 'Giường Ngủ Blue', 'Giương ngủ Blue thuộc bộ sưu tập Blue. Giường được làm bằng gỗ tràm đánh cước, phần đầu giường bọc vải hoa văn cao cấp mang lại cảm giác nhẹ nhàng và thư giãn.', '2950000', '23', '4', '104', 'image/bed/1/', '10');
INSERT INTO `product` VALUES ('bed2', 'bed', 'Giường Ngủ Brown', 'Giường Cẩm Bình với khung gỗ xà cừ chắc chắn, thiết kế đơn giản mang lại cảm giác êm ái, thoải mái khi nằm. Không chỉ đơn giản là một chiếc giường, giường ngủ Cẩm Bình thêm phần thu hút với màu xanh sang trọng của vải bọc đầu giường sẽ là một điểm nhấn duyên dáng trong không gian phòng ngủ.', '3100000', '10', '5', '301', 'image/bed/2/', '30');
INSERT INTO `product` VALUES ('bed3', 'bed', 'Giường Ngủ Venice', 'Giường Venice được hoàn thiện với màu nâu đỏ truyền thống gỗ, điểm thẩm mỹ là những mảnh gỗ lạng ghép hướng đổi chiều 45 độ. Gường cấu tạo chắc chắn làm bằng khung gỗ xà cừ là sự lựa chọn tuyệt hảo cho không gian sống của bạn trở nên sang trọng.', '2690000', '12', '4', '180', 'image/bed/3/', '0');
INSERT INTO `product` VALUES ('bep1', 'kit', 'Tủ Bếp Classic', 'Tủ bếp Classic được làm từ gỗ xà cừ tự nhiên, trang trí nhiều chi tiết hoa văn cổ điển châu Âu. Mặt bếp làm hoàn toàn bằng đá cẩm thạch hồng rosa nhập từ Hy Lạp. Bày trí khoa học và hợp lý với nơi chứa đồ rộng rãi. Đặc biệt phù hợp với các biệt thự sang trọng, bề thế.', '9000000', '11', '1', '50', 'image/kit/1/', '0');
INSERT INTO `product` VALUES ('bep123', 'kit', 'Bếp Gas', 'afsd', '5000000', '5', '0', '0', 'image/kit/3/', '20');
INSERT INTO `product` VALUES ('bep2', 'kit', 'Tủ Bếp ViVo', 'Tủ bếp Vivo có thẩm mỹ và độ bền cao của gỗ công nghiệp chống ẩm sơn trắng phối hợp với các mảng màu sắc của ván lạng óc chó. Kiểu dáng thời trang, hiện đại, các chi tiết tối giản và cách điệu đầy ngẫu hứng, bộ sản phẩm mang những nét độc đáo rất riêng.', '8500000', '11', '2', '100', 'image/kit/2/', '2');
INSERT INTO `product` VALUES ('bep3', 'kit', 'Tủ Bếp Venice', 'Tủ bếp Venice được thiết kế trên nền vật liệu của gỗ Còng và ván lạng Còng tự nhiên, những vân gỗ được kết hợp khéo léo tạo sự mềm mại và độc đáo. Bộ sản phẩm kết hợp hai xu hướng hiện đại và cổ điển chắc chắn sẽ làm hài lòng gia chủ.', '7500000', '24', '5', '300', 'image/kit/3/', '12');
INSERT INTO `product` VALUES ('off1', 'off', 'Bàn Làm Việc Venice', 'Công năng, thẩm mỹ là cảm nhận đầu tiên về bàn làm việc Venice. Với phần hộc kéo hai bên là nơi lưu trữ tài liệu được bố trí gọn gàng ở hai bên bàn, không tạo cảm giác cồng kềnh bàn làm việc Venice có thể kết hợp với ghế ngồi cùng bộ sưu tập sẽ chinh phục được các gia chủ yêu thích phong cách cổ điển pha lẫn một chút tinh thần hiện đại.', '1850000', '11', '4', '220', 'image/off/1/', '20');
INSERT INTO `product` VALUES ('off2', 'off', 'Bàn Làm Việc Milan', 'Không còn cảm giác buồn chán với những sản phẩm chỉ đặc một màu gỗ, bàn làm việc Milan như mang lại một làn gió mới cho phòng làm việc với kiểu dáng thanh mảnh, sang trọng, màu sắc tươi vui. Bàn được xứ lý bề mặt gỗ tinh tế và màu sắc kết hợp hài hòa tạo nên sự yêu thích cho người dùng.', '8500000', '10', '3', '200', 'image/off/2/', '0');
INSERT INTO `product` VALUES ('off3', 'off', 'Bàn Làm Việc Lộc', 'Kiểu dáng cổ điển, sang trọng đặc biệt là điểm uốn cong lên trên ở hai mép bàn, giúp các đồ vật không bị rơi ra ngoài. Bàn làm việc Lộc với tính công năng kết hợp 2 hộc tủ kéo và 2 hộc tủ trống, có thể bỏ các đồ vật như sách, thiết bị văn phòng…. Bàn làm việc Lộc càng thêm thu hút với màu gỗ nâu đỏ quý phái từ gỗ xà cừ.', '7500000', '20', '4', '150', 'image/off/3/', '15');
INSERT INTO `product` VALUES ('pk1', 'acc', 'Gương Khukozu', 'Khung gương với phần khung gỗ xà cừ tự nhiên, được gia công tỉ mỉ từng góc cạnh đường nét sẽ là điểm nhấn độc đáo cho căn phòng.', '2900000', '13', '4', '280', 'image/acc/1/', '0');
INSERT INTO `product` VALUES ('pk2', 'acc', 'Tủ Tivi Lăng Cô', 'Tủ tivi lăng cô được làm bằng gỗ xà cừ có màu vàng tự nhiên. Tủ có kiểu dáng đơn giản phù hợp với nhiều không gian.', '1210000', '12', '5', '20', 'image/acc/2/', '0');
INSERT INTO `product` VALUES ('pk3', 'acc', 'Tủ Áo HT', 'Bộ sưu tập nội thất HT như thấm đượm ánh nắng ngọt ngào của bầu trời mùa thu. Những sản phẩm màu nâu cánh gián mượt mà đã nhẹ nhàng vẽ nên khung cảnh gia đình đầm ấm. Tính năng và thẩm mỹ vượt trội của sản phẩm HT sẽ làm bạn hài lòng.', '3030000', '17', '2', '30', 'image/acc/3/', '0');
INSERT INTO `product` VALUES ('tab1', 'liv', 'Bộ bàn ghế hạng 1', 'Bàn ghế gỗ phòng khách hạng 1 được sản xuất trên vật liệu gỗ tự nhiên là chủ yếu kết hợp với đệm nỉ, bàn ghế được thiết kế cho phòng khách sang trọng, hiện đại, mẫu mã đa dạng, nhiều chủng loại đẹp', '5000000', '28', '4', '200', 'image/liv/1/', '0');
INSERT INTO `product` VALUES ('tab2', 'liv', 'Bộ bàn ghế BG11', 'Bàn ghế gỗ phòng khách BG11 là sản phẩm thuộc dòng gỗ tự nhiên cao cấp. Toàn bộ chất liệu gỗ đã qua quy trình xử lý, tẩm sấy chống mối mọt, cong vênh. Bộ ban ghe go có thiết kế vuông hiện đại kết hợp các đường nét, họa tiết hoa văn cổ điển rất độc đáo và ấn tượng. Màu sắc cùng vân gỗ tự nhiên làm tăng tối đa giá trị của bộ bàn ghế phòng khách này. Thiết kế là sản phẩn của công ty Nội Thất Đức Tính mang phong cách truyền thống pha hiện đại.', '7000000', '10', '5', '100', 'image/liv/2/', '0');
INSERT INTO `product` VALUES ('tab3', 'liv', 'Bộ bàn ghế BG06', 'Mẫu bàn ghế gỗ phòng khách cao cấp BG06 với thiết kế dạng góc chữ L, tiết kiệm diện tích, phù hợp với những không gian phòng khách nhỏ. Kiểu dáng nhỏ gọn, hiện đại kết hợp nệm mút cao cấp mang lại cảm giác thoải mái cho người sử dụng. Sử dụng gỗ tự nhiên làm chất liệu chính, sản phẩm là một vật dụng không thể thiếu trong không gian nội thất phòng khách cho ngôi nhà bạn. Bộ bàn ghế gỗ do công ty Nội Thất Đức Tính thiết kế, sản xuất. Kích thước sản phẩm có thể thay đổi phù hợp với không gian ngôi nhà bạn.', '3000000', '10', '4', '150', 'image/liv/3/', '0');

-- ----------------------------
-- Table structure for response
-- ----------------------------
DROP TABLE IF EXISTS `response`;
CREATE TABLE `response` (
  `rid` int(255) NOT NULL AUTO_INCREMENT,
  `cmid` int(255) NOT NULL,
  `urid` int(255) NOT NULL,
  `content` text COLLATE utf8_vietnamese_ci,
  `date_post` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `time_post` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `cmid` (`cmid`),
  KEY `urid` (`urid`),
  CONSTRAINT `response_ibfk_2` FOREIGN KEY (`urid`) REFERENCES `user` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `response_ibfk_3` FOREIGN KEY (`cmid`) REFERENCES `comment` (`cmid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
-- Records of response
-- ----------------------------
INSERT INTO `response` VALUES ('34', '38', '123', 'bạn liên hệ số điện thoại cửa hàng nhé 0938 200 871', '2015-12-09', '04:20:49');
INSERT INTO `response` VALUES ('35', '39', '123', 'Sản phẩm có sẵn bạn nhé', '2015-12-09', '04:21:04');
INSERT INTO `response` VALUES ('36', '38', '159', 'Mình cám ơn bạn', '2015-12-09', '04:34:12');

-- ----------------------------
-- Table structure for subscriber
-- ----------------------------
DROP TABLE IF EXISTS `subscriber`;
CREATE TABLE `subscriber` (
  `email` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
-- Records of subscriber
-- ----------------------------
INSERT INTO `subscriber` VALUES ('hungphan.iec@gmail.com');
INSERT INTO `subscriber` VALUES ('h@gmail.com');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(255) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `first_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `DOB` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `isManager` int(255) NOT NULL,
  `u_img` varchar(500) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('111', '123456', 'Software Solution', 'HKT', '01-01-1990', '01212188999', '1', 'image/user/cool.jpg', '126 Nguyễn Thị Minh Khai, P. 16, Q. 3, HCMC', 'khoaphan@gmail.com');
INSERT INTO `user` VALUES ('123', 'b', 'Triet', 'Le', '1996-02-03', '123456798', '1', 'image/user/hung.jpg', 'b', 'b');
INSERT INTO `user` VALUES ('159', '1', 'Hưng', 'Phan Ngọc', '11-08-1995', '01212120462', '0', 'image/user/coffee.jpg', '123 Hoàng Văn Thụ, phường 4, quận Tân Bình', 'phithangcung@gmail.com');
INSERT INTO `user` VALUES ('161', '123456', 'Khoa', 'Phan', '1-1-1990', '01203073975', '0', 'image/user/mundo.jpg', '321 Lê Quý Đôn, P. 6, Q. 3, HCMC', 'khoaphan2@gmail.com');

-- ----------------------------
-- Table structure for wishlist
-- ----------------------------
DROP TABLE IF EXISTS `wishlist`;
CREATE TABLE `wishlist` (
  `mid` int(255) NOT NULL,
  `pid` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `date` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  `time` varchar(255) COLLATE utf8_vietnamese_ci NOT NULL,
  PRIMARY KEY (`mid`,`pid`),
  KEY `pid` (`pid`),
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `wishlist_ibfk_3` FOREIGN KEY (`mid`) REFERENCES `member` (`mid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- ----------------------------
-- Records of wishlist
-- ----------------------------
INSERT INTO `wishlist` VALUES ('159', 'bed1', '2015-12-5', '13:50:37');
INSERT INTO `wishlist` VALUES ('159', 'bed2', '2015-12-8', '21:17:44');
