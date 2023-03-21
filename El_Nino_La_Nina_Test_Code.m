%Computational Modeling Project 2
%El-Nino-La-Nina Oscillation Test Code
clc
clear all
close all

%10.7
alpha=1.2;
historyt=linspace(-10,0,1000);

%h=1
sol1=ddesd(@(t,T,Tdel)(-alpha*Tdel+T),[10],@(t)(1),[0,3]);
history1y=1+(0*historyt);

%h=exp(t)
sol2=ddesd(@(t,T,Tdel)(-alpha*Tdel+T),[10],@(t)exp(t),[0,3]);
history2y=exp(historyt);

%h=1+2sin(t)
sol3=ddesd(@(t,T,Tdel)(-alpha*Tdel+T),[10],@(t)(1+2*sin(t)),[0,3]);
history3y=1+2*sin(historyt);

%Plot
figure(1)
hold on
plot(historyt,history1y,'b--',sol1.x,sol1.y,'b-',LineWidth=1.5)
plot(historyt,history2y,'r--',sol2.x,sol2.y,'r-',LineWidth=1.5)
plot(historyt,history3y,'k--',sol3.x,sol3.y,'k-',LineWidth=1.5)
xlabel('Time (t)')
ylabel('Temperatrue')
legend('','h(1)=1','','h(t)=exp(t)','','h(t)=1+2sin(t)',Location='northwest')
hold off

%10.8
clc
clear all
alpha=1.2;
historyt=linspace(-10,0,1000);

%h=1
sol1=ddesd(@(t,T,Tdel)(-alpha*Tdel+T-(T^3)),[10],1,[0,30]);
history1y=1+(0*historyt);

%h=exp(t)
sol2=ddesd(@(t,T,Tdel)(-alpha*Tdel+T-(T^3)),[10],@(t)exp(t),[0,30]);
history2y=exp(historyt);

%h=1+2sin(t)
sol3=ddesd(@(t,T,Tdel)(-alpha*Tdel+T-(T^3)),[10],@(t)(1+2*sin(t)),[0,30]);
history3y=1+2*sin(historyt);

%Plot
figure(2)
hold on
plot(historyt,history1y,'b--',sol1.x,sol1.y,'b-',LineWidth=1.5)
plot(historyt,history2y,'r--',sol2.x,sol2.y,'r-',LineWidth=1.5)
plot(historyt,history3y,'k--',sol3.x,sol3.y,'k-',LineWidth=1.5)
xlabel('Time (t)')
ylabel('Temperature')
legend('','h(1)=1','','h(t)=exp(t)','','h(t)=1+2sin(t)',Location='northeast')
hold off
