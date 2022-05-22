<script setup lang="ts">
import { defineProps } from 'vue';
import { useFavoritesStore } from '../stores/favorites';
import { ListGame } from 'rawg-api-sdk';

const props = defineProps<{
  game: ListGame;
}>();

const favoritesStore = useFavoritesStore();
</script>

<template>
  <li class="list-group-item d-flex align-items-center">
    <img
      :src="props.game.background_image"
      :alt="`Cover of ${props.game.name}`"
    />
    <span class="ms-2 flex-grow-1">{{ props.game.name }}</span>
    <button class="btn btn-close" @click="favoritesStore.remove(game)" />
  </li>
</template>

<style scoped lang="scss">
img {
  height: 64px;
  width: 64px;
  object-fit: cover;
}
</style>
