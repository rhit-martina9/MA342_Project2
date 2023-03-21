%Computational Modeling Project 2
%Innoculation Test Code
clc
clear all
close all

%S(t) is the susceptible people, P(1)
%I(t) is the infrected people, P(2)
%R(t) are the recovered people, P(3)

ti=0;
tf=180;
lag = 10;
history = [30*10^(6); 30; 28];
options = odeset('NormControl','on','MaxStep', 1);

sol1=ddesd(@(t,P,Pdel)calcDP(t,P,Pdel,0.01), [lag], history, [ti,tf], options);
sol2=ddesd(@(t,P,Pdel)calcDP(t,P,Pdel,0.02), [lag], history, [ti,tf], options);

%Plots found in Book
figure(1)
hold on
plot(sol1.x,sol1.y(1,:),'g:',sol1.x,sol1.y(3,:),'r:')
plot(sol2.x,sol2.y(1,:),'g-',sol2.x,sol2.y(3,:),'r-')
xlabel('Time (t)')
ylabel('Population')
legend('u=0.01 Susceptible','u=0.01 Recovered','u=0.02 Susceptible','u=0.02 Recovered',Location='east')
hold off

figure(2)
hold on
plot(sol1.x,sol1.y(2,:),'k:')
plot(sol2.x,sol2.y(2,:),'k-')
xlabel('Time (t)')
ylabel('Population')
legend('u=0.01 infected','u=0.02 infected')
hold off
%--------------------------------------------------------------------------
function [dP] = calcDP(t, P, Pdel, u)
alpha = 0.3095;
beta = 0.2;
rho = 1174.17;
epsilon = 0.0063;
delta = 3.9139e-5;
dP = zeros(3,1);
N = P(1)+P(2)+P(3);
%C=10;
%N = (rho-C*exp(-delta*t))/delta;
dP(1) = rho - alpha*P(1)*P(2)/N - delta*P(1) - u*Pdel(1,1);
dP(2) = alpha*P(1)*P(2)/N - (beta+delta+epsilon)*P(2);
dP(3) = beta*P(2) - delta*P(3) + u*Pdel(1,1);
end
%--------------------------------------------------------------------------