import '@mdi/font/css/materialdesignicons.css';
import Vue from 'vue';
import Vuetify from 'vuetify/lib';

Vue.use(Vuetify);

export default new Vuetify({
    theme: {
      themes: {
        light: {
          primary: "#2196F3",
          secondary: "#1E88E5"
        }
      }
    },
    icons: {
      iconfont: 'mdi',
    }
});
