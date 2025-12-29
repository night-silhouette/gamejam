shader_type canvas_item;

// ** 修复 Godot 4 SCREEN_TEXTURE 错误的关键行 **
// 使用 hint_screen_texture 提示符
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;

// 模糊强度 (Blur Radius)
uniform float blur_amount : hint_range(0.0, 5.0) = 2.0;

// 权重和偏移量 (与水平着色器使用相同的核)
const float offsets[9] = float[](0.0, 1.3846153846, 3.2307692308, 5.0769230769, 6.9230769231, 8.7692307692, 10.6153846154, 12.4615384615, 14.3076923077);
const float weights[9] = float[](0.20417424, 0.18042290, 0.12920785, 0.07185013, 0.02640164, 0.00755919, 0.00192300, 0.00043815, 0.00008889);
const int SAMPLE_COUNT = 9;

void fragment() {
    // 屏幕纹理的像素尺寸 (1 / 屏幕分辨率)
    vec2 resolution = SCREEN_PIXEL_SIZE;

    // 累积颜色
    vec4 sum = texture(SCREEN_TEXTURE, SCREEN_UV) * weights[0];

    // Y 轴采样（垂直模糊）
    for (int i = 1; i < SAMPLE_COUNT; i++) {
        // 计算 Y 轴偏移量（基于像素大小和模糊强度）
        vec2 offset_y = vec2(0.0, offsets[i] * blur_amount * resolution.y);

        // 采样并应用权重
        // 正方向采样
        sum += texture(SCREEN_TEXTURE, SCREEN_UV + offset_y) * weights[i];
        // 负方向采样
        sum += texture(SCREEN_TEXTURE, SCREEN_UV - offset_y) * weights[i];
    }

    // 最终颜色输出
    COLOR = sum;
}