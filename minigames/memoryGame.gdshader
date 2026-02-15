shader_type canvas_item;

uniform vec4 waterTint = vec4(0.0, 0.2, 0.4, 0.6);
uniform float waveSpeed = 1.5;
uniform float waveStrength = 0.01;
uniform float waveFrequency = 8.0;

void fragment() {
    vec2 uv = UV;
	
    uv.x += sin(uv.y * waveFrequency + TIME * waveSpeed) * waveStrength;
    uv.y += cos(uv.x * waveFrequency + TIME * waveSpeed) * waveStrength;
	
    vec4 texColor = texture(TEXTURE, uv);
	
    COLOR = mix(texColor, waterTint, waterTint.a);
}
