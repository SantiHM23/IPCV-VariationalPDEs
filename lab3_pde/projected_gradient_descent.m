function [uk, loss_m2] = projected_gradient_descent(I, uk, tau, lambda, c1, c2, epsilon, K)
    %Based on function 3.7
    for k = 1:K
        UgradX = gradx(uk);
        UgradY = grady(uk);
        UTV = sqrt(UgradX.^2 + UgradY.^2 + epsilon^2);
        term1 = div(UgradX./UTV, UgradY./UTV);
        term2 = lambda * (I-c1).^2;
        term3 = lambda * (I-c2).^2;
        u = uk + tau*(term1-term2+term3);
        uk = min(max(u,0),1);
        loss_m2(k,1) = k; 
        loss_m2(k,2) = compute_energy_smooth(u, term2/lambda, term3/lambda, lambda, epsilon);
    end
end