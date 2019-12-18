function u = forwardbackward_inpainting(f, h, z, lambda, M, it1, it2)
    u = f;
    for i = 1:it1
        gradF = 2 * lambda * M.*(M.*u-f);
        input = u-h*gradF;
        u = prox5(input, h, z, it2);
    end
end