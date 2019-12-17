function [mask, loss] = dual_formulation(z, mask, Image, c1, c2, sigma, tau, K, lambda, th)
    u_acc = mask;
    for k = 1:K
        pb = z + sigma * sqrt(gradx(u_acc).^2 + grady(u_acc).^2);
        if norm(pb,2) <=1
            z = pb;
        else
            z = pb/norm(pb,2);
        end
        term1 = (Image-c1).^2;
        term2 = (Image-c2).^2;
        u = mask + tau * (div(gradx(z), grady(z))-lambda*term1 + lambda*term2);
        mask2 = min(max(u,0),1);
        %%%%%%%% This is added for the acceleration purpose (when th /=0)%%%%%%%%
        u_acc = mask + th * (mask2 - mask);
        mask = mask2;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        loss(k,1) = k; 
        loss(k,2) = compute_energy(u_acc, term1, term2, lambda);
    end
end