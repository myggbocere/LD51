shader_type canvas_item;
const vec4 PRIMARY_COLOR=vec4(0.71333333333333337,0.81666666666666665,0.7466666666666667,1);
const vec4 SECONDARY_COLOR=vec4(0.81333333333333335,0.69999999999999996,0.77666666666666662,1);

void fragment() {
	// Place fragment code here.
	COLOR = texture(TEXTURE, UV); //read from texture
	vec4 shaded = SECONDARY_COLOR*COLOR.a*COLOR.r;
	shaded += PRIMARY_COLOR*(1.0-COLOR.a);
	shaded.a += COLOR.a*(1.0-COLOR.r);  //add this pixel's texture opacity times its texture darkness to its opacity
 	COLOR = shaded; //set blue channel to 1.0
}
