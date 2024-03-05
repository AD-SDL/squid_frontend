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
    :subtitle="value.state"
  ></v-list-item>
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
        v-for="(value, key) in wc_state.workflows"
        :key="key"
        :title="key"
    :subtitle="value"
  ></v-list-item>
        {{ wc_state.workflows }}
      </v-list>
      <!--  -->
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
  import { ref, watchEffect } from 'vue'
  const wc_state = ref()
  wc_state.value={modules: {"test": {state: "test"}}}
  watchEffect(async () => wc_state.value = await (await fetch('http://localhost:8000/wc/state')).json())
  setInterval(async () => wc_state.value = await (await fetch('http://localhost:8000/wc/state')).json(), 500)
  const drawer = ref(false)
</script>

<script lang="ts">
  export default {
    data: () => ({ drawer: false }),
  }
</script>

