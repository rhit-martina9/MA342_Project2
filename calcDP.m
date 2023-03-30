function [dP] = calcDP(t, P, Pdel, u, selection)
    rho = 1174.17;
    alpha = 0.3095;
    delta = 3.9139*10^(-5);
    eps = 0.0063;
    beta = 0.2;
    
    dP = zeros(3,1);
    N = P(1)+P(2)+P(3);
    if selection == 0 % Basic Model
        dP(1)=-alpha*P(1)*P(2);
        dP(2)=alpha*P(1)*P(2)-beta*P(2);
        dP(3)=beta*P(2);
    elseif selection == 1 % Vaccinations, no infected delay
        dP(1)=rho-alpha*P(1)*P(2)/N - delta*S(t)-u*Pdel(1,1);
        dP(2)=alpha*P(1)*P(2)/N-(beta+delta+eps)*P(2);
        dP(3)=beta*P(2)-delta*P(2)+u*Pdel(1,1);
    elseif selection == 2 % Infected delay, no vaccinations
        dP(1)=rho-alpha*P(1)*P(2)/N - delta*S(t);
        dP(2)=alpha*P(1)*P(2)/N-(beta+delta+eps)*P(2);
        dP(3)=beta*P(2)-delta*P(2);
        
        old_dI = beta*Pdel(1,1)*Pdel(2,1)/N - (gamma+d+eps)*Pdel(2,1);
        dP(2) = dP(2) - old_dI;
        dP(3) = dP(3) + old_dI;
    elseif selection == 3 % Infected delay and vaccinations
        dP(1)=rho-alpha*P(1)*P(2)/N - delta*S(t)-u*Pdel(1,1);
        dP(2)=alpha*P(1)*P(2)/N-(beta+delta+eps)*P(2);
        dP(3)=beta*P(2)-delta*P(2)+u*Pdel(1,1);
        
        old_dI = beta*Pdel(1,1)*Pdel(2,1)/N - (gamma+d+eps)*Pdel(2,1);
        dP(2) = dP(2) - old_dI;
        dP(3) = dP(3) + old_dI;
    end
    
end
