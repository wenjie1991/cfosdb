<template>
    <div class="index">
        <v-card class="mx-auto">
            <v-card-title class="display-1 text--primary font-weight-bold">cFos-ANAB</v-card-title>
            <v-divider></v-divider>
            <v-card-text>
                <div class="text--primary pt-3 body-1">
                    c-Fos is one of the most widely studied immediate early genes in the field of neuroscience, which are expressed very soon after different stimuli. By using in situ hybridization and immunostaining technology, the mRNA and protein product of c-Fos can be identified respectively. As the field of brain science has rapidly developed in recent years, scientists desire to understand more functional meaning of neurons, c-Fos still can be the foundation of all functional studies. Currently, there is still not very mature database. Our c-Fos database will provide a good reference for early neuroscience exploration.
                </div>
            </v-card-text>
            <v-card-actions class="flex-row-reverse">
                <v-btn text color="deep-purple accent-4" to="/help">Instruction</v-btn>
                <v-btn text color="deep-purple accent-4" to="/search"><v-icon left>mdi-magnify</v-icon>Search Database</v-btn>
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
        <v-card class="mx-auto mt-12" align="center">
            <v-card-title class="display-0 text--primary">Sharing brain nuclei between behaviors</v-card-title>
            <v-divider></v-divider>
            <v-row no-gutters align="center">
            <v-col class="matrixLegend">Mouse</v-col>
            <v-col cols='12' sm='7'>
                <table id="behavior_matrix" class="matrixStyle">
                    <tbody>
                      <tr v-for="(row, index1) in rows" :key="index1">
                    <!--    <td>{{row.id}}</td> -->
                        <td v-for="(col, index2) in row.value" :key="index2">{{col.value}}</td>
                    <!--    <td>{{row.id}}</td> -->
                      </tr>
                    </tbody>
                </table>
            </v-col>
            <v-col class="matrixLegend">Rat</v-col>
            </v-row>
        </v-card>
        <v-timeline dense class="mt-12">
            <v-timeline-item small color="deep-purple lighten-2">
                <v-card class="elevation-2">
                    <v-card-title class="headline">Data Version 2020.2.2</v-card-title>
                    <v-list-item three-line>
                        <v-list-item-content>
                            <v-list-item-title>398 Nuclei and subnuclei</v-list-item-title>
                            <v-list-item-subtitle>
                                5 Types behaviors ( Pain, Feeding, Fear, Aggression, and Mating )
                            </v-list-item-subtitle>
                            <v-list-item-subtitle>
                                2 Species of animal ( Rat and Mouse )
                            </v-list-item-subtitle>
                        </v-list-item-content>
                    </v-list-item>
                    <v-card-actions class="flex-row-reverse">
                        <v-btn text color="deep-purple accent-4" to="/download">to Download</v-btn>
                    </v-card-actions>
                </v-card>
            </v-timeline-item>
        </v-timeline>
    </div>
</template>

<script>
import behavior_cor_matrix from "@/assets/behavior_correlation_matrix.json"
import colors from 'vuetify/lib/util/colors'


export default {
    name: 'index',
    data() {
        function addTypeMatrix(json) {
            let _json = json
            for (let i = 0; i < _json.length; i++) {
                for (let j = 0; j < _json[i].value.length; j++) {
                    if (j > i) {
                        _json[i].value[j]['isRat'] = true
                    }
                }
            }
            return _json
        }

        return {
            colors: colors,
            rows: addTypeMatrix(behavior_cor_matrix)
        }
    },
}
</script>

<style lang="scss" scoped>
.matrixStyle {
    margin: 50px;
    border-collapse: collapse;
    td {
        padding: 0px;
        height: 100px;
        width: 100px;
        text-align: center;
        border: 1px solid #000;
        font-size: 15px;
    }
}
.matrixLegend {
    font-size: 20px;
    font-weight: bold;
}
</style>
