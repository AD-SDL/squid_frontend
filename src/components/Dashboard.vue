<template>
  <v-app id="inspire">
    <v-navigation-drawer
      v-model="drawer"
      class="bg-blue"
    >
      <v-card-title>Workcells</v-card-title>
      <v-divider class="bg-black" thickness="5"></v-divider>
      <v-list-item link title="RPL Modular Workcell"></v-list-item>
      <v-list-item link title="MIR Base Workcell"></v-list-item>
      <v-list-item link title="N9 Workcell"></v-list-item>
    </v-navigation-drawer>

    <v-app-bar>
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>

      <v-app-bar-title>Squid Dashboard</v-app-bar-title>
       
    </v-app-bar>

    <v-main>
    <div v-if=!has_url>
      <v-text-field id="url" default="Test"></v-text-field>
      <v-btn @click="submit_url()">submit url</v-btn>
      <v-btn @click="submit_default_url()">run locally</v-btn>
    </div>
    <div v-if=has_url>
    <div class="d-inline-flex">
      <div class="d-flex-column">
      <h3 >Modules:</h3>
      <v-list class="d-flex-column">
        <v-list-item
        v-for="(value, key) in wc_state.modules"
        :key="key"
        :title="key"
    ><p class=module_indicator :class="value.state">{{ value.state}}</p></v-list-item>
      </v-list>
    </div>
    </div>
    <div class="d-inline-flex">
      <div class="d-flex-column">
      <h3>Locations:</h3>
        <v-list title="Locations" >
         
        <v-list-item
        v-for="(value, key) in wc_state.locations"
        :key="key"
        :title="key"
    :subtitle="value.state"
    
  ></v-list-item>
        
      </v-list>
    </div>
      </div>
      
      <v-expansion-panels class="w-25" >
        
      
         <v-expansion-panel>
          <v-expansion-panel-title>
            <h3>Workflows</h3>
          </v-expansion-panel-title>
          <v-expansion-panel-text>
      <v-expansion-panels>
         
        <v-expansion-panel
        v-for="key in wfs"
        id="wf"
        :subtitle="wc_state.workflows[key].name"
  >
  
  <v-expansion-panel-title>
    {{ wc_state.workflows[key].name }} {{key}} <p class=wf_indicator :class="wc_state.workflows[key].status"></p>
  </v-expansion-panel-title>
  <v-expansion-panel-text>
  
  State: {{ wc_state.workflows[key].status }}
  <br>
  Start Time: {{  wc_state.workflows[key].start_time }}
  
  <p v-if="!(wc_state.workflows[key].status=='completed')">
  Current Step: {{wc_state.workflows[key].steps[wc_state.workflows[key].step_index].name}} 
  <br>
  Description: {{wc_state.workflows[key].steps[wc_state.workflows[key]  .step_index].comment}}
  <br>
  </p>
  <p v-else>
    End Time: {{ wc_state.workflows[key].end_time}}
  </p>
 
  <p v-if="(wc_state.workflows[key].status=='failed')">
    End Time: {{ wc_state.workflows[key].end_time}}
  </p>
</v-expansion-panel-text>

</v-expansion-panel>
   
      </v-expansion-panels>
    </v-expansion-panel-text>
    </v-expansion-panel>
  </v-expansion-panels>
      <!--  -->
      </div>
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
  import { ref, watchEffect } from 'vue'
  const url = ref()
  const has_url = ref(false)
  const start = () => {
  watchEffect(async () => wc_state.value = await (await fetch(url.value)).json())
  setInterval(async () => wc_state.value = await (await fetch(url.value)).json(), 500)
  setInterval(async () => wfs.value = Object.keys(wc_state.value.workflows).sort().reverse(), 500)
  }
  const submit_url = () => {url.value = document.getElementById('url'); has_url.value = true; start()}
  const submit_default_url = () => {url.value = "http://localhost:8000/wc/state"; has_url.value = true; start()}
  const wc_state = ref()
  const wfs = ref()
  wc_state.value={modules: {"test": {state: "test"}}}

  
  
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
    width:40px;
  }
  .IDLE {
    background-color: green;
    
  }
  .BUSY {
    background-color: blue;
    width:45px;
   
  }
  .ERROR {
    background-color: red;
    width:50px;
   
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
  .running{
  
    background-color: blue;
  }

  .completed{

    background-color: green;
  }
  .failed{
  
  background-color: red;
}



 
</style>