% Harmony Search Algorithm
%By Sajjad Yazdani
function Output=HSFun(Plm,HSOpt)
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

if HSOpt.Min==1
    Output.BestByEvaluation=min(HF)*ones(1,HSOpt.HMS);
else
    Output.BestByEvaluation=max(HF)*ones(1,HSOpt.HMS);
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
    
    if HSOpt.Min==1
        Output.BestSoFar(Itr)=min(HF);
    else
        Output.BestSoFar(Itr)=max(HF);
    end
    Output.BestByEvaluation=[Output.BestByEvaluation,Output.BestSoFar(Itr)];
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

Output.Ans=Best;
Output.Ansfun=BestFit;