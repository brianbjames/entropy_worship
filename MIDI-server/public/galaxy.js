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
// ── Starfield + OBJ model background ────────────────────────
import * as THREE from "three";

const canvas = document.getElementById("galaxy-bg");
const renderer = new THREE.WebGLRenderer({ canvas, antialias: true });
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5));
renderer.setClearColor(0x000000, 1);
renderer.setSize(window.innerWidth, window.innerHeight);

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(
  75,
  window.innerWidth / window.innerHeight,
  0.1,
  500,
);

// ── Circular point sprite ─────────────────────────────────
const spriteCanvas = document.createElement("canvas");
spriteCanvas.width = spriteCanvas.height = 32;
const ctx = spriteCanvas.getContext("2d");
const grad = ctx.createRadialGradient(16, 16, 0, 16, 16, 16);
grad.addColorStop(0, "rgba(255,255,255,1)");
grad.addColorStop(0.3, "rgba(255,255,255,0.8)");
grad.addColorStop(1, "rgba(255,255,255,0)");
ctx.fillStyle = grad;
ctx.fillRect(0, 0, 32, 32);
const pointTex = new THREE.CanvasTexture(spriteCanvas);

// ── Particles ─────────────────────────────────────────────
const COUNT = 22000;
const positions = new Float32Array(COUNT * 3);
const colors = new Float32Array(COUNT * 3);
const color = new THREE.Color();

for (let i = 0; i < COUNT; i++) {
  const i3 = i * 3;
  const theta = Math.random() * Math.PI * 2;
  const phi = Math.acos(2 * Math.random() - 1);
  const r = 8 + Math.pow(Math.random(), 0.6) * 120;

  positions[i3] = r * Math.sin(phi) * Math.cos(theta);
  positions[i3 + 1] = r * Math.sin(phi) * Math.sin(theta);
  positions[i3 + 2] = r * Math.cos(phi);

  const roll = Math.random();
  if (roll < 0.018) {
    color.set(Math.random() < 0.65 ? 0xff2222 : 0x05af90);
  } else if (roll < 0.1) {
    const b = 0.25 + Math.random() * 0.45;
    color.setRGB(b, b * 0.15, b * 0.1);
  } else if (roll < 0.3) {
    const b = 0.08 + Math.random() * 0.22;
    color.setRGB(b, b * 0.55, b * 0.4);
  } else {
    const b = 0.03 + Math.random() * 0.18;
    color.setRGB(b * 0.85, b * 0.85, b);
  }

  colors[i3] = color.r;
  colors[i3 + 1] = color.g;
  colors[i3 + 2] = color.b;
}

const ptGeo = new THREE.BufferGeometry();
ptGeo.setAttribute("position", new THREE.BufferAttribute(positions, 3));
ptGeo.setAttribute("color", new THREE.BufferAttribute(colors, 3));

const ptMat = new THREE.PointsMaterial({
  size: 0.45,
  map: pointTex,
  vertexColors: true,
  sizeAttenuation: true,
  transparent: true,
  alphaTest: 0.01,
  depthWrite: false,
});

const stars = new THREE.Points(ptGeo, ptMat);
scene.add(stars);

// ── Minimal OBJ loader ────────────────────────────────────
async function loadOBJ(url) {
  const text = await fetch(url).then((r) => {
    if (!r.ok) throw new Error(r.status);
    return r.text();
  });

  const verts = [];
  const pos = [];

  for (const raw of text.split("\n")) {
    const parts = raw.trim().split(/\s+/);
    if (parts[0] === "v") {
      verts.push(+parts[1], +parts[2], +parts[3]);
    } else if (parts[0] === "f") {
      const idx = parts.slice(1).map((p) => parseInt(p) - 1);
      for (let i = 1; i < idx.length - 1; i++) {
        const a = idx[0],
          b = idx[i],
          c = idx[i + 1];
        pos.push(
          verts[a * 3],
          verts[a * 3 + 1],
          verts[a * 3 + 2],
          verts[b * 3],
          verts[b * 3 + 1],
          verts[b * 3 + 2],
          verts[c * 3],
          verts[c * 3 + 1],
          verts[c * 3 + 2],
        );
      }
    }
  }

  const geo = new THREE.BufferGeometry();
  geo.setAttribute(
    "position",
    new THREE.BufferAttribute(new Float32Array(pos), 3),
  );
  geo.computeBoundingBox();
  return geo;
}

// ── Load model ────────────────────────────────────────────
let model = null;

loadOBJ("/models/slf_99739.obj")
  .then((geo) => {
    const box = geo.boundingBox;
    const size = new THREE.Vector3();
    const centre = new THREE.Vector3();
    box.getSize(size);
    box.getCenter(centre);
    const scale = 5 / Math.max(size.x, size.y, size.z);

    geo.translate(-centre.x, -centre.y, -centre.z);
    geo.scale(scale, scale, scale);

    const wireGeo = new THREE.WireframeGeometry(geo);
    const wireMat = new THREE.LineBasicMaterial({
      color: 0xff2222,
      transparent: true,
      opacity: 0.55,
    });
    model = new THREE.LineSegments(wireGeo, wireMat);
    scene.add(model);
  })
  .catch(() => {});

// ── Animate ───────────────────────────────────────────────
function animate() {
  requestAnimationFrame(animate);
  stars.rotation.y += 0.00006;
  stars.rotation.x += 0.000025;
  if (model) model.rotation.y += 0.0006;
  renderer.render(scene, camera);
}
animate();

// ── Resize ────────────────────────────────────────────────
window.addEventListener("resize", () => {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
});
