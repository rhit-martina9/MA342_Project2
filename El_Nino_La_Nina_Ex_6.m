%Computational Modeling Project 2
%El-Nino-La-Nina Oscillation Test Code
clc
clear all
close all

Year_wanted=1950;
Year_gap=10;
Compare_start=0;
Compare_gap=10;

A=xlsread('El Nino History Data.xlsx');
[val,loc]=min(abs(A(:,1)-Year_wanted));
Hist=A(loc:loc+Year_gap-1,:);
Comp=A(loc+Year_gap+Compare_start:loc+Year_gap+Compare_start+Compare_gap-1,:);

[n_rowsH,n_colsH]=size(Hist);
[n_rowsC,n_colsC]=size(Comp);

index=1;
for i=1:n_rowsH
    for j=2:13
        histtemp(index)=Hist(i,j);
        histtime(index)=-Compare_start-Year_gap+(index-1)/12;
        index=index+1;
    end
end

index=1;
for i=1:n_rowsC
    for j=2:13
        comptemp(index)=Comp(i,j);
        comptime(index)=(index-1)/12;
        index=index+1;
    end
end

alphstrt=0;
alphastep=0.1;
alphend=5;
alphaprev=5;
alphchange=100;

tau1strt=0;
tau1step=0.1;
tau1end=2;
tau1prev=5;
tau1change=100;

betastrt=0;
betastep=0.1;
betaend=5;
betaprev=5;
betachange=100;

tau2strt=0;
tau2step=0.1;
tau2end=2;
tau2prev=5;
tau2change=100;

comppoints=500;
diffprev=10e15;

tol=0.001;
MaxIter=4;
iter=1;

k=10;
gamma=1;

while(alphchange>tol && tau1change>tol && betachange>tol && tau2change>tol &&iter<MaxIter)
    for alpha=alphstrt:alphastep:alphend
        for tau1=tau1strt:tau1step:tau1end
            for beta=betastrt:betastep:betaend
                for tau2=tau2strt:tau2step:tau2end
                    sol1=ddesd(@(t,T,Tdel)(-alpha*tanh(k*Tdel(1))+beta*tanh(k*Tdel(2))+gamma*cos(2*pi*t)),[tau1,tau2],@(t)(CubicSpline(histtime,histtemp,t)),[Compare_start,Compare_start+Compare_gap]);

                    timegap=linspace(Compare_start,Compare_start+Compare_gap,comppoints);
                    response=CubicSpline(sol1.x,sol1.y,timegap);
                    compresp=CubicSpline(comptime,comptemp,timegap);

                    %             diff=norm(response-compresp,1);
                    %             diff=norm(response-compresp);
                    %             diff=norm(response-compresp,5); %Via Angus' suggestion
                    diff=norm(response-compresp,"inf");

                    if diff<diffprev
                        alphabest=alpha;
                        tau1best=tau1;
                        betabest=beta;
                        tau2best=tau2;
                        diffprev=diff;
                    end
                end
            end
        end
    end

    alphchange=abs(alphaprev-alphabest);
    tau1change=abs(tau1prev-taubest);

    alphstrt=0.85*alphabest;
    alphastep=0.85*alphastep;
    alphend=1.15*alphabest;

    tau1strt=0.85*tau1best;
    tau1step=0.85*tau1step;
    tau1end=1.15*tau1best;

    betastrt=0.85*betabest;
    betastep=0.85*betastep;
    betaend=1.15*betabest;

    tau2strt=0.85*tau2best;
    tau2step=0.85*tau2step;
    tau2end=1.15*tau2best;

    alphaprev=alphabest;
    tau1prev=taubest;
    betaprev=betabest;
    tau2prev=tau2best;

    iter=iter+1;
end

sol1=ddesd(@(t,T,Tdel)(-alphabest*tanh(k*Tdel(1))+betabest*tanh(k*Tdel(2))+gamma*cos(2*pi*t)),[tau1best,tau2best],@(t)(CubicSpline(histtime,histtemp,t)),[Compare_start,Compare_start+Compare_gap]);

figure(1)
hold on
plot(histtime,histtemp,'kx')
plot(solbest.x,solbest.y,'b-')
plot(comptime,comptemp,'k.')
hold off
xlabel('Time (t)')
ylabel('Temperatrue')
start_time=Year_wanted+Year_gap+Compare_start;
legend(sprintf("Historical Data Starting at " +Year_wanted),'Best Solution',sprintf("Historical Data Starting at " +start_time))
