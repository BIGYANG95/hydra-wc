<template>
    <div id="box">
        <el-card>
            <div slot="header" class="clearfix">
                <span>评论</span>
            </div>
            <div v-show="!tableData.length">暂无评论</div>
            <el-row v-for="(item,index) in tableData" :key="index"
                    style="border-bottom:1px solid #c0c4cc;margin-bottom: 10px "
            >
                <el-row style="line-height: 30px;margin-top: 5px">
                    <el-avatar :size="30" @error="true" style="float: left">
                        <img src="@/assets/logo.png"/>
                    </el-avatar>
                    <div style="font-size: 16px;float: left">
                        {{item.userNames}}
                    </div>
                    <div style="font-size: 12px;float: right">
                        {{$Time(item.ids).getTime()}}
                    </div>
                </el-row>
                <el-row style="margin-top: 10px">
                    <el-col :span="18">
                        <span v-show="item.reply">
                            @{{item.reply}}:
                        </span>
                        {{item.text}}
                    </el-col>
<!--                    <el-col :span="6">-->
<!--                        <el-button type="text" style="float: right" @click="form.reply=item.username">-->
<!--                            回复-->
<!--                        </el-button>-->
<!--                    </el-col>-->
                </el-row>
            </el-row>
            <div>
                <el-input v-model="form.reply" v-show="form.reply">
                    <template slot="prepend">@</template>
                </el-input>
            </div>
            <el-input
                    v-model="form.text"
                    maxlength="200"
                    show-word-limit
                    type="textarea"
                    :rows="10">
                <template>Http://</template>
            </el-input>
            <el-button
                    @click="submit"
                    type="primary"
                    style="float: right;width: 100px;margin-top: 10px">
                发表
            </el-button>
        </el-card>

    </div>
</template>

<script>
    export default {
        name: "comment",
        props: ['blogId'],
        data() {
            return {
                tableData:[],
                form:{
                    userId:this.$userInfo().ids,
                    reply:'',
                    text:'',
                    blogId:'',
                    ids:''
                }

            }
        },
        methods: {
            submit(){
                if(!this.$userInfo().ids){
                    this.$message.info('请登陆')
                }
                else if(!this.form.text){
                    this.$message.info('请输入完整')
                }else{
                    this.form.blogId=this.blogId
                    this.form.ids=Date.now()
                    this.$api.add('CommentNew',this.form,res=>{
                        if(res){
                            this.$message.success('发表成功')
                            this.getData()
                        }
                    })
                }
            },
            getData() {
                let cnt = {
                    $where:{blogId:this.blogId},
                    $link:{
                        table:'user',
                        left:'userId',
                        right:'userId',
                        where:'ids as userId, names as userNames',
                    }
                }
                this.$api.get('CommentNew',cnt,res=>{
                    if(res) this.tableData=res
                })
            }
        },
        mounted() {
            this.getData()
        },
        created() {

        },
    }
</script>

<style scoped lang='scss'>
    #box {
        width: 100%;
        margin: 20px auto;
    }
</style>
