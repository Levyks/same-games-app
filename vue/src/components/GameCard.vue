<script setup lang="ts">
import { defineProps } from 'vue';
import { ListGame } from 'rawg-api-sdk';

import { useFavoritesStore } from '../stores/favorites';

const props = defineProps<{
  game: ListGame;
}>();

const favoritesStore = useFavoritesStore();
</script>

<template>
  <div class="card">
    <img
      v-if="props.game.background_image"
      :src="props.game.background_image"
      class="card-img-top"
      :alt="`Cover of ${props.game.name}`"
    />
    <div class="card-body d-flex flex-column">
      <h5 class="card-title">{{ props.game.name }}</h5>
      <h6 class="card-subtitle mb-2 text-muted flex-grow-1">
        {{ props.game.genres.map((genre) => genre.name).join('/') }}
      </h6>
      <p class="card-text text-muted text-end" v-if="props.game.released">
        From {{ props.game.released.getFullYear() }}
      </p>
      <button
        class="btn btn-primary"
        :disabled="favoritesStore.hasGame(props.game)"
        @click="favoritesStore.add(props.game)"
      >
        Add to favorites
      </button>
    </div>
  </div>
</template>

<style scoped lang="scss">
img {
  aspect-ratio: 16/9;
  object-fit: cover;
}
</style>
