<template>
    <div id="box">
        <van-address-edit
                :area-list="areaList"
                show-search-result
                :address-info="addressInfo	"
                :search-result="searchResult"
                :area-columns-placeholder="['请选择', '请选择', '请选择']"
                show-delete
                @delete="onDelete"
                @save="onSave">
        </van-address-edit>
    </div>
</template>

<script>
    import area from './area'
    export default {
        name: "update",
        props: ['addressInfo'],
        data() {
            return {
                areaList:area,
                searchResult: [],
                item:null
            }
        },
        methods: {
            onSave(cnt) {
                //添加地址 或 修改地址
                let val=JSON.parse(JSON.stringify(cnt))
                this.$toast('save');
                console.log(val)
                if(!val.ids){
                    val.ids=Date.now()
                    val.userId=this.$userInfo().ids
                    this.$api.addAddress(val,res=>{
                        if(res){
                            this.$toast('添加成功')
                            this.$emit('closeDia')
                        }
                    })
                }else{
                    delete val.address;

                    this.$api.upAddress(val,res=>{
                        if(res){
                            this.$toast('修改成功')
                            this.$emit('closeDia')
                        }
                    })
                }
            },
            onDelete(val){
                console.log(val)
                this.$api.delAddress({ids:val.ids},res=>{
                    if(res){
                        this.$toast('删除成功')
                        this.$emit('closeDia')
                    }
                })
            }
        },
        mounted() {
            this.item=this.$JSP(this.addressInfo)
        },
        created() {
        },
    }
</script>

<style scoped lang='scss'>
    #box {

    }
</style>