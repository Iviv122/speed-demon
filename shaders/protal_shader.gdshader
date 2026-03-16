shader_type canvas_item;

uniform vec3 color : source_color;
uniform float rays : hint_range(0.,20., 1) = 6;
uniform float speed : hint_range(0., 20., .01) = .5;
uniform float fade : hint_range(0., 3., .01) = .1;
uniform float thickness : hint_range(0., 1., .01) = .3;

void fragment() {

	float r = length(.5 - UV);
	float angle = atan(UV.y-.5, UV.x-.5);

	COLOR.rgb = color;

	COLOR.a = 1. - fract((2.*r-(angle+PI)/TAU)*rays + -TIME*speed)-thickness;

	COLOR.a *= pow(2.*(.5 - r), fade*4.);

}