<template>
    <v-app>
        <v-app-bar app fixed color="primary" dark hide-on-scroll>
            <v-toolbar-title class="text-uppercase font-weight-black display-1">cFos-ANAB</v-toolbar-title>
            <p style="margin-bottom:-7px; margin-left: 1em; font-size: 1.2em;">A c-Fos based web tool for exploring activated neurons and associated behaviors</p>
            <template v-slot:extension>
                <v-tabs centered class="secondary" optional>
                  <v-tab to="/">index</v-tab>
                  <v-tab to="/search">search</v-tab>
                  <v-tab to="/download">download</v-tab>
                  <v-tab to="/help">help</v-tab>
                </v-tabs>
            </template>
        </v-app-bar>

        <v-content class="content">
            <router-view></router-view>
        </v-content>

        <v-footer absolute padless dark>
            <v-card
                flat
                tile
                class="indigo lighten-1 white--text text-center"
            >
            <v-card-text>
                <v-btn
                v-for="icon in []"
                :key="icon"
                class="mx-4 white--text"
                icon
                >
                <v-icon size="24px">{{ icon }}</v-icon>
                </v-btn>
            </v-card-text>
            <v-card-text>
            The web is under development
            </v-card-text>
            <v-bnt
              text
              class="white--text"
              href="http://www.zju.edu.cn/english"
              link="true"
            >
            Zhejiang University
            </v-bnt>

            <v-divider></v-divider>

            <v-card-text class="white--text">
                {{ new Date().getFullYear() }} — <strong>cFos-ANAB</strong>
            </v-card-text>
            </v-card>
        </v-footer>
        <documentation-fab/>
    </v-app>
</template>

<script>
export default {
    name: 'App',
    components: {
        DocumentationFab: () => import('./components/Fab')
    },
    watch: {
        '$route.path' () {
            typeof window !== 'undefined' && window.scrollTo(0, 0)
        }
    }
}
</script>

<style lang="scss" scoped>
.content {
    margin: 50px 50px 250px;
}
</style>
