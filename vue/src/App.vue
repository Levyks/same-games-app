<script setup lang="ts">
import GamesList from './components/GamesList.vue';
import FavoritesList from './components/FavoritesList.vue';
</script>

<template>
  <div class="row h-100">
    <div class="col-12 col-md-8">
      <GamesList />
    </div>
    <div class="col-12 col-md-3">
      <FavoritesList />
    </div>
  </div>
</template>
