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
INSERT INTO xfn_admin VALUES
(NULL,'admin',PASSWORD('123456')),
(NULL,'boss',PASSWORD('999999'));

#/**桌台信息表xfn_table**/
CREATE TABLE xfn_table(
  tid  INT PRIMARY KEY AUTO_INCREMENT,
  tname  VARCHAR(64),
  type   VARCHAR(32),
  status  INT
);
INSERT INTO xfn_table VALUES
(NULL,'福满堂','6-8人桌',1),
(NULL,'金镶玉','4人桌',3),
(NULL,'寿齐天','10人桌',2),
(NULL,'全家福','2人桌',0);

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
INSERT INTO xfn_settings VALUES
(NULL,'小肥牛','http://127.0.0.1:8090',
'http://127.0.0.1:8091','http://127.0.0.1:8092',
'京ICP备12003709号-3','Copyright © 北京达内金桥科技有限公司版权所有');
#/**桌台预定信息表:xfn_resevation**/
CREATE TABLE xfn_resevation(
  rid  INT PRIMARY KEY AUTO_INCREMENT,
  contactName VARCHAR(64),
  phone       VARCHAR(16),
  contactTime BIGINT,
  dinnerTime  BIGINT
);
INSERT INTO xfn_resevation VALUES
(NULL,'丁丁','13501234567',1548404840420,1548410400000),
(NULL,'丫丫','13701234567',1548404840420,1548410400000),
(NULL,'豆豆','13801234567',1548404840420,1548410400000),
(NULL,'东东','15001234567',1548404840420,1548410400000);
#/**菜品分类表:xfn_category**/
CREATE TABLE xfn_category(
  cid  INT PRIMARY KEY AUTO_INCREMENT,
  cname  VARCHAR(32)             
);
INSERT INTO xfn_category VALUES
(NULL,'肉类'),
(NULL,'海鲜河鲜'),
(NULL,'丸滑类'),
(NULL,'蔬菜豆制品'),
(NULL,'菌菇类');
#/**菜品信息表:xfn_dish**/
CREATE TABLE xfn_dish(
  did INT PRIMARY KEY AUTO_INCREMENT,
  title      VARCHAR(32),
  imgUrl     VARCHAR(128),
  price      DECIMAL(6,2),
  detail     VARCHAR(128),
  categoryId INT,
  FOREIGN KEY(categoryId) REFERENCES xfn_category(cid)
);
INSERT INTO xfn_dish VALUES
(100000,'草鱼片','CE7I9470.jpg',35,'选鲜活草鱼，切出鱼片冷鲜保存。锅开后再煮1分钟左右即可食用',1),
(NULL,'脆皮肠','CE7I9017.jpg',20,'锅开后再煮3分钟左右即可食用',1);

#/**订单表:xfn_order**/
CREATE TABLE xfn_order(
  oid  INT PRIMARY KEY AUTO_INCREMENT,
  startTime       BIGINT,
  endTime         BIGINT,
  customerCount   INT,
  tableId        INT,
  FOREIGN KEY(tableId) REFERENCES xfn_table(tid)
);
INSERT INTO xfn_order VALUES
(1,1548404810420,1548405810420,3,1);
#/**订单详情表:xfn_order_detail**/
CREATE TABLE xfn_order_detail(
  did  INT PRIMARY KEY AUTO_INCREMENT,
  dishId         INT,
  dishCount      INT,
  customerName   VARCHAR(64),
  orderId        INT,
  FOREIGN KEY(dishId) REFERENCES xfn_dish(did),
  FOREIGN KEY(orderId) REFERENCES xfn_order(oid)
);
INSERT INTO xfn_order_detail VALUES
(NULL,100000,1,'丁丁',1);