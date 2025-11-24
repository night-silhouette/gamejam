shader_type canvas_item; 

uniform float flip_progress : hint_range(0.0, 1.0) = 0.0;
uniform float card_width = 200.0;
uniform float perspective_strength = 0.05;

void vertex() {
    float x = VERTEX.x;
    float center_x = card_width * 0.5;

    float d_x = x - center_x;

    // 计算压缩因子：当 progress 接近 0.5 时，cos(PI * progress) 接近 -1
    // 当 progress 接近 0 或 1 时，cos(PI * progress) 接近 1
    // 这个因子会从 1.0 变化到接近 0.0，再变回 1.0
    float compress_factor = (1.0 + cos(flip_progress * 3.14159265)) / 2.0;

    VERTEX.x = center_x + d_x * compress_factor;


    float y_stretch = 1.0 + (1.0 - compress_factor) * perspective_strength;
    VERTEX.y *= y_stretch;

    // 确保中心点在 Y 轴保持不动 (如果卡牌不是居中对齐，需要更复杂的逻辑)
    // VERTEX.y -= (y_stretch - 1.0) * center_y;
}

// 片段着色器保持简单，只需要渲染纹理
void fragment() {
    COLOR = texture(TEXTURE, UV);
}