import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { ListGame } from 'rawg-api-sdk';

type FavoritesSliceState = {
  favorites: ListGame[];
};

export const favoritesSlice = createSlice({
  name: 'favorites',
  initialState: {
    favorites: [],
  } as FavoritesSliceState,
  reducers: {
    add: (state, action: PayloadAction<ListGame>) => {
      state.favorites.push(action.payload);
    },
    remove: (state, action: PayloadAction<ListGame>) => {
      state.favorites = state.favorites.filter(
        (game) => game.id !== action.payload.id
      );
    },
  },
});

// Action creators are generated for each case reducer function
export const { add, remove } = favoritesSlice.actions;

export default favoritesSlice.reducer;
