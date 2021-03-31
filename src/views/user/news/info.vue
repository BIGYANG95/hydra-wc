<template>
  <div class="info">
    <el-row style="text-align: center;font-size: 14px;height: 40px;line-height: 40px">
      {{$route.query.name}}
    </el-row>
    <div style="font-size: 20px;color: #333333;font-weight: 600;text-align: center">{{$route.query.title}}</div>

    <div style="float: right;font-size: 12px;position: relative;right: 50px">
      {{$Time($route.query.ids).getTime()}}
    </div>
<!--    <div v-show="isPay" class="pleasePay">-->
<!--      <div style="position: absolute;top: 50%;left: calc( 50% - 72px)">-->
<!--        请先购买视频-->
<!--      </div>-->
<!--    </div>-->
    <dyd-video v-if="$route.query.video" style="width: 70%;padding: 0 15%;margin-bottom: 20px"   :src="$route.query.video"></dyd-video>

    <el-row v-show="isPay" style="width: 70%;margin-left: 15%;height: 60px;line-height: 60px;background-color: #333333">
      <span style="font-size: 20px;color: #ffffff;margin-left: 20px">
        {{$route.query.subtitle}}
      </span>
    </el-row>
    <p style="text-align: center">简介</p>
    <div style="width: 50%;margin-left: 25%;margin-bottom: 100px;max-height: 500px;overflow: auto" v-if="$route.query.content" v-html="$route.query.content">{{ $route.query.content }}</div>
    <p style="text-align: center">评论</p>
    <comment style="width: 70%;padding: 0 15%" :blogId="$route.query.ids"></comment>
  </div>
</template>

<script>
import dydVideo from "@/assets/util/components/dydVideo";
  import Comment from "./comment";
  export default {
    name: "info",
    components: {Comment, dydVideo},
    props: [''],
    data() {
      return {
        showVideo: true,
        status: false,
        pay: true,
        isCollect: false
      }
    },
    provide: {},
    inject: [],
    computed: {
      isPay(){
        return this.$route.query.price && this.pay
      }
    },
    methods: {
      addCollect() {
        let userId = this.$userInfo().ids
        if(userId){
          if(this.isCollect){
            let cnt = {
              userId,
              videoId: this.$route.query.ids,
            }
            this.$api.del('collect',cnt,res=>{
              this.isCollect = false
              this.$message.success('取消收藏')
            })
          }else{
            let cnt = {
              userId,
              videoId: this.$route.query.ids,
              ids:Date.now()
            }
            this.$api.add('collect',cnt,res=>{
              this.isCollect = true
              this.$message.success('收藏成功')
            })
          }
        }else{
          this.$message('请先登录')
        }
      },
      getPay(){
        if(this.$userInfo().ids){
          let cnt ={
            $where:{
              userId:this.$userInfo().ids,
              videoId:this.$route.query.videoId || this.$route.query.ids
            }
          }
          this.$api.get('pay',cnt,res=>{
            if(res.length > 0){
              this.pay = false
            }
          })
        }
      },
      addNum() {
        let cnt =  {
          ids: this.$route.query.ids,
          num: Number(this.$route.query.num) + 1
        }
        this.$api.up('video',cnt,res=>{})
      },
      getCollect() {
        let userId = this.$userInfo().ids
        if(userId){
          let cnt = {
            $where:{
              userId,
              videoId: this.$route.query.ids,
            }
          }
          this.$api.get('collect',cnt,res=>{
            this.isCollect = res.length > 0;
          })
        }
      },
      addHistory(){
        let userId = this.$userInfo().ids
        if(userId){
          let cnt = {
            $where:{
              userId,
              videoId: this.$route.query.ids,
            }

          }
          this.$api.get('history',cnt,res=>{
            if(res.length){
              let c= {
                ids: res[0].ids,
                times: Date.now()
              }
              this.$api.up('history',c,()=>{})
            }else{
              let c= {
                ids: Date.now(),
                times: Date.now(),
                userId,
                videoId:this.$route.query.ids
              }
              this.$api.add('history',c,()=>{})
            }
          })
        }
      }
    },
    mounted() {
      this.getPay()
      this.addNum()
      this.getCollect()
      this.addHistory()
    },
    watch: {
      "$route"(){
        this.showVideo = false
        this.$nextTick(()=>{
          this.showVideo = true
        })
      }
    },
  }
</script>

<style  lang='scss'>
  .info {
    padding: 20px 0;
    .pleasePay  {
      background-color: black;
      position: absolute;
      opacity: 0.5;
      width: 70%;
      left: 15%;
      z-index: 3000;
      height: calc(100vw * (9/16) * 0.7);
      font-size: 24px;
      color: #ffffff;
      text-align: center;
      font-weight: 600;
    }
  }
</style>
