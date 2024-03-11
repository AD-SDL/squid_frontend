<template>
<div class="d-flex-column">
                  <h3>Locations:</h3>
                  <v-list title="Locations">

                    <v-list-item v-for="(value, key) in locations" :key="key" :title="key"
                      :subtitle="value.state"></v-list-item>

                  </v-list>
                  </div>
                </template>

<script setup lang="ts">

const props = defineProps(['locations'])

</script>