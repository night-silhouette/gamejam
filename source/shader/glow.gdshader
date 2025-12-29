shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float glow_intensity : hint_range(0.0, 5.0) = 1.0;
uniform float glow_width : hint_range(0.001, 10.0) = 0.05; 
uniform float glow_softness : hint_range(0.001, 0.5) = 0.1;
uniform vec4 _modulate  = vec4(1.0, 1.0, 1.0, 1.0);

uniform float global_fade : hint_range(0.0, 1.0) = 0.0; 

void fragment() {
    vec4 current_color = texture(TEXTURE, UV);
    float current_alpha = current_color.a;
    
    COLOR = current_color;

    if (current_alpha < 0.001) {
        
        vec2 step_scale = TEXTURE_PIXEL_SIZE * glow_width * 10.0; 

        float total_neighbor_alpha = 0.0;
        
        total_neighbor_alpha += texture(TEXTURE, UV + vec2(step_scale.x, 0.0)).a; 
        total_neighbor_alpha += texture(TEXTURE, UV - vec2(step_scale.x, 0.0)).a; 
        total_neighbor_alpha += texture(TEXTURE, UV + vec2(0.0, step_scale.y)).a; 
        total_neighbor_alpha += texture(TEXTURE, UV - vec2(0.0, step_scale.y)).a; 
        
        float avg_neighbor_alpha = total_neighbor_alpha / 4.0;
        
        float glow_factor = smoothstep(0.0, glow_softness, avg_neighbor_alpha); 
        
        glow_factor *= glow_intensity;
        
        COLOR.rgb = glow_color.rgb;
        COLOR.a = glow_color.a * glow_factor; 
		
        
    } else {
        COLOR = current_color;
    }
    
    COLOR.a *= (1.0 - global_fade);
	COLOR=COLOR*_modulate;
}