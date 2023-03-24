%Computational Modeling Project 2
%El-Nino-La-Nina Oscillation Test Code
clc
clear all
close all

%Check with Figure 10.7
alpha=1.2;

A=xlsread('El Nino History Data Edited.xlsx');

[n_rows,n_cols]=size(A);

index=1;
for i=1:n_rows-8
    for j=1:12
        histtemp(index)=A(i,j);
        histtime(index)=A(i+8,j+12);
        index=index+1;
    end
end

index=1;
for i=n_rows-18:n_rows-8
    for j=1:12
        histsplntemp(index)=A(i,j);
        histsplntime(index)=A(i+8,j+12);
        index=index+1;
    end
end

timespan=linspace(-10,0,1000);
Z=CubicSpline(histsplntime,histsplntemp,timespan)';

%Historical Data
sol1=ddesd(@(t,T,Tdel)(-alpha*Tdel+T-(T^3)),[10],@(t)(CubicSpline(histsplntime,histsplntemp,t)),[0,30]);

%Plot
figure(10)
hold on
plot(histtime,histtemp,'k+')
plot(timespan,Z,'r-')
plot(sol1.x,sol1.y,'b-',LineWidth=1.5)
xlabel('Time (t)')
xlim([-71,30])
ylabel('Temperatrue')
hold off

%Exercise 3
alpha=[1,1,1,1,1.2];
beta=[0,0,0,1,0.8];
gamma=[1,1,1,1,1];
k=[100,100,100,10,10];
lag1=[0.01,0.15,0.995,0.9,0.6];
lag2=[0,0,0,0.1,0.6];

A=xlsread('El Nino History Data Edited.xlsx');

[n_rows,n_cols]=size(A);

index=1;
for i=1:n_rows
    for j=1:12
        histtemp(index)=A(i,j);
        histtime(index)=A(i,j+12);
        index=index+1;
    end
end

index=1;
for i=n_rows-10:n_rows
    for j=1:12
        histsplntemp(index)=A(i,j);
        histsplntime(index)=A(i,j+12);
        index=index+1;
    end
end

timespan=linspace(-10,0,1000);
Z=CubicSpline(histsplntime,histsplntemp,timespan)';

%Instances
for i=1:length(alpha)
    %Historical Data
    sol1=ddesd(@(t,T,Tdel)(-alpha(i)*tanh(k(i)*Tdel(1))+beta(i)*tanh(k(i)*Tdel(2))+gamma(i)*cos(2*pi*t)),[lag1(i),lag2(i)],@(t)(CubicSpline(histsplntime,histsplntemp,t)),[0,30]);

    %Plot
    figure(i)
    hold on
    plot(histtime,histtemp,'k+')
    plot(timespan,Z,'r-')
    plot(sol1.x,sol1.y,'b-',LineWidth=1.5)
    xlabel('Time (t)')
    xlim([-71,30])
    ylabel('Temperatrue')
    hold off
end
