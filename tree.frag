#version 400 core
//#include "../gstap.h"

uniform float uLightX, uLightY, uLightZ;
uniform float uKa, uKd;
uniform bool  uFlat;
//uniform vec4  uColor;
uniform sampler2D uTrunkTex;
uniform sampler2D uLeafTex;
in vec2 gUV;
flat in int gLeaf;


flat in vec3 gNormalF;
     in vec3 gNormalS;
     in vec3 gPosition;

out vec4 FragColor;

void main( )
{
	vec3 lightPos = vec3( uLightX, uLightY, uLightZ );
	float lightIntensity  = dot( normalize( lightPos - gPosition ), uFlat ? gNormalF : gNormalS );
	if(lightIntensity < 0)
		lightIntensity = 0;
	vec4 trunkColor = texture2D(uTrunkTex, gUV);
	if(gLeaf == 2)
		discard;
	if(gLeaf > 0)
	{
		trunkColor = texture2D(uLeafTex, gUV);
		if(trunkColor.r < .15 && trunkColor.g < .15 && trunkColor.b < .15)
			discard;
	}
	FragColor = vec4(  ( uKa + uKd*lightIntensity ) * trunkColor.rgb, 1.  );
}
