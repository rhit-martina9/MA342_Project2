function [] = SIR()

lag = 10;
history = [30*10^6; 30; 38];

sol1 = ddesd(@(t,P,Pdel) calcDP(t,P,Pdel,0.01),lag,history,[0,180]);

plot(sol1.x,sol1.y(1,:),'--g',sol1.x,sol1.y(3,:),'--r');

sol2 = ddesd(@(t,P,Pdel) calcDP(t,P,Pdel,0.02),lag,history,[0,180]);

hold on
plot(sol2.x,sol2.y(1,:),'g',sol2.x,sol2.y(3,:),'r');
hold off

figure;
plot(sol1.x,sol1.y(2,:),'--k',sol2.x,sol2.y(2,:),'k');

end

