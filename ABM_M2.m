function [result] = ABM_M2( A , B , m)

	result = int32(0); 
    A = int32(A);
	B = int32(B);
	b2m1 = 0;
    ajm1 = 0;
    N = 16;

    for i = 0:2:N-1
        
		b2 = bitget(B,bin_index(i));
		b2p1 = bitget(B,bin_index(i+1));

        if m == 0 CF = 1 ; else CF = 0; end		% Correction for partial product when m = 0
        
        for j = 1:N+1					% Generation of accurate partial product row
            aj = bitget(A,j);
            pp_row(j) = PPG( aj , ajm1 , b2p1 , b2 , b2m1 );
            ajm1 = aj;
        end  
            
        if m > 0					% Truncation of partial product row by m bits , replacing it with a single approximated bit
            a_sum = sum(pp_row(1:m));
            if (a_sum > m / 2) aj = 1 ;
            else aj = 0;
            end
            pp_approx = PPG_2S(aj,b2p1,b2,b2m1);	% Generation of approximate bit
            pp_row(m) = pp_approx;
            pp_row = pp_row(m:N);			% Truncation of partial product row
        end
        
        pp_row = int32(binvec2dec_signed(pp_row));
        neg = b2p1 & (~b2 | ~b2m1);
        pp_row = pp_row + int32(neg);        			% Adding neg as correction bit 
        result = result + bitshift(pp_row,m+i-1+CF);		% CF is a correction number
        b2m1 = b2p1;
        
    end
end
