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
    
  ><p :class="value.state">{{ value.state}}</p></v-list-item>
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

      <v-list>
          <h3>Workflows:</h3>
        <v-list-item
        v-for="key in wfs"
        :title="key"
        :subtitle="wc_state.workflows[key].name"
  >
  
  State: {{ wc_state.workflows[key].status }}
  <p v-if="!(wc_state.workflows[key].status=='completed')">
  Current Step: {{wc_state.workflows[key].steps[wc_state.workflows[key].step_index].name}} 
  <br>
  Description: {{wc_state.workflows[key].steps[wc_state.workflows[key]  .step_index].comment}}
  <br>
  </p>
 


</v-list-item>
    
      </v-list>
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
  .IDLE {
    color: white;
    background-color: green;
    border-radius: 5px;
    padding: 3px;
    width:40px;
  }
  .BUSY {
    color: white;
    background-color: red;
    border-radius: 5px;
    padding: 3px;
    width:50px;
  }
</style>