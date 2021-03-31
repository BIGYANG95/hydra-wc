<template>
    <div id="box">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
            <el-form-item label="商品名称" prop="names">
                <el-input v-model="ruleForm.names"></el-input>
            </el-form-item>
            <el-form-item label="商品分类" prop="sort">
                <el-select v-model="ruleForm.sortId" placeholder="请选择">
                    <el-option
                            v-for="item in tableSort"
                            :key="item.ids"
                            :label="item.names"
                            :value="item.ids">
                    </el-option>
                </el-select>
            </el-form-item>
            <el-table :data="goodList">
                <el-table-column type="index" width="50"></el-table-column>
                <el-table-column label="规格名称">
                    <template slot-scope="scope">
                        <el-input v-model="scope.row.listName" placeholder="请输入名称"></el-input>
                    </template>
                </el-table-column>
                <el-table-column label="库存数量">
                    <template slot-scope="scope">
                        <el-input v-model="scope.row.num" placeholder="请输入库存"></el-input>
                    </template>
                </el-table-column>
                <el-table-column label="规格价格">
                    <template slot-scope="scope">
                        <el-input-number :precision="2" :step="0.01" :max="10000" v-model="scope.row.price" placeholder="请输入价格"></el-input-number>
                    </template>
                </el-table-column>
                <el-table-column label="规格图片">
                    <template slot-scope="scope">
                        <up-img :src="scope.row.image" :ref="'upImg'+scope.$index" :auto-upload="true"  @success="successImg" :index="scope.$index"></up-img>
                    </template>
                </el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button type="primary" size="small" @click="adds(scope.$index+1)" round plain class="el-icon-plus"></el-button>
                        <el-button type="danger" size="small" v-if="goodList.length>1" @click="deletes(scope.$index)" round plain class="el-icon-minus"></el-button>
                    </template>
                </el-table-column>
            </el-table>
            <el-form-item>
                <el-button type="primary" @click="submitForm('ruleForm')" >立即修改</el-button>
                <el-button @click="$emit('closeDia','')">取消</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
    import upSpe from './upImg'
    export default {
        name: "createGoods",
        props: ['ruleForm'],
        data() {
            return {
                rules: {
                    names: [{ required: true, message: '请输入分类名称', trigger: 'blur' }],
                },
                list:{
                    listName:'',
                    num:1,
                    price:1
                },
                goodList:[],
                imageList:[],
                file:[],
                tableSort:[]
            }
        },
        methods: {//添加
            adds(index){
                this.goodList.splice(index,0,this.$JSP(this.list))
                this.file.splice(index,0,'')
                this.goodList[index+1].ids=Date.now()
                this.goodList[index+1].goodId=this.ruleForm.ids
                console.log(this.goodList)
            },
            deletes(index){//删除
                this.goodList.splice(index,1)
                this.file.splice(index,1)
            },

            successImg(path,index) {
                let that = this
                this.goodList[index].image = path
            },
            submitForm(){//验证表单 上传商品
                let that=this
                console.log(that.goodList)
                let p =new Promise((rs,rj)=>{
                    delete this.ruleForm.num
                    for(let i in this.ruleForm){
                        if(!this.ruleForm[i]){
                            console.log(false)
                            rj(false)
                        }
                    }
                    this.goodList.forEach(val=>{
                        for(let x in val){
                            if(!val[x]){
                                console.log(false)
                                rj(false)
                            }
                        }
                    })
                    rs(true)
                })
                p.then( tr=>{
                    let pr= new Promise((rs,rj)=>{
                        let c=that.$JSP(that.ruleForm)
                        delete c.num
                        that.$api.upGoods(c,res=>{
                            if(!res){
                                console.log(false)
                                rj(false)
                            }
                        })

                        that.$api.delList({goodId:this.ruleForm.ids},  res => {
                            if(res){
                                that.goodList.forEach( (val, index) => {
                                    if(!val.ids) val.ids=Date.now();
                                    if(!val.goodId) val.goodId=that.ruleForm.ids;
                                    that.$api.addList(val, r => {
                                        console.log(val)
                                        if (!r) {
                                            console.log(false)
                                            rj(false)
                                        }
                                    })
                                })
                                rs(true)
                            }
                        })

                    })
                    pr.then(r=>{
                        that.$emit('closeDia',that.ruleForm);
                    })
                }).catch(fa=>{
                    this.$message.error("请输入完整")
                })
            },
        },
        mounted() {

        },
        created() {
            this.$api.getSort({},res=>{
                if(res) this.tableSort=res

            })
            this.$api.getList({$where:{goodId:this.ruleForm.ids}},res=>{
                if(res){
                    this.goodList.unshift(...res)
                }
            })

        },
        components:{
            upSpe
        }
    }
</script>

<style scoped lang='scss'>
    #box {

    }
</style>
