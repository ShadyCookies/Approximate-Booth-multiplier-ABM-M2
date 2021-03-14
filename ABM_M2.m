function [result] = ABM_M2 ( A , B , m)

	result = int32(0); 
    A = int32(A);
	B = int32(B);
	b2m1 = 0;
    ajm1 = 0;
    N = 16;
    
    for i = 0:2:N-1
        
		b2 = bitget(B,bin_index(i),'int32');
		b2p1 = bitget(B,bin_index(i+1),'int32');
        aj = bitget(A,1,'int32');
        pp(1) = PPG(aj,ajm1,b2p1,b2,b2m1);
        
        if m == 0 CF = 1 ; else CF = 0; end
        
        if m > 0
            a_sum = sum(bitget(A,1:m));
            if (a_sum > m / 2) aj = 1 ; 
            elseif ( a_sum <= m / 2 ) aj = 0;
            end
            pp(1) = PPG_2S(aj,b2p1,b2,b2m1);
        end
        
        for j = 2 : N-m+1-CF
            ajm1 = aj;
            aj = bitget(A,j+m-1);
            pp(j) = PPG( aj , ajm1 , b2p1 , b2 , b2m1 );
        end     
        
        pp = int32(binvec2dec_signed(pp));
        neg = and(b2p1,or(not(b2),not(b2m1)));
        pp = pp + int32(neg);
        result = result + bitshift(pp,m+i-1);
		b2m1 = b2p1;
        
    end
end
