/* /-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\ */
/* |                                                                         | */
/* \ @@@@@@@@  @@@  @@@  @@@@@@@  @@@@@@@    @@@@@@   @@@@@@@   @@@ @@@      / */
/* - @@@@@@@@  @@@@ @@@  @@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@ @@@      - */
/* / @@!       @@!@!@@@    @@!    @@!  @@@  @@!  @@@  @@!  @@@  @@! !@@      \ */
/* | !@!       !@!!@!@!    !@!    !@!  @!@  !@!  @!@  !@!  @!@  !@! @!!      | */
/* \ @!!!:!    @!@ !!@!    @!!    @!@!!@!   @!@  !@!  @!@@!@!    !@!@!       / */
/* - !!!!!:    !@!  !!!    !!!    !!@!@!    !@!  !!!  !!@!!!      @!!!       - */
/* / !!:       !!:  !!!    !!:    !!: :!!   !!:  !!!  !!:         !!:        \ */
/* | :!:       :!:  !:!    :!:    :!:  !:!  :!:  !:!  :!:         :!:        | */
/* \  :: ::::   ::   ::     ::    ::   :::  ::::: ::   ::          ::        / */
/* - : :: ::   ::    :      :      :   : :   : :  :    :           :         - */
/* /                                                                         \ */
/* |                                                                         | */
/* \ @@@  @@@  @@@   @@@@@@   @@@@@@@    @@@@@@   @@@  @@@  @@@  @@@@@@@     / */
/* - @@@  @@@  @@@  @@@@@@@@  @@@@@@@@  @@@@@@@   @@@  @@@  @@@  @@@@@@@@    - */
/* / @@!  @@!  @@!  @@!  @@@  @@!  @@@  !@@       @@!  @@@  @@!  @@!  @@@    \ */
/* | !@!  !@!  !@!  !@!  @!@  !@!  @!@  !@!       !@!  @!@  !@!  !@!  @!@    | */
/* \ @!!  !!@  @!@  @!@  !@!  @!@!!@!   !!@@!!    @!@!@!@!  !!@  @!@@!@!     / */
/* - !@!  !!!  !@!  !@!  !!!  !!@!@!     !!@!!!   !!!@!!!!  !!!  !!@!!!      - */
/* / !!:  !!:  !!:  !!:  !!!  !!: :!!        !:!  !!:  !!!  !!:  !!:         \ */
/* | :!:  :!:  :!:  :!:  !:!  :!:  !:!      !:!   :!:  !:!  :!:  :!:         | */
/* \  :::: :: :::   ::::: ::  ::   :::  :::: ::   ::   :::   ::   ::         / */
/* -   :: :  : :     : :  :    :   : :  :: : :     :   : :  :     :          - */
/* /                                                                         \ */
/* |                                                                         | */
/* \-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/|\-/ */

import * as THREE from "three";
import Stats from "three/addons/libs/stats.module.js";
import { GLTFLoader } from "three/addons/loaders/GLTFLoader.js";
import { Octree } from "three/addons/math/Octree.js";
import { Capsule } from "three/addons/math/Capsule.js";
import { Sky } from "three/addons/objects/Sky.js";

//*******************************************
// ENVIRONMENT SETUP
//*******************************************
// Add Sky to the scene
let sky; // Declare `sky` here to avoid ReferenceError
const sunPosition = new THREE.Vector3();
// Initialize the sky after scene and renderer are defined
function initializeSky() {
  sky = new Sky();
  sky.scale.setScalar(450000); // Scale the skybox
  scene.add(sky);
  // Define sky settings
  const effectController = {
    turbidity: 10,
    rayleigh: 3,
    mieCoefficient: 0.005,
    mieDirectionalG: 0.7,
    elevation: 0, // Elevation of the sun
    azimuth: 180, // Position of the sun (angle)
    exposure: 0.2011, // Ensure renderer is defined. was renderer.toneMappingExposure
  };
  // Function to update sky parameters
  function updateSky() {
    const uniforms = sky.material.uniforms;
    // Set sky parameters
    uniforms["turbidity"].value = effectController.turbidity;
    uniforms["rayleigh"].value = effectController.rayleigh;
    uniforms["mieCoefficient"].value = effectController.mieCoefficient;
    uniforms["mieDirectionalG"].value = effectController.mieDirectionalG;
    // Calculate sun position
    const phi = THREE.MathUtils.degToRad(90 - effectController.elevation);
    const theta = THREE.MathUtils.degToRad(effectController.azimuth);
    sunPosition.setFromSphericalCoords(1, phi, theta);
    uniforms["sunPosition"].value.copy(sunPosition);
    // Update renderer exposure
    renderer.toneMappingExposure = effectController.exposure;
    renderer.render(scene, camera);
  }
  // Call updateSky once to apply initial parameters
  updateSky();
}

const clock = new THREE.Clock();
const scene = new THREE.Scene();
scene.background = new THREE.Color(0x330000);
scene.fog = new THREE.Fog(0x88ccee, 0, 50);
const camera = new THREE.PerspectiveCamera(
  70,
  window.innerWidth / window.innerHeight,
  0.1,
  1000
);
camera.rotation.order = "YXZ";
const fillLight1 = new THREE.HemisphereLight(0x8dc1de, 0x00668d, 1.5);
fillLight1.position.set(2, 1, 1);
scene.add(fillLight1);
const directionalLight = new THREE.DirectionalLight(0xffffff, 2.5);
directionalLight.position.set(-5, 25, -1);
directionalLight.castShadow = true;
directionalLight.shadow.camera.near = 0.01;
directionalLight.shadow.camera.far = 500;
directionalLight.shadow.camera.right = 30;
directionalLight.shadow.camera.left = -30;
directionalLight.shadow.camera.top = 30;
directionalLight.shadow.camera.bottom = -30;
directionalLight.shadow.mapSize.width = 1024;
directionalLight.shadow.mapSize.height = 1024;
directionalLight.shadow.radius = 4;
directionalLight.shadow.bias = -0.00006;
scene.add(directionalLight);
const container = document.getElementById("container");
const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setPixelRatio(window.devicePixelRatio);
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setAnimationLoop(animate);
renderer.shadowMap.enabled = true;
renderer.shadowMap.type = THREE.VSMShadowMap;
renderer.toneMapping = THREE.ACESFilmicToneMapping;
container.appendChild(renderer.domElement);
const stats = new Stats();
stats.domElement.style.position = "absolute";
stats.domElement.style.top = "0px";
const GRAVITY = 30;
const STEPS_PER_FRAME = 5;
// Initialize Sky after setting up scene and renderer
initializeSky();
// Automatically cull objects outside the camera’s frustum
renderer.localClippingEnabled = true;
scene.traverse((child) => {
  if (child.isMesh) {
    child.frustumCulled = true; // Ensure each mesh respects the frustum
  }
});

const worldOctree = new Octree();
const playerCollider = new Capsule(
  new THREE.Vector3(0, 0.35, 0),
  new THREE.Vector3(0, 1, 0),
  0.35
);
const playerVelocity = new THREE.Vector3();
const playerDirection = new THREE.Vector3();
let playerOnFloor = false;
let mouseTime = 0;
const keyStates = {};
const vector1 = new THREE.Vector3();
const vector2 = new THREE.Vector3();
const vector3 = new THREE.Vector3();
const material = new THREE.ShaderMaterial({
  uniforms: {
    color: { value: new THREE.Color(0xff0000) },
  },
  vertexShader: `
      varying vec3 vPosition;
      void main() {
        vPosition = position;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,
  fragmentShader: `
      varying vec3 vPosition;
      uniform vec3 color;
      void main() {
        gl_FragColor = vec4(color * vPosition, 1.0);
      }
    `,
});

//*******************************************
// CONTROLS
//*******************************************
document.addEventListener("keydown", (event) => {
  keyStates[event.code] = true;
});
document.addEventListener("keyup", (event) => {
  keyStates[event.code] = false;
});
container.addEventListener("mousedown", () => {
  console.log("Mouse down detected, requesting pointer lock.");
  document.body.requestPointerLock();
});
// Add touchstart event to the canvas to handle jumping on mobile devices
container.addEventListener("touchstart", (event) => {
  // Prevent the default behavior (optional, depending on your use case)
  event.preventDefault();
  // Check if the player is on the floor before allowing the jump
  if (playerOnFloor) {
    playerVelocity.y = 14; // Jump strength
    console.log("Player jumped via canvas tap");
  }
});
document.addEventListener("pointerlockchange", () => {
  if (document.pointerLockElement === document.body) {
    console.log("Pointer lock activated.");
  } else {
    console.log("Pointer lock deactivated.");
  }
});
document.addEventListener("mouseup", () => {
  console.log("Mouse up detected");
});
document.body.addEventListener("mousemove", (event) => {
  if (document.pointerLockElement === document.body) {
    camera.rotation.y -= event.movementX / 500;
    camera.rotation.x -= event.movementY / 500;
    // Clamp vertical rotation
    camera.rotation.x = Math.max(
      -Math.PI / 2,
      Math.min(Math.PI / 2, camera.rotation.x)
    );
  } else {
    console.log("Pointer lock not active.");
  }
});
window.addEventListener("resize", onWindowResize);
function onWindowResize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
}

function playerCollisions() {
  const result = worldOctree.capsuleIntersect(playerCollider);
  playerOnFloor = false;
  if (result) {
    playerOnFloor = result.normal.y > 0;
    if (!playerOnFloor) {
      playerVelocity.addScaledVector(
        result.normal,
        -result.normal.dot(playerVelocity)
      );
    }
    if (result.depth >= 1e-10) {
      playerCollider.translate(result.normal.multiplyScalar(result.depth));
    }
  }
}

function updatePlayer(deltaTime) {
  let damping = Math.exp(-4 * deltaTime) - 1;
  if (!playerOnFloor) {
    playerVelocity.y -= GRAVITY * deltaTime;
    // small air resistance
    damping *= 0.1;
  }
  playerVelocity.addScaledVector(playerVelocity, damping);
  const deltaPosition = playerVelocity.clone().multiplyScalar(deltaTime);
  playerCollider.translate(deltaPosition);
  playerCollisions();
  camera.position.copy(playerCollider.end);
}

function getForwardVector() {
  camera.getWorldDirection(playerDirection);
  playerDirection.y = 0;
  playerDirection.normalize();
  return playerDirection;
}

function getSideVector() {
  camera.getWorldDirection(playerDirection);
  playerDirection.y = 0;
  playerDirection.normalize();
  playerDirection.cross(camera.up);
  return playerDirection;
}

function controls(deltaTime) {
  // gives a bit of air control
  const speedDelta = deltaTime * (playerOnFloor ? 25 : 8);
  if (keyStates["KeyW"]) {
    playerVelocity.add(getForwardVector().multiplyScalar(speedDelta));
  }
  if (keyStates["KeyS"]) {
    playerVelocity.add(getForwardVector().multiplyScalar(-speedDelta));
  }
  if (keyStates["KeyA"]) {
    playerVelocity.add(getSideVector().multiplyScalar(-speedDelta));
  }
  if (keyStates["KeyD"]) {
    playerVelocity.add(getSideVector().multiplyScalar(speedDelta));
  }
  if (playerOnFloor) {
    if (keyStates["Space"]) {
      playerVelocity.y = 14;
    }
  }
}
const leftJoystick = nipplejs.create({
  zone: document.getElementById("left-joystick"),
  mode: "static",
  position: { left: "70px", bottom: "70px" },
  color: "black",
});

const rightTouch = nipplejs.create({
  zone: document.getElementById("right-touch"),
  mode: "static",
  position: { right: "70px", bottom: "70px" },
  color: "black",
});

leftJoystick.on("move", (evt, data) => {
  if (data.direction) {
    const speedMultiplier = 0.1; // Slow down joystick movement
    const speed = 3 * speedMultiplier; // Adjust speed as needed
    switch (data.direction.angle) {
      case "up":
        playerVelocity.add(getForwardVector().multiplyScalar(speed));
        break;
      case "down":
        playerVelocity.add(getForwardVector().multiplyScalar(-speed));
        break;
      case "left":
        playerVelocity.add(getSideVector().multiplyScalar(-speed));
        break;
      case "right":
        playerVelocity.add(getSideVector().multiplyScalar(speed));
        break;
    }
  }
});

rightTouch.on("move", (evt, data) => {
  if (data.vector) {
    const cameraSensitivity = 3.0; // Increase this value for more sensitivity
    camera.rotation.y -= (data.vector.x / 100) * cameraSensitivity;
    camera.rotation.x -= (data.vector.y / 100) * cameraSensitivity;
    // Clamp vertical rotation
    camera.rotation.x = Math.max(
      -Math.PI / 2,
      Math.min(Math.PI / 2, camera.rotation.x)
    );
  }
});

// Prevent 'mouseup' or 'touchend' on the UI from triggering actions in the canvas
document.getElementById("closebutton").addEventListener("mouseup", (event) => {
  playButtonClickSound();
  event.stopPropagation(); // Prevent the event from propagating
});
document.getElementById("closebutton").addEventListener("touchend", (event) => {
  event.stopPropagation(); // Prevent the event from propagating
});

container.addEventListener("touchend", () => {
  console.log("Touch end detected");
});

let lastMove = Date.now();
leftJoystick.on("move", (evt, data) => {
  if (Date.now() - lastMove < 16) return; // Throttle to ~60 FPS
  lastMove = Date.now();
  // Handle movement...
});

if (isMobileDevice()) {
  console.log(
    "Mobile or touch-capable device detected: disabling pointer lock."
  );
} else {
  container.addEventListener("mousedown", () => {
    document.body.requestPointerLock();
  });
}

document.addEventListener("DOMContentLoaded", () => {
  // Select joystick and jump button elements
  const leftJoystick = document.getElementById("left-joystick");
  const rightTouch = document.getElementById("right-touch");
  const spanElement = document.getElementById("controlsui");

  if (!isMobileDevice()) {
    // Hide elements on non-mobile devices
    if (leftJoystick) leftJoystick.style.display = "none";
    if (rightTouch) rightTouch.style.display = "none";
    spanElement.style.display = "block";
  } else {
    spanElement.style.display = "none";
    console.log("Mobile device detected: Showing touch controls.");
  }
});

//*******************************************
// WORLD LOADER
//*******************************************
const loader = new GLTFLoader().setPath("/models/");
//const worldSelector = document.getElementById("worldSelector");
// Array to keep track of loaded models
let loadedModels = [];
//let worldLevel = 1;
let worldLevel = document.getElementById("world").textContent;
//let worldLevel = document.getElementById("world");
console.log(worldLevel);
// Function to process the loaded model
function processModel(gltf) {
  scene.add(gltf.scene); // Add the model to the scene
  worldOctree.fromGraphNode(gltf.scene); // Add to octree
  loadedModels.push(gltf); // Keep track of the loaded model
  gltf.scene.traverse((child) => {
    if (child.isMesh) {
      child.castShadow = true;
      child.receiveShadow = true;
      if (child.material.map) {
        child.material.map.anisotropy = 4;
      }
    }
  });
}

document.addEventListener("DOMContentLoaded", async () => {
  const loaderElement = document.getElementById("loader");
  const startButtonPanel = document.getElementById("start-button-panel");
  try {
    // Load the primary ground model first to avoid a fall loop
    loader
      .loadAsync("basicground.glb")
      .then((basicGroundGLTF) => {
        processModel(basicGroundGLTF);
        // Hide loader and show button once the model is processed
        loaderElement.style.display = "none";
        startButtonPanel.style.display = "block";
      })
      .catch((error) => {
        console.error("Error loading models:", error);
      });
  } catch (error) {
    console.error("Error loading models:", error);
  }
  try {
    loader
      .loadAsync("stargate.glb")
      .then((stargateGLTF) => {
        stargate = stargateGLTF.scene; // Assign to the outer variable
        // Set the model's position and scale to match the sprite
        stargate.position.set(0.5, 1.25, -13.5); // Match sprite position
        scene.add(stargate);
      })
      .catch((error) => {
        console.error("Error loading models:", error);
      });
  } catch (error) {
    console.error("Error loading models:", error);
  }
});

// Pre-Load the next set of models
let levelmodel1 = null; // Variable to store the loaded glb model
// Function to load glb and store it in memory
async function loadLevelModel1() {
  try {
    levelmodel1 = await loader.loadAsync("maze.glb");
    console.log("levelmodel1 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel1:", error);
  }
}
loadLevelModel1(); // Call the function to load glb in advance

let levelmodel2 = null;
async function loadLevelModel2() {
  try {
    levelmodel2 = await loader.loadAsync("icecave.glb");
    console.log("levelmodel2 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel2:", error);
  }
}
loadLevelModel2();

let levelmodel3 = null;
async function loadLevelModel3() {
  try {
    levelmodel3 = await loader.loadAsync("labyrinth.glb");
    console.log("levelmodel3 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel3:", error);
  }
}
loadLevelModel3();

let levelmodel4 = null;
async function loadLevelModel4() {
  try {
    levelmodel4 = await loader.loadAsync("suspendedrocks.glb");
    console.log("levelmodel4 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel4:", error);
  }
}
loadLevelModel4();

let levelmodel5 = null;
async function loadLevelModel5() {
  try {
    levelmodel5 = await loader.loadAsync("alientubes.glb");
    console.log("levelmodel5 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel5:", error);
  }
}
loadLevelModel5();

let levelmodel6 = null;
async function loadLevelModel6() {
  try {
    levelmodel6 = await loader.loadAsync("disc.glb");
    console.log("levelmodel6 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel6:", error);
  }
}
loadLevelModel6();

let levelmodel7 = null;
async function loadLevelModel7() {
  try {
    levelmodel7 = await loader.loadAsync("suspendedicerocks.glb");
    console.log("levelmodel7 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel7:", error);
  }
}
loadLevelModel7();

let levelmodel8 = null;
async function loadLevelModel8() {
  try {
    levelmodel8 = await loader.loadAsync("tiltedlaby.glb");
    console.log("levelmodel8 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel8:", error);
  }
}
loadLevelModel8();

let levelmodel9 = null;
async function loadLevelModel9() {
  try {
    levelmodel9 = await loader.loadAsync("sidemaze.glb");
    console.log("levelmodel9 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel9:", error);
  }
}
loadLevelModel9();

let levelmodel10 = null;
async function loadLevelModel10() {
  try {
    levelmodel10 = await loader.loadAsync("club.glb");
    console.log("levelmodel10 loaded and ready for initialization.");
  } catch (error) {
    console.error("Error loading levelmodel10:", error);
  }
}
loadLevelModel10();

// let stargate2 = null;
// async function loadStarGate2() {
//   try {
//     stargate2 = await loader.loadAsync("stargate2.glb");
//     console.log("stargate2 loaded and ready for initialization.");
//   } catch (error) {
//     console.error("Error loading stargate2:", error);
//   }
// }
// loadStarGate2();

//*******************************************
// STARGATE AND SPRITE LOADER - GAME PROGRESSION LOGIC
//*******************************************
const spriteMaterial = new THREE.SpriteMaterial({
  map: new THREE.TextureLoader().load("images/blackhole.png"),
  transparent: true,
  opacity: 0.5,
});
const sprite = new THREE.Sprite(spriteMaterial);
sprite.position.set(0.5, 1.25, -13.5); // Same position as the model
sprite.scale.set(3.25, 3.25, 3.25); // Uniform scale
scene.add(sprite);
let stargate; // Declare the stargate variable in the outer scope

// Function to check collision
function checkCollisionWithCamera(camera, sprite) {
  const cameraPosition = camera.position.clone();
  const spritePosition = sprite.position.clone();
  // Check the distance between the camera and the sprite
  const distance = cameraPosition.distanceTo(spritePosition);
  // Consider a threshold for collision detection
  const collisionThreshold = 1; // Adjust as needed
  return distance < collisionThreshold;
}
if ((worldLevel = 1)) {
  function animateSprite1() {
    requestAnimationFrame(animateSprite1);
    // Check for collision
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite); // Remove the sprite
      stargate.position.set(7, 1, 1.3); // Move the stargate
      playStartSound();
      // Initialize glb if it hasn't been added yet
      if (levelmodel1) {
        console.log("Initializing levelmodel1...");
        processModel(levelmodel1); // Add and process the model
        levelmodel1 = null; // Prevent re-initialization
        incrementValue(); // Update World Level
        increaseHealth(); // Update Health Level
        // Add a second sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        worldLevel = 2;
        console.log("World Level: " + worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite1();
}
if ((worldLevel = 2)) {
  // WORLD 2
  function animateSprite2() {
    requestAnimationFrame(animateSprite2);
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite);
      stargate.position.set(-16.75, 1.04, 41.65);
      playStartSound();
      if (levelmodel2) {
        console.log("Initializing levelmodel2...");
        processModel(levelmodel2);
        levelmodel2 = null;
        incrementValue();
        increaseHealth();
        // Add a third sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        worldLevel = 3;
        console.log("World Level: " + worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite2();
}
if ((worldLevel = 3)) {
  // WORLD 3
  function animateSprite3() {
    requestAnimationFrame(animateSprite3);
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite);
      stargate.position.set(10.9, 3.73, 9.15);
      playStartSound();
      if (levelmodel3) {
        console.log("Initializing levelmodel3...");
        processModel(levelmodel3);
        levelmodel3 = null;
        incrementValue();
        increaseHealth();
        // Add a forth sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        worldLevel = 4;
        console.log("World Level: " + worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite3();
}
if ((worldLevel = 4)) {
  // WORLD 4
  function animateSprite4() {
    requestAnimationFrame(animateSprite4);
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite);
      stargate.position.set(1.53, 12.95, 32.69);
      playStartSound();
      if (levelmodel4) {
        console.log("Initializing levelmodel4...");
        processModel(levelmodel4);
        levelmodel4 = null;
        incrementValue();
        increaseHealth();
        // Add a fifth sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        worldLevel = 5;
        console.log("World Level: " + worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite4();
}
if ((worldLevel = 5)) {
  // WORLD 5
  function animateSprite5() {
    requestAnimationFrame(animateSprite5);
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite);
      stargate.position.set(-12.15, 15.53, 33.6);
      playStartSound();
      if (levelmodel5) {
        console.log("Initializing levelmodel5...");
        processModel(levelmodel5);
        levelmodel5 = null;
        incrementValue();
        increaseHealth();
        // Add a sixth sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        worldLevel = 6;
        console.log("World Level: " + worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite5();
}
if ((worldLevel = 6)) {
  // WORLD 6
  function animateSprite6() {
    requestAnimationFrame(animateSprite6);
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite);
      stargate.position.set(-36.79, 13.97, 33.4);
      playStartSound();
      if (levelmodel6) {
        console.log("Initializing levelmodel6...");
        processModel(levelmodel6);
        levelmodel6 = null;
        incrementValue();
        // Add a seventh sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        // WORLD 7
        worldLevel = 7;
        console.log("World Level: " + worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite6();
}
if ((worldLevel = 7)) {
  // WORLD 6
  function animateSprite6() {
    requestAnimationFrame(animateSprite6);
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite);
      stargate.position.set(-13.8, -19.75, -8.64);
      playStartSound();
      if (levelmodel7) {
        console.log("Initializing levelmodel7...");
        processModel(levelmodel7);
        levelmodel7 = null;
        incrementValue();
        // Add a seventh sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        // WORLD 8
        worldLevel = 8;
        console.log("World Level: " + worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite6();
}
if ((worldLevel = 8)) {
  function animateSprite7() {
    requestAnimationFrame(animateSprite7);
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite);
      stargate.position.set(1.89, 0.32, -32.03);
      playStartSound();
      if (levelmodel8) {
        console.log("Initializing levelmodel8...");
        processModel(levelmodel8);
        levelmodel8 = null;
        incrementValue();
        // Add a eigth sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        // WORLD 9
        worldLevel = 9;
        console.log(worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite7();
}
if ((worldLevel = 9)) {
  function animateSprite8() {
    requestAnimationFrame(animateSprite8);
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite);
      stargate.position.set(-80.9, 23.56, -45.76);
      playStartSound();
      if (levelmodel9) {
        console.log("Initializing levelmodel9...");
        processModel(levelmodel9);
        levelmodel9 = null;
        incrementValue();
        // Add a eigth sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        // WORLD 9
        worldLevel = 10;
        console.log(worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite8();
}

if ((worldLevel = 10)) {
  function animateSprite9() {
    requestAnimationFrame(animateSprite9);
    if (checkCollisionWithCamera(camera, sprite)) {
      scene.remove(sprite);
      stargate.position.set(3.81, 1.69, -72.27);
      playStartSound();
      if (levelmodel10) {
        console.log("Initializing levelmodel10...");
        processModel(levelmodel10);
        levelmodel10 = null;
        incrementValue();
        // Add a eigth sprite
        sprite.position.copy(stargate.position);
        scene.add(sprite);
        // WORLD 9
        worldLevel = 11;
        console.log(worldLevel);
      }
    }
    // Update renderer and controls
    renderer.render(scene, camera);
  }
  // Start animation loop
  animateSprite9();
}

if ((worldLevel = 11)) {
  // GAME END logic
  function animateSprite8() {
    requestAnimationFrame(animateSprite8);
    if (checkCollisionWithCamera(camera, sprite)) {
      playStartSound();
      scene.remove(sprite);
      scene.remove(stargate);
      //showGameOverPopup();
    }
  }
  animateSprite8();
}

// //*******************************************
// // WORLD SELECTOR
// //*******************************************
// // Add event listener to the selector after basicground.glb is loaded
// worldSelector.addEventListener("change", (event) => {
//   playButtonClickSound();
//   const selectedValue = event.target.value;

//   if (selectedValue === "0") {
//     loader
//       .loadAsync("basicground.glb")
//       .then((groundGLTF) => processModel(groundGLTF))
//       .catch((error) => console.error("Error loading models:", error));
//     loader
//       .loadAsync("maze.glb")
//       .then((mazeGLTF) => processModel(mazeGLTF))
//       .catch((error) => console.error("Error loading models:", error));
//   } else if (selectedValue === "1") {
//     // loader
//     //   .loadAsync("ground.glb")
//     //   .then((groundGLTF) => processModel(groundGLTF))
//     //   .catch((error) => console.error("Error loading models:", error));
//     loader
//       .loadAsync("warehouse.glb")
//       .then((mazeGLTF) => processModel(mazeGLTF))
//       .catch((error) => console.error("Error loading models:", error));
//   } else if (selectedValue === "2") {
//     loader
//       .loadAsync("ground.glb")
//       .then((groundGLTF) => processModel(groundGLTF))
//       .catch((error) => console.error("Error loading models:", error));
//     loader
//       .loadAsync("labywrinth.glb")
//       .then((mazeGLTF) => processModel(mazeGLTF))
//       .catch((error) => console.error("Error loading models:", error));
//   } else if (selectedValue === "3") {
//     // loader
//     //   .loadAsync("basicground.glb")
//     //   .then((groundGLTF) => processModel(groundGLTF))
//     //   .catch((error) => console.error("Error loading models:", error));
//     loader
//       .loadAsync("sidemaze.glb")
//       .then((mazeGLTF) => processModel(mazeGLTF))
//       .catch((error) => console.error("Error loading models:", error));
//   } else if (selectedValue === "4") {
//     // loader
//     //   .loadAsync("ground.glb")
//     //   .then((groundGLTF) => processModel(groundGLTF))
//     //   .catch((error) => console.error("Error loading models:", error));
//     loader
//       .loadAsync("tiltedlaby.glb")
//       .then((mazeGLTF) => processModel(mazeGLTF))
//       .catch((error) => console.error("Error loading models:", error));
//   } else if (selectedValue === "5") {
//     // loader
//     //   .loadAsync("ground.glb")
//     //   .then((groundGLTF) => processModel(groundGLTF))
//     //   .catch((error) => console.error("Error loading models:", error));
//     loader
//       .loadAsync("club.glb")
//       .then((mazeGLTF) => processModel(mazeGLTF))
//       .catch((error) => console.error("Error loading models:", error));
//   }
// });

//*******************************************
// STATS UI LOGIC
//*******************************************
// Timer setup
const timerElement = document.getElementById("timer");
let startTime = Date.now();
let timerInterval;

// Function to start the timer
function startTimer() {
  timerInterval = setInterval(() => {
    const elapsedTime = Math.floor((Date.now() - startTime) / 1000);
    timerElement.textContent = elapsedTime;
  }, 1000);
}
startTimer(); // Start the timer when the game starts
const startButton = document.getElementById("start-button");
const fallsElement = document.getElementById("falls");
const healthElement = document.getElementById("health");
const worldElement = document.getElementById("world");
let fallCount = 0; // Initialize the fall counter
function teleportPlayerIfOob() {
  // Check if the player is out of bounds
  if (camera.position.y <= -25) {
    // Increment the fall count
    playDeathSound();
    fallCount++;
    fallsElement.textContent = fallCount;
    // Decrease the health meter after a fall
    const healthElement = document.getElementById("health");
    let currentHealth = parseInt(healthElement.textContent, 10);
    if (!isNaN(currentHealth) && currentHealth > 0) {
      currentHealth -= 1;
      healthElement.textContent = currentHealth;
    }
    if (currentHealth === 0) {
      // Check if health reaches 0
      showGameOverPopup();
      return; // Exit function to prevent resetting the player's position
    }
    // Reset player position and rotation
    playerCollider.start.set(0, 0.35, 0);
    playerCollider.end.set(0, 1, 0);
    playerCollider.radius = 0.35;
    camera.position.copy(playerCollider.end);
    camera.rotation.set(0, 0, 0);
  }
}
// Increase the level each time this function is called
function incrementValue() {
  const div = document.getElementById("world");
  const currentValue = parseInt(div.textContent, 10);
  if (!isNaN(currentValue)) {
    div.textContent = currentValue + 1;
  } else {
    console.error("The value inside the div is not a valid number.");
  }
}
function increaseHealth() {
  const healthElement = document.getElementById("health");
  let currentHealth = parseInt(healthElement.textContent, 10);
  if (!isNaN(currentHealth)) {
    healthElement.textContent = currentHealth + 1;
  } else {
    console.error("The health value is not a valid number.");
  }
}
function logCameraPosition() {
  const { x, y, z } = camera.position;
  console.log(
    `Camera Position: x=${x.toFixed(2)}, y=${y.toFixed(2)}, z=${z.toFixed(2)}`
  );
  document.getElementById("x").textContent = x.toFixed(2);
  document.getElementById("y").textContent = y.toFixed(2);
  document.getElementById("z").textContent = z.toFixed(2);
}
setInterval(logCameraPosition, 1000); // logCameraPosition periodically

// Add an event listener for the "Start" button click
startButton.addEventListener("click", () => {
  fallsElement.textContent = "0";
  healthElement.textContent = "1";
  worldElement.textContent = "1";
  console.log("Deaths reset to 0");
});
// Volume slider functionality
const volumeSlider = document.getElementById("volume-slider");
volumeSlider.addEventListener("input", (event) => {
  const volume = parseFloat(event.target.value);
  gainNode.gain.setValueAtTime(volume, audioContext.currentTime);
});
// Starting screen
// Hide the start screen and initialize the game
document.getElementById("start-button").addEventListener("click", () => {
  playStartSound();
  document.getElementById("start-screen").style.display = "none";
  startGame();
});

// Game initialization function
function startGame() {
  console.log("Game started!");
  // Start animations, audio, or gameplay mechanics
  setupAudio(); // Start background audio if not already running
}

//*******************************************
// GAME OVER POPUP
//*******************************************
function showGameOverPopup() {
  // First reset the game to avoid a loop
  resetGame();
  // Create the popup container
  const popup = document.createElement("div");
  popup.id = "game-over-popup";
  popup.style.position = "fixed";
  popup.style.top = "0";
  popup.style.left = "0";
  popup.style.width = "100%";
  popup.style.height = "100%";
  popup.style.backgroundColor = "rgba(0, 0, 0, 0.8)";
  popup.style.color = "#fff";
  popup.style.display = "flex";
  popup.style.flexDirection = "column";
  popup.style.justifyContent = "center";
  popup.style.alignItems = "center";
  popup.style.zIndex = "9999";
  // Add message to the popup
  const message = document.createElement("h1");
  message.textContent = "Game Over";
  message.style.marginBottom = "20px";
  popup.appendChild(message);
  // Add restart button to the popup
  const restartButton = document.createElement("button");
  restartButton.textContent = "Restart";
  restartButton.classList.add("button", "alert", "round");
  restartButton.style.padding = "10px 20px";
  restartButton.style.cursor = "pointer";
  restartButton.addEventListener("click", () => {
    // Restart game logic
    popup.remove(); // Remove the popup
    location.reload();
  });
  popup.appendChild(restartButton);
  // Append the popup to the body
  document.body.appendChild(popup);
}

function resetGame() {
  const healthElement = document.getElementById("health");
  const fallsElement = document.getElementById("falls");
  const worldElement = document.getElementById("world");
  healthElement.textContent = "5"; // Reset health to full
  fallsElement.textContent = "0"; // Reset falls to 0
  worldElement.textContent = "1"; // Reset falls to 0
  fallCount = 0; // Reset fall count
  playerCollider.start.set(0, 0.35, 0);
  playerCollider.end.set(0, 1, 0);
  playerCollider.radius = 0.35;
  camera.position.copy(playerCollider.end);
  camera.rotation.set(0, 0, 0);
  startTime = Date.now(); // Reset timer
}

//*******************************************
// ROTATE DEVICE PROMPT
//*******************************************
// Prompt to rotate device
// Function to detect if the device is a mobile device
function isMobileDevice() {
  return (
    /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini|Mobile/i.test(
      navigator.userAgent
    ) ||
    (navigator.maxTouchPoints > 1 && /Macintosh/i.test(navigator.userAgent))
  );
}

// Function to show a rotate popup
function showRotatePopup() {
  const popup = document.createElement("div");
  popup.id = "rotate-popup";
  popup.style.position = "fixed";
  popup.style.top = "0";
  popup.style.left = "0";
  popup.style.width = "100%";
  popup.style.height = "100%";
  popup.style.backgroundColor = "#000";
  popup.style.color = "#fff";
  popup.style.display = "flex";
  popup.style.flexDirection = "column";
  popup.style.justifyContent = "center";
  popup.style.alignItems = "center";
  popup.style.zIndex = "9999";
  const ewlogo = document.createElement("h1");
  ewlogo.textContent = "ENTROPY WORSHIP";
  ewlogo.style.fontSize = "1.5rem";
  ewlogo.style.textAlign = "center";
  ewlogo.className = "heading display-6";
  ewlogo.style.margin = "0 20px";
  const heading = document.createElement("h2");
  heading.textContent = "deityengine";
  heading.style.fontSize = "1.5rem";
  heading.style.textAlign = "center";
  heading.style.margin = "0 20px";
  const message = document.createElement("p");
  message.textContent = ">rotate device to landscape mode";
  message.style.fontSize = "20px";
  message.style.fontFamily = "VT323-Regular";
  message.style.textAlign = "center";
  message.style.margin = "0 20px";
  message.className = "cyber-glitch-1 panel error shown";
  const space = document.createElement("br");
  popup.appendChild(ewlogo);
  popup.appendChild(heading);
  popup.appendChild(space);
  popup.appendChild(message);
  document.body.appendChild(popup);
}
// Function to check screen orientation and handle popup
function handleOrientationChange() {
  const popup = document.getElementById("rotate-popup");
  if (window.innerWidth < window.innerHeight) {
    // Portrait mode
    if (!popup) {
      showRotatePopup();
    }
  } else {
    // Landscape mode
    if (popup) {
      popup.remove();
    }
  }
}
// Run on load if the device is mobile
if (isMobileDevice()) {
  window.addEventListener("resize", handleOrientationChange);
  handleOrientationChange();
}

//*******************************************
// AUDIO SETUP
//*******************************************
const audioContext = new (window.AudioContext || window.webkitAudioContext)();
const gainNode = audioContext.createGain();
gainNode.gain.value = 0.5; // Default volume
let audioSource;
// Default start game audio
const audioFile = "samples/sticks.mp3";
// Load and play audio sample in a loop
async function setupAudio() {
  try {
    const response = await fetch(audioFile);
    if (!response.ok) {
      throw new Error(`Failed to load audio file: ${audioFile}`);
    }
    const arrayBuffer = await response.arrayBuffer();
    const audioBuffer = await audioContext.decodeAudioData(arrayBuffer);

    // Create a single audio source
    if (audioSource) {
      audioSource.stop(); // Stop the previous source if any
    }

    audioSource = audioContext.createBufferSource();
    audioSource.buffer = audioBuffer;
    audioSource.loop = true; // Enable looping
    audioSource.connect(gainNode).connect(audioContext.destination);
    audioSource.start(0); // Start the audio
  } catch (error) {
    console.error("Error setting up audio:", error);
  }
}
// UI button click audio
const buttonClick = "samples/button.mp3";
// Function to play button click sound through the main audio context
async function playButtonClickSound() {
  try {
    const response = await fetch(buttonClick);
    if (!response.ok) {
      throw new Error(`Failed to load audio file: ${buttonClick}`);
    }
    const arrayBuffer = await response.arrayBuffer();
    const audioBuffer = await audioContext.decodeAudioData(arrayBuffer);

    // Create a new audio source for the button sound
    const buttonAudioSource = audioContext.createBufferSource();
    buttonAudioSource.buffer = audioBuffer;
    buttonAudioSource.connect(gainNode).connect(audioContext.destination);
    buttonAudioSource.start(0); // Play the sound
  } catch (error) {
    console.error("Error playing button click sound:", error);
  }
}
// Death sound
const deathSound = "samples/mechaglitch.mp3";
// Function to play button click sound through the main audio context
async function playDeathSound() {
  try {
    const response = await fetch(deathSound);
    if (!response.ok) {
      throw new Error(`Failed to load audio file: ${deathSound}`);
    }
    const arrayBuffer = await response.arrayBuffer();
    const audioBuffer = await audioContext.decodeAudioData(arrayBuffer);

    // Create a new audio source for the button sound
    const deathAudioSource = audioContext.createBufferSource();
    deathAudioSource.buffer = audioBuffer;
    deathAudioSource.connect(gainNode).connect(audioContext.destination);
    deathAudioSource.start(0); // Play the sound
  } catch (error) {
    console.error("Error playing death sound:", error);
  }
}
// Start sound
const startSound = "samples/alienbleep.mp3";
// Function to play button click sound through the main audio context
async function playStartSound() {
  try {
    const response = await fetch(startSound);
    if (!response.ok) {
      throw new Error(`Failed to load audio file: ${startSound}`);
    }
    const arrayBuffer = await response.arrayBuffer();
    const audioBuffer = await audioContext.decodeAudioData(arrayBuffer);
    // Create a new audio source for the button sound
    const startAudioSource = audioContext.createBufferSource();
    startAudioSource.buffer = audioBuffer;
    startAudioSource.connect(gainNode).connect(audioContext.destination);
    startAudioSource.start(0); // Play the sound
  } catch (error) {
    console.error("Error playing start sound:", error);
  }
}
// Ensure audio context is resumed after a user gesture
document.body.addEventListener("click", () => {
  if (audioContext.state === "suspended") {
    audioContext.resume().then(() => {
      console.log("Audio context resumed");
      setupAudio(); // Load and play audio
    });
  }
});

//*******************************************
// ANIMATE
//*******************************************
function animate() {
  const deltaTime = Math.min(0.05, clock.getDelta()) / STEPS_PER_FRAME;
  // look for collisions in substeps to mitigate the risk of
  // an object traversing another too quickly for detection.
  for (let i = 0; i < STEPS_PER_FRAME; i++) {
    controls(deltaTime);
    updatePlayer(deltaTime);
    //updateSpheres( deltaTime );
    teleportPlayerIfOob();
    //checkCollisionWithSprite();
  }
  renderer.render(scene, camera);
  stats.update();
}
