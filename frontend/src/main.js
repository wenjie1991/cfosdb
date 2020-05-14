import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify'
import router from './router/index'

// import ECharts from 'vue-echarts'
// import 'echarts/lib/chart/graph'

// Vue.component('v-chart', ECharts)

Vue.config.productionTip = false

new Vue({
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
