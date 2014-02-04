#version 400 compatibility
out vec2 vXY;
out vec3[19] branches;
uniform sampler3D Noise3;

void main()
{
	vXY = gl_Vertex.xy / 2. + .5;
	gl_Position = gl_Vertex;
	
	branches[0] = vec3(.93, .65, .055);
	branches[1] = vec3(.27, .94, .05);
	branches[2] = vec3(.32, .8, .06);
	branches[3] = vec3(.65, .75, .061);
	branches[4] = vec3(.852, .85, .04);
	
	branches[5] = vec3(.16, .5, .06);
	branches[6] = vec3(.38, .65, .055);
	branches[7] = vec3(.41, .3, .065);
	branches[8] = vec3(.73, .55, .07);
	branches[9] = vec3(.917, .52, .045);
	
	branches[10] = vec3(.823, .25, .065);
	branches[11] = vec3(.164, .7, .06);
	branches[12] = vec3(.223, .35, .07);
	branches[13] = vec3(.91867, .34, .075);
	branches[14] = vec3(.6536, .4, .05);
	
	branches[15] = vec3(.1526, .18, .07);
	branches[16] = vec3(.32345, .1, .08);
	branches[17] = vec3(.637, .09, .085);
	branches[18] = vec3(.85235, .1, .06);
	
}