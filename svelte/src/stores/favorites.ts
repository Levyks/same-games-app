import { writable } from 'svelte/store';
import type { ListGame } from 'rawg-api-sdk';
// eslint-disable-next-line camelcase
import { get_store_value } from 'svelte/internal';

const { update, set, subscribe } = writable<ListGame[]>([]);

const get = () => get_store_value({ subscribe });

function add(game: ListGame) {
  update((games) => games.concat(game));
}

function remove(game: ListGame) {
  update((games) => games.filter((g) => g.id !== game.id));
}

function hasGame(game: ListGame) {
  return get().some((g) => g.id === game.id);
}

export default {
  get,
  update,
  set,
  subscribe,
  add,
  remove,
  hasGame,
};
