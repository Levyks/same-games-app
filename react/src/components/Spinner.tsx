import React from 'react';

type SpinnerProps = {
  size?: number;
  strokeWidth?: number;
};

function Spinner({ size = 8, strokeWidth = 1.5 }: SpinnerProps) {
  return (
    <div
      className="spinner-border"
      role="status"
      style={{
        width: `${size}rem`,
        height: `${size}rem`,
        fontSize: `${strokeWidth}rem`,
      }}
    >
      <span className="visually-hidden">Loading...</span>
    </div>
  );
}

export default Spinner;
