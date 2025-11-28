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



        COLOR = fill_color;
    } else {
        COLOR = original_color;
    }
}