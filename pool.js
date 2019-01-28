/*
   * MySQL数据库连接池
*/
const  mysql = require('mysql');
var pool=mysql.createPool({
    host:'127.0.0.1',
    port:3306,
    user:'root',
    password:'',
    database:'xiaofeiniu',
    connectionLimit:10     //连接池中连接数量
});
module.exports=pool;