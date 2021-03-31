//跳转路由

export default function routerGo(path,query='',call) {
    if(this.$route.fullPath!==path){
        this.$router.push({
            path:path,
            query:query
        })
    }
    setTimeout(()=>{
        call?call():false
    },0)

}