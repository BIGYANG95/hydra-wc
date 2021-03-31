const Router = require('koa-router') // koa 路由中间件
const router = new Router(); // 实例化路由
const lmsq = require('../../sql/linkSql')


//根据前端传值判断调用方法
router.post('/',    async (ctx)=>{
    let methods=ctx.request.body.$method
    if(ctx.request.body.$db==='mysql') {
        ctx.body = await lmsq[methods](ctx.request.body)
    }
})


module.exports=router