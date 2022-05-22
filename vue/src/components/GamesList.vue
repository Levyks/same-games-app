<script setup lang="ts">
import { ref } from 'vue';
import { RawgClient, PaginatedData, ListGame } from 'rawg-api-sdk';

import SearchField from './SearchField.vue';
import LoadingSpinner from './LoadingSpinner.vue';
import GameCard from './GameCard.vue';
import CenterWrapper from './CenterWrapper.vue';

const data = ref<PaginatedData<ListGame>>();
const page = ref<number>(1);
const search = ref<string>('');
const loading = ref<boolean>(true);
const error = ref<string>('');

const client = new RawgClient(import.meta.env.VITE_RAWG_API_KEY);

async function fetchGames(p: number = page.value, q: string = search.value) {
  loading.value = true;
  page.value = p;
  search.value = q;
  data.value = await client.games
    .list({
      page: p,
      search: q,
      page_size: 15,
    })
    .catch((e) => {
      console.error(e);
      error.value = e.message;
      return undefined;
    });
  loading.value = false;
}

fetchGames();
</script>

<template>
  <div class="h-100 d-flex flex-column align-items-center">
    <h1 class="text-center my-3">Games</h1>
    <SearchField v-model="search" @search="fetchGames(page, $event)" />
    <CenterWrapper flex-grow v-if="loading">
      <LoadingSpinner />
    </CenterWrapper>
    <CenterWrapper flex-grow v-else-if="error">
      <span class="text-danger mb-3">Error: {{ error }}</span>
      <button class="btn btn-primary" @click="fetchGames()">Retry</button>
    </CenterWrapper>
    <template v-else-if="data">
      <div class="games-wrapper mb-3">
        <GameCard v-for="game in data.results" :key="game.id" :game="game" />
      </div>
      <div class="d-flex justify-content-center align-items-center mb-3">
        <button
          class="btn btn-primary"
          :disabled="!data.previous"
          @click="fetchGames(page - 1)"
        >
          Previous
        </button>
        <strong class="mx-2">Page {{ page }}</strong>
        <button
          class="btn btn-primary"
          :disabled="!data.next"
          @click="fetchGames(page + 1)"
        >
          Next
        </button>
      </div>
    </template>
  </div>
</template>

<style scoped lang="scss">
.games-wrapper {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  grid-gap: 1rem;
}
</style>
