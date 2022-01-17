//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 lightPos;
uniform vec3 lightDir;
uniform vec4 lightColor;
uniform vec4 lightAmbient;
uniform float lightRange;
uniform float lightCutoffAngle;
uniform float lightInnerRad;

varying vec3 v_WorldViewProjPosition;
varying vec3 v_WorldPosition;
varying vec3 v_WorldNormal;

void main() {
	vec4 start_color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	/*fog
	vec4 fog_color = vec4(0., 0., 0., 1.);
	
	vec3 fog_origin = vec3(0.);
	float fog_start = 200.;
	float fog_end = 800.;
	
	float dist = length(v_WorldViewProjPosition - fog_origin);
	float frac = clamp((dist - fog_start) / (fog_end - fog_start), 0., 1.);
	
	vec4 final_color = mix(start_color, fog_color, frac);
	*/
	
	/*directional light
	vec3 lightDir = -normalize(vec3(0.1, 0.1, -1.));
	vec3 lightColor = vec3(1., 0.5, 0.5);
	vec3 lightAmbient = vec3(0.1, 0.1, 0.1);
	
	vec3 worldNormal = normalize(gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.)).xyz;
	
	float NdotL = max(dot(worldNormal, lightDir), 0.);
	*/
	
	/*point light
	vec3 lightDir = v_WorldPosition - lightPos;
	float lightDist = length(lightDir);
	float att = max((lightRange - lightDist) / lightRange, 0.);
	
	lightDir = -normalize(lightDir);
	float NdotL = max(dot(v_WorldNormal, lightDir), 0.);
	*/
	
	//spot light
	vec3 lightIncoming = v_WorldPosition - lightPos;
    float lightDist = length(lightIncoming);
    lightIncoming = normalize(-lightIncoming);
    float NdotL = max(dot(v_WorldNormal, lightIncoming), 0.);
    
    float coneAngle = max(dot(lightIncoming, -normalize(lightDir)), 0.);
    
    // This is equal to dcos(30) - you may wish for this to be a uniform instead
    float f = clamp((coneAngle - lightCutoffAngle) / (lightInnerRad - lightCutoffAngle), 0., 1.);
    float att = f * max((lightRange - lightDist) / lightRange, 0.);

	vec4 final_color = start_color * vec4(min(lightAmbient + att * lightColor * NdotL, vec4(1.)).rgb, 1.);
    gl_FragColor = final_color;
}
