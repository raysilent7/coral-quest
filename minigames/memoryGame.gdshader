shader_type canvas_item;

uniform vec4 water_tint = vec4(0.0, 0.2, 0.4, 0.6);
uniform float wave_speed = 1.5;
uniform float wave_strength = 0.02;
uniform float wave_frequency = 8.0;

uniform float shimmer_intensity = 0.1;
uniform float shimmer_speed = 1.5;
uniform float shimmer_scale = 16.0;

void fragment() {
	vec2 uv = UV;
    
	uv.x += sin(uv.y * wave_frequency + TIME * wave_speed) * wave_strength;
	uv.y += cos(uv.x * wave_frequency + TIME * wave_speed) * wave_strength;
    
	vec4 tex_color = texture(TEXTURE, uv);
	vec4 water_color = mix(tex_color, water_tint, water_tint.a);
    
	float shimmer = sin(uv.x * shimmer_scale + TIME * shimmer_speed) * cos(uv.y * shimmer_scale + TIME * shimmer_speed);
	shimmer = shimmer * shimmer_intensity;
	water_color.rgb += shimmer;
    
	COLOR = water_color;
}
