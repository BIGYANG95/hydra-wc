<template>
  <div id="index">
    <dyd-dialog width="700px" ref="dialog" :title="(updates?'修改':'新增')+'发布'">
      <dyd-form ref="dydForm" label-width="70px" :ruleForm="ruleForm" :rules="rules" @submit="submit">
        <el-form-item label="标题" prop="title">
          <el-input maxlength="20" show-word-limit v-model="ruleForm.title"></el-input>
        </el-form-item>
        <el-form-item label="副标题" prop="subtitle">
          <el-input  :autosize="{ minRows: 3, maxRows: 4}" type="textarea" maxlength="50" show-word-limit v-model="ruleForm.subtitle"></el-input>
        </el-form-item>
        <el-form-item label="文章内容">
          <quill-editor
            style="height: 300px;display: inline-block"
            v-model="ruleForm.content"
            ref="myQuillEditor"
            :options="editorOption">
          </quill-editor>
        </el-form-item>
        <el-form-item label="上传视频">
          <up-video :src="ruleForm.video" :auto-upload="true" @success="(src) => ruleForm.video = src"></up-video>
        </el-form-item>
      </dyd-form>
      <div style="float: right;display: block" >
        <el-button plain type="info" plain @click="$refs.dydForm.resetForm();">清除</el-button>
        <el-button  type="primary" @click="$refs.dydForm.submitForm();">提交</el-button>
      </div>
      <div style="width: 100%;height: 40px"></div>
    </dyd-dialog>
    <div style="margin-bottom: 20px">
      <el-button  type="primary" round plain @click="updates=false;ruleForm=$JSP(form);$refs.dialog.openDia();">发布</el-button>
    </div>

    <dyd-table :data="tableData">
      <el-table-column type="expand" label="内容" width="50">
        <template slot-scope="scope">
          <div v-if="scope.row.content" v-html="scope.row.content">{{ scope.row.content }}</div>
          <div style="text-align: center" v-else> 暂无内容 </div>
        </template>
      </el-table-column>
      <el-table-column
        prop="title"
        label="标题 ">
      </el-table-column>
      <el-table-column
        prop="subtitle"
        label="副标题 ">
      </el-table-column>
      <el-table-column
        align="center"
        width="320"
        label="视频 ">
        <template slot-scope="scope">
          <dyd-video v-if="scope.row.video" :src="scope.row.video"></dyd-video>
          <span v-else> --- </span>
        </template>
      </el-table-column>
      <el-table-column
        width="180"
        label="操作">
        <template slot-scope="scope">
          <el-button  type="text" @click.native="updates=true;ruleForm=$JSP(scope.row);$refs.dialog.openDia();index=scope.$index">修改</el-button>
          <el-button  type="text" @click.native="deleteNews(scope.row,scope.$index)">删除</el-button>
        </template>
      </el-table-column>
    </dyd-table>
  </div>
</template>
<script>
  import Vue from 'vue'
  import VueQuillEditor from 'vue-quill-editor'
  import 'quill/dist/quill.core.css'
  import 'quill/dist/quill.snow.css'
  import 'quill/dist/quill.bubble.css'
  Vue.use(VueQuillEditor)
  import dydDialog from "@/views/user/my/news/dydDialog";
  import dydForm from "@/views/user/my/news/dydForm";
  import dydTable from "@/views/user/my/news/dydTable";
  import dydVideo from "@/assets/util/components/dydVideo";
  export default {
    name: "index",
    props: [''],

    data() {
      return {
        editorOption:{},
        tableData:[],
        ruleForm:{},
        updates:false,
        form:{
          title: '',
          subtitle: '',
          content: null,
          video: null,
          pdf: null,
          views:0,
          userId: this.$userInfo().ids
        },
        rules:{
          title: [
            { required: true, message: '请输入标题', trigger: 'blur' },
          ],
          subtitle: [
            { required: true, message: '请输入副标题', trigger: 'blur' },
          ],
        }
      }
    },
    methods: {
      submit(){
        let cnt=this.$JSP(this.ruleForm)
        if(!this.updates){
          if(cnt.content) {
            cnt.content =  cnt.content.replace(/\"/g,"'")
          }
          cnt.ids = Date.now()
          this.$api.add( 'news', cnt, ()=>{
            this.getNews()
          })
        }else{
          this.$api.up('news', cnt , ()=>{
            this.getNews()
          })
        }
        this.$refs.dialog.closeDia()

      },
      deleteNews(row,index){
        this.$api.del('news',{ids:row.ids},res=>{
          this.tableData.splice(index,1)
        })
      },
      getNews() {
        this.$api.get('news',{$orderBY: {col:'ids', methods: 'desc'}, $where:{
            userId: this.$userInfo().ids
          }},res=>{
          this.tableData=res
        })
      }
    },
    mounted() {
    },
    created() {
      this.getNews()

    },
    components: { dydDialog,dydForm,dydTable, dydVideo },
    watch: {},
  }
</script>

<style scoped lang='scss'>
  #index {
  }
</style>
