/*
*座位相关路由
*/
const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;

/*
*GET  /admin/table
*获取所有的全局设置信息
*返回数据
*[{tid:xxx,tname:'xx',status:''},...]
*/
router.get('/',(req,res)=>{
    pool.query('SELECT * FROM xfn_table ORDER BY tid',(err,result)=>{
        if (err) throw err;
        res.send(result);
    })
})
