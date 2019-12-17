function F = prox2(x, h, f)
    F = (x+h*f)/(1+h);
end