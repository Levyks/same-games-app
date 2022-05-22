import { ListGame } from 'rawg-api-sdk';
import { useDispatch } from 'react-redux';
import { remove as removeFromFavorites } from '../stores/favorites';
import { AppDispatch } from '../stores';
import styles from './FavoritesItem.module.scss';

type FavoritesItemProps = {
  game: ListGame;
};

function FavoritesItem({ game }: FavoritesItemProps) {
  const dispatch = useDispatch<AppDispatch>();

  return (
    <li className="list-group-item d-flex align-items-center">
      <img
        src={game.background_image}
        className={styles.cover}
        alt={`Cover of ${game.name}`}
      />
      <span className="ms-2 flex-grow-1">{game.name}</span>
      <button
        className="btn btn-close"
        onClick={() => dispatch(removeFromFavorites(game))}
      />
    </li>
  );
}

export default FavoritesItem;
