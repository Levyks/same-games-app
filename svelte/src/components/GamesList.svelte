<script lang="ts">
  import { RawgClient, PaginatedData, ListGame } from 'rawg-api-sdk';

  import GameCard from './GameCard.svelte';
  import SearchField from './SearchField.svelte';
  import Spinner from './Spinner.svelte';
  import Center from './Center.svelte';

  const client = new RawgClient(import.meta.env.VITE_RAWG_API_KEY);

  let data: PaginatedData<ListGame>;
  let page: number = 1;
  let search: string = '';
  let loading = true;
  let error: string = '';

  async function fetchGames(p: number = page, q: string = search) {
    loading = true;
    page = p;
    search = q;
    data = await client.games
      .list({
        page,
        search,
        page_size: 15,
      })
      .catch((e) => {
        console.error(e);
        error = e.message;
        return undefined;
      });
    loading = false;
  }

  fetchGames();
</script>

<h1 class="text-center my-3">Games</h1>
<SearchField value={search} on:search={(e) => fetchGames(page, e.detail)} />
{#if loading}
  <Center flexGrow>
    <Spinner />
  </Center>
{:else if error}
  <Center flexGrow>
    <span class="text-danger mb-3">Error: {error}</span>
    <button class="btn btn-primary" on:click={() => fetchGames()}>Retry</button>
  </Center>
{:else}
  <div class="games-wrapper mb-3">
    {#each data.results as game (game.id)}
      <GameCard {game} />
    {/each}
  </div>
  <div class="d-flex justify-content-center align-items-center mb-3">
    <button
      class="btn btn-primary"
      disabled={!data.previous}
      on:click={() => fetchGames(page - 1)}
    >
      Previous
    </button>
    <strong class="mx-2">Page {page}</strong>
    <button
      class="btn btn-primary"
      disabled={!data.next}
      on:click={() => fetchGames(page + 1)}
    >
      Next
    </button>
  </div>
{/if}

<style lang="scss">
  .games-wrapper {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    grid-gap: 1rem;
  }
</style>
