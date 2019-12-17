function loss = compute_energy_smooth(u, I1, I2, lambda, epsilon)
    UgradX = gradx(u);
    UgradY = grady(u);
    term1 = sqrt(UgradX.^2 + UgradY.^2 + epsilon^2);
    term2 = I1.*u;
    term3 = I2.*(1-u);
    loss = sum(sum(term1)) + lambda*(sum(sum(term2))) + lambda*(sum(sum(term3)));
end