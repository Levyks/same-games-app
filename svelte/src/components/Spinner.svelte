<script lang="ts">
  export let size: number = 8;
  export let strokeWidth: number = 1.5;
</script>

<div
  class="spinner-border"
  role="status"
  style="width: {size}rem; height: {size}rem; font-size: {strokeWidth}rem;"
>
  <span class="visually-hidden">Loading...</span>
</div>
