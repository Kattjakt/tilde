#include "../settings.glsl"

float applyFog(float vertexDistance, float fogStart, float fogEnd) {
  return vertexDistance < fogEnd
    ? smoothstep(fogStart * 0.9, fogEnd, vertexDistance)
    : 1.0;
}