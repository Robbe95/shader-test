varying vec2 vCoordinates;
uniform sampler2D t1;
varying vec2 vUv;

void main() {
    vec4 image = texture2D(t1, vUv);
    gl_FragColor = image;
}