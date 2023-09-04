<template>
    <v-app>
        <v-app-bar app fixed color="primary" dark hide-on-scroll>
            <v-toolbar-title class="font-weight-black display-1 effect01">cFos-ANAB</v-toolbar-title>
            <p class="mb-n2 ml-4" style="font-size: 1.2em;">A c-Fos based web tool for exploring activated neurons and associated behaviors</p>
            <template v-slot:extension>
                <v-tabs centered class="secondary" optional active-class="accent--text">
                  <v-tabs-slider color="accent"></v-tabs-slider>
                  <v-tab to="/"><v-icon left>mdi-home</v-icon>index</v-tab>
                  <v-tab to="/search"><v-icon left>mdi-search-web</v-icon>search</v-tab>
                  <!-- <v-tab to="/download"><v-icon left>mdi-download</v-icon>download</v-tab> -->
                  <v-tab to="/help"><v-icon left>mdi-help-circle</v-icon>help</v-tab>
                </v-tabs>
            </template>
        </v-app-bar>

        <v-content class="content">
            <router-view></router-view>
        </v-content>

        <v-footer absolute padless dark>
            <v-col
                flat
                tile
                class="indigo tertiary white--text text-center"
            >
                
                <v-btn
                text
                class="white--text"
                href="http://www.zju.edu.cn/english"
                target="_blank"
                >
                Zhejiang University
                </v-btn>

                <v-btn
                text
                class="white--text"
                href="https://github.com/wenjie1991/cfosdb"
                target="_blank"
                >
                Source code
                </v-btn>

                <v-btn
                text
                class="white--text"
                href="https://doi.org/10.1007/s12264-021-00744-2"
                target="_blank"
                >
                Citation
                </v-btn>

                <v-divider class="my-2"></v-divider>

                <v-card-text class="white--text">
                    2021 — <strong>cFos-ANAB</strong>  
                </v-card-text>
            </v-col>
        </v-footer>
        <!-- <documentation-fab/> -->
    </v-app>
</template>

<script>
export default {
    name: 'App',
    components: {
        // DocumentationFab: () => import('./components/Fab')
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
    margin: 50px auto 350px;
    width: 1440px;
}
.effect01{
    color:#fefefe;
    text-shadow:
    0px 1px 0px #c0c0c0,
    0px 2px 0px #b0b0b0,
    0px 3px 0px #a0a0a0,
    0px 4px 0px #909090,
    0px 5px 10px rgba(0, 0, 0, 0.3);
}
</style>
