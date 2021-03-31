<template>
    <div class="index">
        <div class="infinite-list-wrapper" style="overflow:auto">
            <el-row :gutter="20" style="width: 90vw;overflow: hidden;padding: 0 5vw;margin: 20px 0">
                <el-col :span="6" v-for="(item,index) in listData.slice(0, count)" :key="index" v-infinite-scroll="load" infinite-scroll-disabled="disabled">
                    <el-card shadow="hover">
                        <div>
                            <el-row style="font-size: 18px;text-align: center;font-weight: 600">
                                {{item.title}}
                                <el-button style="float: right;margin: 0" @click="$routerGo('news-info',item)" type="text" >详情</el-button>
                            </el-row>
                            <el-row style="width: 100%;height: 180px">
                                <dyd-video style="" v-if="item.video"   :src="item.video"></dyd-video>

                                <el-row v-else>
                                    {{item.subtitle}}
                                </el-row>
                            </el-row>

                            <el-row style="color: #999999;height: 20px;padding-top: 8px">
                                <span style="float: right;">
                                {{$Time(item.ids).getTime()}}
                            </span>
                            </el-row>
                        </div>
                    </el-card>
                </el-col>
            </el-row>
            <el-row style="text-align: center">
                <p v-if="loading">加载中...</p>
                <p v-if="noMore">没有更多了</p>
            </el-row>
        </div>
        <el-row v-show="!listData.length" style="text-align: center;font-size: 14px;height: 200px;line-height: 200px">
            暂无视频
        </el-row>
    </div>
</template>

<script>
import dydVideo from "@/assets/util/components/dydVideo";
  export default {
    name: 'index',
    props: [''],
    components: { dydVideo },
    data() {
      return {
        tableData:[],
          listData:[],
          search:null,
          sortId: null,
          sortData: [],
          count: 12,
          loading: false
      }
    },
    computed: {
        noMore () {
            return this.count >= 20
        },
        disabled () {
            return this.loading || this.noMore
        }
    },
    methods: {
        load () {
            this.loading = true
            setTimeout(() => {
                this.count += 10
                this.loading = false
            }, 2000)
        },
        async getVideo(){
            let cnt= {
                $like:{
                    name:`%${this.search}%`
                },
                $orderBY: {col:'ids', methods: 'desc'},
                $where:{
                    sortId: this.sortId
                }
            }
            if(!this.search){
                delete cnt.$like
            }
            if(!this.sortId || Number(this.sortId) === 0){
                delete cnt.$where
            }
            this.$api.get('news',cnt,res=>{
                this.listData=res
            })
        }
    },
    mounted() {
        this.getVideo()
    },
    async created() {

    },
    watch: {
        sortId() {
            this.getVideo()
        }
    }
  }
</script>

<style scoped lang="scss">
    .index {
    }
</style>

