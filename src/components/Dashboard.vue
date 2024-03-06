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
  
      <v-list>
        <h3>Modules:</h3>
        <v-list-item
        v-for="(value, key) in wc_state.modules"
        :key="key"
        :title="key"
    
  ><p class=module_indicator :class="value.state">{{ value.state}}</p></v-list-item>
      </v-list>
        <v-list title="Locations">
          <h3>Locations:</h3>
        <v-list-item
        v-for="(value, key) in wc_state.locations"
        :key="key"
        :title="key"
    :subtitle="value.state"
  ></v-list-item>
        
      </v-list>
      
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
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
  import { ref, watchEffect } from 'vue'
  const wc_state = ref()
  const wfs = ref()
  wc_state.value={modules: {"test": {state: "test"}}}
  watchEffect(async () => wc_state.value = await (await fetch('http://localhost:8000/wc/state')).json())
  setInterval(async () => wc_state.value = await (await fetch('http://localhost:8000/wc/state')).json(), 500)
  setInterval(async () => wfs.value = Object.keys(wc_state.value.workflows).sort().reverse(), 500)
  
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
  .new {
    
    background-color: blue;
    
   
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