<template>
  <v-dialog v-model="modal">
    <v-btn slot="activator" primary dark></v-btn>
    <v-card>
      <v-card-text>
        <h2 class="title">{{ modal_title }}</h2>
        <div >
          {{ modal_text }}
        </div>
         


      </v-card-text>
      <v-card-row actions>
        <v-spacer></v-spacer>
        <v-btn flat v-on:click.native="modal = false" class="primary--text">close</v-btn>
        
      </v-card-row>
    </v-card>
  </v-dialog>
  </template>


<script setup lang="ts">
    import { ref, defineModel } from 'vue'
    const props = defineProps(['modal_title', 'modal_text'])
    const modal= defineModel('modal', {type: Boolean})
    
    </script>