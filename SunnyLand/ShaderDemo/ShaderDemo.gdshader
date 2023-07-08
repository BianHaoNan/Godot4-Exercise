shader_type canvas_item;

uniform float scale : hint_range(0.1, 10.0, 0.1) = 1.0;
uniform vec4 c : source_color;

void fragment() {
	vec2 distortedUV = UV;
	distortedUV.x += distortedUV.y * 0.5;
	
	
	vec4 pixelColor = texture(TEXTURE, UV * scale);
	
	float brightness = (pixelColor.r + pixelColor.g + pixelColor.b) / 3.0;
	vec4 grayScale = vec4(brightness, brightness, brightness, pixelColor.a);
	
	//COLOR = grayScale * c;
	COLOR.rgb = COLOR.grb;
	
}
