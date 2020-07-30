import Vue from 'vue'
import Router from 'vue-router'
import index from '@/pages/index'
import search from '@/pages/search'
import download from '@/pages/download'
import help from '@/pages/help'
 
Vue.use(Router)
 
export default new Router({
    mode: 'history',
    routes: [
        {
            path: '/',
            name: 'index',
            component: index
        }, {
            path: '/search',
            name: 'search',
            component: search
        }, {
            path: '/download',
            name: 'download',
            component: download
        }, {
            path: '/help',
            name: 'help',
            component: help
        }
    ]
})
