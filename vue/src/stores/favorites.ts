import { defineStore } from 'pinia';
import { ListGame } from 'rawg-api-sdk';

type FavoritesStoreState = {
  favorites: ListGame[];
};

export const useFavoritesStore = defineStore('favorites', {
  state: () =>
    ({
      favorites: [],
    } as FavoritesStoreState),
  actions: {
    add(game: ListGame) {
      this.favorites.push(game);
    },
    remove(game: ListGame) {
      this.favorites = this.favorites.filter((g) => g.id !== game.id);
    },
    hasGame(game: ListGame) {
      return this.favorites.some((g) => g.id === game.id);
    },
  },
});
