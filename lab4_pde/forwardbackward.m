function u = forwardbackward(u, h, z, f, lambda, K)
    
    for i = 1:10
        gradF = 2 * lambda * conv2((u-f), K, 'same');
        input = u-h*gradF;
        u = prox5(input, h, z);
%         u = fista(input, h, z);
    end
end