<template>
    <div id="index">
        <tables :table="table"></tables>
    </div>
</template>

<script>
    import tables from './tables'
    import user from './user'
    import sort from './sort'
    import good from './goods'
    import goodList from './goodList'
    import address from './address'
    import pay from './pay'
    import shopCar from './shopCar'
    import image from './image'
    import joinwe from './joinwe'
    import comment from './comment'
    import news from "@/views/table/news";
    import CommentNew from './commentNew'
    import chat from "@/views/table/chat";
    export default {
        name: "index",
        props: [''],
        data() {
            return {
                //根据格式显示数据库表
                table:[
                    user,sort,goodList,good,address,pay,shopCar,image,joinwe,comment,news, CommentNew, chat
                ]

            }
        },
        methods: {},
        mounted() {
        },
        created() {
        },
        components: {tables},
        watch: {},
    }
</script>

<style scoped lang='scss'>
    #index {

    }
</style>
