function [dP] = calcDP(t, P, Pdel, u, selection, lag)
    rho = 1174.17;
    alpha = 0.3095;
    delta = 3.9139*10^(-5);
    eps = 0.0063;
    beta = 0.2;
    
    dP = zeros(3,1);
    N = P(1)+P(2)+P(3);
    dP(1)=rho-alpha*P(1)*P(2)/N - delta*P(2);
    dP(2)=alpha*P(1)*P(2)/N-(beta+delta+eps)*P(2);
    dP(3)=beta*P(2)-delta*P(3);
    
    if (selection == 1 || selection == 3)  % vaccinations
        if lag(1) <= t
            dP(1)=dP(1)-u*Pdel(1,1);
            dP(3)=dP(3)+u*Pdel(1,1);
        end
    end
    
    if (selection == 2 || selection == 3) % Infection lifespan
        if lag(2) <= t
            old_N = Pdel(1,2)+Pdel(2,2)+Pdel(3,2);
            old_dI = alpha*Pdel(1,2)*Pdel(2,2)/old_N - (beta+delta+eps)*Pdel(2,2);
            dP(2) = dP(2) - old_dI;
            dP(3) = dP(3) + old_dI;
        end
    end
    
    if selection == -1
        alpha = 0.3095*10^(-7);
        beta = 0.2;
        dP(1)=-alpha*P(1)*P(2);
        dP(2)=alpha*P(1)*P(2)-beta*P(2);
        dP(3)=beta*P(2);
    end
end
