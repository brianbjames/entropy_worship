// ── Starfield background ─────────────────────────────────────
(function () {
  if (!window.THREE) return;

  const canvas   = document.getElementById('galaxy-bg');
  const renderer = new THREE.WebGLRenderer({ canvas, antialias: false });
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5));
  renderer.setClearColor(0x000000, 1);
  renderer.setSize(window.innerWidth, window.innerHeight);

  const scene  = new THREE.Scene();
  // Camera sits at origin, looking into the field
  const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 500);

  // ── Particles ─────────────────────────────────────────────
  const COUNT     = 22000;
  const positions = new Float32Array(COUNT * 3);
  const colors    = new Float32Array(COUNT * 3);
  const color     = new THREE.Color();

  for (let i = 0; i < COUNT; i++) {
    const i3 = i * 3;

    // Uniform random point on sphere surface, random radius
    const theta = Math.random() * Math.PI * 2;
    const phi   = Math.acos(2 * Math.random() - 1);
    const r     = 8 + Math.pow(Math.random(), 0.6) * 120; // bias toward farther out

    positions[i3]     = r * Math.sin(phi) * Math.cos(theta);
    positions[i3 + 1] = r * Math.sin(phi) * Math.sin(theta);
    positions[i3 + 2] = r * Math.cos(phi);

    // Colour — mostly dim, occasional hot
    const roll = Math.random();
    if (roll < 0.018) {
      // Hot accent — red or teal
      color.set(Math.random() < 0.65 ? 0xff2222 : 0x05af90);
    } else if (roll < 0.10) {
      // Blood-red mid stars
      const b = 0.25 + Math.random() * 0.45;
      color.setRGB(b, b * 0.15, b * 0.1);
    } else if (roll < 0.30) {
      // Warm dim orange-white
      const b = 0.08 + Math.random() * 0.22;
      color.setRGB(b, b * 0.55, b * 0.4);
    } else {
      // Cold distant white
      const b = 0.03 + Math.random() * 0.18;
      color.setRGB(b * 0.85, b * 0.85, b);
    }

    colors[i3]     = color.r;
    colors[i3 + 1] = color.g;
    colors[i3 + 2] = color.b;
  }

  const geo = new THREE.BufferGeometry();
  geo.setAttribute('position', new THREE.BufferAttribute(positions, 3));
  geo.setAttribute('color',    new THREE.BufferAttribute(colors, 3));

  const mat = new THREE.PointsMaterial({
    size:            0.4,
    vertexColors:    true,
    sizeAttenuation: true,
    transparent:     true,
    opacity:         0.95,
  });

  const stars = new THREE.Points(geo, mat);
  scene.add(stars);

  // ── Animate ───────────────────────────────────────────────
  function animate() {
    requestAnimationFrame(animate);
    stars.rotation.y += 0.00006;
    stars.rotation.x += 0.000025;
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
