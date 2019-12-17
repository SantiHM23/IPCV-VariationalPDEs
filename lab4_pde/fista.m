function F = fista(u, h, z)
    y1 = u;
    y2 = u;
    tau = 0.1;
    t1 = 1;
    for i = 1:100
        term = div(y1, y2)+(u/h);

        GradXH = -2*gradx(term);
        GradYH = -2*grady(term);

        Pcx = y1-tau*GradXH;
        Pcy = y2-tau*GradYH;

        Pcnorm = sqrt(Pcx.^2 + Pcy.^2);

        z1(:,:,1) = (Pcx)./(max(1, Pcnorm));
        z1(:,:,2) = (Pcy)./(max(1, Pcnorm));
        
        t2 = (1+sqrt(1+4*t1^2))/2;
        
        y1 = z(:,:,1) + ((t1-1)/t2)*(z1(:,:,1) - z(:,:,1));
        y2 = z(:,:,2) + ((t1-1)/t2)*(z1(:,:,2) - z(:,:,2));
        
        t1 = t2;
        z = z1;

        F = u + h.* div(z(:,:,1), z(:,:,2));
    end
end