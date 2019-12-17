function Uk = Perona_Malik(f, dt, K, alpha)
%f is the noisy image
%dt is the time step
%K is the number of iterations
%alpha is
for k=0:K-1
    if k==0
        Uk=f;
    else
        eps = (sqrt((gradx(Uk)).^2 + (grady(Uk)).^2));
        den = sqrt((eps/alpha).^2+1);
        G = 1./den;
        Uk=Uk+dt*div(G.*gradx(Uk),G.*grady(Uk));
    end
end  
end