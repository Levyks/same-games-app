import { useRecoilState } from 'recoil';
import { favoritesState } from '../stores/favorites';
import FavoritesItem from './FavoritesItem';

function Favorites() {
  const [favorites] = useRecoilState(favoritesState);

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
