<template>
    <div id="boxs" v-if="show">
        <van-sku
                style="width: 50%;margin-left: 25%"
                v-model="show"
                :sku="sku"
                :goods="goods"
                :goods-id="goodsId"
                :hide-stock="sku.hide_stock"
                :message-config="messageConfig"
                @add-cart="addCarts"
                @buy-clicked="buyClick"

        >
<!--            <template slot="sku-body-top">-->
<!--                <div style="position: absolute;top: 0;width: 70%;left:15%;height: 12rem">-->
<!--                    <van-swipe class="my-swipe" :autoplay="3000" indicator-color="white">-->
<!--                        <van-swipe-item v-for="(it,index) in goodList" :key="index">-->
<!--                            <img :src="$nodeUrl+'getImg?imagePath='+it.image" width="100%" style="height: 20rem" >-->
<!--                        </van-swipe-item>-->
<!--                    </van-swipe>-->
<!--                </div>-->
<!--            </template>-->
            <template slot="extra-sku-group" slot-scope="props">
                <!--<el-collapse accordion>-->
                <!--<el-collapse-item>-->
                <!--<template slot="title">-->
                <!--<div style="padding: 0 12px;width: 70%;height: 49px;overflow: hidden">收获地址：{{address}}</div>-->
                <!--</template>-->
                <!--<el-radio-group v-model="address" style="padding: 12px">-->
                <!--<el-radio style="padding: 8px 0" :label="item.address" v-for="(item,index) in addressList" :key="index">{{item.address}}</el-radio>-->
                <!--</el-radio-group>-->
                <!--</el-collapse-item>-->
                <!--</el-collapse>-->
                <div style="padding: 0 12px;width: 70%;height: 49px;overflow: hidden">月销量：{{payNum}}</div>
                <el-button style="margin-left: 20px" type="text" @click="$routerGo('/chat', $route.query)">联系卖家</el-button>
            </template>
        </van-sku>
    </div>
</template>

<script>
    import { Dialog } from 'vant';
    export default {
        name: "info",
        props: [''],
        data() {
            return {
                addressList:[],
                address:'',
                ruleForm:{},
                show:true,
                payNum:0,//月销量
                goodsId:'',
                goodList:[],
                sku: {
                    // 所有sku规格类目与其值的从属关系，比如商品有颜色和尺码两大类规格，颜色下面又有红色和蓝色两个规格值。
                    // 可以理解为一个商品可以有多个规格类目，一个规格类目下可以有多个规格值。
                    tree: [
                        {
                            k: '规格', // skuKeyName：规格类目名称
                            v: [
                                {
                                    id: '1', // skuValueId：规格值 id
                                    name: '红色', // skuValueName：规格值名称
                                    imgUrl: 'https://img.yzcdn.cn/2.jpg', // 规格类目图片，只有第一个规格类目可以定义图片
                                    previewImgUrl: 'https://img.yzcdn.cn/2.jpg', // 用于预览显示的规格类目图片
                                },
                                {
                                    id: '2',
                                    name: '蓝色',
                                    imgUrl: 'https://img.yzcdn.cn/2.jpg',
                                    previewImgUrl: 'https://img.yzcdn.cn/2.jpg',
                                }
                            ],
                            k_s: 's1'// skuKeyStr：sku 组合列表（下方 list）中当前类目对应的 key 值，value 值会是从属于当前类目的一个规格值 id
                        }
                    ],
                    // 所有 sku 的组合列表，比如红色、M 码为一个 sku 组合，红色、S 码为另一个组合
                    list: [
                        {
                            id: 1, // skuId，下单时后端需要
                            price: 100, // 价格（单位分）
                            s1: '1', // 规格类目 k_s 为 s1 的对应规格值 id
                            stock_num: 110 // 当前 sku 组合对应的库存
                        },
                    ],

                    messages: [
                        {
                            // 商品留言
                            datetime: '0', // 留言类型为 time 时，是否含日期。'1' 表示包含
                            multiple: '0', // 留言类型为 text 时，是否多行文本。'1' 表示多行
                            name: '留言', // 留言名称
                            type: 'text', // 留言类型，可选: id_no（身份证）, text, tel, date, time, email
                            required: '0', // 是否必填 '1' 表示必填
                            placeholder: '' // 可选值，占位文本
                        }
                    ],
                    hide_stock: false // 是否隐藏剩余库存
                },
                goods: {
                    // 数据结构见下方文档
                },
                messageConfig: {
                    // 数据结构见下方文档
                }
            }
        },
        methods: {

            addCarts(data){
                if(this.$userInfo().ids){
                    let sel=data.selectedSkuComb
                    let cnt={
                        goodId:data.goodsId,
                        listId:sel.id,
                        message:data.messages.message_0,
                        num:data.selectedNum,
                        name:sel.name,
                        image:sel.imgUrl,
                        price:parseFloat(sel.price/100),
                        userId:this.$userInfo().ids,
                        ids:Date.now(),
                        status:'0',
                        address:this.address,
                        shopId:this.$route.query.shopId,
                    }
                    this.$api.addShopCar(cnt,res=>{
                        if(res){
                            this.$toast('加入成功')
                            this.$routerGo('/shopCar')
                        }
                    })
                }else{
                    this.$toast('请先登陆')
                }

            },
            buyClick(data){
                if(this.$userInfo().ids){
                    let sel=data.selectedSkuComb;
                    let cnt={
                        goodId:data.goodsId,
                        listId:sel.id,
                        message:data.messages.message_0,
                        num:data.selectedNum,
                        name:sel.name,
                        image:sel.imgUrl,
                        price:parseFloat(sel.price/100),
                        userId:this.$userInfo().ids,
                        ids:Date.now(),
                        status:'0',
                        address:this.address,
                        shopId:this.$route.query.shopId,
                    };

                    let that=this
                    Dialog.confirm({
                        title:'已选'+ cnt.name,
                        message: cnt.num+'件，共'+ +cnt.num*cnt.price+'元'+' '+'配送到以后向配送员付款'

                    }).then(() => {
                        console.log(cnt)
                      that.$api.upGoods({
                        ids: data.goodsId,
                        sales: Number(this.$route.query.sales) + data.selectedNum
                      },res=>{

                      })
                        that.$api.addPay(cnt,res=>{
                            if(res){
                                this.$routerGo('/pay')
                            }
                        })
                    })
                }else{
                    this.$toast('请先登陆')
                }
            },
            changeShow(){
                let list=[]
                this.goodList.forEach((val,index)=>{
                    list.push({})
                    list[index].id=val.ids
                    list[index].s1=val.ids
                    list[index].name=val.listName
                    list[index].imgUrl=this.$nodeUrl+'getImg?imagePath='+val.image
                    list[index].previewImgUrl=list[index].imgUrl
                    list[index].price=100*parseFloat(val.price)
                    list[index].stock_num=parseInt(val.num)
                })

                this.sku.tree[0].v=list
                this.sku.list=list
              document.getElementsByClassName('van-sku-row__item')[0].click()
            },
            getAddress(){
                let that=this
                this.$api.getAddress({$where:{userId:this.$userInfo().ids}},res=>{
                    if(res){
                        res.forEach((val,index)=>{
                            that.addressList.push({'address':''})
                            that.addressList[index].address=val.name+val.tel+val.province+val.city+val.county+val.addressDetail
                        })
                        that.address=that.addressList[0].address
                    }
                })
            },
            getGoodList(){
                this.$api.getList({$where:{goodId:this.goodsId}},res=>{
                    if(res){
                        this.goodList.unshift(...res)
                        this.changeShow()

                    }
                })
            },
            getPayNum(){
                let now=Date.now()
                let Y=this.$Time(now).getTime('Y')
                let M=this.$Time(now).getTime('M')

                //当前月时间戳
                let time=Date.parse(new Date(this.$Time(now).getTime('Y-M')))
                //下个月时间戳
                if(M==='12'||M===12){Y++;M=1}else{M++}
                let nextTime=Date.parse(new Date(Y+'-'+M))
                let cnt={
                    $where: {
                        goodId:this.goodsId,

                    },
                    $or:{
                        'ids>':time,
                        '  ids<':nextTime,
                    }
                }
                this.$api.getPay(cnt,res=>{
                    if(res){
                        let p=0
                        res.forEach(val=>{
                            p+=parseInt(val.num)
                        })
                        this.payNum=p
                    }
                })
            }
        },
        mounted() {
            this.goodsId=this.$route.query.ids
            this.getGoodList()
            this.getPayNum()
          setTimeout(()=>{
            document.getElementsByClassName('van-sku-row__item')[0].click()
          },300)


        },
        created() {
            this.getAddress()
            let now=Date.now()

        },
        watch:{
            show(news){
                console.log(news)
                if(!this.show){
                    this.$router.go(-1)
                }
            }
        }
    }
</script>

<style scoped lang='scss'>
    #boxs {

        .el-collapse-item__header{
            padding: 0 12px;
        }
        .el-divider--horizontal{
            margin: 0.8rem 0 !important;
        }

    }
</style>

<style lang="scss">
    .van-popup--bottom.van-popup--round{
        min-height: 100vh !important;
        max-height: 100% !important;
        border-radius: 0 !important;
    }
    .van-sku-header{
        margin-top: 18rem;
    }

</style>
