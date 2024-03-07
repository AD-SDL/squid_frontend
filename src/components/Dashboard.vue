<template>

  <v-app id="inspire">


    <v-app-bar>
    
      <v-app-bar-title>Squid Dashboard</v-app-bar-title>
       
    </v-app-bar>
    
    <v-main>
    <v-dialog v-model="modal">
    <v-btn slot="activator" primary dark></v-btn>
    <v-card>
      <v-card-text>
        <h2 class="title">{{ modal_title }}</h2>
      </v-card-text>
      <v-card-text class="subheading grey--text">
        <div v-if="'actions' in modal_text" >
        <p>{{ modal_text.description}}</p>
        <br>
        <h2>Actions</h2>
        
        <v-expansion-panels>
        
      
        <v-expansion-panel v-for="action in modal_text.actions">
        <v-expansion-panel-title>{{action.name}}</v-expansion-panel-title>
        <v-expansion-panel-text>
          <p>{{action.description}}</p>
         
          Args: 
          <v-list class="d-flex-column">
        <v-list-item
        v-for="arg in action.args">
        <b>{{ arg.name }}</b>
        <p>{{ arg.description }}</p>
        <p>Type: {{ arg.type }}</p>
        <p>Default Value: {{ arg.default }}</p>
        <p>Required: {{ arg.required }}</p>

      </v-list-item>
        
  
     
      </v-list>
            

        </v-expansion-panel-text>
          </v-expansion-panel>
          </v-expansion-panels>
          </div>
        <div v-else>
          {{ modal_text }}
        </div>
         


      </v-card-text>
      <v-card-row actions>
        <v-spacer></v-spacer>
        <v-btn flat v-on:click.native="modal = false" class="primary--text">close</v-btn>
        
      </v-card-row>
    </v-card>
  </v-dialog>

   

    <div v-if=!has_url>
      <v-text-field id="url" default="Test"></v-text-field>
      <v-btn @click="submit_url()">submit url</v-btn>
      <v-btn @click="submit_default_url()">run locally</v-btn>
    </div>
    <div v-if=has_url>
      <v-tabs
      v-model="tab"
      align-tabs="center"
      color="deep-purple-accent-4"
    >
      <v-tab :value="1">Workcell</v-tab>
      <v-tab :value="2">Workflows</v-tab>
      <v-tab :value="3">Experiments</v-tab>
      <v-tab :value="4">Events</v-tab>
      <v-tab :value="5">Admin</v-tab>
      <v-tab :value="6">Resources</v-tab>
      
    </v-tabs>
    <v-window v-model="tab">
      <v-window-item
        :key="1"
        :value="1"
      >
    <v-row>
      <v-col>
      <div class="d-flex-column">
      <h3 >Modules:</h3>
      <v-list class="d-flex-column">
        <v-list-item
        v-for="(value, key) in wc_state.modules"
        :key="key"
        @click="set_modal(key, value.about)"
    ><v-list-item-title> <h4>{{key}}</h4></v-list-item-title>
  
     
       <p class=module_indicator :class="value.state">{{ value.state}}</p></v-list-item>
      </v-list>
   
    </div>
  </v-col>
    <v-col>
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
  </v-col>
      <v-col>
        <WorkflowTable title="Active Workflows":wc_state=wc_state :wfs="wfs.filter(key => wc_state.workflows[key].status === 'running')" v-model:modal="modal"  v-model:modal_text="modal_text" v-model:modal_title="modal_title"/>
        <WorkflowTable title="Queued Workflows":wc_state=wc_state :wfs="wfs.filter(key => wc_state.workflows[key].status === 'queued' || wc_state.workflows[key].status === 'new' )" v-model:modal="modal"  v-model:modal_text="modal_text" v-model:modal_title="modal_title"/>
        <WorkflowTable title="Recent Completed Workflows":wc_state=wc_state :wfs="wfs.filter(key => wc_state.workflows[key].status === 'completed' || wc_state.workflows[key].status === 'failed' ).slice(0, 10)" v-model:modal="modal"  v-model:modal_text="modal_text" v-model:modal_title="modal_title"/>
      
</v-col>
</v-row>
</v-window-item>
<v-window-item
        :key="2"
        :value="2"
      >
      <p>test2</p>
      </v-window-item>
      <v-window-item
        :key="3"
        :value="3"
      >
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
            <WorkflowTable title="Workflows":wc_state=wc_state :wfs="wfs" v-model:modal="modal"  v-model:modal_text="modal_text" v-model:modal_title="modal_title"/>
       

            
          </v-expansion-panel-text>
        </v-expansion-panel>
      </v-expansion-panels>
    </v-layout>

      </v-window-item>
      <v-window-item
        :key="4"
        :value="4"
      >
      <p>test3</p>
      </v-window-item>
      <v-window-item
        :key="5"
        :value="5"
      >
      <p>test3</p>
      </v-window-item>
      <v-window-item
        :key="6"
        :value="6"
      >
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
  const url = ref()
  const has_url = ref(false)
  const modal = ref(false)
  const modal_title = ref()
  const tab = ref(null)
  const modal_text = ref()
  const active_wfs = ref()
  const wfs = ref([])
  const set_modal = (title, value) =>
    {
      modal_title.value = title
      modal_text.value = value
      modal.value = true
    }

  const start = () => {
  watchEffect(async () => wc_state.value = await (await fetch(url.value)).json())
  setInterval(async () => {wc_state.value = await (await fetch(url.value)).json()
  wfs.value = Object.keys(wc_state.value.workflows).sort().reverse()
  }, 500)
}
  const submit_url = () => {url.value = document.getElementById('url'); has_url.value = true; start()}
  const submit_default_url = () => {url.value = "http://localhost:8000/wc/state"; has_url.value = true; start()}
  const wc_state = ref()
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
  .new {
    
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