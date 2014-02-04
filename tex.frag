#version 400 compatibility
in vec2 vXY;
in vec3[19] branches;
uniform sampler3D Noise3;
float x, y;

float check(float bx, float by, float d)
{
	float dist = min( sqrt((x-bx) * (x-bx) + (y - by) * (y - by)), 
						sqrt((x-bx-1) * (x-bx-1) + (y - by) * (y - by)));
	return d - dist;
}

void main()
{
	float base = 1;
	x = vXY.x;
	y = vXY.y;
	float cX = 1;
	float cY = 1;
	int branchNum = -1;
	float dist;
	
	for(int c = 0; c < 19; c++)
	{
		if(branches[c].x < 0)
			discard;
		if(branches[c].x > 1)
			discard;
		
		dist = check(branches[c].x, branches[c].y, branches[c].z);
		if(dist >= 0)
		{
			branchNum = c;
			break;
		}	
	}
	
	if(branchNum >= 0)
	{
		float extra;
		extra = .9 * (dist / branches[branchNum].z);
		base = branches[branchNum].z;
		cX = branches[branchNum].x;
		cY = branches[branchNum].y;
	}
	
	gl_FragColor = vec4(base, cX, cY, 1);
}