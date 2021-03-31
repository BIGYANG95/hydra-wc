<template>
    <div id="box">
        <img src="@/assets/back.jpg" style="height: 100vh;width: 100%" >
        <div style="background-color: #00000099;width: 100%;height: 100vh;">
            <div style="width: 30%;padding-top: 18rem;position: absolute;z-index: 1000;top:0;right:30%">
                <van-cell-group>
                    <van-field v-model="username" placeholder="请输入账号" />
                    <van-field v-model="password" placeholder="请输入密码" />
                </van-cell-group>
                <div style="width: 100%;height: 3.5rem">
                    <el-button type="text" style="" @click="$routerGo('/signUp')">注册</el-button>
                    <!--<el-button type="text" style="color: #ffffff;float: right" @click="adminLogin">管理员登陆</el-button>-->
                </div>
                <el-button type="success" round style="width: 100%;height: 3rem;font-size: 1.5rem" @click="login" > 登陆</el-button>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "login",
        props: [''],
        data() {
            return {
                username:'',
                password:'',
            }
        },
        methods: {

            login(){
                if(this.username&&this.password){
                    let cnt={
                        $where:{
                            username:this.username,
                            'password':this.password,
                        },
                    }
                    this.$api.login(cnt,res=>{
                        if(res.length>0){
                            this.$userInfo(res[0])
                            this.$routerGo('/my')
                        }else {
                            this.$toast('账号或密码错误')
                        }
                    })
                }else{
                    this.$toast('请输入完整')
                }
            }
        },
        mounted() {
        },
        created() {
            if(this.$userInfo().username){
                this.$routerGo('/my')
            }
        },
    }
</script>

<style scoped lang='scss'>
    #box {
        width: 100%;
        overflow: hidden !important;
        height:81vh;
        .inputs{
            margin-top: 2rem;
        }
    }
</style>