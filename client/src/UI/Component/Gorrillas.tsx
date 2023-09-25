import '/ApeThrow.json';
import ApeThrow from 'src/assets/ApeThrow/apeThrow.png'
import * as PIXI from "pixi.js";
 

const Gorilla1 = async () => {
  
  const spritesheet = new PIXI.Spritesheet(
    PIXI.BaseTexture.from(ApeThrow.meta.image),
    ApeThrow
  );

  await spritesheet.parse();
  const anim = new PIXI.AnimatedSprite(spritesheet.animations.Ape);
  anim.animationSpeed = 0.1666;
  anim.play();
  //   add it to the stage to render
  const app = new PIXI.Application({ width: 640, height: 360 });
  app.stage.addChild(anim);
};
export default Gorilla1;
