function I_cont = grad_edge(f,mu)
%f is the image with noise
%mu is a threshold

if (mu<=0)
    disp("Error: Value of Threshold(mu) should be greater than 0");
    return
end

Igradx = gradx(f);
Igrady = grady(f);
I = sqrt(Igradx.^2 + Igrady.^2);
I_cont = I > mu;
end