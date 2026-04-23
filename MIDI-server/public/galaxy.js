// ── Galaxy background ────────────────────────────────────────
(function () {
  if (!window.THREE) return;

  const canvas   = document.getElementById('galaxy-bg');
  const renderer = new THREE.WebGLRenderer({ canvas, antialias: false });
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5));
  renderer.setClearColor(0x000000, 1);
  renderer.setSize(window.innerWidth, window.innerHeight);

  const scene  = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.1, 200);
  camera.position.set(0, 5, 12);
  camera.lookAt(0, 0, 0);

  // ── Particles ─────────────────────────────────────────────
  const COUNT     = 8000;
  const positions = new Float32Array(COUNT * 3);
  const colors    = new Float32Array(COUNT * 3);
  const color     = new THREE.Color();

  for (let i = 0; i < COUNT; i++) {
    const i3 = i * 3;

    // Radius — bias toward centre
    const r = Math.pow(Math.random(), 1.4) * 9;

    // Three spiral arms
    const arm      = Math.floor(Math.random() * 3);
    const armAngle = (arm / 3) * Math.PI * 2;
    const spin     = r * 0.55;
    const scatter  = (Math.random() - 0.5) * (0.5 + r * 0.06);

    const angle = armAngle + spin + scatter;

    positions[i3]     = Math.cos(angle) * r + (Math.random() - 0.5) * 0.4;
    positions[i3 + 1] = (Math.random() - 0.5) * 0.35 * Math.max(0, 1 - r / 10);
    positions[i3 + 2] = Math.sin(angle) * r + (Math.random() - 0.5) * 0.4;

    // Colour
    const t = r / 9; // 0 = core, 1 = edge
    const roll = Math.random();

    if (roll < 0.015) {
      // Accent stars — red or teal
      color.set(Math.random() < 0.5 ? 0xff2222 : 0x05af90);
    } else if (t < 0.25) {
      // Core — warm near-white
      const b = 0.75 + Math.random() * 0.25;
      color.setRGB(b, b * 0.82, b * 0.65);
    } else if (t < 0.55) {
      // Mid — dim blood red
      const b = 0.25 + Math.random() * 0.35;
      color.setRGB(b * 0.95, b * 0.22, b * 0.18);
    } else {
      // Outer — barely-there embers
      const b = 0.04 + Math.random() * 0.12;
      color.setRGB(b * 0.85, b * 0.15, b * 0.1);
    }

    colors[i3]     = color.r;
    colors[i3 + 1] = color.g;
    colors[i3 + 2] = color.b;
  }

  const geo = new THREE.BufferGeometry();
  geo.setAttribute('position', new THREE.BufferAttribute(positions, 3));
  geo.setAttribute('color',    new THREE.BufferAttribute(colors, 3));

  const mat = new THREE.PointsMaterial({
    size:            0.045,
    vertexColors:    true,
    sizeAttenuation: true,
    transparent:     true,
    opacity:         0.9,
  });

  const galaxy = new THREE.Points(geo, mat);
  galaxy.rotation.x = Math.PI * 0.13; // tilt the disc toward viewer
  scene.add(galaxy);

  // ── Animate ───────────────────────────────────────────────
  function animate() {
    requestAnimationFrame(animate);
    galaxy.rotation.y += 0.00025;
    renderer.render(scene, camera);
  }
  animate();

  // ── Resize ────────────────────────────────────────────────
  window.addEventListener('resize', () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
  });
}());
