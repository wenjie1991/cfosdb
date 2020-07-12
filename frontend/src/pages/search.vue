<template>
    <div>
        <div class="grey lighten-4 pa-8">
            <p class="display-1">Search</p>
            <v-row align="center">
                <v-col class="d-flex" cols="12" sm="5">
                    <v-select v-model="selectedBehavior" :items="behaviorData" label="Behavior" multiple>
                        <template v-slot:selection="{ item, index }">
                            <v-chip v-if="index < 3">
                              <span>{{ item.text }}</span>
                            </v-chip>
                            <span
                              v-if="index === 3"
                              class="grey--text caption"
                            >(+{{ selectedBehavior.length - 3 }} others)</span>
                        </template>
                    </v-select>
                </v-col>
                <v-col class="d-flex" cols="12" sm="5">
                    <v-combobox
                        v-model="selectedBrainArea"
                        :items="brainAreaData"
                        label="Brain Nucleus"
                        :allow-overflow="false"
                        :single-line="true"
                        ref="brainAreaComboBox"
                        multiple>
                        <template v-slot:prepend-item>
                            <v-list-item ripple @click="toggle">
                              <v-list-item-action>
                                <v-icon :color="selectedBrainArea.length > 0 ? 'indigo darken-4' : ''">{{ icon }}</v-icon>
                              </v-list-item-action>
                              <v-list-item-content>
                                <v-list-item-title>Select All</v-list-item-title>
                              </v-list-item-content>
                            </v-list-item>
                            <v-divider class="mt-2"></v-divider>
                        </template>
                        <template v-slot:selection="{ item, index }">
                            <v-chip v-if="index < 1">
                              <span>{{ item.text }}</span>
                            </v-chip>
                            <span
                              v-if="index === 1"
                              class="grey--text caption"
                            >(+{{ selectedBrainArea.length - 1 }} others)</span>
                        </template>

                    </v-combobox>
                </v-col>
                <v-col class="d-flex" cols="12" sm="1">
                    <v-btn text color="secondary accent-4" to="/help#brain_area_annot">[Brain Nucleus List]</v-btn>
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
                            v-for="n in [{label: 'All', value: '%'}, {label: 'Male', value: 'male'}, {label: 'Female', value: 'female'}]"
                            :key="n.label"
                            :label= n.label
                            :value= n.value
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
                <v-btn large color="secondary lighten-3" v-on:click="submitQuery">Submit</v-btn>
            </v-row>
        </div>
        <v-card-title>
            Results
            <v-spacer></v-spacer>
            <v-col cols="12" sm="3">
                <v-select
                    class="tableRowClass"
                    v-model="selectedTableRow"
                    :return-object="true"
                    :items="headers"
                    label="Selected Row Item"
                    multiple
                    :small-chips="true"
                >
                    <template v-slot:selection="{ item, index }">
                        <v-chip v-if="index < 1" :small="true">
                          <span>{{ item.text }}</span>
                        </v-chip>
                        <span
                          v-if="index === 1"
                          class="grey--text caption"
                        >(+{{ selectedTableRow.length - 1 }} others)</span>
                    </template>
                </v-select>
            </v-col>
            <v-text-field
                v-model="search"
                append-icon="mdi-magnify"
                label="Search"
                single-line
                hide-details
            ></v-text-field>
        </v-card-title>
        <v-data-table
            :headers="selectedTableRow"
            :search="search"
            :items="table_cotent"
            :items-per-page="5"
            class="elevation-1"
        >
            <template v-slot:header.name="{ selectedTableRow }">
                {{ selectedTableRow.text }}
            </template>
            <template v-slot:item.doi="{ item }">
                <a :href="`http://47.114.44.79/${item.doi}`" target="_blank">{{item.doi}}</a>
            </template>
        </v-data-table>
        <div class="d-flex justify-center mt-12">
            <v-chart :options="graphData" v-show="!dialogChart"/>
        </div>
        <v-btn @click="dialogChart = true">dialogChart</v-btn>
        <v-dialog v-model="dialogChart" scrollable max-width="1000px">
            <v-chart :options="graphData"/>
        </v-dialog>
    </div>
</template>

<script>
import ECharts from 'vue-echarts'
import 'echarts/lib/chart/graph'
import 'echarts/lib/component/title'
import 'echarts/lib/component/tooltip'
import options_json from '@/assets/front_end.json'

function draw_network(tbJson, brain_area_level = 1, behavior_level = 1) {
	var behavior_dict = {};
	var brain_area_dict = {};

	var generate_dict = {};

	if (behavior_level == 1) {
		generate_dict["behavior_value"] = (function(tb_row) {
			return tb_row.condition;
		});
	} else {
		generate_dict["behavior_value"] = (function(tb_row) {
			return tb_row.behavior;
		});
	}

	generate_dict["brain_area_value"] = (function(tb_row) {
		return [tb_row.brain_code, tb_row.main];
	});

	
	for (var i=0; i<tbJson.length; i++) {
		brain_area_dict[tbJson[i].brain_code] = generate_dict.brain_area_value(tbJson[i]);
		behavior_dict[tbJson[i].condition] = generate_dict.behavior_value(tbJson[i]);
	}

	var query_dict;
	if (brain_area_level == 1) {
		query_dict = (function(x) {
			return x;
		})
	} else {
		query_dict = (function(x) {
			var parent = x.split(".")[0];
			if (brain_area_dict[parent]) {
				return parent;
			} else {
				return x;
			}
		})
	}

	var links = {}, data = {};
	for (i=0; i<tbJson.length; i++) {
		var source = behavior_dict[tbJson[i].condition],
			target = brain_area_dict[query_dict(tbJson[i].brain_code)],
			link_key = source + target[0];

		if (links[link_key]) {
			links[link_key].lineStyle.width++;
		} else {
			links[link_key] = {
				source : source,
				target : target[0],
				lineStyle : {
					width : 1
				}
			}
		}

		if (data[source]) {
			data[source].value++;
		} else {
			data[source] = {
				id : source,
				name : source,
				value : 1,
				category : 0,
			}
		}

		if (data[target[0]]) {
			data[target[0]].value++;
		} else {
			data[target[0]] = {
				id : target[0],
				name : target[1],
				value : 1,
				category : 1,
			}
		}
	}

	var graph = {links : [], nodes: []};
	for (i in links) {
		graph.links.push(links[i]);
	}
	for (i in data) {
		graph.nodes.push(data[i]);
	}

	var categories = [
		{
			name: "Condition",
		},
		{
			name: "Brain Nucleus"
		}
	];
	graph.nodes.forEach(function (node) {
		node.itemStyle = null;
		node.symbolSize = node.value * 5;
		node.label = {
			normal: {
				show: true
				//node.symbolSize > 0
			}
		};
	});

	var option = {
		title: {
			text: 'cFOS Brain Nucleus- Condition Mapping',
			subtext: '',
			top: 'top',
			left: 'left'
		},
		tooltip: {},
		legend: [{
			// selectedMode: 'single',
			data: categories.map(function (a) {
				return a.name;
			}),
			left: 'right'
		}],
		animationDuration: 1500,
		animationEasingUpdate: 'quinticInOut',
		series : [
			{
				name: '',
				type: 'graph',
				layout: 'circular',
				data: graph.nodes,
				links: graph.links,
				categories: categories,
				roam: true,
				focusNodeAdjacency: true,
				itemStyle: {
					normal: {
						borderColor: '#fff',
						borderWidth: 1,
						shadowBlur: 10,
						shadowColor: 'rgba(0, 0, 0, 0.3)'
					}
				},
				label: {
					position: 'right',
					formatter: '{b}'
				},
				lineStyle: {
					color: 'source',
					curveness: 0.3
				},
				emphasis: {
					lineStyle: {
						width: 10
					}
				}
			}
		]
	};

    return option
}


export default {
    name: 'search',
    components: {
        'v-chart': ECharts
    },

    data () {
        return {
            selectedBrainArea: [],
            selectedBehavior: [],
            brainAreaData: options_json.brain_area.map(function(x) { return {text: x.display, value: x.value}}), // update
            behaviorData: options_json.behavior.map(function(x) { return {text: x.display, value: x.value}}),  // update, watch
            speciesData: 'Mouse', // watch
            GenderData: '%',  //watch
            withFigure: false,
            statistics: false,
            dialogChart: false,
            search: '',
            // selectedColumns: foobar, "watch"
            headers: [ // update
                {
                text: 'Behavior',
                align: 'start',
                sortable: false,
                value: 'behavior',
                },
                { text: 'Brain Nucleus', value: 'main' },
                { text: 'Condition', value: 'condition' },
                { text: 'Species', value: 'species' },
                { text: 'Source', value: 'doi' },
                { text: 'Cell Type', value: 'cell_type' },
            ],
            table_cotent: [],
            selectedTableRow: [],
            // figure_parameter: foobar, *watch
            graphData: draw_network([]) // listen
        }
    },
    mounted() {
        this.selectedTableRow = this.headers
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
    watch: {
        selectedBrainArea() {
            this.$refs.brainAreaComboBox.internalSearch = ''
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
      },
      submitQuery () {
        var behavior_x = this.selectedBehavior.join(",")
        var brain_code_x = this.selectedBrainArea.map(function(x) {return x.value}).join(",")
        console.log([behavior_x, brain_code_x])
        fetch(`http://47.114.44.79/api?brain_code=${brain_code_x}&gender=${this.GenderData}&species=${this.speciesData}&behavior=${behavior_x}`)
            .then(response => response.json())
            .then(json => {
                this.table_cotent = json
                this.graphData = draw_network(json)
            })
      }
    }
}
</script>

<style lang="scss" scoped>
.tableRowClass {
    position: relative;
    bottom: -11px;
    right: 5px;
}
</style>
