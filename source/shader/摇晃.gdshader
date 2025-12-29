shader_type canvas_item;


uniform float wind_speed : hint_range(0.1, 5.0) = 1.5;

uniform float wind_strength : hint_range(0.0, 50.0) = 10.0;

uniform float wave_density : hint_range(1.0, 50.0) = 20.0;

uniform float start_height : hint_range(0.0, 1.0) = 0.8; 


void vertex() {
    float height_from_bottom = 1.0 - UV.y;

    float wave_weight = smoothstep(start_height, 0.0, UV.y);
    
    
    float offset = sin(TIME * wind_speed + UV.y * wave_density);
    float displacement = offset * wind_strength  * wave_weight;
    
    VERTEX.x += displacement;
}

void fragment() {
    COLOR = texture(TEXTURE, UV);
	
}