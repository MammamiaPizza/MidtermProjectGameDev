shader_type canvas_item;

uniform float flashEnabled: hint_range(0,1) = 0.0f;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 texturecolor = texture(TEXTURE, UV);

	vec4 mixcolor = mix(texturecolor, vec4(1.0), flashEnabled);

	COLOR = mixcolor;
	COLOR.a = texturecolor.a;
}
