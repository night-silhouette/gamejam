shader_type canvas_item;

// --- Uniform 变量：由 GDScript 和 Inspector 控制 ---
uniform float dissolve_amount : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D noise_texture;
uniform vec4 burn_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float burn_size : hint_range(0.0, 0.1) = 0.02;


void fragment() {
    vec4 base_color = texture(TEXTURE, UV);

    // 默认颜色设置为原始颜色
    vec4 final_color = base_color;

    // 只有当原始像素不透明时，才执行溶解和燃烧逻辑
    if (base_color.a > 0.01) {

        float noise_value = texture(noise_texture, UV).r;

        // --- 核心溶解/碎裂逻辑 ---
        float difference = noise_value - dissolve_amount;

        // 1. 像素丢弃 (Discard)
        if (difference < 0.0) {
            discard; // discard 是允许的，它不是 return
        }

        // --- 边缘发光/燃烧效果 ---
        float burn_mask_start = step(0.0, difference);
        float burn_mask_end = step(difference, burn_size);
        float burn_mask = burn_mask_start * burn_mask_end;

        // 2. 混合颜色
        final_color = mix(base_color, burn_color, burn_mask);
    }

    COLOR = final_color;
}