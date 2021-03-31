<template>
    <div id="index">
        <div style="width: 300px;float: left;padding: 1rem">
            <el-card style="background-color: #f9f9f9" v-if="$userInfo().ids">
                <div style="width: 120px;height: 120px;margin: 0 auto">
                    <user-image width="120px" height="120px" border-radius="60px" :src="$userInfo().userImg"></user-image>
                </div>
                <p style="text-align: center;font-size: 1.8rem"> {{$userInfo().names}}</p>
            </el-card>
            <el-card style="background-color: #f9f9f9" v-else>
                <div @click="$routerGo('/Login')">
                    <div style="width: 120px;height: 120px;margin: 0 auto">
                        <user-image width="120px" height="120px" border-radius="60px" src=""></user-image>
                    </div>
                    <p style="text-align: center;font-size: 1.8rem"> 登录/注册</p>
                </div>
            </el-card>
            <el-menu
                    default-active="0"
                    class="el-menu-vertical-demo"
            >

                <el-menu-item v-show="$userInfo().ids" index="0" @click="$routerGo('/userInfo')">
                    <i class="el-icon-menu"></i>
                    <span slot="title">我的信息</span>
                </el-menu-item>
                <el-menu-item v-show="$userInfo().ids" index="14" @click="$routerGo('/myGoods')">
                    <i class="el-icon-menu"></i>
                    <span slot="title">我的商品</span>
                </el-menu-item>
                <el-menu-item v-show="$userInfo().ids" index="16" @click="$routerGo('/pays')">
                    <i class="el-icon-menu"></i>
                    <span slot="title">商品订单</span>
                </el-menu-item>
                <el-menu-item v-show="$userInfo().ids" index="10" @click="$routerGo('/myAddress')">
                    <i class="el-icon-menu"></i>
                    <span slot="title">我的地址</span>
                </el-menu-item>
                <el-menu-item v-show="$userInfo().ids" index="11" @click="$routerGo('/pay')">
                    <i class="el-icon-menu"></i>
                    <span slot="title">我的订单</span>
                </el-menu-item>
                <el-menu-item v-show="$userInfo().ids" index="12" @click="$routerGo('/shopCar')">
                    <i class="el-icon-menu"></i>
                    <span slot="title">我的购物车</span>
                </el-menu-item>
              <el-menu-item v-show="$userInfo().ids" index="13" @click="$routerGo('/myNews')">
                <i class="el-icon-menu"></i>
                <span slot="title">我的论坛</span>
              </el-menu-item>
              <el-menu-item v-show="$userInfo().ids" index="22" @click="$routerGo('/chat')">
                <i class="el-icon-menu"></i>
                <span slot="title">聊天信息</span>
              </el-menu-item>
                <el-menu-item  index="1" @click="adminLogin">
                    <i class="el-icon-s-tools"></i>
                    <span slot="title">管理员登陆</span>
                </el-menu-item>
                <el-menu-item v-show="$userInfo().ids" index="2" @click="$userInfo('clear');$routerGp('/')">
                    <i class="el-icon-delete-solid"></i>
                    <span slot="title">退出登录</span>
                </el-menu-item>
            </el-menu>
        </div>
        <div style="padding: 1rem;width: auto;overflow: hidden">
            <div style="width: 100%;">
                <router-view></router-view>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "index",
        props: [''],
        data() {
            return {}
        },
        methods: {
            adminLogin(){
                let admins=this.$router.resolve({
                    path:'/admin_login',
                })

                window.open(admins.href, '_blank')
            }
        },
        mounted() {
        },
        created() {
        },
        components: {},
        watch: {

        },
    }
</script>

<style scoped lang='scss'>
    #index {
        margin-bottom: 20px;
    }
</style>
