import { useEffect, useState } from 'react';
import { RawgClient, PaginatedData, ListGame } from 'rawg-api-sdk';

import styles from './GamesList.module.scss';
import Center from './Center';
import Spinner from './Spinner';
import GameCard from './GameCard';
import SearchField from './SearchField';

const client = new RawgClient(import.meta.env.VITE_RAWG_API_KEY);

function GamesList() {
  const [data, setData] = useState<PaginatedData<ListGame>>();
  const [page, setPage] = useState(1);
  const [search, setSearch] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  async function fetchGames(p: number = page, q: string = search) {
    setLoading(true);
    setPage(p);
    setSearch(q);

    setData(
      await client.games
        .list({
          page: p,
          search: q,
          page_size: 15,
        })
        .catch((e) => {
          setError(e.message);
          return undefined;
        })
    );

    setLoading(false);
  }

  useEffect(() => {
    fetchGames();
  }, []);

  return (
    <>
      <h1 className="text-center my-3">Games</h1>
      <SearchField onSearch={(search) => fetchGames(page, search)} />
      {loading ? (
        <Center flexGrow={true}>
          <Spinner />
        </Center>
      ) : error ? (
        <Center flexGrow={true}>
          <span className="text-danger mb-3">Error: {error}</span>
          <button className="btn btn-primary">Retry</button>
        </Center>
      ) : data ? (
        <>
          <div className={`${styles.gamesWrapper} mb-3`}>
            {data.results.map((game) => (
              <GameCard key={game.id} game={game} />
            ))}
          </div>
          <div className="d-flex justify-content-center align-items-center mb-3">
            <button
              className="btn btn-primary"
              disabled={!data.previous}
              onClick={() => fetchGames(page - 1)}
            >
              Previous
            </button>
            <strong className="mx-2">Page {page}</strong>
            <button
              className="btn btn-primary"
              disabled={!data.next}
              onClick={() => fetchGames(page + 1)}
            >
              Next
            </button>
          </div>
        </>
      ) : (
        <></>
      )}
    </>
  );
}

export default GamesList;
