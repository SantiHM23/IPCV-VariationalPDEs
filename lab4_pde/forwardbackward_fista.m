function u = forwardbackward_fista(u, h, z, f, lambda, K, it1, it2)
    
    for i = 1:it1
        gradF = 2 * lambda * conv2((u-f), K, 'same');
        input = u-h*gradF;
        u = fista(input, h, z, it2);
    end
end