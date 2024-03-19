<template>


                </template>

<script setup lang="ts">


import { ref, watchEffect } from 'vue'
const props = defineProps(['main_url',"experiment_id"])


const logs_test = ref()
setInterval(async () => {logs_test.value = await ((await fetch(props.main_url.value.concat("/experiments/".concat(props.experiment_id).concat("/log"))))).json() }, 500)


</script>
