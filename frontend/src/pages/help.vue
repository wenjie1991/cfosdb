<template>
    <div>

        <div class="d-flex align-start mt-8">
            <v-img :src="require('../assets/placeholder.png')" class="my-3" height="300" contain/>
            <v-list-item two-line>
                <v-list-item-content>
                  <v-list-item-title class="display-3 font-weight-black">Demo Title</v-list-item-title>
                  <v-list-item-subtitle>demo description</v-list-item-subtitle>
                  <v-list-item-subtitle>demo description</v-list-item-subtitle>
                  <v-list-item-subtitle>demo description</v-list-item-subtitle>
                  <v-list-item-subtitle>demo description</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
        </div>
        <div class="d-flex align-start my-8">
            <v-list-item two-line>
                <v-list-item-content>
                  <v-list-item-title class="display-3 font-weight-black">Demo Title</v-list-item-title>
                  <v-list-item-subtitle>demo description</v-list-item-subtitle>
                  <v-list-item-subtitle>demo description</v-list-item-subtitle>
                  <v-list-item-subtitle>demo description</v-list-item-subtitle>
                  <v-list-item-subtitle>demo description</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
            <v-img :src="require('../assets/placeholder.png')" class="my-3" height="300" contain/>
        </div>

        <div class="d-flex flex-column align-center">
            <p class="font-weight-black display-3">FAQ</p>
            <v-list-item two-line>
                <v-list-item-content>
                  <v-list-item-title><span class="font-weight-black">Question 1: </span>xxxxxxxxx</v-list-item-title>
                  <v-list-item-subtitle><span class="font-weight-black">Answer: </span>xxxxxxxxxxxxx</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
            <v-list-item two-line>
                <v-list-item-content>
                  <v-list-item-title><span class="font-weight-black">Question 2: </span>xxxxxxxxx</v-list-item-title>
                  <v-list-item-subtitle><span class="font-weight-black">Answer: </span>xxxxxxxxxxxxx</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
            <v-list-item two-line>
                <v-list-item-content>
                  <v-list-item-title><span class="font-weight-black">Question 3: </span>xxxxxxxxx</v-list-item-title>
                  <v-list-item-subtitle><span class="font-weight-black">Answer: </span>xxxxxxxxxxxxx</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
        </div>

        <a name='brain_area_annot' style="line-height: 50px;opacity: 0;">hidden anchor</a>
        <v-card-title class="display-2 font-weight-black"> Brain Nucleus List </v-card-title>
           <v-card-title class="display-1 font-weight-black">
                Mouse 
                <v-spacer></v-spacer>
                <v-text-field
                  v-model="search_mouse"
                  append-icon="mdi-magnify"
                  label="Search"
                  single-line
                  hide-details
                ></v-text-field>
            </v-card-title>
            <v-data-table
                :headers="headers_mouse"
                :search="search_mouse"
                :items="brain_area_annotation_mouse"
                :items-per-page="5"
                class="elevation-1"
            ></v-data-table>
           <v-card-title class="display-1 font-weight-black">
                Rat 
                <v-spacer></v-spacer>
                <v-text-field
                  v-model="search_rat"
                  append-icon="mdi-magnify"
                  label="Search"
                  single-line
                  hide-details
                ></v-text-field>
            </v-card-title>
            <v-data-table
                :headers="headers_rat"
                :search="search_rat"
                :items="brain_area_annotation_rat"
                :items-per-page="5"
                class="elevation-1"
            ></v-data-table>
    </div>
</template>

<script>
import brain_area_annotation from "@/assets/clean_brain_area_annotation.json"

    export default {
      data () {
        return {
          search_mouse: "",
          search_rat: "",
          headers_mouse: [
            {
              text: 'Display Name',
              align: 'start',
              sortable: false,
              value: 'main',
            },
            { text: 'Paxinos & Franklin, 2013 (Abbr)', value: 'long_1' },
            { text: 'Mouse brain_Franklin & Paxinos, 2007 (Abbr)', value: 'long_2' },
          ],
          brain_area_annotation_mouse: brain_area_annotation.filter(function(x) { return x.species === "Mouse" }).map(
                  function(x) {
                      var long_1 = "", long_2 = "";
                      if (x.long_1 != "") {
                          long_1 = `${x.long_1} (${x.short_1})`
                      }
                      if (x.long_2 != "") {
                          long_2 = `${x.long_2} (${x.short_2})`
                      }
                      return {main: x.main, long_1: long_1, long_2: long_2}
                  }
          ),
          headers_rat: [
            {
              text: 'Display Name',
              align: 'start',
              sortable: false,
              value: 'main',
            },
            { text: 'L.W.Swanson, 2004 (Abbr)', value: 'long_1' },
            { text: 'Paxinos & Watson, 2007 (Abbr)', value: 'long_2' },
          ],
          brain_area_annotation_rat: brain_area_annotation.filter(function(x) { return x.species === "Rat" }).map(
                  function(x) {
                      var long_1 = "", long_2 = "";
                      if (x.long_1 != "") {
                          long_1 = `${x.long_1} (${x.short_1})`
                      }
                      if (x.long_2 != "") {
                          long_2 = `${x.long_2} (${x.short_2})`
                      }
                      return {main: x.main, long_1: long_1, long_2: long_2}
                  }
          )
        }
      },
    }
</script>

<style lang="scss" scoped>

</style>
