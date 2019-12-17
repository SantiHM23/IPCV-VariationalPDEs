function u = forwardbackward_inpainting(f, h, z, lambda, M)
    u = f;
    for i = 1:100
        gradF = 2 * lambda * M.*(M.*u-f);
        input = u-h*gradF;
        u = prox5(input, h, z);
%         u = fista(input, h, z);
    end
end