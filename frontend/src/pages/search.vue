<template>
    <div>
        <div>
            <v-select v-model="selectedFruits" :items="brainAreaData" label="Behavior" multiple>

            </v-select>
            <v-select v-model="selectedFruits" :items="brainAreaData" label="Behavior" multiple>

            </v-select>
            <v-select v-model="selectedFruits" :items="brainAreaData" label="Behavior" multiple>

            </v-select>
            <v-checkbox
                v-model="checkbox"
                :label="`Checkbox 1: ${checkbox.toString()}`"
            ></v-checkbox>
            <v-checkbox
                v-model="checkbox"
                :label="`Checkbox 1: ${checkbox.toString()}`"
            ></v-checkbox>
        </div>
        <v-data-table
            :headers="headers"
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
            selectedFruits: '',
            brainAreaData: [],
            checkbox: '',
            graphData: option,
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
    }
}
</script>

<style lang="scss" scoped>

</style>
