import { ListGame } from 'rawg-api-sdk';
import { atom } from 'recoil';

export const favoritesState = atom<ListGame[]>({
  key: 'favorites',
  default: [],
});
