<script lang="ts">
  import favorites from '@/stores/favorites';
  import FavoritesItem from './FavoritesItem.svelte';
</script>

<h2 class="text-center mt-4 mb-3">Favorites</h2>
<ul class="list-group">
  {#each $favorites as game (game.id)}
    <FavoritesItem {game} />
  {:else}
    <li class="list-group-item">No games favorited yet</li>
  {/each}
</ul>
