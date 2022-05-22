<script lang="ts">
  import { favorites } from '@/stores';
  import type { ListGame } from 'rawg-api-sdk';

  export let game: ListGame;

  function addToFavorites() {
    favorites.update((favorites) => [...favorites, game]);
  }
</script>

<div class="card">
  {#if game.background_image}
    <img
      src={game.background_image}
      class="card-img-top"
      alt="Cover of {game.name}"
    />
  {/if}
  <div class="card-body d-flex flex-column">
    <h5 class="card-title">{game.name}</h5>
    <h6 class="card-subtitle mb-2 text-muted flex-grow-1">
      {game.genres.map((genre) => genre.name).join('/')}
    </h6>
    <p class="card-text text-muted text-end">
      From {game.released.getFullYear()}
    </p>
    <button
      class="btn btn-primary"
      disabled={$favorites.some((g) => g.id === game.id)}
      on:click={addToFavorites}>Add to favorites</button
    >
  </div>
</div>

<style lang="scss">
  img {
    aspect-ratio: 16/9;
    object-fit: cover;
  }
</style>
