shader_type canvas_item;

// 辉光颜色 (白色)
uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
// 辉光的强度或不透明度
uniform float glow_intensity : hint_range(0.0, 5.0) = 1.0;
// 扩大范围：控制辉光宽度/采样距离。
uniform float glow_width : hint_range(0.001, 10.0) = 0.05; 
// 新增：控制辉光边缘的模糊程度。
uniform float glow_softness : hint_range(0.001, 0.5) = 0.1;
uniform vec4 _modulate  = vec4(1.0, 1.0, 1.0, 1.0);

// *** 新增参数：全局淡出/透明度控制 ***
// 0.0 表示完全不透明（正常显示），1.0 表示完全透明（消失）。
uniform float global_fade : hint_range(0.0, 1.0) = 0.0; 

void fragment() {
    // 1. 获取当前像素的颜色和透明度
    vec4 current_color = texture(TEXTURE, UV);
    float current_alpha = current_color.a;
    
    // 默认输出为原色，或直接透明
    COLOR = current_color;

    // *** 关键修改：只在透明区域计算辉光（外发光） ***
    if (current_alpha < 0.001) {
        
        // 2. 设置采样步长 (控制辉光范围的核心)
        // 使用 glow_width 来直接控制采样的相对距离。
        vec2 step_scale = TEXTURE_PIXEL_SIZE * glow_width * 10.0; 

        // 3. 边缘检测：查找附近非透明像素
        float total_neighbor_alpha = 0.0;
        
        // 采样方向：四点采样。
        total_neighbor_alpha += texture(TEXTURE, UV + vec2(step_scale.x, 0.0)).a; 
        total_neighbor_alpha += texture(TEXTURE, UV - vec2(step_scale.x, 0.0)).a; 
        total_neighbor_alpha += texture(TEXTURE, UV + vec2(0.0, step_scale.y)).a; 
        total_neighbor_alpha += texture(TEXTURE, UV - vec2(0.0, step_scale.y)).a; 
        
        float avg_neighbor_alpha = total_neighbor_alpha / 4.0;
        
        // 4. 应用辉光计算
        // 使用 smoothstep 创建一个平滑的过渡，这是模糊效果的关键。
        // glow_softness 控制了 alpha 从 0 到 1 的过渡区域的宽度。
        float glow_factor = smoothstep(0.0, glow_softness, avg_neighbor_alpha); 
        
        // 应用强度
        glow_factor *= glow_intensity;
        
        // 5. 最终颜色输出
        // 使用辉光颜色和计算出的 alpha 值。
        COLOR.rgb = glow_color.rgb;
        // 最终的透明度是辉光颜色自身的 alpha 乘以计算出的辉光因子。
        COLOR.a = glow_color.a * glow_factor; 
		
        
    } else {
        // 如果不是透明像素 (即在物体内部)，则保持其原有的颜色和透明度
        COLOR = current_color;
    }
    
    // ======================================================================
    // *** 全局淡出逻辑：将最终的透明度乘以 (1.0 - global_fade) ***
    // 当 global_fade = 0.0 时，透明度不变 (1.0 - 0.0 = 1.0)。
    // 当 global_fade = 1.0 时，透明度变为 0.0 (1.0 - 1.0 = 0.0)，完全透明。
    // ======================================================================
    COLOR.a *= (1.0 - global_fade);
	COLOR=COLOR*_modulate;
}