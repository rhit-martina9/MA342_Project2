function [] = SIR()
close all
lag = [10];
history = [3*10^(7); 30; 28];
options = odeset('NormControl', 'on', 'MaxStep', 1);
endStep = 200;

sol10 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,  [],0),lag,history,[0,endStep],options);
%sol11 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.01,1),lag,history,[0,endStep],options);
%sol12 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,  [],2),lag,history,[0,endStep],options);
%sol13 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.01,3),lag,history,[0,endStep],options);
%sol21 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.02,1),lag,history,[0,endStep],options);
%sol23 = dde23(@(t,P,Pdel) calcDP(t,P,Pdel,0.02,3),lag,history,[0,endStep],options);

% basic figure
hold on
plot(sol10.x,sol10.y(1,:),'g',sol10.x,sol10.y(3,:),'r');

title("SIR Model (Susceptible/Recovered)");
ylabel("Population");
xlabel("Time (t)");
legend("Susceptible","Recovered");
hold off

figure;
hold on
plot(sol10.x,sol10.y(2,:),'k');

title("SIR Model (Infected)");
ylabel("Population");
xlabel("Time (t)");
legend("Susceptible","Recovered");
hold off

% with vaccinations/short-lived disease
figure;
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
legend("Susceptible, u=0.01","Recovered, u=0.01","Susceptible, u=0.02","Recovered, u=0.02");

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

figure;
plot(sol11.x,sol11.y(1,:)+sol11.y(2,:)+sol11.y(3,:),'--k',sol21.x,sol21.y(1,:)+sol21.y(2,:)+sol21.y(3,:),'k');

title("Delayed SIR Model (Total Population)");
ylabel("Population");
xlabel("Time (t)");
legend("u=0.01","u=0.02");


figure;
plot(sol12.x,sol12.y(1,:)+sol12.y(2,:)+sol12.y(3,:),'--k',sol22.x,sol22.y(1,:)+sol22.y(2,:)+sol22.y(3,:),'k');

title("Delayed SIR Model (Total Population) - with Delay");
ylabel("Population");
xlabel("Time (t)");
legend("u=0.01","u=0.02");

end

