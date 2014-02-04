#version 400 compatibility
#define VERTEX_SHADER
//#include "../gstap.h"

out vec3  vCenter;
out float vRadius;

void main( )
{
	vCenter = gl_Vertex.xyz;
	vRadius = gl_Vertex.w;
	int id = int(gl_Vertex.w);
	int xCount = 0;
	int yCount = 0;
	xCount = id / 8;
	yCount = id % 8;

	gl_Position = vec4( xCount, yCount, 0., 1. );
}
