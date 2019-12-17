function I = conv_gauss_krnl(f,dt,K)
%f is the noisy image
%dt is the time step
%K is the number of iterations
sigmasq = 2*K*dt;
P = floor(K*dt+1);

G = fspecial('gaussian', 2*P-1, sqrt(sigmasq));
I = imfilter(f, G, 'replicate');
end