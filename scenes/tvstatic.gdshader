shader_type spatial;
render_mode unshaded;

float random(vec2 uv)
{
	return fract(
		sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453
	);
}

void fragment()
{
	float noise = random(
		UV * vec2(1920.0, 1080.0) + TIME * 25.0
	);
	
	float scanline = sin(UV.y * 900.0 + TIME * 20.0) * 0.08;
	
	vec3 static_color = vec3(noise + scanline);
	
	ALBEDO = static_color;
	EMISSION = static_color * 0.8;
}