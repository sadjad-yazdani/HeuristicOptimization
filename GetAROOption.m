%OutPut is option for GVSV5

function AROOpt=GetAROOption(Plm)

% ARO Algorithem Parametters
AROOpt.Min=1;
AROOpt.Tmax=5000;%maximun number of needed iteration

AROOpt.MutMethod='Uniform'; % Arithmatic or Uniform
AROOpt.alfa=0.4;

AROOpt.StopFitValue=-1^AROOpt.Min*inf;

AROOpt.DecMutIvl=fix((Plm.High-Plm.Low)/10)+1;% Decimal Mutation Interval (Maximom amount af decimal chenge)
AROOpt.FrcMutIvl=0.25*ones(1,Plm.Dim);% Fraction Mutation Interval (Maximom amount af decimal chenge)

% Monitor Param
AROOpt.Mon.Enb=0;
if AROOpt.Mon.Enb
    if Plm.Dim==2
        AROOpt.Mon.Step=(Plm.High-Plm.Low)/30;
        AROOpt.Mon.X=Plm.Low(1):AROOpt.Mon.Step:Plm.High(1);
        AROOpt.Mon.Y=Plm.Low(2):AROOpt.Mon.Step:Plm.High(2);
        [AROOpt.Mon.X,AROOpt.Mon.Y]=meshgrid(AROOpt.Mon.X,AROOpt.Mon.Y);
        Nmon=numel(AROOpt.Mon.X);
        index=1:Nmon;
        X_(:,1)=AROOpt.Mon.X(index)';
        X_(:,2)=AROOpt.Mon.Y(index)';
        AROOpt.Mon.Z=AROOpt.Mon.X;
        AROOpt.Mon.Z(index)=TestFunction(X_,Plm.FunNum);
    else
        AROOpt.Mon.Enb=0;
    end
end

