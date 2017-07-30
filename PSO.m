%PSO CODE By Sajjad Yazdani <V 2013.1>
% Problem Parametters
% clc;
clear all;
Plm.FunNum=1;
Plm.Dim=2;
[Plm.Low,Plm.High]=LowHighTestFunction(Plm.FunNum,1,Plm.Dim);

%
PSO_Opt.Min=1;

PSO_Opt.SwarmNum=20;
PSO_Opt.TotalIterat=100;

PSO_Opt.C1=1;
PSO_Opt.C2=2;


PSO_Opt.VMax=0.1*repmat(Plm.High,PSO_Opt.SwarmNum,1);
PSO_Opt.VMin=-PSO_Opt.VMax;

PSO_Opt.wMax=0.9;
PSO_Opt.wMin=0.4;
PSO_Opt.Dim=Plm.Dim;

% Monitor Param
PSO_Opt.Mon.Enb=1;
if PSO_Opt.Mon.Enb
    if Plm.Dim==2
        PSO_Opt.Mon.Step=(Plm.High-Plm.Low)/30;
        PSO_Opt.Mon.X=Plm.Low(1):PSO_Opt.Mon.Step:Plm.High(1);
        PSO_Opt.Mon.Y=Plm.Low(2):PSO_Opt.Mon.Step:Plm.High(2);
        [PSO_Opt.Mon.X,PSO_Opt.Mon.Y]=meshgrid(PSO_Opt.Mon.X,PSO_Opt.Mon.Y);
        Nmon=numel(PSO_Opt.Mon.X);
        index=1:Nmon;
        X_(:,1)=PSO_Opt.Mon.X(index)';
        X_(:,2)=PSO_Opt.Mon.Y(index)';
        PSO_Opt.Mon.Z=PSO_Opt.Mon.X;
        PSO_Opt.Mon.Z(index)=TestFunction(X_,Plm.FunNum);
    else
        PSO_Opt.Mon.Enb=0;
    end
end

%Initialization
Low=repmat(Plm.Low,PSO_Opt.SwarmNum,1);
High=repmat(Plm.High,PSO_Opt.SwarmNum,1);
Swarms.X=unifrnd(Low,High);

Swarms.V=zeros(PSO_Opt.SwarmNum,PSO_Opt.Dim);

Swarms.Fit=TestFunction(Swarms.X,Plm.FunNum);

Swarms.pBest.X=Swarms.X;
Swarms.pBest.Fit=Swarms.Fit;

[Best,BestLoc]=max(Swarms.Fit);
Swarms.gBest.X=Swarms.X(BestLoc,:);
Swarms.gBest.Fit=Best;

for t=1:PSO_Opt.TotalIterat
    % Update w
    PSO_Opt.w(t)=PSO_Opt.wMax-(PSO_Opt.wMax-PSO_Opt.wMin)*t/PSO_Opt.TotalIterat;
    % calculate V
    Swarms.V=PSO_Opt.w(t)*Swarms.V+...
        PSO_Opt.C1*rand(PSO_Opt.SwarmNum,PSO_Opt.Dim).*(Swarms.pBest.X-Swarms.X)+...
        PSO_Opt.C2*rand(PSO_Opt.SwarmNum,PSO_Opt.Dim).*(repmat(Swarms.gBest.X,PSO_Opt.SwarmNum,1)-Swarms.X);
    Swarms.V=min(max(PSO_Opt.VMin,Swarms.V),PSO_Opt.VMax);
    % Update X
    Swarms.X=Swarms.X+Swarms.V;
    Swarms.X=min(max(Low,Swarms.X),High);
    % Evaluate Positions
    Swarms.Fit=TestFunction(Swarms.X,Plm.FunNum);
    if PSO_Opt.Min
        % Update Local Best
        Improved=find(Swarms.Fit<Swarms.pBest.Fit);
        Swarms.pBest.Fit(Improved)=Swarms.Fit(Improved);
        Swarms.pBest.X(Improved,:)=Swarms.X(Improved,:);
        % Update Global Best
        [Best,BestLoc]=min(Swarms.Fit);
        if Best<Swarms.gBest.Fit
            Swarms.gBest.X=Swarms.X(BestLoc,:);
            Swarms.gBest.Fit=Best;
        end

    else
        % Update Local Best
        Improved=find(Swarms.Fit>Swarms.pBest.Fit);
        Swarms.pBest.Fit(Improved)=Swarms.Fit(Improved);
        Swarms.pBest.X(Improved,:)=Swarms.X(Improved,:);
        % Update Global Best
        [Best,BestLoc]=max(Swarms.Fit);
        if Best>Swarms.gBest.Fit
            Swarms.gBest.X=Swarms.X(BestLoc,:);
            Swarms.gBest.Fit=Best;
        end
    end
    %% Monitor What hapend!!
    if PSO_Opt.Mon.Enb
        mesh(PSO_Opt.Mon.X,PSO_Opt.Mon.Y,PSO_Opt.Mon.Z);
        hold on
            plot3(Swarms.gBest.X(1),Swarms.gBest.X(2),Swarms.gBest.Fit,'sb')
            plot3(Swarms.X(:,1),Swarms.X(:,2),Swarms.Fit,'ok')
        hold off
        view(2)
        pause(.001);
    end
end
display(Swarms.gBest.X)

display(Swarms.gBest.Fit)