<script setup lang="ts">
import { defineProps } from 'vue';

const props = defineProps({
  size: {
    type: Number,
    default: 8,
  },
  strokeWidth: {
    type: Number,
    default: 1.5,
  },
});
</script>

<template>
  <div
    class="spinner-border"
    role="status"
    :style="`width: ${props.size}rem; height: ${props.size}rem; font-size: ${props.strokeWidth}rem;`"
  >
    <span class="visually-hidden">Loading...</span>
  </div>
</template>
