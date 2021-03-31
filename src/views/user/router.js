
import header from './head'

import home from './home'
import news from './news'
import goods from './goods/index'
import chat from './chat/index'
import my from './my/index'
import myAddress from './my/address/index'
import myGoods from './my/goods/index'
import myPay from './my/address/index'
import joinWe from './my/joinWe/index'



import pay from './pay/index'
import pays from './my/pays/index'
import myNews from './my/news'

import goodsInfo from './goods/info'
import shopCar from './shopCar/index'

import login  from './login/login'
import signUp  from './login/signUp'
import userInfo from './login/info'
import newsInfo from './news/info'

let router=[
    {
        path:'/header',
        name:'header',
        component:header,
        children:[
            {
                path:'/my',
                name:'my',
                component:my,
                children:[
                    {
                        path:'/chat',
                        name:'chat',
                        component:chat,
                    },
                    {
                        path:'/pays',
                        name:'pays',
                        component:pays,
                    },
                    {
                        path:'/myGoods',
                        name:'myGoods',
                        component:myGoods,
                    },
                    {
                        path:'/myNews',
                        name:'myNews',
                        component:myNews,
                    },
                    {
                        path:'/pay',
                        name:'pay',
                        component:pay,
                    },
                    {
                        path:'/shopCar',
                        name:'shopCar',
                        component:shopCar,
                    },
                    {
                        path:'/myPay',
                        name:'myPay',
                        component:myPay,
                    },
                    {
                        path:'/myAddress',
                        name:'myAddress',
                        component:myAddress,
                    },
                    {
                        path:'/login',
                        name:'login',
                        component:login,
                    },
                    {
                        path:'/signUp',
                        name:'signUp',
                        component:signUp,
                    },
                    {
                        path:'/userInfo',
                        name:'userInfo',
                        component:userInfo,
                    },
                ]
            },

            {
                path:'/goodsInfo',
                name:'goodsInfo',
                component:goodsInfo,
            },
            {
                path:'/home',
                name:'home',
                component:home,
            },
            {
                path:'/news-info',
                name:'news-info',
                component: newsInfo,
            },
            {
                path:'/news',
                name:'news',
                component:news,
            },
            {
                path:'/goods',
                name:'goods',
                component:goods,
            },


            {
                path:'/joinWe',
                name:'joinWe',
                component:joinWe,
            },




        ]
    }
]

export default router
