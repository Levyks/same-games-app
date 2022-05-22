import { useDebouncedCallback } from 'use-debounce';

type SearchFieldProps = {
  onSearch: (search: string) => void;
};

function SearchField({ onSearch }: SearchFieldProps) {
  const debounced = useDebouncedCallback(onSearch, 750);

  return (
    <input
      type="text"
      className="form-control mb-3"
      placeholder="Search"
      onChange={(e) => debounced(e.target.value)}
    />
  );
}

export default SearchField;
