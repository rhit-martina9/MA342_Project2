%Computational Modeling Project 2
%El-Nino-La-Nina Oscillation Test Code
clc
clear all
close all

%Exercise 2
alpha=[1,1,1,1,1.2];
beta=[0,0,0,1,0.8];
gamma=[1,1,1,1,1];
k=[100,100,100,10,10];
lag1=[0.01,0.15,0.995,0.9,0.6];
lag2=[0,0,0,0.1,0.6];

historyt=linspace(-7,0,1000);
history1y=(0*historyt);
history2y=1+(0*historyt);
history3y=exp(historyt);
history4y=1+2*sin(historyt);

%Instances
for i=1:length(alpha)
    %h=0
    sol1=ddesd(@(t,T,Tdel)(-alpha(i)*tanh(k(i)*Tdel(1))+beta(i)*tanh(k(i)*Tdel(2))+gamma(i)*cos(2*pi*t)),[lag1(i),lag2(i)],@(t)(0),[0,20]);

    %h=1
    sol2=ddesd(@(t,T,Tdel)(-alpha(i)*tanh(k(i)*Tdel(1))+beta(i)*tanh(k(i)*Tdel(2))+gamma(i)*cos(2*pi*t)),[lag1(i),lag2(i)],@(t)(1),[0,20]);

    %h=exp(t)
    sol3=ddesd(@(t,T,Tdel)(-alpha(i)*tanh(k(i)*Tdel(1))+beta(i)*tanh(k(i)*Tdel(2))+gamma(i)*cos(2*pi*t)),[lag1(i),lag2(i)],@(t)(exp(t)),[0,20]);

    %h=1+2sin(t)
    sol4=ddesd(@(t,T,Tdel)(-alpha(i)*tanh(k(i)*Tdel(1))+beta(i)*tanh(k(i)*Tdel(2))+gamma(i)*cos(2*pi*t)),[lag1(i),lag2(i)],@(t)(1+2*sin(t)),[0,20]);

    %Plot
    figure(i)
    hold on
    plot(historyt,history1y,'b--',sol1.x,sol1.y,'b-',LineWidth=1.5)
    plot(historyt,history2y,'r--',sol2.x,sol2.y,'r-',LineWidth=1.5)
    plot(historyt,history3y,'g--',sol3.x,sol3.y,'g-',LineWidth=1.5)
    plot(historyt,history4y,'k--',sol4.x,sol4.y,'k-',LineWidth=1.5)
    xlabel('Time (t)')
    xlim([-7,20])
    ylabel('Temperatrue')
    legend('','h(1)=0','','h(t)=1','','h(t)=exp(t)','','h(t)=1+2sin(t)',Location='northeastoutside')
    hold off
end
