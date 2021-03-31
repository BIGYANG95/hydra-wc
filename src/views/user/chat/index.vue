<template>
  <div class="index">
    <el-container style="border: 1px solid #dcdfe6">
      <el-aside style="height: 700px;box-shadow: 1px 1px 1px #dcdfe6">
        <el-row v-for="item in userList" v-if="item && item !== 'null'" :key="item" style="padding: 10px" class="rows" :class="selectUser === item ? 'active' : ''">
          <div @click="selectUser = item">
            <img style="width: 50px;height: 50px;border-radius: 25px"
                 :src="userInfo(item).userImg ? ($nodeUrl+'getImg?imagePath='+userInfo(item).userImg) : require('@/assets/head.jpg')"
                 alt="">
            {{userInfo(item).names}}
          </div>
        </el-row>
      </el-aside>
      <el-main>
        <el-container>
          <el-main style="height: 560px">
            <el-row v-for="item in chatList" :key="ids" :class="item.speakUserId == $userInfo().ids ? 'isMe': 'isThat'">
              <div>
                {{item.text}}
              </div>
            </el-row>
          </el-main>
          <el-footer style="height: 100px">
            <el-input type="textarea" :rows="5" v-model="input"></el-input>
            <el-row>
              <el-button type="success" style="position: absolute;right: 20px; bottom: 20px" @click="addChat(input)">发送</el-button>
            </el-row>
          </el-footer>
        </el-container>
      </el-main>
    </el-container>
  </div>
</template>

<script>
export default {
  name: "index",
  components: {},
  props: [],
  data() {
    return {
      query: {},
      input: null,
      userList: [],
      selectUser: false,
      userDataList: [],
      chatData:[]
    }
  },
  computed: {
    chatList() {
      if(this.selectUser){
        return this.chatData.filter(item=>{
         return  item.speakUserId == this.selectUser  || item.hearUserId == this.selectUser
        })
      }else{
        return []
      }
    }
  },
  created() {
    this.getUser()
  },
  mounted() {
    this.query = this.$route.query

    if(this.query.ids) {
      this.selectUser = this.query.shopId
      this.addChat('我想咨询一下'+this.query.names, ()=>{
        this.getChat()
      })
    }else{
      this.getChat()
    }
  },
  watch: {},
  methods: {
    userInfo(userId){
      return this.userDataList.filter(item=> item.ids === userId)[0] || {}
    },
    addChat(text, call) {
      this.$api.add('chat',{
        ids: Date.now(),
        speakUserId: this.$userInfo().ids,
        hearUserId: this.query.shopId || this.selectUser,
        text
      },()=>{
        call ? call() : this.getChat()
        this.input = null
      })
    },
    getChat() {
      this.$api.get('chat',{
        $where:{
          speakUserId: this.$userInfo().ids + '"' + '  or hearUserId = ' + '"' +this.$userInfo().ids,
        },
        $orderBY:{
          col: 'ids'
        }
      }, res=>{
        let userList = {}
        res.map(item=>{
          if(item.speakUserId === this.$userInfo().ids && item.hearUserId === this.$userInfo().ids){

          }else{
            if(item.speakUserId !== this.$userInfo().ids){
              userList[item.speakUserId] = item.speakUserId
            }else{
              userList[item.hearUserId] = item.hearUserId
            }
          }
        })
        this.userList = Object.keys(userList)
        this.chatData = res
        if(!this.selectUser){
          console.log(userList);
          this.selectUser = this.userList[0]
        }
      })
    },
    getUser() {
      this.$api.get('user',{}, res=>{
        this.userDataList = res
      })
    }
  }
}
</script>

<style scoped lang="scss">
.index {
  .rows:hover, .active {
      background: #eff6fe;
    }
  .isMe, .isThat {

    margin: 10px;
    color: #ffffff;
  }
  .isMe div{
    border-radius: 5px;
    padding: 10px;
    background: #409EFF;
    display: inline-block;
    float: right;
  }
  .isThat div{
    border-radius: 5px;
    padding: 10px;
    background: #969799;
    display: inline-block;
  }
}
</style>