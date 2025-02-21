#include "../settings.glsl"

// 0, 1, 2 are the interesting ones :)

uniform float far;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;
uniform float frameTimeCounter;

vec3 getViewPosition() {
    return (gl_ModelViewMatrix * gl_Vertex).xyz;
}

vec3 getWorldPosition() {
    vec3 eyeCameraPosition = cameraPosition + gbufferModelViewInverse[3].xyz;
    vec3 viewPos = getViewPosition();
    vec3 feetPlayerPos = (gbufferModelViewInverse * vec4(viewPos, 1.0)).xyz;
    vec3 worldPos = feetPlayerPos + cameraPosition;

    return worldPos;
}

vec3 getViewPositionFromWorldPosition(vec3 worldPos) {
    vec3 eyeCameraPosition = cameraPosition + gbufferModelViewInverse[3].xyz;
    vec3 eyePlayerPos = worldPos - eyeCameraPosition;
    vec3 viewPos = mat3(gbufferModelView) * eyePlayerPos;

    return viewPos;
}

vec3 getPlayerPosition() {
    vec3 eyeCameraPosition = cameraPosition + gbufferModelViewInverse[3].xyz;
    vec3 viewPos = getViewPosition();
    vec3 feetPlayerPos = (gbufferModelViewInverse * vec4(viewPos, 1.0)).xyz;
    vec3 worldPos = feetPlayerPos + cameraPosition;
    vec3 eyePlayerPos = worldPos - eyeCameraPosition;

    return eyePlayerPos;
}

vec3 getViewPositionFromPlayerPosition(vec3 eyePlayerPos) {
    vec3 eyeCameraPosition = cameraPosition + gbufferModelViewInverse[3].xyz;
    vec3 viewPos = mat3(gbufferModelView) * eyePlayerPos;

    return viewPos;
}

// default
#if STYLE == 0
vec3 effect() {
    vec3 position = getViewPosition();
    float distance_norm = length(position.xyz) / far;
    float offset = 0.0;

    float curvature = -0.0001;
    float activation = 0.9;

    if (distance_norm >= activation) {
        float amount =  smoothstep(0.0, 1.0, (distance_norm - activation) / (1 - activation));

        float peakOffset = far * far * curvature * amount;
        offset = peakOffset * (1.0 - amount * 2.0);

        offset = pow(offset, 2) * 2.0;
    }

    position.y -= offset;

    return position;
}
#endif

// increased motion
#if STYLE == 1
vec3 effect() {
    vec3 position = getViewPosition();
    float distance_norm = length(position.xyz) / far;
    float offset = 0.0;
    float curvature = -0.0001;
    float activation = 0.9;

    if (distance_norm >= activation) {
        float amount =  smoothstep(0.0, 1.0, (distance_norm - activation) / (1 - activation));
        float peakOffset = far * far * curvature * amount;

        offset = peakOffset * (1.0 - amount * 2.0);
        offset = pow(offset, 2) * 4.0;
    }

    position.y -= offset;

    return position;
}
#endif

// reduced motion
#if STYLE == 2
vec3 effect() {
    vec3 position = getPlayerPosition();
    float distance_norm = length(position.xz) / far;
    distance_norm = clamp(distance_norm, 0.0, 1.0);

    float a = 0.03;
    float b = 0.05;
    float offset = (a / (distance_norm - 1)) + a + (b * pow(distance_norm, 2.0));

    position.y += (offset * 10.0);

    return getViewPositionFromPlayerPosition(position);
}
#endif


// a complete mess
#if STYLE == 3
vec3 effect() {
    vec3 position = getPlayerPosition();
    float distance_norm = length(position.xz) / far;

    position.y += sin(position.y);

    return getViewPositionFromPlayerPosition(position);
}
#endif


// minimal world breathing
#if STYLE == 4
vec3 effect() {
    vec3 position = getViewPosition();
    float distance_norm = length(position.xz) / far;

    float weight = sin(frameTimeCounter + (length(gl_Vertex.xz) * 0.1));
    weight *= distance_norm / 5.0;
    position.y += weight * 10.0;

    return position;
}
#endif

// extreme world breathing
#if STYLE == 5
vec3 effect() {
    vec3 position = getViewPosition();
    float distance_norm = length(position.xyz) / far;

    float weight = sin(frameTimeCounter + (distance_norm * 10)) * 50;
    weight *= pow(distance_norm, 2);

    position.y += weight;

    return position;
}
#endif

// fishbowl
#if STYLE == 6
vec3 effect() {
    vec3 position = getViewPosition();
    float distance_norm = length(position.xyz) / far;
    float curvature = 0.001;

    float amount =  smoothstep(0.0, 1.0, distance_norm);

    float peakOffset = far * far * curvature * amount;
    float offset = peakOffset * (1.0 - amount * 2.0);

    position.y -= offset;

    return position;
}
#endif

// fishbowlyer
#if STYLE == 7
vec3 effect() {
    vec3 position = getViewPosition();
    float distance_norm = length(position.xyz) / far;
    float curvature = 0.002;

    float amount =  smoothstep(0.0, 1.0, distance_norm);

    float peakOffset = far * far * curvature * amount;
    float offset = peakOffset * (1.0 - amount * 2.0);

    position.y -= offset;

    return position;
}
#endif

// jagged mess
#if STYLE == 8
vec3 effect() {
    vec3 position = getWorldPosition();

    position.y += sin(position.z) * 1;

    return getViewPositionFromWorldPosition(position);
}
#endif


