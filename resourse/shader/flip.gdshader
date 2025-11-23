shader_type canvas_item; // 用于 2D 节点

// 翻转进度，由 GDScript 控制 (0.0 到 1.0)
uniform float flip_progress : hint_range(0.0, 1.0) = 0.0;
// 卡牌的宽度
uniform float card_width = 200.0;
// 模拟透视的强度 (例如 0.05)
uniform float perspective_strength = 0.05;

void vertex() {
    // 顶点位置在局部坐标系中的 X 轴
    float x = VERTEX.x;
    // 计算 X 轴的中心点 (假设卡牌是居中对齐的)
    float center_x = card_width * 0.5;

    // 计算顶点到中心点的距离 (d_x 在 -width/2 到 +width/2 之间)
    float d_x = x - center_x;

    // 计算压缩因子：当 progress 接近 0.5 时，cos(PI * progress) 接近 -1
    // 当 progress 接近 0 或 1 时，cos(PI * progress) 接近 1
    // 这个因子会从 1.0 变化到接近 0.0，再变回 1.0
    float compress_factor = (1.0 + cos(flip_progress * 3.14159265)) / 2.0;

    // 扭曲 X 坐标：将顶点拉近中心
    VERTEX.x = center_x + d_x * compress_factor;

    // 模拟透视拉伸 (可选)：让卡牌在翻转中点时 Y 轴略微拉伸，增加 3D 错觉
    // 压缩因子接近 0 时，y_stretch 接近 perspective_strength
    float y_stretch = 1.0 + (1.0 - compress_factor) * perspective_strength;
    VERTEX.y *= y_stretch;

    // 确保中心点在 Y 轴保持不动 (如果卡牌不是居中对齐，需要更复杂的逻辑)
    // VERTEX.y -= (y_stretch - 1.0) * center_y;
}

// 片段着色器保持简单，只需要渲染纹理
void fragment() {
    COLOR = texture(TEXTURE, UV);
}