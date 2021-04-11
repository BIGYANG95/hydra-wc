<template>
    <div id="index">
        <el-container>
            <el-header height="80px" >
                <div class="logo-image">
                    <img src="@/assets/title.jpg" width="120px" height="72px">
                </div>
                <div class="title">
                  HYDRA-MARKET
                </div>
                <div class="title-search">
                    <search ></search>
                </div>

                <div class="tab-title">
                    <el-tabs v-model="activeName" @tab-click="handleClickRouter">
                        <el-tab-pane label="首页" name="/home"></el-tab-pane>
                        <el-tab-pane label="商品" name="/goods"></el-tab-pane>
                        <el-tab-pane label="论坛" name="/news"></el-tab-pane>
                        <el-tab-pane label="我的" name="/my"></el-tab-pane>
                    </el-tabs>
                </div>
            </el-header>
            <el-main>
                <rightBox></rightBox>
                <router-view style="min-height: calc(100vh - 272px)"></router-view>
            </el-main>
            <el-footer height="160px">
                <div id="we">
                    <el-row style="border-bottom: 1px solid #606266;padding-bottom: 20px;margin-bottom: 10px">
                        <el-col :span="24">
                            <div  class="footHead">
                                联系方式
                            </div>
                            <div style="margin: 0 auto;width: 458px;height: 20px">
                                <li class="lis">COPYRIGHT: BIGYANG</li>
                                <li class="lis">email: bigyang95@qq.com</li>
                                <li class="lis">地址: 贵州理工学院</li>
                            </div>
                        </el-col>
                    </el-row>

                    <div style="text-align: center">“HYDRA”电商网站</div>
                </div>
            </el-footer>
        </el-container>
    </div>
</template>

<script>
  import rightBox from './rightBox'
  import search from './search'
  export default {
    name: "index",
    components: { search, rightBox },
    data() {
      return {
        activeName:'',
        heights:[800,1600,2400]
      }
    },
    methods: {
      handleClick(){
        this.$routerGo('/home','',call=>{
          let clickDom=this.heights[this.activeName]/46
          setTimeout(()=>{
            let c=0
            let setI= setInterval(()=>{
              c+=clickDom
              document.documentElement.scrollTop =c
            },4)

            setTimeout(()=>{
              window.clearInterval(setI)
            },200)
          },0)
        })
      },
      handleClickRouter(){
        this.$routerGo(this.activeName)
      }
    },
  }
</script>

<style scoped lang='scss'>
#index {
  user-select: none;
  min-width: 900px;
  .el-header{
    .logo-image{
      width: 120px;
      height: 72px;
      float: left;
      margin: 3px 20px 0 0;
      cursor: pointer;
    }
    .title{
      width: 230px;
      height: 80px;
      float: left;
      line-height: 80px;
      font-weight: 600;
      color: #303133;
      font-size: 18px;
      cursor: pointer;
    }
    .title-search{
      float: left;
      margin-top: 20px
    }
    .tab-title{
      height: 54px;
      float: right;
      font-size: 12px;
      margin: 26px 20px 0 0;
    }
  }
  .el-main{
    padding: 0;
  }
  .el-footer{
    padding: 40px 100px;
    background-color: #2a2a2a;
    color:#979797;
    #we{
      margin: 0 auto;
    }
    .footHead{
      text-align: center;
      margin-bottom: 10px;
    }
    .lis{
      line-height: 16px;
      margin-bottom: 4px;
      margin-right: 10px;
      float: left;
      cursor: pointer;
      &:hover{
        color: #ffffff;
      }
    }
  }
}
</style>
