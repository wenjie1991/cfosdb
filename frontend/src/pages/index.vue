<template>
    <div class="index">
        <v-card class="mx-auto">
            <v-card-title class="display-1 text--primary font-weight-bold">cFOS Database</v-card-title>
            <v-divider></v-divider>
            <v-card-text>
                <div class="text--primary pt-3 body-1">
                    c-Fos is one of the most widely studied immediate early genes in the field of neuroscience, which are expressed very soon after different stimuli. By using in situ hybridization and immunostaining technology, the mRNA and protein product of c-Fos can be identified respectively. As the field of brain science has rapidly developed in recent years, scientists desire to understand more functional meaning of neurons, c-Fos still can be the foundation of all functional studies. Currently, there is still not very mature database. Our c-Fos database will provide a good reference for early neuroscience exploration.
                </div>
            </v-card-text>
            <v-card-actions>
                <v-btn text color="deep-purple accent-4" to="/help">More</v-btn>
            </v-card-actions>
        </v-card>
        <v-card class="mx-auto mt-12">
            <v-card-title class="display-1 text--primary font-weight-bold">Feature</v-card-title>
            <v-divider></v-divider>
            <v-list-item>
                <v-list-item-icon>
                    <v-icon>mdi-checkbox-marked-circle</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                    <v-list-item-subtitle>c-Fos data are extracted from the figure legend of original findings, namely, the results are supported by original figures, and can be easily traced via publications’ DOI hyperlinks; only c-Fos values increased at significant confidence level are included.</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
            <v-list-item>
                <v-list-item-icon>
                    <v-icon>mdi-checkbox-marked-circle</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                    <v-list-item-subtitle>An unified term of brain region is employed, the detailed relationships among behavior, brain nuclei, specific active conditions, and their network mappings, can be shown and downloaded.</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
        </v-card>
    </div>
</template>

<script>
export default {
    name: 'index',
    data() {
        return {
            features: [{
                
            }]
        }
    }
}
</script>

<style lang="scss" scoped>
</style>
