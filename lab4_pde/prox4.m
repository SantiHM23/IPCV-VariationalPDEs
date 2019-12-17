function F = prox4(u, h)
    if u > h
        F = u-h;
    elseif u < -h
        F = u+h;
    elseif abs(u) <= h
        F = 0;
    end
end