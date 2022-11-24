<template>
  <div
    class="row entry-container mb-3 pointer p-2"
    @click="openMap"
  >
    <div class="col entry-title d-flex">
      Address: <span class="text-bold">{{ entry.address.street }} {{
        entry.address.houseNumber
      }}, {{ entry.address.postalCode }} -
      {{ entry.address.city }}</span>
      <br>
      Location: <span class="text-bold">{{ entry.address.geoLocation.lat }}; {{ entry.address.geoLocation.lng }}</span>
      <br>
      Distance: <span class="text-bold">{{ entry.distance }}</span>
      <br>
      Type: <span class="text-bold">{{ entry.type }}</span>
    </div>
  </div>
</template>

<script>

export default {
  name: 'EntryComponent',
  props: {
    entry: {
      type: Object,
      required: true
    }
  },
  methods: {
    openMap() {
      window.open(`https://www.google.com/maps/search/${this.entry.address.geoLocation.lat},${this.entry.address.geoLocation.lng}/`, '_blank');
    }
  }
}
</script>

<style lang="scss" scoped>
.entry-container {
  border-bottom: 1px solid #2c3e50;
  transition: 0.2s all ease-in;

  &:hover {
    background-color: lighten($color: grey, $amount: 45);
    transition: 0.2s all ease-in;

  }

  .entry-description {
    font-size: 12px;
  }
}
</style>
