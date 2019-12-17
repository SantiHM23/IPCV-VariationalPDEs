function phik = iterative_gradient_descent(I, phi, d, epsilon, lambda, c1, c2)
    %Calculation of equation 2.5
    PhigradX = gradx(phi);
    PhigradY = grady(phi);
    PhiTV = sqrt(PhigradX.^2 + PhigradY.^2 + epsilon^2);
    term1 = div(PhigradX./PhiTV, PhigradY./PhiTV);
    term2 = lambda * (I-c1).^2;
    term3 = lambda * (I-c2).^2;
    mj = max(max(d.*(term1-term2+term3)));
    tau = 1/(2*mj);
    phik = phi + tau*d.*(term1-term2+term3);
end