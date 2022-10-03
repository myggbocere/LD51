shader_type canvas_item;
const vec4 PRIMARY_COLOR=vec4(0.71333333333333337,0.81666666666666665,0.7466666666666667,1);

void fragment() {
	COLOR = texture(TEXTURE, UV);
	vec4 shaded = PRIMARY_COLOR*COLOR.r - (PRIMARY_COLOR*COLOR.b)*(COLOR.b/COLOR.r) - vec4(1,0,0,1)*(1.0 - COLOR.b/COLOR.r);
	shaded.a *= 1.0*COLOR.a;
	COLOR += shaded;
}
