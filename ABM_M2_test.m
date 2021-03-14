m = 2;
i = int32(0);
j = int32(0);
RED = int32(0)
resolution = 7
for i=-256:255
	for j=-256:255
		if(i~=0 && j~=0)
			a=  double(i*j);
			RED =double(RED)+abs(double(i*j-ABM_M2(i,j,m))/a);

		end
	end
end
MRED =  vpa((RED)/(2^32))