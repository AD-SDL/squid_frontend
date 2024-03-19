<template>
  <v-app id="inspire">


    <v-app-bar>

      <v-app-bar-title>Squid Dashboard</v-app-bar-title>

    </v-app-bar>

    <v-main>


     
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
                  :wfs="wfs.filter(key => wc_state.workflows[key].status === 'running')" start_open=true />
                <WorkflowTable title="Queued Workflows" :wc_state=wc_state
                  :wfs="wfs.filter(key => wc_state.workflows[key].status === 'queued'
                   || wc_state.workflows[key].status === 'new')"
                 start_open=true />
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

                    <p>{{ logs_test }}</p>

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
     

    </v-main>
  </v-app>
</template>

<script setup lang="ts">
import { ref, watchEffect } from 'vue'
import WorkflowTable from './WorkflowTable.vue'
import ModuleColumn from './ModuleColumn.vue'
import LocationsColumn from './LocationsColumn.vue';
const main_url = ref()
const state_url = ref()
const has_url = ref(false)
const modal = ref(false)
const modal_title = ref()
const tab = ref(null)
const modal_text = ref()
const wfs = ref([''])
const active_wfs = ref([''])
const queued_wfs = ref([''])
const completed_wfs = ref([''])
const experiments = ref()
const experiments_url = ref()
const logs_test = ref()
const input = ref()
const url_text = ref()
const backend_server = ref()
const workcell_urls = ref()
const wc_state = ref()
const set_modal = (title: string, value: Object) => {
  modal_title.value = title
  modal_text.value = value
  modal.value = true
}
backend_server.value = "http://".concat(window.location.host).concat("/server")
console.log(backend_server)
// workcell_urls.value = await (await fetch(backend_server.value)).json()
console.log(workcell_urls.value)
watchEffect(async () => {workcell_urls.value = await (await fetch(backend_server.value)).json();
main_url.value = workcell_urls.value[0]
console.log(workcell_urls.value)
// main_url.value = workcell_urls.value[0]
 
has_url.value = true;  
// main_url.value = "http://localhost:8000"
state_url.value=main_url.value.concat("/wc/state")

experiments_url.value=main_url.value.concat("/experiments/all")


watchEffect(async () => wc_state.value = await (await fetch(state_url.value)).json())


wc_state.value = { modules: { "test": { state: "test" } } }


const drawer = ref(false)
setInterval(async () => {
  wc_state.value = await (await fetch(state_url.value)).json()
  wfs.value = Object.keys(wc_state.value.workflows).sort().reverse()
  experiments.value = await ((await fetch(experiments_url.value)).json())
  console.log(wc_state)
  if(experiments.value["experiment_ids"].length > 0) {
  logs_test.value = await ((await fetch(main_url.value.concat("/experiments/".concat(experiments.value["experiment_ids"][0]).concat("/log"))))).json()
}

}, 500)
}
)

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

.UNKNOWN {
  background-color: red;
  width: 60px;

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