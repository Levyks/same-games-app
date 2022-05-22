<script setup lang="ts">
import { defineEmits, defineProps } from 'vue';

const emit = defineEmits(['update:modelValue', 'search']);
const props = defineProps({
  modelValue: {
    type: String,
    required: true,
  },
});

function handleInput(e: Event) {
  const target = e.target as HTMLInputElement;
  emit('update:modelValue', target.value);
}
</script>

<template>
  <input
    type="text"
    class="form-control mb-3"
    placeholder="Search"
    :value="props.modelValue"
    @input="handleInput"
    v-debounce:750="() => emit('search', props.modelValue)"
  />
</template>
