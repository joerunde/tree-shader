#version 400 compatibility
//#include "../gstap.h"
#extension GL_EXT_gpu_shader4: enable
#extension GL_EXT_geometry_shader4: enable

layout( triangles )  in;
layout( triangle_strip, max_vertices=224 )  out;

uniform sampler3D Noise3;

uniform float uShrink;
uniform float uNoiseAmp;
uniform float uNoiseFreq;
in int teLeaf[3];
in vec2 teUV[3];
in vec3 teNormal[3];
flat out int gLeaf;
out vec2 gUV;

flat out vec3 gNormalF;
     out vec3 gNormalS;
     out vec3 gPosition;

vec3 V[3];
vec3 CG;

void
ProduceVertex( int v )
{
	gNormalF = gNormalS = teNormal[v];
	gPosition = V[v];
	//gl_Position = uProjectionMatrix * vec4( CG + uShrink * ( V[v] - CG ), 1. );
	gl_Position = gl_ModelViewProjectionMatrix * vec4( CG + uShrink * ( V[v] - CG ), 1. );
	gUV = teUV[v];
	gLeaf = 0;
	//if(v == 2)
		//gLeaf = 1;
	EmitVertex();
}

void
ProduceLeaf( int v )
{
	vec4 nz = texture3D(Noise3, uNoiseFreq * 10 * V[v]);
	float lol = nz.r + nz.g + nz.b + nz.a;
	lol -= 1.666;
	lol -= .5;

	gNormalF = gNormalS = teNormal[v];
	gPosition = V[v];
	gl_Position = gl_ModelViewProjectionMatrix * vec4( CG + uShrink * ( V[v] - CG ), 1. );
	gUV = vec2(.1,1);
	gLeaf = 1;
	EmitVertex();
	
	vec3 dxz = cross(vec3(0,1,0), teNormal[v]);
	//dxz = teNormal[v];
	dxz.y = 0;
	dxz *= 2;
	dxz += teNormal[v];
	dxz.y = 0;
	dxz.x += uNoiseAmp * lol;
	dxz.z -= uNoiseAmp * lol;
	dxz = normalize(dxz);
	
	gNormalF = gNormalS = teNormal[v];
	gPosition = V[v];
	gPosition.y += 5;
	gPosition -= 2.5 * dxz;
	gl_Position = gl_ModelViewProjectionMatrix * vec4( gPosition, 1. );
	gUV = vec2(1,1);
	gLeaf = 2;
	EmitVertex();
	
	gNormalF = gNormalS = teNormal[v];
	gPosition = V[v];
	gPosition += 2.5 * dxz;
	gPosition.y += 5;
	gl_Position = gl_ModelViewProjectionMatrix * vec4( gPosition, 1. );
	gUV = vec2(1,0);
	gLeaf = 1;
	EmitVertex();
	
	gNormalF = gNormalS = teNormal[v];
	gPosition = V[v];
	gPosition += 2.5 * dxz;
	gl_Position = gl_ModelViewProjectionMatrix * vec4( gPosition, 1. );
	gUV = vec2(.1,0);
	gLeaf = 1;
	EmitVertex();
}


void
main()
{
	V[0]  =   gl_PositionIn[0].xyz;
	V[1]  =   gl_PositionIn[1].xyz;
	V[2]  =   gl_PositionIn[2].xyz;

	CG = ( V[0] + V[1] + V[2] ) / 3.;

	ProduceVertex( 0 );
	ProduceVertex( 1 );
	ProduceVertex( 2 );
	
	if(teLeaf[0] == 1)
		ProduceLeaf(0);
	if(teLeaf[1] == 1)
		ProduceLeaf(1);
	if(teLeaf[2] == 1)
		ProduceLeaf(2);
}
