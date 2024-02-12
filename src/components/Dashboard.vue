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
      <!--  -->
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
  import { ref } from 'vue'

  const drawer = ref(false)
</script>

<script lang="ts">
  export default {
    data: () => ({ drawer: false }),
  }
</script>

