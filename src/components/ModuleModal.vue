 <template>
 <v-dialog v-model="modal">
    <v-btn slot="activator" primary dark></v-btn>
    <v-card>
      <v-card-text>
        <h2 class="title">{{ modal_title }}</h2>
      </v-card-text>
      <v-card-text class="subheading grey--text">
        <div >
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
        
  
     
      