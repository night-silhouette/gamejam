shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform float feather : hint_range(0.0, 0.1) = 0.01;
uniform vec2 pixel_size = vec2(0.001, 0.001); 


void fragment() {
	vec2 uv = UV;
	vec4 original_color = texture(TEXTURE, uv);
	
	if (original_color.a < 0.01) {
		discard;
	}
	
	vec2 uv_below = uv + vec2(0.0, pixel_size.y);
	
	float below_alpha = 0.0;
	if (uv_below.y < 1.0) {
		below_alpha = texture(TEXTURE, uv_below).a;
	}

	
	float wipe_base = 1.0 - uv.y; 
	
	if (below_alpha < 0.01) {
		wipe_base = 0.0;
	} else {
		wipe_base = mix(0.1, 0.9, 1.0 - uv.y); 
	}
	
	float alpha_value = smoothstep(progress, progress + feather, wipe_base);
	
	COLOR.rgb = original_color.rgb;
	COLOR.a = original_color.a * alpha_value;
}