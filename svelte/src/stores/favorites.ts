import { writable } from 'svelte/store';
import type { ListGame } from 'rawg-api-sdk';

const { update, set, subscribe } = writable<ListGame[]>([]);

function add(game: ListGame) {
  update((games) => games.concat(game));
}

function remove(game: ListGame) {
  update((games) => games.filter((g) => g.id !== game.id));
}

export default {
  update,
  set,
  subscribe,
  add,
  remove,
};
