<script lang="ts">
  import Favorites from './components/Favorites.svelte';
  import GamesList from './components/GamesList.svelte';
</script>

<div class="row h-100">
  <div class="col-12 col-md-8 d-flex flex-column">
    <GamesList />
  </div>
  <div class="col-12 col-md-3">
    <Favorites />
  </div>
</div>
