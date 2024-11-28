// Get the canvas element
const canvas = document.getElementById('renderCanvas');

// Create the Babylon.js engine
const engine = new BABYLON.Engine(canvas, true);

// Create a basic scene
const createScene = () => {
    // Create a new scene
    const scene = new BABYLON.Scene(engine);

    // Create a camera and attach it to the canvas
    const camera = new BABYLON.ArcRotateCamera("camera", Math.PI / 2, Math.PI / 4, 4, BABYLON.Vector3.Zero(), scene);
    camera.attachControl(canvas, true);

    // Add a light to the scene
    const light = new BABYLON.HemisphericLight("light", new BABYLON.Vector3(0, 1, 0), scene);

    // Add a simple box
    const box = BABYLON.MeshBuilder.CreateBox("box", { size: 1 }, scene);

    // Add some material to the box
    const material = new BABYLON.StandardMaterial("material", scene);
    material.diffuseColor = new BABYLON.Color3(0.5, 0.5, 1);
    box.material = material;

    return scene;
};

// Create the scene
const scene = createScene();

// Run the render loop
engine.runRenderLoop(() => {
    scene.render();
});

// Resize the engine when the window is resized
window.addEventListener('resize', () => {
    engine.resize();
});
