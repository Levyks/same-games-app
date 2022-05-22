import React from 'react';

type CenterProps = {
  h100?: boolean;
  flexGrow?: boolean;
  children: React.ReactNode;
};

function Center({ h100 = false, flexGrow = false, children }: CenterProps) {
  return (
    <div
      className={`d-flex flex-column justify-content-center align-items-center ${
        h100 && 'h-100'
      } ${flexGrow && 'flex-grow-1'}`}
    >
      {children}
    </div>
  );
}

export default Center;
