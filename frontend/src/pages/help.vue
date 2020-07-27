<template>
    <div>

        <div class="d-flex align-start mt-8">
            <v-img :src="require('../assets/placeholder.png')" class="my-3" height="300" contain/>
            <v-list-item two-line>
                <v-list-item-content>
                  <v-list-item-title class="display-3 font-weight-black tertiary--text">Demo Title</v-list-item-title>
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
                  <v-list-item-title class="display-3 font-weight-black tertiary--text">Demo Title</v-list-item-title>
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
            <v-col cols="12" sm="12">
              <v-list-item line>
                  <v-list-item-content>
                    <v-list-item-title><span class="font-weight-black">Question 1: </span>
                        Where are the data included in cFos-ANAB from?
                    </v-list-item-title>
                    <p class="pStyle"><b>Answer: </b>All data used in the cFos-ANAB (1.0) are manually extracted from publications of original experiments. 
  In order to ensure the high quality of data provided by cFos-ANAB, we employ a distinct criterion for data being included in the project, that is, only the results supported by figure legends are focused, of which cFos positive expression with significant statistics are required.  Furthermore, data in each record is linked to the DOI of original publication.
    More detailed answers, see Wang, et al (2020). cFos-ANAB: a c-Fos based web tool for exploring activated neurons and associated behaviors.  Preprint.
                    </p>
                  </v-list-item-content>
              </v-list-item>
              <v-list-item line>
                  <v-list-item-content>
                    <v-list-item-title><span class="font-weight-black">Question 2: </span>
                      What are the main functions of cFos-ANAB (1.0)?
                    </v-list-item-title>
                    <p class="pStyle"><b>Answer: </b>cFos-ANAB (1.0) is a user-friendly interface tool for exploring activated CNS neurons and associated behaviors based on cFos expression. 398 nuclei and subnuclei in total associated to 5 behaviors ( pain, feeding, fear, aggression, and sexual behavior ) of rats and mice are provided for quick analyses before experimental designs, more than 1900 records in total are available online.
                    </p>
                  </v-list-item-content>
              </v-list-item>
              <v-list-item line>
                  <v-list-item-content>
                    <v-list-item-title><span class="font-weight-black">Question 3: </span>
                        Which type of data could to be downloaded from cFos-ANAB (1.0) for non-commercial use?
                    </v-list-item-title>
                    <p class="pStyle"><b>Answer: </b>
                        Users can download any type data results for academic research, in formats preferable for programming (JSON format), including:
                          <ol>
                              <li>Original data.</li>
                              <li>Data on different brain nuclei.</li>
                              <li>Data on different behavior.</li>
                              <li>Data on different species.</li>
                              <li>Pictures of Network mapping.</li>
                              <li>Overlapping rat brain nuclei (subnuclei) among different behaviors.</li>
                              <li>Overlapping mouse brain nuclei (subnuclei) among different behaviors.</li>
                          </ol>
                    </p>
                  </v-list-item-content>
              </v-list-item>
            </v-col>
        </div>

        <a ref="BrainNucleusList" style="line-height: 160px;opacity: 0;">hidden anchor</a>
        <v-card-title class="display-2 font-weight-black"> Brain Nucleus List </v-card-title>
           <v-card-title class="display-1 font-weight-black">
                Mouse 
                <v-spacer></v-spacer>
                <v-col cols="12" sm="3">
                    <v-text-field
                      v-model="search_mouse"
                      append-icon="mdi-magnify"
                      label="Search"
                      single-line
                      hide-details
                    ></v-text-field>
                </v-col>
            </v-card-title>
            <v-data-table
                :headers="headers_mouse"
                :search="search_mouse"
                :items="brain_area_annotation_mouse"
                :items-per-page="5"
                :sort-by="['main']"
                class="elevation-1"
            ></v-data-table>
           <v-card-title class="display-1 font-weight-black">
                Rat 
                <v-spacer></v-spacer>
                <v-col cols="12" sm="3">
                    <v-text-field
                      v-model="search_rat"
                      append-icon="mdi-magnify"
                      label="Search"
                      single-line
                      hide-details
                    ></v-text-field>
                </v-col>
            </v-card-title>
            <v-data-table
                :headers="headers_rat"
                :search="search_rat"
                :items="brain_area_annotation_rat"
                :items-per-page="5"
                :sort-by="['main']"
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
              text: 'Database ID',
              align: 'start',
              sortable: true,
              value: 'brain_code',
            },
            { text: 'Database Name', value: 'main' },
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
                      return {brain_code: x.brain_code, main: x.main, long_1: long_1, long_2: long_2}
                  }
          ),
          headers_rat: [
            {
              text: 'Database ID',
              align: 'start',
              sortable: true,
              value: 'brain_code',
            },
            { text: 'Database Name', value: 'main' },
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
                      return {brain_code: x.brain_code, main: x.main, long_1: long_1, long_2: long_2}
                  }
          )
        }
      },
      mounted() {
        if (this.$route.hash.indexOf('#brain_area_annot') > -1) {
          this.$refs.BrainNucleusList.scrollIntoView()
        }
      }
    }
</script>

<style lang="scss" scoped>
.pStyle {
    line-height: 1.5rem;
    color: rgba(0, 0, 0, 0.6);
    font-size: 14px;
}
</style>
