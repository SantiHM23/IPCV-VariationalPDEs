function F = prox5(x, h, z)
    tau = 0.1;
    for i = 1:100
        term = div(z(:,:,1), z(:,:,2))+(x/h);

        GradXH = -2*gradx(term);
        GradYH = -2*grady(term);

        Pcx = z(:,:,1)-tau*GradXH;
        Pcy = z(:,:,2)-tau*GradYH;

        Pcnorm = sqrt(Pcx.^2 + Pcy.^2);

        z(:,:,1) = (Pcx)./(max(1, Pcnorm));
        z(:,:,2) = (Pcy)./(max(1, Pcnorm));

        F = x + h.* div(z(:,:,1), z(:,:,2));
    end
end