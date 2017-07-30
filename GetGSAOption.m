function GSAOpt=GetGSAOption(Plm)


%GSA Parametters __________________________________________________________

GSAOpt.N=75;                   %number of gravitational mass row

GSAOpt.TotalIteration=100;                   %Number of iteration
GSAOpt.Alpha=20;                %parametr for G
GSAOpt.Min=1;

% Monitor Param
GSAOpt.Mon.Enb=0;
if GSAOpt.Mon.Enb
    if Plm.Dim==2
        GSAOpt.Mon.Step=(Plm.High-Plm.Low)/30;
        GSAOpt.Mon.X=Plm.Low(1):GSAOpt.Mon.Step:Plm.High(1);
        GSAOpt.Mon.Y=Plm.Low(2):GSAOpt.Mon.Step:Plm.High(2);
        [GSAOpt.Mon.X,GSAOpt.Mon.Y]=meshgrid(GSAOpt.Mon.X,GSAOpt.Mon.Y);
        Nmon=numel(GSAOpt.Mon.X);
        index=1:Nmon;
        X_(:,1)=GSAOpt.Mon.X(index)';
        X_(:,2)=GSAOpt.Mon.Y(index)';
        GSAOpt.Mon.Z=GSAOpt.Mon.X;
        GSAOpt.Mon.Z(index)=TestFunction(X_,Plm.FunNum);
    else
        GSAOpt.Mon.Enb=0;
    end
end

