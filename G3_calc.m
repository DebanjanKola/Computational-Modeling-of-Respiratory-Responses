function G3 = G3_calc(P_aO2)
    P_aO2_threshold = 104;
    G3_const = 4.72e-9;
    if P_aO2 <= P_aO2_threshold
        G3 = G3_const * (104 - P_aO2)^4.9;
    else
        G3 = 0;
    end
end
