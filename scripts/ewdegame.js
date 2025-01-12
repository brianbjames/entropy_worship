import * as THREE from "three";
import Stats from "three/addons/libs/stats.module.js";
import { GLTFLoader } from "three/addons/loaders/GLTFLoader.js";
import { Octree } from "three/addons/math/Octree.js";
import { Capsule } from "three/addons/math/Capsule.js";
import { Sky } from "three/addons/objects/Sky.js";

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
    elevation: 2, // Elevation of the sun
    azimuth: 180, // Position of the sun (angle)
    exposure: renderer.toneMappingExposure, // Ensure renderer is defined
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
// Ensure shaders are not overly complex and use only necessary calculations
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

//*******************************************
// LOADER
//*******************************************
const loader = new GLTFLoader().setPath("/models/");
const worldSelector = document.getElementById("worldSelector");
// Array to keep track of loaded models
let loadedModels = [];

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
// Function to dispose other models
/* function disposeModels(scene, collisionObjects) {
  loadedModels.forEach((model) => {
    // Remove physics body from the physics world
    if (model.physicsBody && physicsWorld) {
      physicsWorld.remove(model.physicsBody);
      model.physicsBody = null; // Clear reference to physics body
      console.log("Physics body removed");
    }

    // Dispose the model's scene and its children
    if (model.scene) {
      model.scene.traverse((child) => {
        if (child.isMesh) {
          // Dispose geometry
          if (child.geometry) {
            child.geometry.dispose();
            console.log("Geometry disposed");
          }

          // Dispose materials and associated textures
          if (child.material) {
            if (Array.isArray(child.material)) {
              child.material.forEach((mat) => {
                if (mat.map) {
                  if (mat.map.image instanceof ImageBitmap) {
                    mat.map.image.close(); // Close ImageBitmap
                    console.log("ImageBitmap closed");
                  }
                  mat.map.dispose();
                }
                if (mat.normalMap) {
                  if (mat.normalMap.image instanceof ImageBitmap) {
                    mat.normalMap.image.close(); // Close ImageBitmap
                    console.log("NormalMap ImageBitmap closed");
                  }
                  mat.normalMap.dispose();
                }
                if (mat.roughnessMap) {
                  if (mat.roughnessMap.image instanceof ImageBitmap) {
                    mat.roughnessMap.image.close(); // Close ImageBitmap
                    console.log("RoughnessMap ImageBitmap closed");
                  }
                  mat.roughnessMap.dispose();
                }
                mat.dispose();
              });
            } else {
              if (child.material.map) {
                if (child.material.map.image instanceof ImageBitmap) {
                  child.material.map.image.close(); // Close ImageBitmap
                  console.log("ImageBitmap closed");
                }
                child.material.map.dispose();
              }
              if (child.material.normalMap) {
                if (child.material.normalMap.image instanceof ImageBitmap) {
                  child.material.normalMap.image.close(); // Close ImageBitmap
                  console.log("NormalMap ImageBitmap closed");
                }
                child.material.normalMap.dispose();
              }
              if (child.material.roughnessMap) {
                if (child.material.roughnessMap.image instanceof ImageBitmap) {
                  child.material.roughnessMap.image.close(); // Close ImageBitmap
                  console.log("RoughnessMap ImageBitmap closed");
                }
                child.material.roughnessMap.dispose();
              }
              child.material.dispose();
            }
            console.log("Material disposed");
          }
        }
      });

      // Remove the model's scene from the main scene
      scene.remove(model.scene);
    }
  });

  // Dispose of collision objects if provided
  if (collisionObjects && Array.isArray(collisionObjects)) {
    collisionObjects.forEach((obj) => {
      // Remove collision object from physics world
      if (obj.physicsBody && physicsWorld) {
        physicsWorld.remove(obj.physicsBody);
        console.log("Collision physics body removed");
      }

      // Dispose geometry and material
      if (obj.geometry) {
        obj.geometry.dispose();
        console.log("Collision geometry disposed");
      }
      if (obj.material) {
        if (obj.material.map && obj.material.map.image instanceof ImageBitmap) {
          obj.material.map.image.close(); // Close ImageBitmap
          console.log("Collision object ImageBitmap closed");
        }
        obj.material.dispose();
        console.log("Collision material disposed");
      }

      // Remove from scene
      scene.remove(obj);
      console.log("Collision object removed from scene");
    });
  }

  // Clear the loadedModels array
  loadedModels = [];
  console.log("All models disposed and removed from the scene.");

  // Check renderer memory usage and clear render lists
  if (renderer) {
    console.log("Renderer info after disposal:", renderer.info);
    renderer.renderLists?.dispose();
  }
} */

// Load the primary ground model first
loader
  .loadAsync("basicground.glb")
  .then((groundGLTF) => {
    processModel(groundGLTF);
  })
  .catch((error) => {
    console.error("Error loading models:", error);
  });
loader
  .loadAsync("maze.glb")
  .then((groundGLTF) => {
    processModel(groundGLTF);
  })
  .catch((error) => {
    console.error("Error loading models:", error);
  });

//*******************************************
// WORLD SELECTOR
//*******************************************
// Add event listener to the selector after basicground.glb is loaded
worldSelector.addEventListener("change", (event) => {
  playButtonClickSound();
  const selectedValue = event.target.value;

  if (selectedValue === "0") {
    loader
      .loadAsync("basicground.glb")
      .then((groundGLTF) => processModel(groundGLTF))
      .catch((error) => console.error("Error loading models:", error));
    loader
      .loadAsync("maze.glb")
      .then((mazeGLTF) => processModel(mazeGLTF))
      .catch((error) => console.error("Error loading models:", error));
  } else if (selectedValue === "1") {
    // loader
    //   .loadAsync("ground.glb")
    //   .then((groundGLTF) => processModel(groundGLTF))
    //   .catch((error) => console.error("Error loading models:", error));
    loader
      .loadAsync("warehouse.glb")
      .then((mazeGLTF) => processModel(mazeGLTF))
      .catch((error) => console.error("Error loading models:", error));
  } else if (selectedValue === "2") {
    loader
      .loadAsync("ground.glb")
      .then((groundGLTF) => processModel(groundGLTF))
      .catch((error) => console.error("Error loading models:", error));
    loader
      .loadAsync("labywrinth.glb")
      .then((mazeGLTF) => processModel(mazeGLTF))
      .catch((error) => console.error("Error loading models:", error));
  } else if (selectedValue === "3") {
    // loader
    //   .loadAsync("basicground.glb")
    //   .then((groundGLTF) => processModel(groundGLTF))
    //   .catch((error) => console.error("Error loading models:", error));
    loader
      .loadAsync("sidemaze.glb")
      .then((mazeGLTF) => processModel(mazeGLTF))
      .catch((error) => console.error("Error loading models:", error));
  } else if (selectedValue === "4") {
    // loader
    //   .loadAsync("ground.glb")
    //   .then((groundGLTF) => processModel(groundGLTF))
    //   .catch((error) => console.error("Error loading models:", error));
    loader
      .loadAsync("tiltedlaby.glb")
      .then((mazeGLTF) => processModel(mazeGLTF))
      .catch((error) => console.error("Error loading models:", error));
  } else if (selectedValue === "5") {
    // loader
    //   .loadAsync("ground.glb")
    //   .then((groundGLTF) => processModel(groundGLTF))
    //   .catch((error) => console.error("Error loading models:", error));
    loader
      .loadAsync("club.glb")
      .then((mazeGLTF) => processModel(mazeGLTF))
      .catch((error) => console.error("Error loading models:", error));
  }
});

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

// Function to stop the timer
function stopTimer() {
  clearInterval(timerInterval);
}

// Start the timer when the game starts
startTimer();

// Select the "Falls" counter element
const startButton = document.getElementById("start-button");
const fallsElement = document.getElementById("falls");
let fallCount = 0; // Initialize the fall counter
function teleportPlayerIfOob() {
  // Check if the player is out of bounds
  if (camera.position.y <= -25) {
    // Increment the fall count
    fallCount++;
    fallsElement.textContent = fallCount;
    // Decrease the health meter after a fall
    const healthElement = document.getElementById("health");
    let currentHealth = parseInt(healthElement.textContent, 10);
    if (!isNaN(currentHealth) && currentHealth > 0) {
      currentHealth -= 1;
      healthElement.textContent = currentHealth;
    }
    // Check if health reaches 0
    if (currentHealth === 0) {
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

// Add an event listener for the "Start" button click
startButton.addEventListener("click", () => {
  playButtonClickSound();
  // Reset the fall count to 0
  fallsElement.textContent = "0";
  console.log("Deaths reset to 0");
});

function showGameOverPopup() {
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
  restartButton.classList.add("button", "alert");
  restartButton.style.padding = "10px 20px";
  restartButton.style.cursor = "pointer";
  restartButton.addEventListener("click", () => {
    // Restart game logic
    popup.remove(); // Remove the popup
    resetGame(); // Call a resetGame function to reset game state
  });
  popup.appendChild(restartButton);

  // Append the popup to the body
  document.body.appendChild(popup);
}

function resetGame() {
  // Reset health, falls, and player position
  const healthElement = document.getElementById("health");
  const fallsElement = document.getElementById("falls");
  //const coinsElement = document.getElementById("coins");

  healthElement.textContent = "20"; // Reset health to full
  fallsElement.textContent = "0"; // Reset falls to 0
  fallCount = 0; // Reset fall count
  //coinsElement.textContent = '0'; // Reset falls to 0

  playerCollider.start.set(0, 0.35, 0);
  playerCollider.end.set(0, 1, 0);
  playerCollider.radius = 0.35;
  camera.position.copy(playerCollider.end);
  camera.rotation.set(0, 0, 0);

  startTime = Date.now(); // Reset timer
}

function animate() {
  const deltaTime = Math.min(0.05, clock.getDelta()) / STEPS_PER_FRAME;
  // we look for collisions in substeps to mitigate the risk of
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

// Automatically cull objects outside the camera’s frustum
renderer.localClippingEnabled = true; // Enable clipping
scene.traverse((child) => {
  if (child.isMesh) {
    child.frustumCulled = true; // Ensure each mesh respects the frustum
  }
});

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
    const speedMultiplier = 0.11; // Slow down joystick movement
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
    const cameraSensitivity = 3.5; // Increase this value for more sensitivity
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
  playButtonClickSound();
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

if (/Mobi|Android/i.test(navigator.userAgent)) {
  console.log("Mobile device detected: disabling pointer lock.");
  // Disable pointer lock for mobile or handle touch controls instead
} else {
  container.addEventListener("mousedown", () => {
    document.body.requestPointerLock();
  });
}

document.addEventListener("DOMContentLoaded", () => {
  const isMobile = /Mobi|Android/i.test(navigator.userAgent);

  // Select joystick and jump button elements
  const leftJoystick = document.getElementById("left-joystick");
  const rightTouch = document.getElementById("right-touch");
  const spanElement = document.getElementById("controlsui");

  if (!isMobile) {
    // Hide elements on non-mobile devices
    if (leftJoystick) leftJoystick.style.display = "none";
    if (rightTouch) rightTouch.style.display = "none";
    spanElement.style.display = "block";
  } else {
    spanElement.style.display = "none";
    console.log("Mobile device detected: Showing touch controls.");
  }
});

// Prompt to rotate device
// Function to detect if the device is a mobile device
function isMobileDevice() {
  return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini|Mobile/i.test(
    navigator.userAgent
  );
}

// Function to show a rotate popup
function showRotatePopup() {
  // Create the popup container
  const popup = document.createElement("div");
  popup.id = "rotate-popup";
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
  const message = document.createElement("p");
  message.textContent = "rotate device to landscape mode";
  message.style.fontSize = "20px";
  message.style.textAlign = "center";
  message.style.margin = "0 20px";
  popup.appendChild(message);
  // Append the popup to the body
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

// Ensure audio context is resumed after a user gesture
document.body.addEventListener("click", () => {
  if (audioContext.state === "suspended") {
    audioContext.resume().then(() => {
      console.log("Audio context resumed");
      setupAudio(); // Load and play audio
    });
  }
});

// Volume slider functionality
const volumeSlider = document.getElementById("volume-slider");
volumeSlider.addEventListener("input", (event) => {
  const volume = parseFloat(event.target.value);
  gainNode.gain.setValueAtTime(volume, audioContext.currentTime);
});
// Load the throw sound on page load
//document.addEventListener('DOMContentLoaded', loadThrowSound);

// Starting screen
// Hide the start screen and initialize the game
document.getElementById("start-button").addEventListener("click", () => {
  document.getElementById("start-screen").style.display = "none";
  startGame(); // Replace with your game's initialization logic
});

// Game initialization function
function startGame() {
  console.log("Game started!");
  // Start animations, audio, or gameplay mechanics
  setupAudio(); // Start background audio if not already running
}
