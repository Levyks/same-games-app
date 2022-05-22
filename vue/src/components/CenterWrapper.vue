<script setup lang="ts">
import { defineProps } from 'vue';

const props = defineProps({
  h100: {
    type: Boolean,
    default: false,
  },
  flexGrow: {
    type: Boolean,
    default: false,
  },
});
</script>

<template>
  <div
    class="d-flex flex-column justify-content-center align-items-center"
    :class="{ 'h-100': props.h100, 'flex-grow-1': props.flexGrow }"
  >
    <slot></slot>
  </div>
</template>
