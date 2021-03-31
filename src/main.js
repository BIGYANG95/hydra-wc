import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

Vue.config.productionTip = false

//自己封装的方法 组件 接口清单
import fun from '@/assets/util/fun/index'
Vue.use(fun)
import Vant from 'vant';

import 'vant/lib/index.css';
Vue.use(Vant);
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI);
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
