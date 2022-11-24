<template>
  <q-layout view="hHh Lpr fFf">
    <q-header bordered class="bg-white text-primary">
      <q-toolbar>
        <q-toolbar-title class="text-center">
          <q-avatar>
            <q-icon name="local_atm"/>
          </q-avatar>
          ATM's Location
        </q-toolbar-title>
      </q-toolbar>
    </q-header>
    <q-page-container>
      <router-view/>
    </q-page-container>
  </q-layout>
</template>

<script lang="ts">
import {defineComponent} from 'vue';


export default defineComponent({
  name: 'MainLayout',
  components: {},
  setup() {
    return {}
  }
});
</script>
