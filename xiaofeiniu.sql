#设置客户端连接使用的编码
SET NAMES UTF8;
#丢弃xiaofeiniu表如果存在的话
DROP DATABASE IF EXISTS xiaofeiniu;
#创建xiaofeiniu表并设置编码
CREATE DATABASE xiaofeiniu CHARSET=UTF8;
#进入xiaofeiniu表
USE xiaofeiniu;

#/**管理员信息表xfn_admin**/
CREATE TABLE xfn_admin(
  aid  INT PRIMARY KEY AUTO_INCREMENT,
  aname VARCHAR(32) UNIQUE,
  apwd  VARCHAR(64)
);

#/**桌台信息表xfn_table**/
CREATE TABLE xfn_table(
  tid  INT PRIMARY KEY AUTO_INCREMENT,
  tname  VARCHAR(64),
  type   VARCHAR(16),
  status  INT
);

#/**项目全局设置表xfn_settings**/
CREATE TABLE xfn_settings(
  sid  INT PRIMARY KEY AUTO_INCREMENT,
  appName  VARCHAR(32),
  apiUrl   VARCHAR(64),
  adminUrl VARCHAR(64),
  appUrl   VARCHAR(64),
  icp      VARCHAR(64),
  copyright VARCHAR(128)
);

#/**桌台预定信息表:xfn_resevation**/
CREATE TABLE xfn_resevation(
  rid  INT PRIMARY KEY AUTO_INCREMENT,
  contactName VARCHAR(64),
  phone       VARCHAR(16),
  contactTime BIGINT,
  dinnerTime  BIGINT
);

#/**菜品分类表:xfn_category**/
CREATE TABLE xfn_category(
  cid  INT PRIMARY KEY AUTO_INCREMENT,
  cname  VARCHAR(32)             
);

#/**菜品信息表:xfn_dish**/
CREATE TABLE xfn_dish(
  did INT PRIMARY KEY AUTO_INCREMENT,
  title      VARCHAR(32),
  imgUrl     VARCHAR(128),
  price      DECIMAL(6,2),
  detail     VARCHAR(128),
  categoryid INT
);

#/**订单表:xfn_order**/
CREATE TABLE xfn_order(
  oid  INT PRIMARY KEY AUTO_INCREMENT,
  startTime       BIGINT,
  endTime         BIGINT,
  customerCount   INT,
  tableId         INT
);

#/**订单表:xfn_order_detail**/
CREATE TABLE xfn_order_detail(
  did  INT PRIMARY KEY AUTO_INCREMENT,
  dishId         INT,
  dishCount      INT,
  customerName   VARCHAR(64),
  orderId        INT
);