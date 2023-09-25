import { Stage, Container, Sprite, Text, useApp } from "@pixi/react";
import { useState } from "react";
import Characters from "../Shared/Characters";
import * as PIXI from "pixi.js";
export const Battle = () => {
  const [app, setApp] = useState();

  return (
    <div className="">
      <Stage
        width={window.innerWidth}
        height={window.innerHeight}
        options={{
          backgroundColor: 0x00000,
          autoDensity: true,
          resizeTo: window,
        }}
      >
        <Container>
          <Text
            text={Characters.playerStatus.name}
            anchor={0.5}
            x={150}
            y={100}
            style={
              new PIXI.TextStyle({
                align: "center",
                fontFamily: '"Press Start 2P", cursive',
                fontSize: 20,
                fontWeight: "400",
                fill: ["#26f7a3", "#01d27e"],
                stroke: "#eef1f5",
              })
            }
          />
        </Container>

        <Container position={[50, 400]}>
          <Sprite
            anchor={0.5}
            x={150}
            y={150}
            image={Characters.playerStatus.img}
          />
        </Container>
          {/* opponent  */}
          <Container>
          <Text
            text={Characters.oponentStatus.name}
            anchor={0.5}
            x={1050}
            y={100}
            style={
              new PIXI.TextStyle({
                align: "center",
                fontFamily: '"Press Start 2P", cursive',
                fontSize: 20,
                fontWeight: "400",
                fill: ["#26f7a3", "#01d27e"],
                stroke: "#eef1f5",
              })
            }
          />
        </Container>
        <Container position={[900, 400]}>
          <Sprite
            anchor={0.5}
            x={150}
            y={150}
            image={Characters.oponentStatus.img}
          />
        </Container>
      </Stage>
    </div>
  );
};
