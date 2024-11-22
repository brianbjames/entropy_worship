import React, { ReactElement, useState, useEffect } from 'react';
import { createRoot } from 'react-dom/client';
import { Animator } from '@arwes/react-animator';
import { Puffs } from '@arwes/react-bgs';


const Sandbox = (): ReactElement => {
  const [active, setActive] = useState(true);

  useEffect(() => {
    const iid = setInterval(() => setActive(active => !active), 3000);
    return () => clearInterval(iid);
  }, []);

  return (
    <Animator
    active={active}
    duration={{
      interval: 2
    }}
    style={{
      position: 'absolute',
      top: 0,
      left: 0,
      zIndex: 1
    }}
  >
      <div style={{
        position: 'relative',
        width: '80vw',
        height: '80vh',
        zIndex: '1'
      }}>
        {/* Canvas element will ocupy the positioned parent element. */}
        <Puffs
        color='hsla(180, 100%, 75%, 0.5)'
        quantity={20}
        zIndex={101}
        style={{ position: 'absolute', top: 0, left: 0, width: '100%', height: '100%' }}
        />
      </div>
    </Animator>
  );
};

createRoot(document.querySelector('#root')).render(<Sandbox />);
export default Sandbox;