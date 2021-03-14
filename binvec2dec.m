function out = binvec2dec( bin )
    len = length(bin);
    if( bin(len) )
        out = -2^(len-1);
    else
        out = 0;
    end
    for i=1:len-1
            out = out + bin(i)*2^(i-1);
    end
end