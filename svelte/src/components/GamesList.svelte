<script lang="ts">
  import { RawgClient, PaginatedData, ListGame } from 'rawg-api-sdk';
  import { debounce } from 'svelte-debounce';

  import GameCard from './GameCard.svelte';
  import Spinner from './Spinner.svelte';

  const client = new RawgClient(import.meta.env.VITE_RAWG_API_KEY);

  let data: PaginatedData<ListGame>;
  let page: number = 1;
  let search: string = '';
  let loading = true;
  let error: string = '';

  async function fetchGames() {
    loading = true;
    data = await client.games
      .list({
        page,
        search,
        page_size: 15,
      })
      .catch((e) => {
        error = e.message;
        return undefined;
      });
    loading = false;
  }

  $: page && fetchGames();

  const debounceConfig = {
    callback: () => {
      page = 1;
      fetchGames();
    },
  };
</script>

<h1 class="text-center my-3">Games</h1>
<div
  class="flex-grow-1 d-flex flex-column justify-content-center align-items-center"
>
  {#if loading}
    <Spinner />
  {:else if error}
    <span class="text-danger">Error: {error}</span>
    <button class="btn btn-primary mt-3" on:click={fetchGames}>Retry</button>
  {:else}
    <input
      type="text"
      class="form-control mb-3"
      placeholder="Search"
      bind:value={search}
      use:debounce={debounceConfig}
    />
    <div class="games-wrapper mb-3">
      {#each data.results as game (game.id)}
        <GameCard {game} />
      {/each}
    </div>
    <div class="d-flex justify-content-center align-items-center mb-3">
      <button
        class="btn btn-primary"
        disabled={!data.previous}
        on:click={() => page--}
      >
        Previous
      </button>
      <strong class="mx-2">Page {page}</strong>
      <button
        class="btn btn-primary"
        disabled={!data.next}
        on:click={() => page++}
      >
        Next
      </button>
    </div>
  {/if}
</div>

<style lang="scss">
  .games-wrapper {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    grid-gap: 1rem;
  }
</style>
