export const Battle = () => {
  return (
    <div>
      Battle
      <div className="flex justify-between">
        {/* PLAYER 1 */}
        <div>
          <h1 className="">Player 1</h1>

          {/* Angle data  fetching */}
          <div className="py-4">
            <h1>Angle: </h1>
            {/* input for data  */}
          </div>

          {/* Velocity data  fetching */}
          <div className="p">
            <h1>Velocity: </h1>
            {/* input for data  */}
          </div>
        </div>

        {/* PLAYER 2 */}
        <div>
          <h1 className="">Player 2</h1>

          {/* Angle data  fetching */}
          <div className="py-4">
            <h1>Angle: </h1>
          </div>

          {/* Velocity data  fetching */}
          <div className="p">
            <h1>Velocity: </h1>
          </div>
        </div>
      </div>
    </div>
  );
};
