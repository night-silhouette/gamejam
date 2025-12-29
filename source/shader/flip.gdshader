shader_type canvas_item;

uniform float flip_progress : hint_range(0.0, 1.0) = 0.0;
uniform float card_width = 200.0;
uniform float perspective_strength = 0.05; // 用于翻转时的Y轴拉伸

uniform float tilt_amount : hint_range(-1.0, 1.0) = 0.5; // 用于静态透视倾斜的强度

void vertex() {
    
    float x = VERTEX.x;
    float center_x = card_width * 0.5;
    float d_x = x - center_x;

    float compress_factor = (1.0 + cos(flip_progress * 3.14159265)) / 2.0;

    VERTEX.x = center_x + d_x * compress_factor;


    float y_stretch = 1.0 + (1.0 - compress_factor) * perspective_strength;
    


    float center_y = 0.0; 
    float card_height = 400.0; 
    
    VERTEX.y *= y_stretch;
}

void fragment() {
    
    vec2 uv = UV;
    
    float width_scale = 1.0 + (uv.y * 2.0 - 1.0) * tilt_amount;
    
    vec2 distorted_uv;
    distorted_uv.y = uv.y;
    
    distorted_uv.x = 0.5 + (uv.x - 0.5) * width_scale;
    
    COLOR = texture(TEXTURE, distorted_uv);
}