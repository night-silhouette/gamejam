shader_type canvas_item;

// === 1. 翻转动画参数 (Vertex Shader) ===
uniform float flip_progress : hint_range(0.0, 1.0) = 0.0;
uniform float card_width = 200.0;
uniform float perspective_strength = 0.05; // 用于翻转时的Y轴拉伸

// === 2. 透视倾斜参数 (Fragment Shader) ===
uniform float tilt_amount : hint_range(-1.0, 1.0) = 0.5; // 用于静态透视倾斜的强度

void vertex() {
    // === 卡牌翻转 Vertex Logic ===
    
    // 1. 计算 X 轴压缩
    float x = VERTEX.x;
    float center_x = card_width * 0.5;
    float d_x = x - center_x;

    // 计算压缩因子：当 progress 接近 0.5 时，卡牌最薄
    float compress_factor = (1.0 + cos(flip_progress * 3.14159265)) / 2.0;

    // 压缩 VERTEX.x
    VERTEX.x = center_x + d_x * compress_factor;


    // 2. 计算 Y 轴拉伸（为配合翻转动画的透视效果）
    float y_stretch = 1.0 + (1.0 - compress_factor) * perspective_strength;
    
    // 将 Y 轴拉伸应用到顶点
    // 仅拉伸，因为这是 Vertex Shader，应该在 Y 轴中心点保持不变，但 UV 坐标是 0-1 的
    // VERTEX.y *= y_stretch; // 原本的拉伸逻辑
    
    // 更好的做法：以 Y 轴中心点为基准进行缩放（假设卡牌中心为 0.5）
    // VERTEX.y 的值取决于您的 Mesh/Quad 的 Y 坐标布局
    float center_y = 0.0; // 如果您的 Quad 顶点 Y 坐标在 [-H/2, H/2]，中心就是 0.0
    
    // 假设您的 Quad 是从 [0, Height]
    // 找到 Y 轴的中心点
    float card_height = 400.0; // 需要根据实际卡牌高度设置
    
    // 我们暂时沿用您提供的简单拉伸逻辑，但如果卡牌乱跳，需要用 center_y 修正
    VERTEX.y *= y_stretch;
    // 如果需要确保底部固定：
    // VERTEX.y = (VERTEX.y - card_height) * y_stretch + card_height;
}

void fragment() {
    // === 透视倾斜 Fragment Logic ===
    
    vec2 uv = UV;
    
    // 1. 计算宽度拉伸/压缩因子
    // 范围从 (1-tilt_amount) [顶部] 到 (1+tilt_amount) [底部]
    float width_scale = 1.0 + (uv.y * 2.0 - 1.0) * tilt_amount;
    
    vec2 distorted_uv;
    distorted_uv.y = uv.y;
    
    // 2. 以 X 轴中心 (0.5) 为基准进行缩放
    distorted_uv.x = 0.5 + (uv.x - 0.5) * width_scale;
    
    // 3. 采样颜色
    COLOR = texture(TEXTURE, distorted_uv);
}