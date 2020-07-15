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
                        :search-input.sync="brainAreaComboBoxInput"
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
                <a :href="`https://doi.org/${item.doi}`" target="_blank">{{item.doi}}</a>
            </template>
            <template v-slot:item.main="{ item }">
                <a :href="`https://www.ncbi.nlm.nih.gov/pubmed/?term=${item.main}`" target="_blank">{{item.main}}</a>
            </template>
            <!-- https://www.ncbi.nlm.nih.gov/pubmed/?term="{{main}} -->
        </v-data-table>

        <v-row>
        <v-card-title> 
            Visualization
        </v-card-title>
        </v-row>

        <v-row class="justify-center" v-show="!haveSearchResult">
            <v-chip outlined>No data for visualization</v-chip>
        </v-row>

        <v-row v-show="haveSearchResult">
            <v-col class="flex-column" cols = "12" sm = "4">
                <header>Nucleus - Behaviors Network Options:</header>
                    <v-switch class="flex-column"
                        v-model="graph_option.brain_area_level" 
                        label="Display Nucleus detail"
                        true-value=1
                        false-value=0
                    ></v-switch>
                    <v-switch 
                        v-model="graph_option.behavior_level" 
                        label="Display treatments detail"
                        true-value=1
                        false-value=0
                    ></v-switch>
                    <v-switch 
                        v-model="graph_option.show_label" 
                        label="Display the node label"
                        ></v-switch>
            </v-col>
            
            <v-col cols="12" sm="8" align='center' @click="dialogChart = true" >
                <v-hover v-slot:default="{ hover }" v-show="!dialogChart" title="Click to show the graph">
                    <v-card :elevation="hover ? 16 : 2" class="mx-auto" >
                        <v-chart class="echarts-inline" autoresize :options="graphData"/>
                    </v-card>
                </v-hover>
            <v-dialog v-model="dialogChart" 
                max-width="1000px" 
                class="graphpopup"
                >
                <div class="dialog-frame">
                    <v-chart class="echarts-pop" :options="graphData"/>
                </div>
             </v-dialog>
               
            </v-col>
        </v-row>

    </div>
</template>

<script>
import ECharts from 'vue-echarts'
import 'echarts/lib/chart/graph'
import 'echarts/lib/component/title'
import 'echarts/lib/component/tooltip'
import options_json from '@/assets/front_end.json'

function draw_network(tbJson, graph_option) {
    // brain_area_level: 1 more detail, else less detail
    // behavior_level: 1 more detail, else less detail
	var behavior_dict = {};
	var brain_area_dict = {};

	var generate_dict = {};

	if (graph_option.behavior_level == 1) {
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
	if (graph_option.brain_area_level == 1) {
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
		node.symbolSize = Math.log2(node.value + 1) * 5 + 1;
		node.label = {
			normal: {
				show: graph_option.show_label, 
                //node.symbolSize > 0
			}
		};
	});


	var option = {
		title: {
			text: 'Nucleus - Behavior Network',
			subtext: '',
			top: 'top',
            left: 'center'
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
                roam: graph_option.roam_enable,
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
                    show: graph_option.show_label,
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
            brainAreaComboBoxInput: '',
            brainAreaData: options_json.brain_area.map(function(x) { return {text: x.display, value: x.value}}),
            behaviorData: options_json.behavior.map(function(x) { return {text: x.display, value: x.value}}),
            speciesData: 'Mouse',
            GenderData: '%',
            withFigure: false,
            statistics: false,
            dialogChart: false,
            search: '',
            headers: [
                { text: 'Nucleus ID', value: 'brain_code' },
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
                { text: 'Gender', value: 'gender' },
                { text: 'Figure', value: 'figure' },

            ],
            table_cotent: [],
            selectedTableRow: [],
            graphData_json: [],
            graph_option: {
                brain_area_level: 0,
                behavior_level: 0,
                show_label: false,
                roam_enable: false,
            }
        }
    },
    mounted() {
        this.selectedTableRow = this.headers.slice(1, 5)
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
        },
        graphData () {
            return draw_network(this.graphData_json, this.graph_option)
        },
        haveSearchResult: function() {
            return this.table_cotent.length > 0
        }
    },
    watch: {
        selectedBrainArea() {
            this.brainAreaComboBoxInput = ''
        },

        table_cotent: function() {
            this.graphData_json = this.table_cotent
        },
        dialogChart: function() {
            this.graph_option.roam_enable = this.dialogChart
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
        // console.log([behavior_x, brain_code_x])
        fetch(`http://47.114.44.79/api?brain_code=${brain_code_x}&gender=${this.GenderData}&species=${this.speciesData}&behavior=${behavior_x}`)
            .then(response => response.json())
            .then(json => {
                this.table_cotent = json
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

.echarts-pop {
    height: 1000px;
    width: 1000px;
}

.echarts-inline {
    height: 400px;
    width: 100%;
}

.dialog-frame {
    height: 1000px;
    width: 1000px;
    background: white;
}

.graphPopup {
    background: "white";
}
</style>
