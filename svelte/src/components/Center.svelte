<script lang="ts">
  export let h100: boolean = false;
  export let flexGrow: boolean = false;
</script>

<div
  class="d-flex flex-column justify-content-center align-items-center"
  class:h-100={h100}
  class:flex-grow-1={flexGrow}
>
  <slot />
</div>
