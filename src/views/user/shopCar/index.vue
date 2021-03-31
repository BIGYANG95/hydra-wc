<template>
    <div id="index">
        <div style="width: 100%;height: 70vh;overflow: auto">
            <el-checkbox-group v-model="checkList">
                <el-checkbox
                        style="width: 96%;margin: 0 2% 3rem 2%"
                        v-for="(item,index) in tableData"
                        :key="index"
                        :label="item">
                    <van-card

                            :price="Number(item.price).toFixed(2)"
                            :desc="'备注：'+item.message"
                            :num="item.num"
                            :title="item.name"
                            :thumb="item.image">
                        <div slot="footer">
                            <van-button size="mini" :disabled="item.num>=item.stock_num"  @click="item.num++">+</van-button>
                            <van-button size="mini" :disabled="item.num<2" @click="item.num--">-</van-button>
                        </div>
                    </van-card>
                </el-checkbox>
            </el-checkbox-group>
        </div>

        <van-submit-bar
                style=""
                :price="price"
                button-text="提交"
                @submit="onSubmit">
            <el-checkbox :indeterminate="isIndeterminate" v-model="checkAll" @change="handleCheckAllChange">全选</el-checkbox>
            <el-button type="danger" round plain size="mini" :disabled="checkList.length<1" @click="deleteAll()">删除</el-button>
        </van-submit-bar>
    </div>
</template>

<script>
    export default {
        name: "index",
        props: [''],
        data() {
            return {
                tableData:[],
                checkList:[],
                checkAll: false,
                isIndeterminate: true,
                price:0
            }
        },
        methods: {
            deletes(index){

            },
            deleteAll(){
                //清空购物车
                let that=this
                this.checkList.forEach(val=>{
                    //循环清空所有
                    that.$api.delShopCar({ids:val.ids},res=>{
                        if(res){
                            this.$toast('删除成功')
                            //删除重复数组
                            that.tableData = that.tableData.filter((item) => !(that.checkList.some((i) => i === item)))
                            that.checkList.splice(0,that.checkList.length)
                        }
                    })
                })
            },

            onSubmit(){
                //点击购买
                let that=this
                if(this.checkList.length<1){
                    this.$toast('请至少选择一样商品')
                }else{

                    //留言等于加入时的留言
                    let message=''
                    this.checkList.forEach(cnt=>{
                        message+=cnt.name+'x'+cnt.num+', '
                    })
                    //弹框确认购买
                    this.$dialog.confirm({
                        title:'购买',
                        message: message
                    }).then(() => {
                        //如果要购买  循环调用接口 上传购买
                        new Promise((rs,rj)=>{
                            that.checkList.forEach(cnt=>{
                                that.$api.addPay(cnt,res=>{
                                    if(!res) rj(false)
                                  that.$api.upGoods({
                                    ids: cnt.goodsId,
                                    sales: Number(cnt.sales) + cnt.num
                                  },r=>{

                                  })
                                })
                            })
                            rs(true)
                        }).then(()=>{
                            that.tableData = that.tableData.filter((item) => !(that.checkList.some((i) => i === item)))
                            that.checkList.forEach(cnt=>{
                                that.$api.delShopCar(cnt,res=>{

                                })
                            })
                        })
                    })
                }
            },
            handleCheckAllChange(val) {
                //点击全选时
                this.checkList = val ? this.tableData : [];
                this.isIndeterminate = false;
                this.getPrice()
            },
            getPrice(){
                //获取商品价格
                let price=0
                this.checkList.forEach(val=>{
                    price+=val.price*val.num
                })
                this.price= price*100
            }
        },
        mounted() {
        },
        created() {
            //获取我的购物车情况
            if(this.$userInfo().ids){
                this.$api.getShopCar({$where:{userId:this.$userInfo().ids}},res=>{
                    if(res){
                        this.tableData=res
                    }
                })
            }else{
                this.$toast('请先登陆')
            }
        },
        computed:{
            shopCars(){
                return JSON.parse(JSON.stringify(this.tableData))
            }
        },
        components: {},
        watch: {
            checkList(){
                this.getPrice()
            },
            shopCars(){
                this.getPrice()
            }
        },
    }
</script>

<style scoped lang='scss'>
    #index {

    }
</style>
<style  lang='scss'>
    #index {
        .el-checkbox__label{
            width: 90%;
        }
        .van-submit-bar__button{
            width: 20% !important;
        }
        .van-submit-bar{
            position:static
        }
    }
</style>
