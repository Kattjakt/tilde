#version 330 compatibility

in vec2 texCoord;
in vec2 lightCoord;
in vec4 vertexColor;

uniform sampler2D gtexture;
uniform sampler2D lightmap;

layout(location = 0) out vec4 pixelColor;

in float vertexDistance;

void main() {
    vec4 texColor = texture(gtexture, texCoord);

    if (texColor.a < 0.1) discard;

    vec4 lightColor = texture(lightmap, lightCoord);

    pixelColor = texColor * vertexColor;
}