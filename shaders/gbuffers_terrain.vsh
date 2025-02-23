#version 120

#ifdef GLSLANG
#extension GL_GOOGLE_include_directive : enable
#endif

#include "/lib/effect.glsl"

varying vec4 color;
varying vec3 normal;
varying vec4 lmcoord;

varying vec4 texcoord;

out float vertexDistance;

void main() {

    vec3 viewPos = effect();

    gl_Position = gl_ProjectionMatrix * vec4(viewPos.xyz, 1.0);

    texcoord = gl_MultiTexCoord0;
    normal = gl_NormalMatrix * gl_Normal;
    color = gl_Color;

		lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;

		vertexDistance = length(viewPos.xyz);
}
