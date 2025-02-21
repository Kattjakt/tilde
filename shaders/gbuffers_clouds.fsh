#version 120

uniform sampler2D texture;

uniform int fogMode;
const int GL_LINEAR = 9729;
const int GL_EXP = 2048;

uniform int isEyeInWater;
uniform float far;

varying vec4 color;
varying vec2 coord0;

void main()
{
    vec4 col = color * texture2D(texture, coord0);

    if(fogMode == GL_LINEAR){
        float fog = clamp((gl_FogFragCoord-gl_Fog.start) * gl_Fog.scale, 0., 1.);
        col.rgb = mix(col.rgb, gl_Fog.color.rgb, fog);
    } else if(fogMode == GL_EXP || isEyeInWater >= 1){
        float fog = 1.-clamp(exp(-gl_FogFragCoord * gl_Fog.density), 0., 1.);
        col.rgb = mix(col.rgb, gl_Fog.color.rgb, fog);
    }

    // wtf
    col.a = 1.0 - clamp(gl_FogFragCoord / far, 0.0, 1.0);

    /*DRAWBUFFERS:0*/
    gl_FragData[0] = col;
}
