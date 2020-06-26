<template>
    <div>
        <div class="grey lighten-4 pa-8">
            <p class="display-1">Search</p>
            <v-row align="center">
                <v-col class="d-flex" cols="12" sm="5">
                    <v-select v-model="selectedBehavior" :items="behaviorData" label="Behavior" multiple></v-select>
                </v-col>
                <v-col class="d-flex" cols="12" sm="5">
                    <v-combobox
                        v-model="selectedBrainArea"
                        :items="brainAreaData"
                        label="Brain Area"
                        multiple>
                        <template v-slot:prepend-item>
                            <v-list-item
                              ripple
                              @click="toggle"
                            >
                              <v-list-item-action>
                                <v-icon :color="selectedBrainArea.length > 0 ? 'indigo darken-4' : ''">{{ icon }}</v-icon>
                              </v-list-item-action>
                              <v-list-item-content>
                                <v-list-item-title>Select All</v-list-item-title>
                              </v-list-item-content>
                            </v-list-item>
                            <v-divider class="mt-2"></v-divider>
                        </template>
                    </v-combobox>
                </v-col>
            </v-row>

            <v-row align="center">
                <v-col class="d-flex" cols="12" sm="3">
                    <v-radio-group v-model="speciesData" row label="Species:">
                        <v-radio
                            v-for="n in ['Mouse', 'Rat']"
                            :key="n"
                            :label="`${n}`"
                            :value="n"
                        ></v-radio>
                    </v-radio-group>
                </v-col>
                <v-col class="d-flex" cols="12" sm="4">
                    <v-radio-group v-model="GenderData" row label="Gender:">
                        <v-radio
                            v-for="n in ['All', 'Male', 'Female']"
                            :key="n"
                            :label="`${n}`"
                            :value="n"
                        ></v-radio>
                    </v-radio-group>
                </v-col>
                <v-col class="d-flex align-center" cols="12" sm="4">
                    <span class="mr-4 text--secondary">Other: </span>
                    <v-checkbox
                        v-model="withFigure"
                        label="With Figure"
                        class="mr-8"
                    ></v-checkbox>
                    <v-checkbox
                        v-model="statistics"
                        label="Statistics Significant"
                    ></v-checkbox>
                </v-col>
            </v-row>
            <v-row justify="end">
                <v-btn large color="primary lighten-3">Submit</v-btn>
            </v-row>
        </div>
        <v-card-title>
            Results
            <v-spacer></v-spacer>
            <v-text-field
              v-model="search"
              append-icon="mdi-magnify"
              label="Search"
              single-line
              hide-details
            ></v-text-field>
        </v-card-title>
        <v-data-table
            :headers="headers"
            :search="search"
            :items="desserts"
            :items-per-page="5"
            class="elevation-1"
        ></v-data-table>
        <div class="d-flex justify-center mt-12">
            <v-chart :options="graphData"/>
        </div>
    </div>
</template>

<script>
import ECharts from 'vue-echarts'
import 'echarts/lib/chart/graph'
import 'echarts/lib/component/title'
import 'echarts/lib/component/tooltip'
import options_json from '@/assets/front_end.json'

export default {
    name: 'search',
    components: {
        'v-chart': ECharts
    },
    data () {
        const option = {
            title: {
                text: 'Les Miserables',
                subtext: 'Circular layout',
                top: 'top',
                left: 'left'
            },
            tooltip: {},
            animationDurationUpdate: 1500,
            animationEasingUpdate: 'quinticInOut',
            series: [
                {
                    type: 'graph',
                    layout: 'none',
                    symbolSize: 50,
                    roam: true,
                    label: {
                        show: true
                    },
                    edgeSymbol: ['circle', 'arrow'],
                    edgeSymbolSize: [4, 10],
                    edgeLabel: {
                        fontSize: 20
                    },
                    data: [{
                        name: '节点1',
                        x: 300,
                        y: 300
                    }, {
                        name: '节点2',
                        x: 800,
                        y: 300
                    }, {
                        name: '节点3',
                        x: 550,
                        y: 100
                    }, {
                        name: '节点4',
                        x: 550,
                        y: 500
                    }],
                    // links: [],
                    links: [{
                        source: 0,
                        target: 1,
                        symbolSize: [5, 20],
                        label: {
                            show: true
                        },
                        lineStyle: {
                            width: 5,
                            curveness: 0.2
                        }
                    }, {
                        source: '节点2',
                        target: '节点1',
                        label: {
                            show: true
                        },
                        lineStyle: {
                            curveness: 0.2
                        }
                    }, {
                        source: '节点1',
                        target: '节点3'
                    }, {
                        source: '节点2',
                        target: '节点3'
                    }, {
                        source: '节点2',
                        target: '节点4'
                    }, {
                        source: '节点1',
                        target: '节点4'
                    }],
                    lineStyle: {
                        opacity: 0.9,
                        width: 2,
                        curveness: 0
                    }
                }
            ]
        };
        return {
            selectedBrainArea: [],
            selectedBehavior: [],
            brainAreaData: options_json.brain_area.map(function(x) { return x.display}),
            behaviorData: options_json.behavior.map(function(x) { return x.display}),
            checkbox: '',
            speciesData: 'Mouse',
            GenderData: 'All',
            withFigure: false,
            statistics: false,
            graphData: option,
            search: '',
            headers: [
                {
                text: 'Dessert (100g serving)',
                align: 'start',
                sortable: false,
                value: 'name',
                },
                { text: 'Calories', value: 'calories' },
                { text: 'Fat (g)', value: 'fat' },
                { text: 'Carbs (g)', value: 'carbs' },
                { text: 'Protein (g)', value: 'protein' },
                { text: 'Iron (%)', value: 'iron' },
            ],
            desserts: [
            {
              name: 'Frozen Yogurt',
              calories: 159,
              fat: 6.0,
              carbs: 24,
              protein: 4.0,
              iron: '1%',
            },
            {
              name: 'Ice cream sandwich',
              calories: 237,
              fat: 9.0,
              carbs: 37,
              protein: 4.3,
              iron: '1%',
            },
            {
              name: 'Eclair',
              calories: 262,
              fat: 16.0,
              carbs: 23,
              protein: 6.0,
              iron: '7%',
            },
            {
              name: 'Cupcake',
              calories: 305,
              fat: 3.7,
              carbs: 67,
              protein: 4.3,
              iron: '8%',
            },
            {
              name: 'Gingerbread',
              calories: 356,
              fat: 16.0,
              carbs: 49,
              protein: 3.9,
              iron: '16%',
            },
            {
              name: 'Jelly bean',
              calories: 375,
              fat: 0.0,
              carbs: 94,
              protein: 0.0,
              iron: '0%',
            },
            {
              name: 'Lollipop',
              calories: 392,
              fat: 0.2,
              carbs: 98,
              protein: 0,
              iron: '2%',
            },
            {
              name: 'Honeycomb',
              calories: 408,
              fat: 3.2,
              carbs: 87,
              protein: 6.5,
              iron: '45%',
            },
            {
              name: 'Donut',
              calories: 452,
              fat: 25.0,
              carbs: 51,
              protein: 4.9,
              iron: '22%',
            },
            {
              name: 'KitKat',
              calories: 518,
              fat: 26.0,
              carbs: 65,
              protein: 7,
              iron: '6%',
            },
          ],
        }
    },
    computed: {
        likesAllFruit () {
            return this.selectedBrainArea.length === this.brainAreaData.length
        },
        likesSomeFruit () {
            return this.selectedBrainArea.length > 0 && !this.likesAllFruit
        },
        icon () {
            if (this.likesAllFruit) return 'mdi-close-box'
            if (this.likesSomeFruit) return 'mdi-minus-box'
            return 'mdi-checkbox-blank-outline'
        }
    },
    methods: {
      toggle () {
        this.$nextTick(() => {
          if (this.likesAllFruit) {
            this.selectedBrainArea = []
          } else {
            this.selectedBrainArea = this.brainAreaData.slice()
          }
        })
      }
    }
}
</script>

<style lang="scss" scoped>

</style>
