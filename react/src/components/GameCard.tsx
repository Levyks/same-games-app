import { ListGame } from 'rawg-api-sdk';
import { useDispatch, useSelector } from 'react-redux';
import { add as addToFavorites } from '../stores/favorites';
import { AppDispatch, RootState } from '../stores';
import styles from './GameCard.module.scss';

type GameCardProps = {
  game: ListGame;
};

function GameCard({ game }: GameCardProps) {
  const favorites = useSelector<RootState, ListGame[]>(
    (state) => state.favorites.favorites
  );
  const dispatch = useDispatch<AppDispatch>();

  return (
    <div className="card">
      {game.background_image && (
        <img
          src={game.background_image}
          className={`card-img-top ${styles.cover}`}
          alt={`Cover of ${game.name}`}
        />
      )}
      <div className="card-body d-flex flex-column">
        <h5 className="card-title">{game.name}</h5>
        <h6 className="card-subtitle mb-2 text-muted flex-grow-1">
          {game.genres.map((genre) => genre.name).join('/')}
        </h6>
        <p className="card-text text-muted text-end">
          From {game.released?.getFullYear()}
        </p>
        <button
          className="btn btn-primary"
          disabled={favorites.some((fav) => fav.id === game.id)}
          onClick={() => dispatch(addToFavorites(game))}
        >
          Add to favorites
        </button>
      </div>
    </div>
  );
}

export default GameCard;
