import dydUtil from '../lib/axios.js'
import serveUrl from './url'
let util=new dydUtil(serveUrl).util  //封装的axios请求

//所有接口清单合并  接口名称不能一样
import user from './user'
let api= Object.assign(
    user,
)

export {
    util,
    api
}