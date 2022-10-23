varying vec2 vCoordinates;

uniform sampler2D t1;
uniform sampler2D distortion;
uniform vec4 resolution;
uniform float time;

varying vec2 vUv;
varying vec4 vPosition;

void main() {
    vec4 displace = texture2D(distortion, vUv.yx); 
    vec2 displacedUV = vec2(vUv.x, vUv.y + displace.r * time);

    displacedUV.y = mix(vUv.y, displace.r - 0.2, time);

    vec4 image = texture2D(t1, displacedUV);

    gl_FragColor = image;
}