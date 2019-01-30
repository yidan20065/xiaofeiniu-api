/*小肥牛扫码点餐项目API子系统*/
const PORT = 8090;
const express = require('express');
const categoryRouter = require('./routes/admin/category');
const adminRouter = require('./routes/admin/admin');
const dishRouter = require('./routes/admin/dish');
const settingsRouter = require('./routes/admin/settings');
const tableRouter = require('./routes/admin/table');


//引入中间件body-parser
const bodyParser=require('body-parser');
//启动主服务器
var app=express();
app.listen(PORT,()=>{
    console.log('Server Listening:'+PORT+'...');
})
//引入cors 
const cors = require('cors');
//配置跨域访问
app.use(cors());
//将application/json格式的请求主体数据解析出来放入req.body属性
app.use(bodyParser.json());

//挂载路由器
app.use('/admin/category',categoryRouter);
app.use('/admin',adminRouter);
app.use('/admin/dish',dishRouter);
app.use('/admin/settings',settingsRouter);
app.use('/admin/table',tableRouter);