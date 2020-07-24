import '@mdi/font/css/materialdesignicons.css';
import Vue from 'vue';
import Vuetify from 'vuetify/lib';

Vue.use(Vuetify);

export default new Vuetify({
    theme: {
      themes: {
        light: {
          // primary: "#5CB8E5",
          primary: "#0099CB",
          secondary: "#1F77B4",
          // secondary: "#0099CB",
          tertiary: "#4C3366",
          accent: "#FFC61A"
        }
      }
    },
    icons: {
      iconfont: 'mdi',
    }
});
