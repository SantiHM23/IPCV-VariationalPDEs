function I = Marr_Hildreth(u, mu)
%u is the image with noise
%mu is a threshold

if (mu<=0)
    disp("Error: Value of mu should be greater than 0");
    return
end

Igrad = grad_edge(u, mu);
Ilap = lap_edge(u);
I = Igrad.*Ilap;
end