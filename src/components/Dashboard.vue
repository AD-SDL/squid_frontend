<template>

  <v-app id="inspire">


    <v-app-bar>

      <v-app-bar-title>Squid Dashboard</v-app-bar-title>

    </v-app-bar>

    <v-main>



      <div v-if=!has_url>
        <v-text-field id="url" default="Test"></v-text-field>
        <v-btn @click="submit_url()">submit url</v-btn>
        <v-btn @click="submit_default_url()">run locally</v-btn>
      </div>
      <div v-if=has_url>
        <v-tabs v-model="tab" align-tabs="center" color="deep-purple-accent-4">
          <v-tab :value="1">Workcell</v-tab>
          <v-tab :value="2">Workflows</v-tab>
          <v-tab :value="3">Experiments</v-tab>
          <v-tab :value="4">Events</v-tab>
          <v-tab :value="5">Admin</v-tab>
          <v-tab :value="6">Resources</v-tab>

        </v-tabs>
        <v-window v-model="tab">
          <v-window-item :key="1" :value="1">
            <v-row>
              <v-col>

                <ModuleColumn :modules=wc_state.modules />
              </v-col>
              <v-col>
                <LocationsColumn :locations=wc_state.locations />
              </v-col>
              <v-col>
                <WorkflowTable title="Active Workflows" :wc_state=wc_state
                  :wfs="wfs.filter(key => wc_state.workflows[key].status === 'running')" />
                <WorkflowTable title="Queued Workflows" :wc_state=wc_state
                  :wfs="wfs.filter(key => wc_state.workflows[key].status === 'queued'
                   || wc_state.workflows[key].status === 'new')"
                 />
                <WorkflowTable title="Recent Completed Workflows" :wc_state=wc_state
                  :wfs="wfs.filter(key => wc_state.workflows[key].status === 'completed' 
                  || wc_state.workflows[key].status === 'failed').slice(0, 10)"
                 />

              </v-col>
            </v-row>
          </v-window-item>
          <v-window-item :key="2" :value="2">
            <p>test2</p>
          </v-window-item>
          <v-window-item :key="3" :value="3">
            <v-layout class='justify-center'>
              <v-expansion-panels class="w-50">
                <v-expansion-panel>
                  <v-expansion-panel-title>
                    <h3>Color_Picker_ASDFSFDJDLGKjLDKJLKJ</h3>
                  </v-expansion-panel-title>
                  <v-expansion-panel-text>
                    <h4>Project:</h4> Color_Picker
                    <h4> Creator:</h4> No b. Ody
                    <h4> Started:</h4> 1/1/1111
                    <WorkflowTable title="Workflows" :wc_state=wc_state :wfs="wfs" v-model:modal="modal"
                      v-model:modal_text="modal_text" v-model:modal_title="modal_title" />



                  </v-expansion-panel-text>
                </v-expansion-panel>
              </v-expansion-panels>
            </v-layout>

          </v-window-item>
          <v-window-item :key="4" :value="4">
            <p>test3</p>
          </v-window-item>
          <v-window-item :key="5" :value="5">
            <p>test3</p>
          </v-window-item>
          <v-window-item :key="6" :value="6">
            <p>test3</p>
          </v-window-item>

        </v-window>
        <!--  -->
      </div>

    </v-main>
  </v-app>
</template>

<script setup lang="ts">
import { ref, watchEffect } from 'vue'
import WorkflowTable from './WorkflowTable.vue'
import ModuleColumn from './ModuleColumn.vue'
import LocationsColumn from './LocationsColumn.vue';
const url = ref()
const has_url = ref(false)
const modal = ref(false)
const modal_title = ref()
const tab = ref(null)
const modal_text = ref()
const wfs = ref([''])
const active_wfs = ref([''])
const queued_wfs = ref([''])
const completed_wfs = ref([''])
const set_modal = (title: string, value: Object) => {
  modal_title.value = title
  modal_text.value = value
  modal.value = true
}

const start = () => {
  watchEffect(async () => wc_state.value = await (await fetch(url.value)).json())
  setInterval(async () => {
    wc_state.value = await (await fetch(url.value)).json()
    wfs.value = Object.keys(wc_state.value.workflows).sort().reverse()
  }, 500)
}
const submit_url = () => { url.value = document.getElementById('url'); has_url.value = true; start() }
const submit_default_url = () => { url.value = "http://localhost:8000/wc/state"; has_url.value = true; start() }
const wc_state = ref()
wc_state.value = { modules: { "test": { state: "test" } } }

const drawer = ref(false)
</script>

<script lang="ts">
export default {
  data: () => ({ drawer: false }),
}
</script>

<style>
.module_indicator {
  color: white;

  border-radius: 5px;
  padding: 3px;
  width: 40px;
}

.IDLE {
  background-color: green;

}

.BUSY {
  background-color: blue;
  width: 45px;

}

.ERROR {
  background-color: red;
  width: 50px;

}

.wf_indicator {
  width: 10px;
  height: 10px;
  border-radius: 5px;
  margin-left: 10px;
}

.queued {

  background-color: yellow;


}

.new {

  background-color: yellow;


}

.running {

  background-color: blue;
}

.completed {

  background-color: green;
}

.failed {

  background-color: red;
}
</style>