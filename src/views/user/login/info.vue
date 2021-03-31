<template>
    <div id="box">
        <div style="width: 10rem;margin: 0 auto">
            <up-img :auto-upload="true" @success="success" :src="$userInfo().userImg"></up-img>
        </div>

        <van-form @submit="onSubmit" style="margin-top: 1rem">
            <van-field
                    v-model="form.username"
                    name="username"
                    label="账号"
                    :disabled="true"
            ></van-field>
            <van-field
                    v-model="form.names"
                    name="names"
                    label="用户名"
                    placeholder="请填用户名"
                    :rules="[{ required: true, message: '请填用户名' }]">
            </van-field>
            <van-field
                    v-model="form.password"
                    name="password"
                    label="密码"
                    placeholder="请填写密码"
                    :rules="[{ required: true, message: '请填写密码' }]">

            </van-field>
            <van-field
                    v-model="form.phone"
                    name="phone"
                    label="手机"
                    placeholder="请填写手机号"
                    :rules="[{ required: true, message: '请填写手机号' }]">

            </van-field>
            <div style="">
                <van-button  block type="info" native-type="submit">
                    修改
                </van-button>


                <van-button  block style="margin-top: 20px" type="danger" @click="signUp">
                    退出登陆
                </van-button>
            </div>
        </van-form>
    </div>
</template>

<script>


    export default {
        name: "info",
        props: [''],
        data() {
            return {
                form:JSON.parse(JSON.stringify(this.$userInfo())),//深度拷贝对象
                imageUrl:this.$userInfo().userImg
            }
        },
        methods: {

            //上传图片成功调用函数
            success(path){
                //this.imageUrl=this.$nodeUrl+'file/getImg?imagePath='+this.$userInfo.userImg
                console.log(path)
                //修改用户信息
                this.form.userImg=path
                // let cnt={
                //     ids:this.$userInfo().ids,
                //     userImg:path
                // }
                // this.$api.upUser(cnt,res=>{
                //     if(res){
                //         this.$toast('修改成功')
                //         sessionStorage.setItem('userInfo',JSON.stringify(this.$userInfo()))
                //     }
                // })
            },
            onSubmit(values) {
                //点击修改
                let cnt=JSON.parse(JSON.stringify(this.form))
                this.$api.upUser(cnt,res=>{
                    if(res){
                        this.$toast('修改成功')
                        this.$userInfo(cnt)
                    }
                })
            },
            signUp(){
                this.$userInfo('clear')
                this.$routerGo('/my')
            }
        },
        mounted() {
            if(!this.$userInfo().username){
                this.$routerGo('/my')
            }
        },
        created() {

        },
        components:{

        }
    }
</script>

<style scoped lang='scss'>
    #box {
        width: 80%;
        margin: 0 10%;
    }
</style>
