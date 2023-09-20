import StartMenu from './UI/StartMenu';
import { Battle } from './UI/Battle';
import { useEffect, useState } from 'react';


export const App = () => {
  const [mode, setMode] = useState('start');

  useEffect(() => {
    if (mode === 'battle') {
      console.log(mode)
      // setWinner(undefined);
    }
  }, [mode]);



  return (
    <div className="">


      {mode === 'start' && (
        <StartMenu onStartClick={() => setMode('battle')} />
      )}


      {mode === 'battle' && ( <Battle /> )}
    </div>
  );
};