<template>

<v-list>
    <WorkflowTable title="Workflows" :wc_state="wc_state" :wfs="my_wfs"/>

                      <v-list-item v-for="thing in logs_test">
                          {{ thing }}
                        </v-list-item>
                    </v-list>
                    
</template>

<script setup lang="ts">


import { ref } from 'vue'
const props = defineProps(['main_url',"experiment_id", "wc_state", "wfs"])
import WorkflowTable from './WorkflowTable.vue'
const my_wfs = ref()

my_wfs.value = props.wfs.filter((key: any) => props.wc_state.workflows[key].experiment_id === props.experiment_id)

const logs_test = ref()
setInterval(async () => {logs_test.value = await ((await fetch(props.main_url.concat("/experiments/".concat(props.experiment_id).concat("/log"))))).json() }, 500)


</script>
