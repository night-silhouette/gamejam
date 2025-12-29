shader_type canvas_item;

uniform float dissolve_amount : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D noise_texture;
uniform vec4 burn_color : source_color = vec4(1.0, 0.5, 0.0, 1.0);
uniform float burn_size : hint_range(0.0, 0.1) = 0.02;


void fragment() {
    vec4 base_color = texture(TEXTURE, UV);

    vec4 final_color = base_color;

    if (base_color.a > 0.01) {

        float noise_value = texture(noise_texture, UV).r;

        float difference = noise_value - dissolve_amount;

        if (difference < 0.0) {
            discard; 
        }

        float burn_mask_start = step(0.0, difference);
        float burn_mask_end = step(difference, burn_size);
        float burn_mask = burn_mask_start * burn_mask_end;

        final_color = mix(base_color, burn_color, burn_mask);
    }

    COLOR = final_color;
}