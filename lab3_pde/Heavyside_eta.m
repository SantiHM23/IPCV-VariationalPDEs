function H = Heavyside_eta(phi, epsilon)
    %Equation in page 5, second column, of the proposed paper
    H = 0.5*(1+(2/pi)*atan(phi/epsilon));
end