function [] = SIR()
close all
lag = [10];
history = [2*10^(7); 30; 28];
options = odeset('NormControl', 'on', 'MaxStep', 1);

sol11 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.01,lag,0),lag,history,[0,180],options);
sol12 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.01,lag,1),lag,history,[0,180],options);
sol21 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.02,lag,0),lag,history,[0,180],options);
sol22 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.02,lag,1),lag,history,[0,180],options);

hold on
plot(sol11.x,sol11.y(1,:),'--g',sol11.x,sol11.y(3,:),'--r');
plot(sol21.x,sol21.y(1,:),  'g',sol21.x,sol21.y(3,:),  'r');

title("Delayed SIR Model (Susceptible/Recovered)");
ylabel("Population");
xlabel("Time (t)");
legend("Susceptible, u=0.01","Recovered, u=0.01","Susceptible, u=0.02","Recovered, u=0.02");

hold off

figure;
hold on
plot(sol12.x,sol12.y(1,:),'--g',sol12.x,sol12.y(3,:),'--r');
plot(sol22.x,sol22.y(1,:),  'g',sol22.x,sol22.y(3,:),  'r');

title("Delayed SIR Model (Susceptible/Recovered) - with Delay");
ylabel("Population");
xlabel("Time (t)");
legend("Susceptible, u=0.01","Recovered, u=0.01","Susceptible, u=0.02","Recovered, u=0.02");

hold off

figure;
hold on
plot(sol12.x,sol12.y(1,:)-sol11.y(1,:),'--g',sol12.x,sol12.y(3,:)-sol11.y(3,:),'--r');
plot(sol22.x,sol22.y(1,:)-sol21.y(1,:),  'g',sol22.x,sol22.y(3,:)-sol21.y(3,:),  'r');

title("Delayed SIR Model (Susceptible/Recovered) - Delay Difference");
ylabel("Population");
xlabel("Time (t)");
legend("Susceptible, u=0.01","Recovered, u=0.01","Susceptible, u=0.02","Recovered, u=0.02", "Susceptible, u=0.01","Recovered, u=0.01","Susceptible, u=0.02","Recovered, u=0.02");

hold off


figure;
plot(sol11.x,sol11.y(2,:),'--k',sol21.x,sol21.y(2,:),'k');

title("Delayed SIR Model (Infected)");
ylabel("Population");
xlabel("Time (t)");
legend("u=0.01","u=0.02");


figure;
plot(sol12.x,sol12.y(2,:),'--k',sol22.x,sol22.y(2,:),'k');

title("Delayed SIR Model (Infected) - with Delay");
ylabel("Population");
xlabel("Time (t)");
legend("u=0.01","u=0.02");

end

