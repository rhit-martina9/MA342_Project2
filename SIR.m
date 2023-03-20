function [] = SIR()

lag = [10];
history = [30*10^6; 30; 38];

sol1 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.01),lag,history,[0,180]);

plot(sol1.x,sol1.y(1,:),'--g',sol1.x,sol1.y(3,:),'--r');

sol2 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.02),lag,history,[0,180]);

hold on
plot(sol2.x,sol2.y(1,:),'g',sol2.x,sol2.y(3,:),'r');

title("Delayed SIR Model (Susceptible/Recovered)");
ylabel("Population");
xlabel("Time (t)");
legend("Susceptible, u=0.01","Recovered, u=0.01","Susceptible, u=0.02","Recovered, u=0.02");

hold off

figure;
plot(sol1.x,sol1.y(2,:),'--k',sol2.x,sol2.y(2,:),'k');

title("Delayed SIR Model (Infected)");
ylabel("Population");
xlabel("Time (t)");
legend("u=0.01","u=0.02");

end

