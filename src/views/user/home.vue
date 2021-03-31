<template>
    <div id="home">
        <el-carousel height="500px"  type="card" :interval="2000">

            <el-carousel-item v-for="(item,index) in imageData" :key="index">
                <img :src="$exImg+item.image"  width="100%" style="height: 500px">
            </el-carousel-item>
        </el-carousel>
        <div style="width: 80%;margin-left: 10%;">
            <p style="text-align: center">分类情况</p>
        <van-grid :gutter="10"  :column-num="8" style="margin: 1rem 0;">
            <van-grid-item
                    @click="clickSort(index)"
                    v-for="(item,index) in tableData.slice(0,8)"
                    :key="index"
                    :text="item.names">
                <user-image border-radius="20px" :src="item.image" />{{item.names}}
            </van-grid-item>
        </van-grid>
        </div>
        <p style="text-align: center">最新商品</p>
        <div style="width: 80%;margin-left: 10%;">
            <el-row>
                <el-col :span="6" v-for="(item,index) in goodData" :key="index">
                    <div  @click="$routerGo('/goodsInfo',item)">
                        <van-card
                                :price="Number(item.price).toFixed(2)"
                                :title="item.names"
                                :thumb="$exImg+imageList[index]||'https://img.yzcdn.cn/vant/ipad.jpeg'">
                        </van-card>
                    </div>
                </el-col>
            </el-row>

        </div>
    </div>
</template>

<script>
    import Image from "../admin/image";
    export default {
        name: "home",
        props: [''],
        data() {
            return {
                tableData:[],
                imageData:[],
                goodData:[],
                imageList:[]
            }
        },
        methods: {
            //点击分类时跳转
            clickSort(index){
                this.$routerGo('goods',{index:index+1})
            },
            getGoods(){

                //根据筛选条件获得商品
                let that=this
               let cnt={
                    $orderBY: {
                        col:'ids',
                        methods:'desc'
                    }
               }
                this.$api.getGoods(cnt,res=>{
                    if(res){
                        //获取商品规格
                        res.forEach((val,index)=> {
                            let c = {
                                $where: {
                                    goodId: val.ids
                                }
                            }
                            this.$api.getList(c, r => {
                                if (r) {
                                    that.imageList.push(r[0].image)
                                }
                            })
                        })
                        this.goodData=res
                    }
                })
            }
        },
        mounted() {

        },
        created() {
            //获取分类
            this.$api.getSort({},res=>{
                if(res) {
                    this.tableData=res
                }
            })
            this.getGoods()
            //获取轮播图
            this.$api.getImage({},res=>{
                if(res) this.imageData=res;
            })

        },
        components: {Image},
        watch: {},
    }
</script>

<style scoped lang='scss'>
    #home {

    }
</style>
