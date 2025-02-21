#version 330 compatibility

#ifdef GLSLANG
#extension GL_GOOGLE_include_directive : enable
#endif

#include "/lib/fog.glsl"

in vec2 texCoord;
in vec2 lightCoord;
in vec4 vertexColor;

uniform sampler2D gtexture;
uniform sampler2D lightmap;

uniform float fogStart;
uniform float fogEnd;
uniform vec3 fogColor;
uniform float far;

layout(location = 0) out vec4 pixelColor;

in float vertexDistance;

void main() {
    vec4 texColor = texture(gtexture, texCoord);

    if (texColor.a < 0.1) discard;

    if (vertexDistance > far) { // eh?
        discard;
    }

    vec4 lightColor = texture(lightmap, lightCoord);

    float fogValue = applyFog(vertexDistance, fogStart, fogEnd);
    vec4 finalColor = texColor * lightColor * vertexColor;

    pixelColor = vec4(mix(finalColor.xyz, fogColor, fogValue), finalColor.a);
}