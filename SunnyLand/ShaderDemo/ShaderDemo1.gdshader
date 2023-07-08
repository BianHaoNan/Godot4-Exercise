shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float brightness = 1.0;
uniform float contrast = 1.0;
uniform float saturation = 1.0;

void fragment() {
	vec2 distortedUV = SCREEN_UV + texture(TEXTURE, UV).a * 0.01;
	
	vec3 c = textureLod(screen_texture, distortedUV, 1.0).rgb;
	c.rgb = mix(vec3(1.0), c.rgb, brightness);
	c.rgb = mix(vec3(1.0), c.rgb, contrast);
	c.rgb = mix(vec3(dot(vec3(1.01), c.rgb) * 0.1), c. rgb, saturation);
	COLOR.rgb = c;
}
