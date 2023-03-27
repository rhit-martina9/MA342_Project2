function [dP] = calcDP(t, P, Pdel, u, lag, delay)
    Gamma = 1174.17;
    beta = 0.3095;
    d = 3.9139*10^(-5);
    eps = 0.0063;
    gamma = 0.2;
    dP = zeros(3,1);
    N = P(1)+P(2)+P(3);
    dP(1) = Gamma - beta*P(1)*P(2)/N - u*Pdel(1,1);
    dP(2) = beta*P(1)*P(2)/N - (gamma+d+eps)*P(2);
    dP(3) = gamma*P(2) - d*P(3) + u*Pdel(1,1);
    if t>=lag && delay == 1
        old_dI = beta*Pdel(1,1)*Pdel(2,1)/N - (gamma+d+eps)*Pdel(2,1);
        dP(2) = dP(2) - old_dI;
        dP(3) = dP(3) + old_dI;
    end
end
