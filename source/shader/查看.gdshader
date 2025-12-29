shader_type canvas_item;

uniform sampler2D original_texture : filter_nearest;
uniform sampler2D fill_image : filter_linear;

uniform vec4 mask_rect = vec4(0.0, 0.0, 1.0, 1.0); // 默认值是全图

void fragment() {
    vec4 original_color = texture(original_texture, UV);

    bool is_in_mask_area = (UV.x >= mask_rect.x && UV.x <= mask_rect.z) &&
                           (UV.y >= mask_rect.y && UV.y <= mask_rect.w);

    if (is_in_mask_area && original_color.a!=0.0) {

        vec2 relative_uv;

        relative_uv.x = (UV.x - mask_rect.x) / (mask_rect.z - mask_rect.x);
        relative_uv.y = (UV.y - mask_rect.y) / (mask_rect.w - mask_rect.y);

        vec4 fill_color = texture(fill_image, relative_uv);

        COLOR = fill_color;
    } else {
        COLOR = original_color;
    }
}