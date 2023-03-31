%Computational Modeling Project 2
%El-Nino-La-Nina Oscillation Test Code
clc
clear all
close all

Year_wanted=1950;
Year_gap=10;
Compare_start=0;
Compare_gap=20;

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
alphastep=0.2;
alphend=10;
alphaprev=5;
alphchange=100;

taustrt=0;
taustep=0.2;
tauend=15;
tauprev=5;
tauchange=100;

comppoints=500;
diffprev=10e15;
% diffworst=1;

tol=0.001;
MaxIter=8;
iter=1;

while(alphchange>tol && tauchange>tol && iter<MaxIter)

    for alpha=alphstrt:alphastep:alphend
        for tau=taustrt:taustep:tauend
            sol1=ddesd(@(t,T,Tdel)(-alpha*Tdel+T-(T^3)),[tau],@(t)(CubicSpline(histtime,histtemp,t)),[Compare_start,Compare_start+Compare_gap]);

            timegap=linspace(Compare_start,Compare_start+Compare_gap,comppoints);
            response=CubicSpline(sol1.x,sol1.y,timegap);
            compresp=CubicSpline(comptime,comptemp,timegap);

%             diff=norm(response-compresp,1);
%             diff=norm(response-compresp);
%             diff=norm(response-compresp,5); %Via Angus' suggestion
            diff=norm(response-compresp,"inf");

            if diff<diffprev
                alphabest=alpha;
                taubest=tau;
                diffprev=diff;
            end

%             if diff>diffworst
%                 alphaworst=alpha;
%                 tauworst=tau;
%                 diffworst=diff;
%             end
        end
    end

    alphchange=abs(alphaprev-alphabest);
    tauchange=abs(tauprev-taubest);

    alphstrt=0.85*alphabest;
    alphastep=0.75*alphastep;
    alphend=1.15*alphabest;

    taustrt=0.85*taubest;
    taustep=0.75*taustep;
    tauend=1.15*taubest;

    alphaprev=alphabest;
    tauprev=taubest;

    iter=iter+1;
end

solbest=ddesd(@(t,T,Tdel)(-alphabest*Tdel+T-(T^3)),[taubest],@(t)(CubicSpline(histtime,histtemp,t)),[Compare_start,Compare_start+Compare_gap]);
% solworst=ddesd(@(t,T,Tdel)(-alphaworst*Tdel+T-(T^3)),[tauworst],@(t)(CubicSpline(histtime,histtemp,t)),[Compare_start,Compare_start+Compare_gap]);

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
