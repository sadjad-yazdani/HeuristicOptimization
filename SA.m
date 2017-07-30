%Simulated Anneling Code By Sajjad Yazdani

clc; clear all;close all;
%% Problem Parametters
Plm.FunNum=7;
Plm.Dim=2;

[Plm.Low,Plm.High]=LowHighTestFunction(Plm.FunNum,1,Plm.Dim);

%% Algorithem Parametters
SAOpt.T=3; %Temprature
SAOpt.MaxIteration=1000;
SAOpt.MaxTry=50;
SAOpt.Dx=(Plm.High-Plm.Low)/4;
SAOpt.Landa=0.8;
SAOpt.Min=1;


% Monitor Param
SAOpt.Mon.Enb=1;
if SAOpt.Mon.Enb
    if Plm.Dim==2
        SAOpt.Mon.Step=(Plm.High-Plm.Low)/30;
        SAOpt.Mon.X=Plm.Low(1):SAOpt.Mon.Step:Plm.High(1);
        SAOpt.Mon.Y=Plm.Low(2):SAOpt.Mon.Step:Plm.High(2);
        [SAOpt.Mon.X,SAOpt.Mon.Y]=meshgrid(SAOpt.Mon.X,SAOpt.Mon.Y);
        Nmon=numel(SAOpt.Mon.X);
        index=1:Nmon;
        X_(:,1)=SAOpt.Mon.X(index)';
        X_(:,2)=SAOpt.Mon.Y(index)';
        SAOpt.Mon.Z=SAOpt.Mon.X;
        SAOpt.Mon.Z(index)=TestFunction(X_,Plm.FunNum);
    else
        SAOpt.Mon.Enb=0;
    end
end

%% Initialization
X=Plm.Low+(Plm.High-Plm.Low).*rand(1,Plm.Dim);
fit=TestFunction(X,Plm.FunNum);

Ans=X;
Ans_fit=fit;

Plot_Ans_fit=[];
Plot_fit=[];
Try=1;
%% main loop
for Itr=1:SAOpt.MaxIteration
    Y=X;
    ind=1+fix(rand*(Plm.Dim));

    Y(ind)=Y(ind)+SAOpt.Dx(ind)*(2*rand-1);
    Y=Y.*((Y>Plm.Low).*(Y<Plm.High))+(Plm.Low+(Plm.High-Plm.Low).*rand(1,Plm.Dim)).*((Y<Plm.Low)+(Y>Plm.High));
    Y_fit=TestFunction(Y,Plm.FunNum);
    if ((Y_fit>fit)&&~SAOpt.Min)||(Y_fit<fit)&&SAOpt.Min
        X=Y;
        fit=Y_fit;
    else
        P=exp(-abs(fit-Y_fit)/SAOpt.T);
        if rand<P
            X=Y;
            fit=Y_fit;
        end
    end

    if ((fit>Ans_fit)&&~SAOpt.Min)||(fit<Ans_fit)&&SAOpt.Min
        Ans=X;
        Ans_fit=fit;
    end
    % Monitor What hapend!!
    if SAOpt.Mon.Enb
        mesh(SAOpt.Mon.X,SAOpt.Mon.Y,SAOpt.Mon.Z);
        hold on
            plot3(Ans(1),Ans(2),Ans_fit,'sb')
            plot3(X(1),X(2),fit,'ok')
        hold off
        view(2)
        pause(.001);
    end
    
    BestSoFar(Itr)=Ans_fit; %#ok<SAGROW>
    
    Try=Try+1;
    if Try>SAOpt.MaxTry
        Try=1;
        SAOpt.T=SAOpt.Landa*SAOpt.T;
        SAOpt.Dx=SAOpt.Dx*SAOpt.Landa;
    end
end
plot(BestSoFar)
Ans %#ok<NOPTS>
Ans_fit %#ok<NOPTS>
