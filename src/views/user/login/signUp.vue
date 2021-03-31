<template>
    <div id="box">
        <img src="@/assets/back.jpg" style="height: 100vh;width: 100%" >
        <div style="background-color: #00000099;width: 100%;height: 100vh;">
            <div style="width: 30%;padding-top: 18rem;position: absolute;z-index: 1000;top:0;right:30%">


                    <van-cell-group>
                        <van-field   label="账号" v-model="ruleForm.username" placeholder="请输入账号" />
                        <van-field label="密码" v-model="ruleForm.password" placeholder="请输入密码" />
                        <van-field label="昵称" v-model="ruleForm.names" placeholder="请输入昵称" />
                    </van-cell-group>
                    <van-button type="primary" round style="z-index: 10;width: 100%;height: 3rem;font-size: 1.5rem;margin-top: 1rem" @click="signUp"> 注册</van-button>
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
                ruleForm:{
                    username:'',
                    password:'',
                    names:'',
                    phone:'',
                    userImg:'',

                },
            }
        },
        methods: {
            signUp(){
                let that=this
                let form =JSON.parse(JSON.stringify(this.ruleForm))
                delete form.userImg
                new Promise((rs,rj)=>{
                    for(let i in form){
                        if(!form[i]){
                            console.log(i+form[i])
                            rj(false)
                        }
                    }
                    if(form.password===that.$route.query.password){
                        console.log('password')
                        rj(false)
                    }
                    rs(true)
                }).then(r=>{
                    that.successImg()
                }).catch(msg=>{
                    this.$toast('请填写完整或修改密码');
                })
            },
            changeImg(file){
                this.ruleForm.file=file
            },
            successImg(){
              if(this.ruleForm.username.length < 6 || this.ruleForm.password.length < 6){
                this.$toast('账号密码长度在6位以上')
                return;
              }
              this.$api.login({$where:{username: this.ruleForm.username}},r=>{
                if(r.length>0){
                  this.$toast('该账号已被注册')
                }else {
                  let form =JSON.parse(JSON.stringify(this.ruleForm));
                  form.ids=Date.now()
                  this.$api.addUser(form,res=>{
                    if(res) {
                      this.$routerGo('/login')
                    }
                  })
                }
              })
            }
        },
        mounted() {
            this.ruleForm=this.$JSP(this.$route.query)

        },
        created() {
        },
    }
</script>

<style scoped lang='scss'>
    #box {
        overflow: hidden !important;
        height:81vh;
        .inputs{
            margin-bottom: 2rem;
        }

    }
</style>