//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;					 // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec3 v_WorldViewProjPosition;
varying vec3 v_WorldPosition;
varying vec3 v_WorldNormal;

uniform mat4 u_LightViewMat;
uniform mat4 u_LightProjMat;

varying float v_LightDistance;
varying vec2 v_ShadowTexcoord;

void main() {
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	v_WorldViewProjPosition = gl_Position.xyz;
	
	v_WorldPosition = (gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1.)).xyz;
	v_WorldNormal = normalize(gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0.)).xyz;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
	
	vec4 worldSpace = gm_Matrices[MATRIX_WORLD] * vec4(in_Position, 1.);
	vec4 cameraSpace = u_LightViewMat * worldSpace;
	vec4 screenSpace = u_LightProjMat * cameraSpace;
	
	v_LightDistance = screenSpace.z / screenSpace.w;
	v_ShadowTexcoord = (screenSpace.xy / screenSpace.w * 0.5) + 0.5;
}
