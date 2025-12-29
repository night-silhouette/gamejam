shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;

uniform float blur_amount : hint_range(0.0, 5.0) = 2.0;

const float offsets[9] = float[](0.0, 1.3846153846, 3.2307692308, 5.0769230769, 6.9230769231, 8.7692307692, 10.6153846154, 12.4615384615, 14.3076923077);
const float weights[9] = float[](0.20417424, 0.18042290, 0.12920785, 0.07185013, 0.02640164, 0.00755919, 0.00192300, 0.00043815, 0.00008889);
const int SAMPLE_COUNT = 9;

void fragment() {
    vec2 resolution = SCREEN_PIXEL_SIZE;

    vec4 sum = texture(SCREEN_TEXTURE, SCREEN_UV) * weights[0];

    for (int i = 1; i < SAMPLE_COUNT; i++) {
        vec2 offset_x = vec2(offsets[i] * blur_amount * resolution.x, 0.0);

        sum += texture(SCREEN_TEXTURE, SCREEN_UV + offset_x) * weights[i];
        sum += texture(SCREEN_TEXTURE, SCREEN_UV - offset_x) * weights[i];
    }

    COLOR = sum;
}