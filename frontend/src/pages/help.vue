<template>
    <div>
        <div>instruction</div>
        <div>Brain Area Annotation</div>
        <div class="d-flex align-start">
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
    </div>
</template>

<script>
export default {
    name: 'help'
}
</script>

<style lang="scss" scoped>

</style>
