<template>
    <div id="rightBox" v-show="show">
        <el-card>
            <div>

                <el-tooltip class="item" effect="dark" content="回到顶部" placement="left">
                    <el-button  @click="toTop" type="text"  size="mini">
                        <i class="el-icon-caret-top" style="font-size: 3rem"></i>
                    </el-button>

                </el-tooltip>
            </div>

            <div>
                <el-tooltip class="item" effect="dark" content="反馈" placement="left">
                    <el-button @click="$routerGo('/joinWe')"  type="text"  size="mini">
                        <i class="el-icon-edit" style="font-size: 2rem"></i>
                    </el-button>
                </el-tooltip>

            </div>

        </el-card>
    </div>
</template>

<script>
    export default {
        name: "rightBox",
        props: [''],
        data() {
            return {
                scrollTop:0,
                show:false
            }
        },
        methods: {
            toTop(){
                let l = document.documentElement.scrollTop;
                console.log(l);
                let s = l / 600 * 25;  //路程/时间=s *25每隔25ms秒 动的路程
                let st = setInterval(function () {
                    l -= s;
                    if (l <= 0) {
                        l = 0; //当l<=0时，设置l=0
                        clearInterval(st);
                    }
                    document.documentElement.scrollTop = l;
                }, 25)
            },
            handleScroll () {
                if(document.documentElement.scrollTop>300){
                    this.show=true
                }else if(this.$route.fullPath!=='/home'){
                    this.show=true
                }
                else{
                    this.show=false
                }
            }
        },
        mounted() {
            window.addEventListener('scroll', this.handleScroll, true);  // 监听（绑定）滚轮滚动事件
        },
        created() {
        },
        destroyed: function () {
            window.removeEventListener('scroll', this.handleScroll);   //  离开页面清除（移除）滚轮滚动事件
        },
        components: {},
        watch: {},
    }
</script>

<style scoped lang='scss'>
    #rightBox {
        position: fixed;
        right: 40px;
        top:60vh;
        z-index: 1000;
        .el-card__body{
            padding: 5px;
        }
    }
</style>
<style  lang='scss'>
    #rightBox {
        .el-card__body{
            padding: 5px;
        }
        .el-button--text{
            width: 30px;
        }
    }
</style>