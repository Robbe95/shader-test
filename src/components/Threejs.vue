<script setup lang="ts">
import * as THREE from 'THREE'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'
import type { WebGLRenderer } from 'THREE'
import * as dat from 'dat.gui'
onMounted(async () => {
  const person = { age: 45 }
  const gui = new dat.GUI()
  gui.add(person, 'age', 0, 100)

  // Canvas
  const canvas = document.querySelector('canvas.webgl')

  // Scene
  const scene = new THREE.Scene()

  // Objects
  const geometry = new THREE.PlaneGeometry(1, 1)

  // Materials
  // const material = new THREE.MeshBasicMaterial()
  // material.color = new THREE.Color(0xFF0000)

  const vertexShader = await (await fetch('vertex.glsl')).text()
  const fragmentShader = await (await fetch('fragment.glsl')).text()

  const material = new THREE.ShaderMaterial({

    uniforms: {
      time: { value: 0 },
      resolution: { value: new THREE.Vector2() },
      t1: { value: new THREE.TextureLoader().load('/image.jpg') },
    },
    vertexShader,
    fragmentShader,

  })
  material.side = THREE.DoubleSide

  // Mesh
  const sphere = new THREE.Mesh(geometry, material)
  scene.add(sphere)

  // Lights
  const pointLight = new THREE.PointLight(0xFFFFFF, 1)
  pointLight.position.x = 2
  pointLight.position.y = 2
  pointLight.position.z = 1
  scene.add(pointLight)

  /**
 * Sizes
 */
  const sizes = {
    width: window.innerWidth,
    height: window.innerHeight,
  }

  /**
 * Camera
 */
  // Base camera
  const camera = new THREE.PerspectiveCamera(75, sizes.width / sizes.height, 0.1, 100)
  camera.position.x = 0
  camera.position.y = 0
  camera.position.z = 2
  scene.add(camera)

  /**
 * Renderer
 */
  let renderer: WebGLRenderer
  if (canvas) {
    renderer = new THREE.WebGLRenderer({
      canvas,
    })
  }
  else {
    renderer = new THREE.WebGLRenderer()
  }

  renderer.setSize(sizes.width, sizes.height)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  window.addEventListener('resize', () => {
  // Update sizes
    sizes.width = window.innerWidth
    sizes.height = window.innerHeight

    // Update camera
    camera.aspect = sizes.width / sizes.height
    camera.updateProjectionMatrix()

    // Update renderer
    renderer.setSize(sizes.width, sizes.height)
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
  })

  // Controls
  // const controls = new OrbitControls(camera, canvas)
  // controls.enableDamping = true

  /**
 * Animate
 */

  const rotation = { x: 0, y: 0, z: 0 }
  gui.add(rotation, 'y', 0, 10)

  const tick = () => {
    // Update objects
    sphere.rotation.y = 0.5 * rotation.y

    // Update Orbital Controls
    // controls.update()

    // Render
    renderer.render(scene, camera)

    // Call tick again on the next frame
    if (material.uniforms.time.value < 2)
      material.uniforms.time.value += 0.01
    window.requestAnimationFrame(tick)
  }

  tick()
})
</script>

<template>
  <div class="w-100vw h-100vh">
    <canvas class="webgl" />
  </div>
</template>
