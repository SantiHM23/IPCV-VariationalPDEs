function I_cont = lap_edge(f)
%f is the image with noise
laplacian = div(gradx(f), grady(f));
I_cont = change_sign(laplacian);
end