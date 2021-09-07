-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}admin`;
CREATE TABLE `{{$pk}}admin`
(
    `id`              int(10) unsigned NOT NULL AUTO_INCREMENT,
    `username`        char(32) NOT NULL,
    `password`        char(32) NOT NULL,
    `create_time`     int(10) unsigned DEFAULT '0',
    `update_time`     int(10) unsigned DEFAULT '0',
    `last_login_time` int(10) unsigned DEFAULT '0',
    `last_login_ip`   varchar(100) DEFAULT '',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for {{$pk}}user
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}user`;
CREATE TABLE `{{$pk}}user`
(
    `id`              int(10) unsigned NOT NULL AUTO_INCREMENT,
    `username`        char(32) NOT NULL,
    `suid`            char(32) NOT NULL,
    `nick_name`       varchar(100) DEFAULT '',
    `mobile`          char(11)     DEFAULT '' COMMENT '会员手机号',
    `email`           char(32)     DEFAULT '' COMMENT '会员邮箱',
    `password`        char(32) NOT NULL,
    `level`           int          default '1' COMMENT '1为游客，2为正式用户,3为作者',
    `autopay`         tinyint(4) default 1 COMMENT '是否自动购买章节',
    `create_time`     int(10) unsigned DEFAULT '0',
    `update_time`     int(10) unsigned DEFAULT '0',
    `delete_time`     int(10) unsigned DEFAULT '0',
    `last_login_time` int(10) unsigned DEFAULT '0',
    `vip_expire_time` int(10) unsigned DEFAULT '0' COMMENT '会员到期时间',
    `pid`             int(10) unsigned DEFAULT '0' COMMENT '上线用户ID',
    `reg_ip`          varchar(32)  DEFAULT '' COMMENT '用户注册ip',
    PRIMARY KEY (`id`) USING BTREE,
    unique key `username` (`username`),
    key               `suid` (`suid`),
    key               `mobile` (`mobile`),
    key               `email` (`email`),
    key               `pid` (`pid`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for {{$pk}}user_finance
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}user_finance`;
CREATE TABLE `{{$pk}}user_finance`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`     int(10) NOT NULL DEFAULT 0,
    `money`       decimal(10, 2) NOT NULL DEFAULT 0 COMMENT '充值/消费金额',
    `usage`       tinyint(4) NOT NULL COMMENT '用途，1.充值，2.购买vip，3.购买章节，4.推广奖励, 5.每日签到奖励, 6.提现',
    `summary`     text COMMENT '备注',
    `create_time` date DEFAULT NULL,
    `update_time` date DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    key           `user_id` (`user_id`) USING BTREE,
    key           `usage` (`usage`) USING BTREE,
    key `create_time` (`create_time`) USING BTREE
) ENGINE = InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for {{$pk}}user_order
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}user_order`;
CREATE TABLE `{{$pk}}user_order`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`     int(10) NOT NULL DEFAULT 0,
    `money`       decimal(10, 2) NOT NULL DEFAULT 0 COMMENT '充值金额',
    `status`      tinyint(4) not null default 0 COMMENT '0为未支付，1为已支付',
    `pay_type`    tinyint(4) default 1 COMMENT '0为未知，1为充值金币，2为购买vip，3为提现',
    `summary`     text COMMENT '备注',
    `order_id`    varchar(100) default '' COMMENT '云端订单号',
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    `expire_time` int(10) unsigned default '0',
    PRIMARY KEY (`id`) USING BTREE,
    key           `user_id` (`user_id`) USING BTREE,
    key           `status` (`status`) USING BTREE,
    key           `pay_type` (`pay_type`) USING BTREE
) ENGINE = InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for {{$pk}}user_buy
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}user_buy`;
CREATE TABLE `{{$pk}}user_buy`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`     int(10) NOT NULL DEFAULT 0 COMMENT '购买用户ID',
    `chapter_id`  int(10) unsigned NOT NULL DEFAULT 0 COMMENT '购买漫画ID',
    `book_id`     int(10) unsigned NOT NULL DEFAULT 0 COMMENT '购买章节ID',
    `money`       decimal(10, 2) NOT NULL DEFAULT 0 COMMENT '消费金额',
    `summary`     text COMMENT '备注',
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for author
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}author`;
CREATE TABLE `{{$pk}}author`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `username`    char(32)  DEFAULT 'nil',
    `password`    char(32)  DEFAULT 'nil',
    `email`       char(100) DEFAULT 'nil',
    `author_name` varchar(100) NOT NULL,
    `status`      tinyint(4) DEFAULT 0,
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    PRIMARY KEY (`id`) USING BTREE,
    key           `username` (`username`) USING BTREE,
    key           `password` (`password`) USING BTREE,
    key           `email` (`email`) USING BTREE,
    key           `status` (`status`) USING BTREE,
    key           `author_name` (`author_name`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}banner`;
CREATE TABLE `{{$pk}}banner`
(
    `id`           int(10) unsigned NOT NULL AUTO_INCREMENT,
    `pic_name`     varchar(255) DEFAULT '' COMMENT '轮播图完整路径名',
    `create_time`  int(10) unsigned DEFAULT '0',
    `update_time`  int(10) unsigned DEFAULT '0',
    `book_id`      int(10) unsigned NOT NULL COMMENT '所属漫画ID',
    `title`        varchar(50) NOT NULL COMMENT '轮播图标题',
    `banner_order` int(10) unsigned DEFAULT 0,
    PRIMARY KEY (`id`) USING BTREE,
    KEY            `banner_order` (`banner_order`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}book`;
CREATE TABLE `{{$pk}}book`
(
    `id`              int(10) unsigned NOT NULL AUTO_INCREMENT,
    `unique_id`       char(100)   NOT NULL COMMENT '漫画标识',
    `book_name`       varchar(50) NOT NULL COMMENT '漫画名',
    `nick_name`       varchar(100)   DEFAULT '' COMMENT '别名',
    `last_chapter_id` int(10) unsigned DEFAULT '0',
    `last_chapter`    varchar(255)   DEFAULT '无章节',
    `chapter_count` int(10) unsigned DEFAULT '0',
    `create_time`     int(10) unsigned DEFAULT '0',
    `update_time`     int(10) unsigned DEFAULT '0',
    `last_time`       int(10) unsigned DEFAULT '0' COMMENT '最后更新时间',
    `delete_time`     int(10) unsigned DEFAULT '0',
    `tags`            varchar(100)   DEFAULT '' COMMENT '分类',
    `summary`         text COMMENT '简介',
    `end`             tinyint(4) DEFAULT '1' COMMENT '2为连载，1为完结',
    `author_id`       int(10) unsigned NOT NULL COMMENT '作者ID',
    `author_name`     varchar(100)   DEFAULT '佚名',
    `cover_url`       varchar(255)   DEFAULT '' COMMENT '封面图路径',
    `banner_url`      varchar(255)   DEFAULT '' COMMENT '封面横图路径',
    `start_pay`       int(10) NOT NULL DEFAULT '99999' COMMENT '第m话开始需要付费',
    `money`           decimal(10, 2) DEFAULT '0' COMMENT '每章所需费用',
    `area_id`         int(10) unsigned NOT NULL COMMENT '漫画所属地区',
    `is_top`          tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否推荐',
    `src_url`         varchar(255)   DEFAULT NULL COMMENT '原地址',
    `is_copyright`    tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否开启版权',
    `hits` int(10) unsigned DEFAULT '0' COMMENT '总人气',
    `mhits` int(10) unsigned DEFAULT '0' COMMENT '月人气',
    `whits` int(10) unsigned DEFAULT '0' COMMENT '周人气',
    `dhits` int(10) unsigned DEFAULT '0' COMMENT '日人气',
    PRIMARY KEY (`id`) USING BTREE,
    KEY               `tags` (`tags`) USING BTREE,
    KEY               `end` (`end`) USING BTREE,
    KEY               `author_id` (`author_id`) USING BTREE,
    KEY               `is_top` (`is_top`) USING BTREE,
    KEY               `area_id` (`area_id`) USING BTREE,
    KEY               `is_copyright` (`is_copyright`) USING BTREE,
    KEY               `book_name`(`book_name`) USING BTREE,
    KEY               `hits`(`hits`) USING BTREE,
    KEY               `mhits`(`mhits`) USING BTREE,
    KEY               `whits`(`whits`) USING BTREE,
    KEY               `dhits`(`dhits`) USING BTREE,
    unique KEY `unique_id`(`unique_id`)
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for chapter
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}chapter`;
CREATE TABLE `{{$pk}}chapter`
(
    `id`            int(10) unsigned NOT NULL AUTO_INCREMENT,
    `chapter_name`  varchar(255)   NOT NULL COMMENT '章节名称',
    `create_time`   int(10) unsigned DEFAULT '0',
    `update_time`   int(10) unsigned DEFAULT '0',
    `book_id`       int(10) unsigned NOT NULL COMMENT '章节所属漫画ID',
    `chapter_order` decimal(10, 2) NOT NULL COMMENT '章节序',
    PRIMARY KEY (`id`) USING BTREE,
    KEY             `chapter_name` (`chapter_name`) USING BTREE,
    KEY             `book_id` (`book_id`) USING BTREE,
    KEY             `chapter_order` (`chapter_order`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for photo
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}photo`;
CREATE TABLE `{{$pk}}photo`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `chapter_id`  int(10) unsigned NOT NULL,
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    `pic_order`   decimal(10, 2) NOT NULL COMMENT '图片序',
    `img_url`     varchar(255) DEFAULT '' COMMENT '图片路径',
    PRIMARY KEY (`id`) USING BTREE,
    KEY           `chapter_id` (`chapter_id`) USING BTREE,
    KEY           `pic_order` (`pic_order`) USING BTREE
) ENGINE=InnoDB;

PARTITION BY RANGE COLUMNS(chapter_id) (
    PARTITION p0 VALUES LESS THAN (100000),
    PARTITION p1 VALUES LESS THAN (200000),
    PARTITION p2 VALUES LESS THAN (300000),
    PARTITION p3 VALUES LESS THAN (400000),
    PARTITION p4 VALUES LESS THAN (500000),
    PARTITION p5 VALUES LESS THAN (600000),
    PARTITION p6 VALUES LESS THAN (700000),
    PARTITION p7 VALUES LESS THAN (800000),
    PARTITION p8 VALUES LESS THAN (900000),
    PARTITION p9 VALUES LESS THAN (1000000),
    PARTITION p10 VALUES LESS THAN MAXVALUE
);

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}tags`;
CREATE TABLE `{{$pk}}tags`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `tag_name`    varchar(20) NOT NULL COMMENT '分类名',
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    `cover_url`   varchar(255) DEFAULT '' COMMENT '图片路径',
    PRIMARY KEY (`id`) USING BTREE,
    unique KEY `tag_name` (`tag_name`)
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for {{$pk}}friendship_link
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}friendship_link`;
CREATE TABLE `{{$pk}}friendship_link`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `name`        varchar(100) NOT NULL COMMENT '友链名',
    `url`         varchar(255) NOT NULL COMMENT '友链地址',
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB  ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for {{$pk}}area
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}area`;
CREATE TABLE `{{$pk}}area`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `area_name`   varchar(32) NOT NULL COMMENT '地区名',
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    PRIMARY KEY (`id`),
    unique key `area_name` (`area_name`)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for {{$pk}}user_book
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}user_favor`;
CREATE TABLE `{{$pk}}user_favor`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `book_id`     int(10) unsigned NOT NULL COMMENT '用户收藏的漫画ID',
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    `user_id`     int(10) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    key           book_id (`book_id`) USING BTREE,
    key           user_id (`user_id`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=Dynamic;

-- ----------------------------
-- Table structure for {{$pk}}user_history
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}user_history`;
CREATE TABLE `{{$pk}}user_history`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `book_id`     int(10) unsigned NOT NULL COMMENT '用户阅读的漫画ID',
    `chapter_id`  int(10) unsigned NOT NULL COMMENT '用户阅读的章节ID',
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    `user_id`     int(10) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    key           book_id (`book_id`) USING BTREE,
    key           user_id (`user_id`) USING BTREE
) ENGINE=InnoDB  ROW_FORMAT=Dynamic;

-- ----------------------------
-- Table structure for {{$pk}}comments
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}comments`;
CREATE TABLE `{{$pk}}comments`
(
    `id`          int(10) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`     int(10) unsigned NOT NULL DEFAULT '0',
    `book_id`     int(10) unsigned NOT NULL DEFAULT '0',
    `content`     text,
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY           `user_id` (`user_id`),
    KEY           `book_id` (`book_id`)
) ENGINE=InnoDB ROW_FORMAT=Dynamic;

-- ----------------------------
-- Table structure for {{$pk}}article
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}article`;
CREATE TABLE `{{$pk}}article`
(
    `id`          int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `unique_id`   char(100)    DEFAULT NULL,
    `title`       varchar(200) NOT NULL,
    `content_url` varchar(200) NOT NULL,
    `cover_url`   varchar(255) DEFAULT '' COMMENT '封面图路径',
    `desc`        text,
    `book_id`     int(10) UNSIGNED DEFAULT NULL,
    `hits` int(10) unsigned DEFAULT '0' COMMENT '总人气',
    `mhits` int(10) unsigned DEFAULT '0' COMMENT '月人气',
    `whits` int(10) unsigned DEFAULT '0' COMMENT '周人气',
    `dhits` int(10) unsigned DEFAULT '0' COMMENT '日人气',
    `create_time` int(10) UNSIGNED DEFAULT NULL,
    `update_time` int(10) UNSIGNED DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY           `title` (`title`) USING BTREE,
    KEY           `book_id`(`book_id`) USING BTREE,
    KEY           `unique_id`(`unique_id`) USING BTREE,
    KEY               `hits`(`hits`) USING BTREE,
    KEY               `mhits`(`mhits`) USING BTREE,
    KEY               `whits`(`whits`) USING BTREE,
    KEY               `dhits`(`dhits`) USING BTREE
) ENGINE = InnoDB ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for {{$pk}}vip_code
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}vip_code`;
CREATE TABLE `{{$pk}}vip_code`
(
    `id`          int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `code`        varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'vip码',
    `add_day`     int(10) unsigned DEFAULT 0 COMMENT '增加时间',
    `create_time` int(10) unsigned DEFAULT 0,
    `update_time` int(10) unsigned DEFAULT 0,
    `used`        tinyint(4) DEFAULT 1 COMMENT '1.未使用 2.已发出 3.已使用',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX         `code`(`code`) USING BTREE,
    INDEX         `used`(`used`) USING BTREE
) ENGINE=InnoDB ROW_FORMAT=Dynamic;

-- ----------------------------
-- Table structure for {{$pk}}charge_code
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}charge_code`;
CREATE TABLE `{{$pk}}charge_code`
(
    `id`          int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `code`        varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '卡密',
    `money`       decimal(5, 2)                                          NOT NULL COMMENT '面额',
    `used`        tinyint(4) DEFAULT 1 COMMENT '1.未使用 2.已发出 3.已使用',
    `create_time` int(10) unsigned NULL DEFAULT NULL,
    `update_time` int(10) unsigned NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX         `code`(`code`) USING BTREE,
    INDEX         `used`(`used`) USING BTREE
) ENGINE=InnoDB ROW_FORMAT=Dynamic;

DROP TABLE IF EXISTS `{{$pk}}book_logs`;
CREATE TABLE `{{$pk}}book_logs`
(
    `id`        int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `book_id`   int(10) UNSIGNED NOT NULL DEFAULT 0,
    `book_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci          DEFAULT '',
    `src_url`   varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
    `log_time`  int(10) DEFAULT 0,
    `src`       varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL DEFAULT '',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX       `src_url`(`src_url`) USING BTREE,
    INDEX       `book_id`(`book_id`) USING BTREE,
    INDEX       `book_name`(`book_name`) USING BTREE,
    INDEX       `log_time`(`log_time`) USING BTREE,
    INDEX       `src`(`src`) USING BTREE
) ENGINE = InnoDB  ROW_FORMAT=Dynamic;

-- ----------------------------
-- Table structure for chapterlogs
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}chapter_logs`;
CREATE TABLE `{{$pk}}chapter_logs`
(
    `id`           int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `chapter_id`   int(10) UNSIGNED NOT NULL DEFAULT 0,
    `chapter_name` varchar(100) DEFAULT '',
    `src_url`      varchar(500)  NOT NULL DEFAULT '',
    `src`          varchar(32)  NOT NULL DEFAULT '',
    `log_time`     int(10) UNSIGNED DEFAULT 0,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX          `src_url`(`src_url`) USING BTREE,
    INDEX          `chapter_id`(`chapter_id`) USING BTREE,
    INDEX          `chapter_name`(`chapter_name`) USING BTREE,
    INDEX          `log_time`(`log_time`) USING BTREE,
    INDEX          `src`(`src`) USING BTREE
) ENGINE = InnoDB ROW_FORMAT=Dynamic;

-- ----------------------------
-- Table structure for photologs
-- ----------------------------
DROP TABLE IF EXISTS `{{$pk}}photo_logs`;
CREATE TABLE `{{$pk}}photo_logs`
(
    `id`       int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `photo_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
    `src_url`  varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
    `log_time` int(10) UNSIGNED DEFAULT 0,
    `src`      varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL DEFAULT '',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX      `src_url`(`src_url`) USING BTREE,
    INDEX      `photo_id`(`photo_id`) USING BTREE,
    INDEX      `log_time`(`log_time`) USING BTREE,
    INDEX      `src`(`src`) USING BTREE
) ENGINE = InnoDB ROW_FORMAT=Dynamic;

DROP TABLE IF EXISTS `{{$pk}}tail`;
CREATE TABLE `{{$pk}}tail` (
    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
    `book_id` int(10) unsigned NOT NULL DEFAULT '0',
    `tailname` varchar(200) NOT NULL COMMENT '长尾词',
    `tailcode` varchar(255) NOT NULL COMMENT '唯一标识',
    `create_time` int(10) unsigned DEFAULT '0',
    `update_time` int(10) unsigned DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY `tailname` (`tailname`),
    unique key `tailcode` (`tailcode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;