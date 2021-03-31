<template>
    <div id="index">
        <van-tabs v-model="active" @change="changeActive">
            <van-tab title="待发货"></van-tab>
            <van-tab title="已发货"></van-tab>
            <van-tab title="已收货"></van-tab>
            <van-tab title="已取消"></van-tab>
        </van-tabs>
        <van-card
                v-for="(item,index) in tableData"
                :key="index"
                :price="item.price*item.num"
                :desc="'备注：'+item.message"
                :num="item.num"
                :title="item.name"
                :thumb="item.image">
            <div slot="footer">
                {{headers[item.status]}}
                <el-button v-show="active===1" size="mini" type="primary" @click="changeStatus(item,index)">收货</el-button>
            </div>
        </van-card>
    </div>
</template>

<script>
    export default {
        name: "index",
        props: [''],
        data() {
            return {
                tableData:[],
                active:0,
                headers:['待发货','待收货','已收货','已取消']
            }
        },
        methods: {
            //点击收货时调用
            changeStatus(item,index){
                this.$api.upPay({ids:item.ids,status:'2'},res=>{
                    if(res){
                        this.tableData.splice(index,1)
                    }
                })
            },
            //改变菜单时
            changeActive(){
                console.log(this.active)
                this.getPay()
            },
            //获取我的支付列表
            getPay(){
                this.$api.getPay({$where:{userId:this.$userInfo().ids,status:this.active}},res=>{
                    if(res){
                        this.tableData.splice(0,this.tableData.length,...res)
                    }
                })
            }
        },
        mounted() {
            if(this.$userInfo().ids){
                this.getPay()
            }else{
                this.$toast('请先登陆')
            }
        },
        created() {
        },
        components: {},
        watch: {},
    }
</script>

<style scoped lang='scss'>
    #index {
        margin-bottom: 50px;
    }
</style>