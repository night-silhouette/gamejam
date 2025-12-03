shader_type canvas_item;

// 辉光颜色 (白色)
uniform vec4 glow_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
// 辉光的强度或不透明度
uniform float glow_intensity : hint_range(0.0, 5.0) = 1.0;
// *** 1. 扩大范围：控制辉光宽度/采样距离。最大值提高到 1.0。***
uniform float glow_width : hint_range(0.001, 10.0) = 0.05; 
// *** 新增：控制辉光边缘的模糊程度。***
uniform float glow_softness : hint_range(0.001, 0.5) = 0.1;

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
        // 乘数 10.0 是一个经验值，用于将 glow_width (0.001-1.0) 转换为合理的像素距离。
        vec2 step_scale = TEXTURE_PIXEL_SIZE * glow_width * 10.0; 

        // 3. 边缘检测：查找附近非透明像素
        float total_neighbor_alpha = 0.0;
        float max_alpha = 0.0;
        
        // 采样方向：可以增加更多采样点来获得更平滑的效果，这里保持四点采样。
        // 为了增大范围，我们使用 step_scale 作为偏移量。
        total_neighbor_alpha += texture(TEXTURE, UV + vec2(step_scale.x, 0.0)).a; 
        total_neighbor_alpha += texture(TEXTURE, UV - vec2(step_scale.x, 0.0)).a; 
        total_neighbor_alpha += texture(TEXTURE, UV + vec2(0.0, step_scale.y)).a; 
        total_neighbor_alpha += texture(TEXTURE, UV - vec2(0.0, step_scale.y)).a; 
        
        // 也可以使用 max_alpha 来获得更锐利的轮廓，这里使用平均值（或最大值）来判断接近程度。
        // max_alpha = max(max_alpha, texture(TEXTURE, UV + vec2(step_scale.x, 0.0)).a);
        // ... (对所有采样点执行 max())
        
        float avg_neighbor_alpha = total_neighbor_alpha / 4.0;
        
        // 4. 应用辉光计算
        
        // 我们希望：
        // - 当 avg_neighbor_alpha 接近 1.0 (轮廓很近) 时，glow_factor 接近 1.0。
        // - 当 avg_neighbor_alpha 接近 0.0 (轮廓很远) 时，glow_factor 接近 0.0。
        
        // 使用 smoothstep 创建一个平滑的过渡，这是模糊效果的关键。
        // 第一个参数是起始点（alpha 值），第二个是结束点。
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
}