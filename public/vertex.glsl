uniform float time;
varying vec2 vPosition;
varying vec2 vUv;
float PI = 3.1415926535897932384626433832795;
void main() {
    vUv = uv;
    vec3 newPosition = position + normal * vec3(sin(time * 0.2) * 3.0);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);
}