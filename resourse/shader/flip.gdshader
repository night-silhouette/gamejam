shader_type canvas_item;

// 原有的 uniform 变量，用于控制翻转效果 (不改动，保留原有功能)
uniform float flip_progress : hint_range(0.0, 1.0) = 0.0;
uniform float card_width = 200.0;
uniform float perspective_strength = 0.05;

// 【新增】用于下层/修补图像的 uniform 变量
uniform sampler2D back_texture;

void vertex() {
	// 保持原有的顶点着色器逻辑不变
    float x = VERTEX.x;
    float center_x = card_width * 0.5;

    float d_x = x - center_x;

    float compress_factor = (1.0 + cos(flip_progress * 3.14159265)) / 2.0;

    VERTEX.x = center_x + d_x * compress_factor;

    float y_stretch = 1.0 + (1.0 - compress_factor) * perspective_strength;
    VERTEX.y *= y_stretch;

}

void fragment() {
	
	//  主纹理 (卡面) 的颜色
    vec4 front_color = texture(TEXTURE, UV);
	
	// 下层纹理颜色
	vec4 back_color = texture(back_texture, UV);


    COLOR = mix(back_color, front_color, front_color.a);
}