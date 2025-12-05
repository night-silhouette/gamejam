shader_type canvas_item;

// =============== Uniforms (可在编辑器中调整) ===============

// 风速：控制摇晃动画的速度
uniform float wind_speed : hint_range(0.1, 5.0) = 1.5;

// 强度：控制摇晃的幅度（位移的像素数量）
uniform float wind_strength : hint_range(0.0, 50.0) = 10.0;

// 密度/频率：控制波浪的紧密程度 (影响扭曲的平滑度)
uniform float wave_density : hint_range(1.0, 50.0) = 20.0;

// 起始高度：控制从图像的哪个垂直位置开始摇晃 (0.0=底部, 1.0=顶部)
// 默认从底部 20% 处开始摇晃
uniform float start_height : hint_range(0.0, 1.0) = 0.8; 

// ==========================================================

void vertex() {
    // 1. 计算从底部向上算的相对高度 (0.0=底部, 1.0=顶部)
    float height_from_bottom = 1.0 - UV.y;

    float wave_weight = smoothstep(start_height, 0.0, UV.y);
    
    
    // 2. 计算水平位移量
    float offset = sin(TIME * wind_speed + UV.y * wave_density);
    
    // 3. 施加位移
    // 注意：`wind_strength` 是像素值，`TEXTURE_PIXEL_SIZE.x` 是 UV 空间中 1 像素的宽度
    float displacement = offset * wind_strength  * wave_weight;
    
    // 4. 应用到位移
    VERTEX.x += displacement;
}

void fragment() {
    // Fragment Shader 不做任何修改，直接输出纹理颜色
    COLOR = texture(TEXTURE, UV);
	
}