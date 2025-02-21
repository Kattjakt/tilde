#version 330 compatibility

#ifdef GLSLANG
#extension GL_GOOGLE_include_directive : enable
#endif

#include "/lib/effect.glsl"

out vec2 texCoord;
out vec2 lightCoord;
out vec4 vertexColor;

out float vertexDistance;

void main() {
    vec3 viewPos = effect();

    gl_Position = gl_ProjectionMatrix * vec4(viewPos.xyz, 1.0);

    texCoord = gl_MultiTexCoord0.xy;
    lightCoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    vertexColor = gl_Color;
    vertexDistance = length((gl_ModelViewMatrix * gl_Vertex).xyz);
}
