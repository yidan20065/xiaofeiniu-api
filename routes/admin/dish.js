/*
*菜品相关路由
*/
const express=require('express');
const pool=require('../../pool');
var router=express.Router();
module.exports=router;

/*
*API: GET /admin/dish
*获取所有的菜品(按类别进行分类)
*返回数据：
*[
*  {cid:1,cname:'肉类',dishList:[{},{}...]},
*  {cid:2,cname:'肉类',dishList:[{},{}...]},
*  ...
*]
*/
router.get('/',(req,res)=>{
    //查询所有的菜品类型
    pool.query('SELECT cid,cname FROM xfn_category',(err,result)=>{
        if (err) throw err;
        var categoryList=result; //菜品类型数组
        var count = 0;
        for(let c of categoryList){
            //循环查询每个类别下有哪些菜品
            pool.query('SELECT * FROM xfn_dish WHERE categoryId=?',c.cid,(err,result)=>{
                if (err) throw err;
                c.dishList=result;
                count++;
                if(count==categoryList.length){
                    res.send(categoryList);
                }
            })
        }
    })
})
/*
* POST  /admin/dish/image
*请求参数:
*接收客户端上传的菜品图片，保存在服务器上，返回该图片在服务器上的随机文件名
*响应数据：
*{code:200,msg:"upload succ",fileName:'13512873612-2342.jpg'}
*/
//引入multer中间件
const multer=require('multer');
const fs=require('fs');
var upload=multer({
    dest:'tmp/'     //指定客户端上传的文件临时存储路径
});
//定义路由，使用文件上传中间件
router.post('/image',upload.single('dishImg'),(req,res)=>{
    //console.log(req.file);  //客户端上传的图片
    //console.log(req.body);  //客户端随同图片提交的字符数据
    var tmpFile=req.file.path;  //临时文件名
    var suffix=req.file.originalname.substring(
        req.file.originalname.lastIndexOf('.'));//原始文件名中的后缀部分
    var newFile=randFileName(suffix); //目录文件名
    fs.rename(tmpFile,'img/dish/'+newFile,()=>{
        res.send({code:200,msg:'upload succ',fileName:newFile});//把临时文件转移
    })   
})

//生成一个随机文件名
//参数:suffix 表示要生成的文件名中的后缀
function randFileName(suffix){
    var time=new Date().getTime();  //当前系统时间戳
    var num=Math.floor(Math.random()*(10000-1000)+1000);  //4位的随机数字
    return time + '-' + num + suffix;
}
/*
* POST  /admin/dish
*请求参数:{title:'xx',imgUrl:'..jpg',price:xx,detail:'xx',categoryId:xx}
*添加一个新菜品
*输出信息：{code:200,msg:'dish added succ',dishId:45}
*/
router.post('/',(req,res)=>{
    var data=req.body;
    pool.query('INSERT INTO xfn_dish SET ?',data,(err,result)=>{
        if (err) throw err;
        if(result.affectedRows>0){
            res.send({code:200,msg:'dish added succ',dishId:result.insertId})
        }
    })
})

/*
*DELETE /admin/dish/:did
*根据指定的菜品编号删除该菜品
*输出数据
*{code:200,msg:''}
*/
router.delete('/:did',(req,res)=>{
    //注意:删除菜品类别前必须先把属于该类别的菜品的类别编号设置为NULL
    pool.query('UPDATE xfn_dish SET categoryId=NULL WHERE categoryId=?',req.params.did,(err,result)=>{
        if (err) throw err;
        //至此指定类别的菜品已经修改完毕
        pool.query('DELETE  FROM xfn_dish WHERE did=?',req.params.did,(err,result)=>{
            if (err) throw err;
            //获取DELETE语句在数据库中影响的行数
            if(result.affectedRows>0){
                res.send({code:200,msg:'1 category deleted'})
            }else{
                res.send({code:400,msg:'0 category deleted'})
            }
        })
    })  
})