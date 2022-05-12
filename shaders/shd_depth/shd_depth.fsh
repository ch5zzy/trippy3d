varying float v_LightDepth;

const float SCALE_FACTOR = 16777215.;
vec3 toDepthColor(float depth) {
	float dscale = depth * SCALE_FACTOR;
	return floor(vec3(mod(dscale, 256.), mod(dscale / 256., 256.), dscale / 65536.)) / 255.;
}

void main()
{
    gl_FragColor = vec4(toDepthColor(v_LightDepth), 1);
}
