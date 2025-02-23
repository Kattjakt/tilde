#version 330 compatibility

varying vec4 texcoord;
varying vec3 normal;
varying vec4 color;
varying vec4 lmcoord;

uniform float fogStart;
uniform float fogEnd;
uniform vec3 fogColor;
uniform float far;
uniform sampler2D texture;
uniform sampler2D lightmap;

in float vertexDistance;

float applyFog(float vertexDistance, float fogStart, float fogEnd) {
	// start the fog a bit earlier to hide largely distorted vertices
  return vertexDistance < fogEnd
    ? smoothstep(fogStart * 0.9, fogEnd, vertexDistance)
    : 1.0;
}

void main() {
	if (vertexDistance > far) { // eh?
		discard;
	}

	gl_FragData[0] = texture2D(texture, texcoord.st) * (texture2D(lightmap, lmcoord.st)) * color;
	float fogValue = applyFog(vertexDistance, fogStart, fogEnd);
	gl_FragData[0].rgb = mix(gl_FragData[0].rgb, fogColor, fogValue);

	gl_FragData[1] = vec4(vec3(gl_FragCoord.z), 1.0);
	gl_FragData[4] = vec4(0.0, 0.0, 1.0, 1.0);
}