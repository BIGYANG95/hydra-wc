<template>
    <div id="box">
        <van-address-list
                v-if="!update"
                v-model="chosenAddressId"
                :list="list"
                @add="onAdd"
                @edit="onEdit">
        </van-address-list>
        <updates :addressInfo="addressInfo" v-else @closeDia="closeDia"></updates>
    </div>
</template>

<script>
    import updates from './update'
    export default {
        name: "index",
        props: [''],
        data() {
            return {
                update:false,
                chosenAddressId: '1',
                list: [],
                addressInfo:{}
            }
        },
        methods: {
            //关闭弹框
            closeDia(){
                this.update=false
                this.getAddress()
            },
            onAdd() {
                //点击添加地址
                this.$toast('新增地址');
                this.addressInfo={}
                this.update=true
            },
            onEdit(item, index) {
                //修改地址
                this.addressInfo=this.list[index]
                this.update=true
            },
            getAddress(){
                //获取用户地址
                this.$api.getAddress({$where:{userId:this.$userInfo().ids}},res=>{
                    if(res){
                        res.forEach((val,index)=>{
                            val.address=val.province+val.city+val.county+val.addressDetail
                        })
                        this.list=res
                    }
                })
            }
        },
        mounted() {
        },
        created() {
            this.getAddress()
        },
        components:{
            updates
        }
    }
</script>

<style scoped lang='scss'>
    #box {
        .van-address-list__bottom{
            position: static;
        }
    }
</style>