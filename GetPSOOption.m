%OutPut is option for GVSV5

function PSOOpt=GetPSOOption(Plm)

% PSO Algorithem Parametters
PSOOpt.Min=1;

PSOOpt.SwarmNum=120;
PSOOpt.TotalIterat=100;

PSOOpt.C1=1;
PSOOpt.C2=2;


PSOOpt.VMax=0.1*repmat(Plm.High,PSOOpt.SwarmNum,1);
PSOOpt.VMin=-PSOOpt.VMax;

PSOOpt.wMax=0.9;
PSOOpt.wMin=0.4;
PSOOpt.Dim=Plm.Dim;

% Monitor Param
PSOOpt.Mon.Enb=0;
if PSOOpt.Mon.Enb
    if Plm.Dim==2
        PSOOpt.Mon.Step=(Plm.High-Plm.Low)/30;
        PSOOpt.Mon.X=Plm.Low(1):PSOOpt.Mon.Step:Plm.High(1);
        PSOOpt.Mon.Y=Plm.Low(2):PSOOpt.Mon.Step:Plm.High(2);
        [PSOOpt.Mon.X,PSOOpt.Mon.Y]=meshgrid(PSOOpt.Mon.X,PSOOpt.Mon.Y);
        Nmon=numel(PSOOpt.Mon.X);
        index=1:Nmon;
        X_(:,1)=PSOOpt.Mon.X(index)';
        X_(:,2)=PSOOpt.Mon.Y(index)';
        PSOOpt.Mon.Z=PSOOpt.Mon.X;
        PSOOpt.Mon.Z(index)=TestFunction(X_,Plm.FunNum);
    else
        PSOOpt.Mon.Enb=0;
    end
end
