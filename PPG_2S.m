function [PP] = PPG_2S( aj , b2p1 , b2 , b2m1 )
    neg = b2p1 & (~b2 | ~b2m1);
    zero = (~b2p1 & ~b2 & ~b2m1) | (b2p1 & b2 & b2m1);
    PP = (~aj & neg) | (aj & ~neg & ~zero);
end