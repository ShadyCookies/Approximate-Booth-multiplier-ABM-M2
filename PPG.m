function [PP] = PPG( aj , ajm1 , b2p1 , b2 , b2m1 )
    neg = b2p1 & (~b2 | ~b2m1);
    two = (~b2p1 & b2 & b2m1) | (b2p1 & ~b2 & ~b2m1);
    zero = (~b2p1 & ~b2 & ~b2m1) | (b2p1 & b2 & b2m1);
    m = (aj & ~two) | (ajm1 & two);
    PP = ~zero & xor(neg,m);
end