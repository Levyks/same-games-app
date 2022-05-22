import GamesList from './components/GamesList';
import Favorites from './components/Favorites';

function App() {
  return (
    <div className="row h-100">
      <div className="col-12 col-md-8 d-flex flex-column">
        <GamesList />
      </div>
      <div className="col-12 col-md-3">
        <Favorites />
      </div>
    </div>
  );
}

export default App;
