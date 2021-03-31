import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)
function json(data){
    return JSON.parse(data)
}

let store= new Vuex.Store({
    state: {
        user:json(sessionStorage.getItem('userInfo'))||json(localStorage.getItem('userInfo'))||{
            username:'',
            password:'',
            names:'',
            userImg:'',
            ids:'',
        }
    },
    getters: {
        user(state){
            return state.user
        },
    },
    mutations: {
        setUser (state, options) {
            if(options==='clear'){
                for(let i in  state.user){
                    Vue.set(state.user,`${i}`, '')
                }
            }
            else{
                for(let c in  options){
                    //Vue.set(state.user,`${c}`, options[c]);
                    state.user[c]=options[c]
                }
            }
            sessionStorage.setItem('userInfo', JSON.stringify(state.user))
        }
    }
})

//获取用户信息
function userInfo(options=null){
    if(!options) return store.state.user
    else {
        //修改用户信息并保存
        store.commit('setUser',options)
    }
}
export default userInfo