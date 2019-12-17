function d = delta_eta(phi, epsilon)
    %Derivative of H (obtained by Heavyside_eta)
    d = epsilon./(pi*(phi.^2 + epsilon^2));
end