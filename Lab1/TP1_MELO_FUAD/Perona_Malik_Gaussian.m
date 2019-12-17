function Uk = Perona_Malik_Gaussian(f, dt, K, alpha)
%f is the noisy image
%dt is the time step
%K is the number of iterations
%alpha is

for k=0:K-1
    if k==0
        Uk=f;
    else
        eps = conv_gauss_krnl(f, dt, K);
%         imshow(eps)
        norm_eps=sqrt(gradx(eps).^2+grady(eps).^2);
        den = sqrt((norm_eps/alpha).^2+1);
        G = 1./den;
        Uk=Uk+dt*div(G.*gradx(Uk),G.*grady(Uk));
    end
end  
end