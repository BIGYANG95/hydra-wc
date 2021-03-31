<template>
    <div id="box">
        <admin-menu menuText="“冰菓”动漫电商网站"  :menuList="menuList" :asideWidth="160" >

            <div slot="menu-ele"><el-button type="danger" @click="backLogins" size="mini" style="position: fixed;right: 30px;top:20px">退出登陆</el-button></div>
            <div slot="main">
                <router-view></router-view>
            </div>
        </admin-menu>
    </div>
</template>

<script>
    import menuList from './menu.js'
    import adminMenu from './menu.vue'
    export default {
        name: "index",
        props: [''],
        data() {
            return {
                //管理员菜单
                menuList:menuList,
            }
        },
        methods: {
            //退出登陆
            backLogins(){
                sessionStorage.setItem('adminInfo', '')
                this.$router.push('/admin_login')
            }
        },
        mounted() {
            //判断是否登陆
            let adminInfo=sessionStorage.getItem('adminInfo')
            if(!adminInfo||adminInfo==='') this.$router.push('/admin_login');
            console.log(adminInfo)
        },
        created() {

        },
        components:{
            adminMenu
        }
    }
</script>

<style scoped lang='scss'>
    #box {

    }
</style>
