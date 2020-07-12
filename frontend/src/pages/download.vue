<template>
    <v-timeline>
        <v-timeline-item color="orange lighten-2">
            <template v-slot:opposite>
                <span :class="`headline font-weight-bold orange--text`">2020.2.2</span>
            </template>
            <v-card color="orange lighten-2" dark>
                <v-card-title class="title">Lorem Ipsum Dolor</v-card-title>
                <v-card-text class="white text--primary">
                    <p>
                        Lorem ipsum dolor sit amet, no nam oblique veritus. Commune scaevola
                        imperdiet nec ut, sed euismod convenire principes at. Est et nobis
                        iisque percipit, an vim zril disputando voluptatibus, vix an
                        salutandi sententiae.
                    </p>
                    <div class="d-flex flex-row-reverse">
                        <v-btn text color="orange lighten-2" class="mx-0" outlined>Mouse Data<v-icon>mdi-download</v-icon></v-btn>
                        <v-btn text color="orange lighten-2" class="mx-0" outlined>Rat Data<v-icon>mdi-download</v-icon></v-btn>
                    </div>
                </v-card-text>
            </v-card>
        </v-timeline-item>
        <v-timeline-item color="primary">
            <template v-slot:opposite>
                <span :class="`headline font-weight-bold primary--text`">2019.2.2</span>
            </template>
            <v-card color="primary" dark>
                <v-card-title class="title">Lorem Ipsum Dolor</v-card-title>
                <v-card-text class="white text--primary">
                    <p>
                        Lorem ipsum dolor sit amet, no nam oblique veritus. Commune scaevola
                        imperdiet nec ut, sed euismod convenire principes at. Est et nobis
                        iisque percipit, an vim zril disputando voluptatibus, vix an
                        salutandi sententiae.
                    </p>
                    <v-btn color="primary darken-1" class="mx-0" outlined>
                        Button
                    </v-btn>
                </v-card-text>
            </v-card>
        </v-timeline-item>
    </v-timeline>
</template>

<script>
export default {
    name: "download",
    data() {
        return {

        }
    }
};
</script>

<style lang="scss" scoped>

</style>