<script lang="ts">
  import { createEventDispatcher } from 'svelte';
  import { debounce } from 'svelte-debounce';

  export let value: string = '';
  export let debounceDelay: number = 750;

  const dispatch = createEventDispatcher<{
    search: string;
  }>();

  const debounceConfig = {
    callback: () => dispatch('search', value),
    delay: debounceDelay,
  };
</script>

<input
  type="text"
  class="form-control mb-3"
  placeholder="Search"
  bind:value
  use:debounce={debounceConfig}
/>
