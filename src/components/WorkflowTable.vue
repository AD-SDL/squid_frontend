<template>


    <WorkflowModal :modal_title="modal_title ":modal_text="modal_text" v-model:modal="modal" />

    <v-expansion-panels>


        <v-expansion-panel>
            <v-expansion-panel-title>
                <h3>{{ title }}</h3>
            </v-expansion-panel-title>
            <v-expansion-panel-text >
                <v-expansion-panels>

                    <v-expansion-panel
                        v-for="key in wfs"
                        id="wf" :subtitle="wc_state.workflows[key].name">

                        <v-expansion-panel-title>
                            {{ wc_state.workflows[key].name }} {{ key }} <p class=wf_indicator
                                :class="wc_state.workflows[key].status"></p>
                        </v-expansion-panel-title>
                        <v-expansion-panel-text>
                            <v-card class='pa-2'
                                @click="set_modal(wc_state.workflows[key].name, wc_state.workflows[key])">
                                State: {{ wc_state.workflows[key].status }}
                                <br>
                                Start Time: {{ wc_state.workflows[key].start_time }}

                                <p v-if="!(wc_state.workflows[key].status == 'completed')">
                                    Current Step:
                                    {{ wc_state.workflows[key].steps[wc_state.workflows[key].step_index].name }}
                                    <br>
                                    Description: {{ wc_state.workflows[key].steps[wc_state.workflows[key]
                            .step_index].comment }}
                                    <br>
                                </p>
                                <p v-else>
                                    End Time: {{ wc_state.workflows[key].end_time }}
                                </p>

                                <p v-if="(wc_state.workflows[key].status == 'failed')">
                                    End Time: {{ wc_state.workflows[key].end_time }}
                                </p>
                            </v-card>
                        </v-expansion-panel-text>

                    </v-expansion-panel>

                </v-expansion-panels>
            </v-expansion-panel-text>
        </v-expansion-panel>
    </v-expansion-panels>
</template>

<script setup lang="ts">
import { ref, defineModel } from 'vue'
import WorkflowModal from './WorkflowModal.vue'
const props = defineProps(['wfs', 'wc_state', 'title'])
const modal = ref(false)
const modal_text=ref()
const modal_title = ref()
const set_modal = (title: string, value: Object) =>
    {
      modal_title.value = title
      modal_text.value = value
      modal.value = true
    }
</script>