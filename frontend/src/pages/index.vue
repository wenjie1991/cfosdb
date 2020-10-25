<template>
    <div class="index">
        <v-card class="mx-auto">
            <v-card-title class="display-1 tertiary--text font-weight-bold ">cFos-ANAB</v-card-title>
            <v-divider :light="true"></v-divider>
            <v-card-text>
                <div class="pt-3 body-1">
                    cFos is one of the most widely studied immediate early genes in the field of neuroscience, which are expressed very soon after different stimuli. By using in situ hybridization and immunostaining technology, the mRNA and protein product of cFos can be identified respectively. In the fast-developing field of brain science, scientists desire to better understand functional meanings of neurons, cFos mapping has become an important approach to assess neuronal activation and determine neuronal circuits underlying stimuli-elicited behaviors. Currently, there does not exist a systematic database focusing on cFos in neuroscience. Our database cFos-ANAB can serve as a helpful tool and good reference for early neuroscience exploration. 
                </div>
                <div class="pt-3 body-1">
                    More detailed, see Wang, et al.(2020). cFos-ANAB: a cFos based web tool for exploring activated neurons and associated behaviors. Preprint.
                </div>
            </v-card-text>
            <v-card-actions class="flex-row-reverse">
                <v-btn text color="accent lighten-0" to="/help">Instruction</v-btn>
                <v-btn text color="accent lighten-0" to="/search"><v-icon left>mdi-magnify</v-icon>Search Database</v-btn>
            </v-card-actions>
        </v-card>
        <v-card class="mx-auto mt-12">
            <v-card-title class="display-1 tertiary--text font-weight-bold">Feature</v-card-title>
            <v-divider></v-divider>
            <v-list-item>
                <v-list-item-icon>
                    <v-icon>mdi-checkbox-marked-circle</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                    <p class="pStyle">
                        cFos-ANAB (1.0) is a user-friendly interface tool for exploring activated CNS neurons and associated behaviors based on cFos expression. 398 nuclei and subnuclei in total associated to 5 behaviors ( pain, feeding, fear, aggression, and sexual behavior ) of rats and mice are provided for quick analyses before experimental designs, more than 1900 records in total are available online.
                    </p>
                </v-list-item-content>
            </v-list-item>
            <v-list-item>
                <v-list-item-icon>
                    <v-icon>mdi-checkbox-marked-circle</v-icon>
                </v-list-item-icon>
                <v-list-item-content>
                    <p class="pStyle">
                        All data used in the cFos-ANAB (1.0) are manually extracted from publications of original experiments.  In order to ensure the high quality of data provided by cFos-ANAB, we employ a distinct criterion for data being included in the project, that is, only the results supported by figure legends are focused, of which cFos positive expression with significant statistics are required.  Moreover, data in each record is linked to the DOI of original publication.
                    </p>
                </v-list-item-content>
            </v-list-item>
        </v-card>
        <v-card class="mx-auto mt-12" align="center">
            <v-card-title class="display-0 tertiary--text">Shared brain Nucleus between behaviors</v-card-title>
            <v-divider></v-divider>
            <v-row no-gutters align="center">
            <v-col class="matrixLegend display-1">Rat</v-col>
            <v-col cols='12' sm='7'>
                <table id="behavior_matrix" class="matrixStyle">
                    <tbody>
                      <tr v-for="(row, index1) in rows" :key="index1">
                       <!-- Here the is.NaN will test if the variable is a number or not  -->
                        <!-- <td v&#45;for="(col, index2) in row.value" :key="index2" @click="jumpSearch(col)" :class="{ active: !isNaN(col.value) &#38;&#38; col.isRat !== 0, activeRat: !isNaN(col.value) &#38;&#38; col.isRat === 0 }">{{!isNaN(col.value) ? 'x' : col.value}}</td> -->
                        <td v-for="(col, index2) in row.value" :key="index2" @click="jumpSearch(col)" :class="{ active: !isNaN(col.value) && col.isRat !== 0, activeRat: !isNaN(col.value) && col.isRat === 0 }">{{col.value}}</td>
                      </tr>
                    </tbody>
                </table>
            </v-col>
            <v-col class="matrixLegend display-1">Mouse</v-col>
            </v-row>
        </v-card>
        <v-timeline dense class="mt-12">
            <v-timeline-item small color="secondary lighten-2">
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
                        <v-btn text color="secondary lighten-0" to="/download">to Download</v-btn>
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
                        _json[i].value[j]['isRat'] = 0
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
    methods: {
        jumpSearch(y) {
            const behaviors = y.behaviors
            const species = y.isRat !== 0 ? 'Rat' : 'Mouse'
            this.$router.push({ name: 'search', query: { behavior: behaviors.join(','), species }})
        }
    }
}
</script>

<style lang="scss" scoped>
.matrixStyle {
    margin: 50px;
    border-collapse: collapse;
    box-shadow: 5px 5px 5px #88888885;
    td {
        padding: 0px;
        height: 100px;
        width: 100px;
        text-align: center;
        border: 1px solid #000;
        font-size: 18px;
    }
    .activeRat {
        background-color: rgb(249, 193, 44);
        cursor: pointer;
        font-size: 20px;
        &:hover {
            opacity: 0.8;
        }
    }
    .active {
        background-color: rgb(79, 172, 237);
        cursor: pointer;
        font-size: 20px;
        &:hover {
            opacity: 0.8;
        }
    }
}
.matrixLegend {
    font-size: 20px;
    font-weight: bold;
}
.pStyle {
    line-height: 1.5rem;
    color: rgba(0, 0, 0, 0.6);
}
</style>
