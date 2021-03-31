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
                        <up-img :ref="'upImg'+scope.$index" :auto-upload="false" @change="changeImg" @success="successImg" :index="scope.$index"></up-img>
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
                <el-button type="primary" @click="submitForm('ruleForm')" >立即创建</el-button>
                <el-button @click="$emit('closeDia','')">取消</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
    import upSpe from './upImg'
    export default {
        name: "createGoods",
        props: [],
        data() {
            return {
                ruleForm:{
                    names:'',
                    sortId:'',
                    price:'',
                },
                rules: {
                    names: [{ required: true, message: '请输入分类名称', trigger: 'blur' }],
                },
                list:{
                    listName:'',
                    num:1,
                    price:1
                },
                goodList:[{
                    listName:'',
                    num:1,
                    price:1
                }],
                imageList:[],
                file:[],
                tableSort:[]
            }
        },
        methods: {
            adds(index){
                //添加商品
                this.goodList.splice(index,0,this.$JSP(this.list))
                this.file.splice(index,0,'')
            },
            deletes(index){
                //删除tableData里的商品
                this.goodList.splice(index,1)
                this.file.splice(index,1)
            },
            changeImg(file,index){
                //改变图片
                this.file[index]=file
            },
            successImg(path,index){
                //图片上传成功
                let that=this
                this.imageList[index]=path
                    if(index<this.goodList.length-1){
                        //直到上传完所有图片
                        this.$refs['upImg'+parseInt(index+1)].submit()
                    }else{
                        //添加商品
                        let form=JSON.parse(JSON.stringify(this.ruleForm))
                        delete form.sales
                        form.price=this.goodList[0].price
                        form.ids=Date.now()
                        form.hot='不显示'
                        form.shopId=this.$userInfo().ids
                        this.$api.addGoods(form,res=>{
                            if(res) {
                                let p=new Promise((rs,rj)=>{
                                    //判断是否上传成功
                                    this.goodList.forEach((val,index)=>{
                                        val.image=that.imageList[index]
                                        val.ids=Date.now()+''+index
                                        val.goodId=form.ids

                                        that.$api.addList(val,r=>{
                                            if(!r){
                                                rj(false)
                                            }
                                        })
                                        rs(true)
                                    })
                                })
                                p.then(tr=>{
                                    this.$emit('closeDia',form);
                                })
                            }
                        })
                    }
            },
            submitForm(){
                //提交表单
                let that=this
                let p= function(){
                    let form=that.ruleForm
                    let c=true
                    //验证字段是否填写
                    if(!form.names||!form.sortId){
                        console.log('!form.listName||!form.sortId')
                        c=false
                    }
                    for(let i=0;i<that.goodList.length;i++){
                        //验证规格是否填写完整
                        for(let x in that.goodList[i]){
                            if(!that.goodList[i][x]){
                                console.log(x)
                                c=false
                            }
                        }
                    }

                    that.file.forEach(val=>{
                        if(val===''){
                            console.log(val)
                            that.$message.error('请选择完整')
                        }
                    })
                    return c
                }

                if(p()){
                    this.$refs['upImg0'].submit()
                }else{
                    that.$message.error('请填写完整')
                }
            },
        },
        mounted() {
        },
        created() {
            this.$api.getSort({},res=>{
                if(res) this.tableSort=res

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
