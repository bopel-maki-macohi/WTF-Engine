#pragma header

uniform float time;
uniform float speed;
uniform float frequency;
uniform float waveAmplitude;

void main()
{
    vec2 uv = openfl_TextureCoordv;

    uv.y += sin(uv.x * frequency + time * speed) * waveAmplitude;

    gl_FragColor = texture2D(bitmap, uv);
}