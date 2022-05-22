<script setup lang="ts">
import { useFavoritesStore } from '../stores/favorites';
import FavoritesItem from './FavoritesItem.vue';

const favoritesStore = useFavoritesStore();
</script>

<template>
  <div>
    <h2 class="text-center mt-4 mb-3">Favorites</h2>
    <ul class="list-group">
      <FavoritesItem
        v-for="game in favoritesStore.favorites"
        :key="game.id"
        :game="game"
      />
      <li v-if="!favoritesStore.favorites.length" class="list-group-item">
        No games favorited yet
      </li>
    </ul>
  </div>
</template>
