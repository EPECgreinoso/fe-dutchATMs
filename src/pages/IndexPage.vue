<template>
  <q-page class="row items-center justify-evenly">

    <div class="col-4 offset-1 ">
      <q-input
        :loading="loading"
        v-model="search"
        debounce="100"
        placeholder="Search your ATM">
        <template v-slot:append>
          <q-icon name="search"/>
        </template>
      </q-input>
      <div>
        <img src="atm.png" alt="atm-img" class="q-img">
      </div>
    </div>

    <div class="col entry-scrollarea offset-1 cursor-pointer">
      <q-inner-loading :showing="loading">
        <q-spinner-gears size="50px" color="primary"/>
      </q-inner-loading>
      <Entry v-for="atm in data" :key="atm" :entry="atm"/>

      <h4 v-if="data && data.length === 0" class="justify-center flex">There are not ATMs matching</h4>
    </div>

  </q-page>
</template>
<script lang="ts">
import {defineComponent, onMounted, ref, watch} from 'vue';
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
    const loading = ref(false);

    onMounted(() => loadData(''));

    watch(search, (term) => {
      loadData(term);
    })

    function loadData(term: string) {
      loading.value = true;
      api.get<Atm[]>(`/atm/search?term=${term}`)
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
        .finally(() => loading.value = false)
    }

    return {atms, data, search, loading}
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
