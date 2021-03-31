<template>
    <div id="box">
        <el-dialog
                :visible.sync="dialogVisible"
                width="70%">
            <createGoods  @closeDia="closeDia" :ruleForm="ruleForm"></createGoods>
        </el-dialog>
        <el-dialog
                :visible.sync="update"
                width="70%">
            <update-goods v-if="update"  @closeDia="closeDia" :ruleForm="ruleForm"></update-goods>
        </el-dialog>
        <el-button plain round type="primary" @click="addGoods">  + 添加商品</el-button>
        <el-table :data="tableData">
            <el-table-column type="index" width="50"></el-table-column>
            <el-table-column prop="names" label="名称"></el-table-column>
            <el-table-column prop="sortId" label="分类">
                <template slot-scope="scope">
                    {{getSort(scope.row.sortId)}}
                </template>
            </el-table-column>
            <el-table-column prop="price" label="价格"></el-table-column>
            <el-table-column prop="num" label="库存"></el-table-column>
          <el-table-column prop="sales" label="销量"></el-table-column>
            <el-table-column prop="password" label="新增时间">
                <template slot-scope="scope">
                    {{$Time(scope.row.ids).getTime()}}
                </template>
            </el-table-column>
            <el-table-column prop="password" label="操作" width="350">
                <template slot-scope="scope">
                    <el-button type="primary" plain round @click="upSort(scope.$index,scope.row)">修改</el-button>
                    <el-button type="warning" plain round @click="delSort(scope.$index,scope.row)">删除</el-button>
                    <!--<el-button type="warning" plain round @click="upGood(scope.$index,scope.row,'显示')" v-if="scope.row.hot==='不显示'">显示热门</el-button>-->
                    <!--<el-button type="warning" plain round @click="upGood(scope.$index,scope.row,'不显示')" v-else>不显示热门</el-button>-->
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
    import createGoods from './createGoods'
    import updateGoods from './update'
    export default {
        name: "index",
        props: [''],
        data() {
            return {
                dialogVisible:false,
                tableSort:[],
                tableData:[],
                ruleForm:{
                    names:'',
                    sorts:'',
                    prices:[0.00],
                    nums:[0],
                    images:[''],
                    specs:[''],
                    describe:'',
                    shopId:this.$userInfo().ids
                },
                update:false,
                index:0,
                names:'',
                sortList:[]
            }
        },
        methods: {
            //获取分类情况
            getSort(sortId){
                for(let i=0;i<this.sortList.length;i++){
                    if(sortId===this.sortList[i].ids){
                        return this.sortList[i].names
                    }
                }

            },
            //修改商品信息
            upGood(index,row,hot){
                this.$api.upGoods({ids:row.ids,hot:hot},res=>{
                    if(res){
                        row.hot=hot
                    }
                })
            },
            //关闭弹窗
            closeDia(row){
                console.log('row')
                if(row){
                    if(this.update){
                        this.update=false
                        this.tableData.splice(this.index,1,row)
                    }else{
                        this.tableData.splice(this.index,0,row)
                    }
                }
                this.dialogVisible=false
            },
            addGoods(){//打开弹窗添加商品
                this.dialogVisible=true
                this.update=false
            },
            sums(arr){
                var s = 0;
                for (var i=arr.length-1; i>=0; i--) {
                    s += parseInt(arr[i]);
                }
                return s;
            },
            //修改分类情况
            upSort(index,row){
                this.update=true
                this.ruleForm=row
                this.index=index

            },
            delSort(index,row){
                this.$api.delGoods({ids:row.ids},res=>{
                    if(res){
                        this.tableData.splice(index,1)
                    }

                })
            }

        },
        mounted() {
        },
        created() {
            let that=this

            this.$api.getGoods({
                $where:{
                    shopId:this.$userInfo().ids
                }

            },res=>{
                //获取商品列表
                if(res) {
                    this.tableData=res
                    res.forEach((val,index)=>{
                        //获取商品下的规格表
                        let cnt={
                            $where:{
                                goodId:val.ids
                            }
                        }
                        this.$api.getList(cnt,r=>{
                            //把价格变为需要的格式
                            if(r){
                                let num=0
                                r.forEach((v,i)=>{
                                    num+=parseInt(v.num)
                                })
                                res[index].num=num
                                that.tableData.splice(index,1,res[index])
                            }
                        })
                    })
                }

            })
            this.$api.getSort({},res=>{
                if(res) {
                    this.sortList=res

                }

            })
        },
        components:{
            createGoods,
            updateGoods
        },
        watch:{
            names(news){
                //模糊搜索商品
                let cnt
                if(news){cnt={"names":{"$regex":news}}}
                else{cnt={}}
                this.$api.getGoods(cnt,res=>{
                    if(res){
                        this.tableData=res
                    }
                })
            }
        }
    }
</script>

<style scoped lang='scss'>
    #box {

    }
</style>
