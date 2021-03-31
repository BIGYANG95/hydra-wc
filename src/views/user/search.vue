<template>
    <div id="search">
        <el-input  v-model="search" placeholder="请输入内容">
            <el-button slot="append" @click="changeSearch" icon="el-icon-search"></el-button>
        </el-input>
    </div>
</template>

<script>
    export default {
        name: "search",
        props: [''],
        data() {
            return {
                search:''
            }
        },
        methods: {
            changeSearch(){
                let that=this

                //先跳转 等待页面渲染完成时搜索
                this.$routerGo('/goods',{},call=>{
                    setTimeout(()=>{
                        that.$center.$emit('changeName',that.search)
                    },100)
                })
            }
        },
        mounted() {
        },
        created() {
        },
        components: {},
        watch: {
            search(news){

            }
        },
    }
</script>

<style scoped lang='scss'>
    #search {

    }
</style>
