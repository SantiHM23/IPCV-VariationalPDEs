function uK = heat_equation(f,dt,K)
%f is the noisy image
%dt is the time step
%K is the number of iterations
for k=0:K-1
    if k==0
        uK=f;
    else
        uK=uK+dt*div(gradx(uK),grady(uK));  
    end
end    
end