<template>
    <div id="index">
        <div style="width: 80%;margin-left: 10%;">
          <el-row>
            <el-button type="text" @click="changeSort('sort')">综合</el-button>
            <el-button type="text" @click="changeSort('price')">价格</el-button>
            <el-button type="text" @click="changeSort('num')">销量</el-button>
          </el-row>
            <el-tabs tab-position="top" v-model="activeKey">
                <el-tab-pane  label="全部"></el-tab-pane>
                <el-tab-pane v-for="(item,index) in menuData" :key="index+''"  :label="item.names"></el-tab-pane>
            </el-tabs>
        </div>
        <div style="width: 80%;margin-left: 10%;">
            <el-row>
                <el-col :span="6" v-for="(item,index) in tableData" :key="index">
                    <div  @click="$routerGo('/goodsInfo',item)">
                        <van-card
                            :desc="`销量 ：${item.sales || 0}`"
                                :price="Number(item.price).toFixed(2)"
                                :title="item.names"
                                :thumb="$exImg+item.imageList||'https://img.yzcdn.cn/vant/ipad.jpeg'">
                        </van-card>
                    </div>
                </el-col>
            </el-row>
        </div>
    </div>
</template>

<script>
    export default {
        name: "index",
        props: [''],
        data() {
            return {
                activeKey:0,
                menuData:[],
                names:'',
                tableData:[],
                imageList:[],
                sortList:[],
              select:{
                sort: false,
                price: false,
                num: false
              }
            }
        },
        methods: {
            getGoods(cnt={}){
                //更具赛选条件获取商品
                let that=this
                if(this.activeKey!=0){
                    cnt.$where={sortId:this.menuData[this.activeKey-1].ids}
                }
                if(this.names){
                    cnt.$like={names:`%${this.names}%`}
                }
                this.$api.getGoods(cnt, res=>{
                    if(res){
                       this.tableData.splice(0,this.tableData.length)
                         res.forEach((val,index)=> {
                            let c = {
                                $where: {
                                    goodId: val.ids
                                }
                            }
                            that.imageList.splice(0,that.imageList.length)
                            that.imageList=[]
                                 that.$api.getList(c, r => {
                                     if (r) {
                                         let item=res[index]
                                         item.imageList=r[0].image
                                         that.tableData.splice(index,0,item)
                                        // that.imageList.splice(index,0,r[0].image)
                                     }
                                 })

                        })

                    }
                })
            },
          changeSort(key) {
            this.select[key] = !this.select[key]

            let cnt = {}
            if(key === 'sort'){
              cnt.$orderBY = {
                col: 'ids',
                methods: this.select[key] ?  'asc' : 'desc'
              }
            }else if(key === 'price') {
              cnt.$orderBY = {
                col: 'price',
                methods: this.select[key] ?  'asc' : 'desc'
              }
            }else{
              cnt.$orderBY = {
                col: 'sales',
                methods: this.select[key] ?  'asc' : 'desc'
              }
            }
            if(key === 'price') {
              this.tableData = this.tableData.sort((a, b)=>{
                if(this.select[key]) {
                  return Number(b.price) - Number(a.price)
                }else{
                  return Number(a.price) - Number(b.price)
                }
                let that = this
                that.imageList=[]
                that.$api.getList(c, r => {
                  if (r) {
                    let item=res[index]
                    item.imageList=r[0].image
                    that.tableData.splice(index,0,item)
                    // that.imageList.splice(index,0,r[0].image)
                  }
                })
              })
            }else{
              this.tableData.length = 0
              this.getGoods(cnt)
            }

          }
        },
        mounted() {
            //判断是否路由传值
            if(this.$route.query.index){
                this.activeKey=this.$route.query.index||0
                console.log(this.$route.query.index)
            }



        },
        created() {
            this.$api.getSort({},res=>{
                if(res){
                    this.menuData.splice(0,this.menuData.length,...res)
                    setTimeout(()=>{
                        if(!this.names){
                            this.getGoods()
                        }
                    },100)

                }
            })
            this.$center.$on('changeName',name=>{
                this.names=name
                this.getGoods()
            })
            this.$center.$on('changeActive',index=>{
                this.activeKey=index
            })
        },
        components: {},
        watch: {
            activeKey(){
                this.getGoods()
            }
        },
    }
</script>

<style scoped lang='scss'>
    #index {

    }
</style>