function [phi, loss, k, diffofnorm] = chanvese(Image, phi, epsilon, K, lambda, n, threshold)
    H = zeros(size(phi));
    k = 1;
    loss = zeros(k,2);
    diffofnorm = zeros(k,1);
    diff = 2*threshold;
    %Alternate Minimization
    while k<K %&& diff>threshold
        H2 = Heavyside_eta(phi, epsilon);
        d = delta_eta(phi, epsilon);
        c1 = (sum(sum(Image.*H2)))/(sum(sum(H2)));
        c2 = (sum(sum(Image.*(1-H2))))/(sum(sum(1-H2)));
        phi = iterative_gradient_descent(Image, phi, d, epsilon, lambda, c1, c2);
        if mod(k,n) == 0
            phi = signed_distance_from_mask(phi>0);
        end
        loss(k,1) = k;
        I1 = (Image - c1).^2;
        I2 = (Image - c2).^2;
        loss(k,2) = compute_energy_smooth(H2, I1, I2, lambda, epsilon);
        diff = norm(H2-H,2);
        diffofnorm(k) = diff;
        H = H2;
        k = k+1;
    end
   
end
