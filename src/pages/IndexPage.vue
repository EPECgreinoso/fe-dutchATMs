<template>
  <q-page class="row items-center justify-evenly">
    <div>
      <q-input
        v-model="search"
        debounce="100"
        filled
        placeholder="Search">
        <template v-slot:append>
          <q-icon name="search"/>
        </template>
      </q-input>
    </div>
    <div class="entry-scrollarea">
      <Entry v-for="atm in data" :key="atm" :entry="atm"/>
    </div>

  </q-page>
</template>
<script lang="ts">
import {defineComponent, ref, watch} from 'vue';
import {api} from 'boot/axios'
import {useQuasar} from 'quasar'
import {Atm} from 'components/models';
import Entry from 'components/Entry.vue';


export default defineComponent({
  name: 'IndexPage',
  components: {Entry},
  setup() {
    const $q = useQuasar()
    const search = ref()
    const data = ref();
    let atms: Atm[] = [];

    watch(search, (term) => {
      loadData(term);
    })

    function loadData(term: string) {
      api.get<Atm[]>(`/atm/?term=${term}`)
        .then((response) => {
          atms = response.data;
          data.value = atms;
          console.log('ATM QUEDO EN ', atms)
        })
        .catch(() => {
          $q.notify({
            color: 'negative',
            position: 'top',
            message: 'Loading failed',
            icon: 'report_problem'
          })
        })
    }

    return {atms, data, search}
  }
});
</script>

<style lang="scss" scoped>
input {
  height: 25px;
}

.entry-list-container {
  border-right: 1px solid #2c3e50;
  height: calc(100vh - 56px);
}

.entry-scrollarea {
  height: calc(100vh - 110px);
  overflow: scroll;
}

</style>
