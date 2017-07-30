% Harmony Search Algorithm
%By Sajjad Yazdani

clc;clear all;close all
%% Problem Prametters
Plm.FunNum=1;
Plm.Dim=2; % problem Dimention
% Plm.Low Boundry of Problem
% Plm.High Boundry of Problem
[Plm.Low,Plm.High]=LowHighTestFunction(Plm.FunNum,1,Plm.Dim);

%% Harmony Search Parametters
HSOpt.Min=1; % Minimaization or maximaiz of Fun? if HSOp.Min=1 it will be minimaze the function and if HSOp.Min=0 it will be maximized the function.
HSOpt.HMS=100;%Harmony Memory Size (Population Number)
HSOpt.bw=0.2;
HSOpt.HMCR=0.95;%[1], Harmony Memory Considering Rate
HSOpt.PAR=0.3;%[1], Pitch Adjustment Rate
HSOpt.TotalIterat=100;% Maximum number of Iteration

% Monitor Param
HSOpt.Mon.Enb=1;
if HSOpt.Mon.Enb
    if Plm.Dim==2
        HSOpt.Mon.Step=(Plm.High-Plm.Low)/30;
        HSOpt.Mon.X=Plm.Low(1):HSOpt.Mon.Step:Plm.High(1);
        HSOpt.Mon.Y=Plm.Low(2):HSOpt.Mon.Step:Plm.High(2);
        [HSOpt.Mon.X,HSOpt.Mon.Y]=meshgrid(HSOpt.Mon.X,HSOpt.Mon.Y);
        Nmon=numel(HSOpt.Mon.X);
        index=1:Nmon;
        X_(:,1)=HSOpt.Mon.X(index)';
        X_(:,2)=HSOpt.Mon.Y(index)';
        HSOpt.Mon.Z=HSOpt.Mon.X;
        HSOpt.Mon.Z(index)=TestFunction(X_,Plm.FunNum);
    else
        HSOpt.Mon.Enb=0;
    end
end


%% Initialization
%Initialization
Low=repmat(Plm.Low,HSOpt.HMS,1);
High=repmat(Plm.High,HSOpt.HMS,1);
HM=unifrnd(Low,High);
HF=TestFunction(HM,Plm.FunNum);


if HSOpt.Min==1
    [WorstFit,WorstLoc]=max(HF);
else
    [WorstFit,WorstLoc]=min(HF);
end


%% Iteration Loop
for Itr=1:HSOpt.TotalIterat
    HarmonyIndex=fix(rand(1,Plm.Dim)*HSOpt.HMS)+1;% Random Selection of Harmony
    Harmony=diag(HM(HarmonyIndex,1:Plm.Dim))';% Extraxt Value of harmony from Memory(Can Be better???)
    CMMask=rand(1,Plm.Dim)<HSOpt.HMCR;
    NHMask=(1-CMMask);
    PAMask=(rand(1,Plm.Dim)<HSOpt.PAR).*(CMMask);
    CMMask=CMMask.*(1-PAMask);
    NewHarmony=CMMask.*Harmony+PAMask.*(Harmony+HSOpt.bw*(2*rand(1,Plm.Dim)-1))+NHMask.*(Plm.Low+(Plm.High-Plm.Low).*rand(1,Plm.Dim));
    OutOfBoundry=(NewHarmony>Plm.High)+(NewHarmony<Plm.Low);
    NewHarmony(OutOfBoundry==1)=Harmony(OutOfBoundry==1);
    NHF=TestFunction(NewHarmony,Plm.FunNum);
    
    if (NHF<WorstFit)&&(HSOpt.Min==1)
        HM(WorstLoc,:)=NewHarmony;
        HF(WorstLoc)=NHF;
        [WorstFit,WorstLoc]=max(HF);
    elseif (NHF<WorstFit)&&(HSOpt.Min==0)
        HM(WorstLoc,:)=NewHarmony;
        HF(WorstLoc)=NHF;
        [WorstFit,WorstLoc]=min(HF);
    end
    
    %% Monitor What hapend!!
    if HSOpt.Mon.Enb
        
        if HSOpt.Min==1
            [BestFit,BestLoc]=min(HF);
        else
            [BestFit,BestLoc]=max(HF);
        end
        Best=HM(BestLoc,:);


        mesh(HSOpt.Mon.X,HSOpt.Mon.Y,HSOpt.Mon.Z);
        hold on
            plot3(Best(1),Best(2),BestFit,'sb')
            plot3(HM(:,1),HM(:,2),HF,'ok')
        hold off
        view(2)
        pause(.001);
    end
end

%% Present Best Answer
if HSOpt.Min==1
    [BestFit,BestLoc]=min(HF);
else
    [BestFit,BestLoc]=max(HF);
end
Best=HM(BestLoc,:);

display(Best)
display(BestFit)