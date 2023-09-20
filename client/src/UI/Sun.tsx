import React, { useRef } from "react";
import { useFrame } from "@react-three/fiber";
import { Mesh } from "three";

const Sun: React.FC = () => {
  const sunRef = useRef<Mesh>();

  useFrame(() => {
    if (sunRef.current) {
      sunRef.current.rotation.x += 0.005;
      sunRef.current.rotation.y += 0.005;
      
    }
  });

 
  return (
    <mesh  ref={(sunRef as React.MutableRefObject<Mesh>)}>
      <sphereGeometry args={[1, 32, 32]} />
      <meshBasicMaterial color={0xffff00} />
    </mesh>
  );
};

export default Sun;
