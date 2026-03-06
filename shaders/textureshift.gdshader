shader_type canvas_item;

uniform float x_speed;
uniform float y_speed;

void fragment() {
	COLOR = texture(TEXTURE, UV+vec2(TIME*x_speed,TIME*y_speed));
}
