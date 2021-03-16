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
    
    if m == 0 CF = 1 ; else CF = 0; end                     % Correction for the partial product when m = 0
    
    for j = 1:N+1                                           % Generation of accurate partial product rows
        aj = bitget(A,j);
        pp_row(j) = PPG( aj , ajm1 , b2p1 , b2 , b2m1 );    
        ajm1 = aj;
    end
    
    if m > 0
        a_sum = sum(pp_row(1:m));                           % Determining aj value for approximate partial product generation
        if (a_sum > m / 2) aj = 1 ;
        else aj = 0;
        end
        pp_approx = PPG_2S(aj,b2p1,b2,b2m1);                % Generating the approximate partial product
        pp_row(m) = pp_approx;                              % LSB of (going to be) truncated partial product row replaced by approximate partial product
        pp_row = pp_row(m:N);                               % Truncation of partial product row by m bits
    end
    
    pp_row = int32(binvec2dec_signed(pp_row));              
    neg = b2p1 & (~b2 | ~b2m1);
    pp_row = pp_row + int32(neg);                           % Adding correction bit neg to partial product
    result = result + bitshift(pp_row,m+i-1+CF);            % CF is a correction for when m = 0
    b2m1 = b2p1;
    
end
end
