<template>
    <v-timeline>
        <v-timeline-item color="orange lighten-2">
            <template v-slot:opposite>
                <span :class="`headline font-weight-bold
                  orange--text`">2021.7.12</span>
            </template>
            <v-card color="orange lighten-2" dark>
                <v-card-title class="title">cFos-ANAB dataset 20210712</v-card-title>
                <v-card-text class="white text--primary">
                    <p>
                    The dataset includes the relationship between 5 behaviors
                    and 403 nuclei (106 nuclei for mice and 297 nuclei for
                    rats). 
                    </p>
                    <div class="d-flex flex-row-reverse">
                        <a href="/download/m_20210712.json" download><v-btn text
                            color="orange lighten-2" class="mx-0" outlined>Mouse
                            Data<v-icon>mdi-download</v-icon></v-btn></a>
                        <a href="/download/m_20210712.json" download><v-btn text
                            color="orange lighten-2" class="mx-0" outlined>Rat
                            Data<v-icon>mdi-download</v-icon></v-btn></a>
                    </div>
                </v-card-text>
            </v-card>
        </v-timeline-item>
        <v-timeline-item color="primary">
            <template v-slot:opposite>
                <span :class="`headline font-weight-bold primary--text`">2019.2.2</span>
            </template>
            <v-card color="primary" dark>
                <v-card-title class="title">cFos-ANAB dataset (test)</v-card-title>
                <v-card-text class="white text--primary">
                    <p>
                   The dataset loaded in the database is the test dataset.
                   The test dataset includes the relationship between 5
                   behaviors and 151 nuclei (56 nuclei for mice and 95 nuclei
                   for rats).
                    </p>
                    <div class="d-flex flex-row-reverse">
                        <a href="/download/m_20190202.json" download><v-btn text
                            color="orange lighten-2" class="mx-0" outlined>Mouse
                            Data<v-icon>mdi-download</v-icon></v-btn></a>
                        <a href="/download/r_20190202.json" download><v-btn text
                            color="orange lighten-2" class="mx-0" outlined>Rat
                            Data<v-icon>mdi-download</v-icon></v-btn></a>
                    </div>
                </v-card-text>
            </v-card>
        </v-timeline-item>
    </v-timeline>
</template>

<script>
export default {
    name: "download",
    data() {
        return {

        }
    }
};
</script>

<style lang="scss" scoped>

</style>
