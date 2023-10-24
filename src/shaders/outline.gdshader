// From: https://github.com/anunknowperson/Godot4SimpleOutline
shader_type spatial;
render_mode unshaded, cull_front;

uniform bool enable = true;
uniform float outline_size = 0.01;
uniform vec4 color : source_color = vec4(1.0);

void vertex() {
    if (enable) {
        VERTEX += normalize(VERTEX) * outline_size;
    }
}

void fragment() {
    if (enable) {
        ALBEDO = color.rgb;
    }
}
