<script lang="ts">
  import favorites from '@/stores/favorites';
  import type { ListGame } from 'rawg-api-sdk';

  export let game: ListGame;
</script>

<li class="list-group-item d-flex align-items-center">
  <img src={game.background_image} alt="Cover of {game.name}" />
  <span class="ms-2 flex-grow-1">{game.name}</span>
  <button class="btn btn-close" on:click={() => favorites.remove(game)} />
</li>

<style lang="scss">
  img {
    height: 64px;
    width: 64px;
    object-fit: cover;
  }
</style>
