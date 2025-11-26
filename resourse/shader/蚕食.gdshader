shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform float feather : hint_range(0.0, 0.1) = 0.01;
// 纹理的像素大小：必须由 GDScript 设置为 Vector2(1.0/width, 1.0/height)
uniform vec2 pixel_size = vec2(0.001, 0.001); 

// 查找像素在 Y 轴上的哪个位置是“底部边缘”
// 这里的 wipe_base 需要根据 progress 来动态计算。
// 如果一个像素是底部边缘，它的 wipe_base 应该接近 0.0。

void fragment() {
	vec2 uv = UV;
	vec4 original_color = texture(TEXTURE, uv);
	
	// 1. 检查原始图片的透明度，跳过透明部分
	if (original_color.a < 0.01) {
		discard;
	}
	
	// 2. 检查下方像素的透明度
	// 采样下方一个像素的 UV 坐标 (UV.y + pixel_size.y)
	vec2 uv_below = uv + vec2(0.0, pixel_size.y);
	
	// 如果下方超出纹理范围 (即 UV.y 接近 1.0)，我们假设它是透明的
	// 检查下方像素的 Alpha 值
	float below_alpha = 0.0;
	if (uv_below.y < 1.0) {
		below_alpha = texture(TEXTURE, uv_below).a;
	}

	// 3. 定义“垂直深度” (Approximation of Wipe Base)
	// 如果下方是透明的 (below_alpha < 0.01)，则该像素位于最底部边缘，
	// 它的 wipe_base 应该从 0.0 开始。
	// 如果不是底部边缘，则 wipe_base 应该基于其在 UV 空间中的垂直位置 (1.0 - UV.y)。
	
	float wipe_base = 1.0 - uv.y; // 默认垂直基准（底部 0.0，顶部 1.0）
	
	// 如果当前像素位于最底部的曲线边缘：
	if (below_alpha < 0.01) {
		// 位于图像底部边缘的像素，将它们的基准设置为起始点 (例如 0.0)
		// 这将导致 progress 稍有增加时，底部边缘的像素首先被擦除。
		wipe_base = 0.0;
	} else {
		// 对于其他不在底部边缘的像素，基于它们的垂直位置计算一个偏移，
		// 使得它们沿着曲线向上被擦除。
		// 这里我们使用一个简单的插值，来尝试模拟曲线的深度
		// 这是一个粗略的近似，用于避免整个矩形同时擦除。
		// 可以根据需要调整下面的 0.1 和 0.9。
		wipe_base = mix(0.1, 0.9, 1.0 - uv.y); 
	}
	
	// 4. 计算擦除进度
	// 这里使用 wipe_base 决定擦除的时机
	float alpha_value = smoothstep(progress, progress + feather, wipe_base);
	
	// 5. 设置最终颜色
	COLOR.rgb = original_color.rgb;
	COLOR.a = original_color.a * alpha_value;
}