<template>
    <div id="tables">
        <el-table :data="table">
            <el-table-column type="expand">
                <template slot-scope="scope">
                    <el-form label-position="left"  class="demo-table-expand">
                        <el-form-item v-for="(item,id) in scope.row.table" :key="id" :label="id+':'">
                            <span>{{ item }}</span>
                        </el-form-item>
                    </el-form>
                </template>
            </el-table-column>
            <el-table-column label="id" type="index" width="50"></el-table-column>

            <el-table-column prop="name" label="表名"></el-table-column>

            <el-table-column prop="num" label="行数"></el-table-column>

            <el-table-column prop="name" label="操作">
                <template slot-scope="scope">
                    <el-button type="primary" @click="add(scope.row)">新建</el-button>
                    <el-button type="danger" @click="del(scope.row)">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
    export default {
        name: "tables",
        props: ['table'],
        data() {
            return {}
        },
        methods: {
            //创建表
            add(row){
                let cnt={
                    $method:'create',
                    $table:'tbl_'+row.name,
                    $col:row.table
                }
                this.$api.mysqlTable(cnt,res=>{
                    if(res){
                        this.$notify({message: '创建成功',type: 'success'});

                    }else{
                        this.$notify.error({message: '创建失败'});

                    }
                })
            },
            del(row){
                let cnt={
                    $method:'deleteTable',
                    $table:'tbl_'+row.name,
                }
                this.$api.mysqlTable(cnt,res=>{
                    if(res){
                        this.$notify({message: '删除成功',type: 'success'});
                    }else{
                        this.$notify.error({message: '删除失败'});

                    }
                })
            }
        },
        mounted() {
            //获取已经创建的所有表
            this.table.forEach((val,index)=>{
                let cnt={
                    $method:'get',
                    $table:val.name,
                }
                this.$api.mysqlTable(cnt,res=>{
                    if(res){
                        val.num=res.length
                    }
                })
            })
        },
        created() {
        },
        components: {},
        watch: {},
    }
</script>

<style scoped lang='scss'>
    #tables {

    }
</style>