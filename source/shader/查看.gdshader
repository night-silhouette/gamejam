shader_type canvas_item;

// 原始纹理（你的黑白图片）
uniform sampler2D original_texture : filter_nearest;
// 要填充的图像
uniform sampler2D fill_image : filter_linear;

// 关键：定义蒙版区域的 UV 坐标
// mask_rect.xy: 区域的左上角 UV 坐标 (x_start, y_start)
// mask_rect.zw: 区域的右下角 UV 坐标 (x_end, y_end)
uniform vec4 mask_rect = vec4(0.0, 0.0, 1.0, 1.0); // 默认值是全图

void fragment() {
    // 获取当前像素在原始纹理上的颜色
    vec4 original_color = texture(original_texture, UV);

    // 判断当前像素的 UV 坐标是否在定义的矩形区域内
    bool is_in_mask_area = (UV.x >= mask_rect.x && UV.x <= mask_rect.z) &&
                           (UV.y >= mask_rect.y && UV.y <= mask_rect.w);

    if (is_in_mask_area && original_color.a!=0.0) {
        // ** 核心修改在这里：计算用于填充图像的 UV 坐标 **
        
        // 1. 获取当前像素在 mask_rect 内部的相对 UV 坐标 (0.0 - 1.0)
        // 这个 UV 是相对于 mask_rect 区域自身的
        vec2 relative_uv;
        
        // X 轴的相对 UV
        relative_uv.x = (UV.x - mask_rect.x) / (mask_rect.z - mask_rect.x);
        // Y 轴的相对 UV
        relative_uv.y = (UV.y - mask_rect.y) / (mask_rect.w - mask_rect.y);

        // 2. 使用这个相对 UV 去采样 fill_image
        // 这将使 fill_image 拉伸以完全覆盖 mask_rect 区域
        vec4 fill_color = texture(fill_image, relative_uv);
        
        COLOR = fill_color;
    } else {
        COLOR = original_color;
    }
}