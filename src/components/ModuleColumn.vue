
<template>
<ModuleModal :modal_title="modal_title ":modal_text="modal_text" v-model:modal="modal" />

<div class="d-flex-column">
      <h3 >Modules:</h3>
      <v-list class="d-flex-column">
        <v-list-item
        v-for="(value, key2) in modules"   
        @click="set_modal(String(key2), value.about)"
    ><v-list-item-title> <h4>{{key2}}</h4></v-list-item-title>
  
     
       <p class=module_indicator :class="value.state">{{ value.state}}</p></v-list-item>
      </v-list>
   
    </div>
</template>

<script setup lang="ts">

import { ref  } from 'vue'
import ModuleModal from './ModuleModal.vue'
const props = defineProps(['modules'])
const modal_title = ref()
const modal = ref(false)
const modal_text = ref()
const set_modal = (title: string, value: Object) =>
    {
      modal_title.value = title
      modal_text.value = value
      modal.value = true
    }
</script>