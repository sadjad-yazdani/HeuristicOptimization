%Output is option for Harmony Search
function HSOpt=GetHSOption(Plm)

% Harmony Search Parametters
HSOpt.Min=1; % Minimaization or maximaiz of Fun? if HSOp.Min=1 it will be minimaze the function and if HSOp.Min=0 it will be maximized the function.
HSOpt.HMS=100;%Harmony Memory Size (Population Number)
HSOpt.bw=0.2;
HSOpt.HMCR=0.95;%[1], Harmony Memory Considering Rate
HSOpt.PAR=0.3;%[1], Pitch Adjustment Rate
HSOpt.TotalIterat=10000-100;% Maximum number of Iteration

% Monitor Param
HSOpt.Mon.Enb=0;
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
