import { ListGame } from 'rawg-api-sdk';
import { useRecoilState } from 'recoil';
import { favoritesState } from '../stores/favorites';
import styles from './FavoritesItem.module.scss';

type FavoritesItemProps = {
  game: ListGame;
};

function FavoritesItem({ game }: FavoritesItemProps) {
  const [favorites, setFavorites] = useRecoilState(favoritesState);

  const removeFromFavorites = () =>
    setFavorites(favorites.filter((fav) => fav.id !== game.id));

  return (
    <li className="list-group-item d-flex align-items-center">
      <img
        src={game.background_image}
        className={styles.cover}
        alt={`Cover of ${game.name}`}
      />
      <span className="ms-2 flex-grow-1">{game.name}</span>
      <button className="btn btn-close" onClick={removeFromFavorites} />
    </li>
  );
}

export default FavoritesItem;
