import { writable } from 'svelte/store';
import type { ListGame } from 'rawg-api-sdk';

export const favorites = writable<ListGame[]>([]);
