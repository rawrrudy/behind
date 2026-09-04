shader_type canvas_item;

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

    COLOR = vec4(vec3(noise), 0.18);
}