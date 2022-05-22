import { ListGame } from 'rawg-api-sdk';
import { useSelector } from 'react-redux';
import { RootState } from '../stores';
import FavoritesItem from './FavoritesItem';

function Favorites() {
  const favorites = useSelector<RootState, ListGame[]>(
    (state) => state.favorites.favorites
  );

  return (
    <>
      <h2 className="text-center mt-4 mb-3">Favorites</h2>
      <ul className="list-group">
        {favorites.map((game) => (
          <FavoritesItem game={game} key={game.id} />
        ))}
        {!favorites.length && (
          <li className="list-group-item">No games favorited yet</li>
        )}
      </ul>
    </>
  );
}

export default Favorites;
