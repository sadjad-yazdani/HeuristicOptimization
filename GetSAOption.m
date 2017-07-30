function SAOpt=GetSAOption(Plm)


%% Algorithem Parametters
SAOpt.T=3; %Temprature
SAOpt.MaxIteration=10000;
SAOpt.MaxTry=SAOpt.MaxIteration/30;
SAOpt.Dx=(Plm.High-Plm.Low)/4;
SAOpt.Landa=0.8;
SAOpt.Min=1;


% Monitor Param
SAOpt.Mon.Enb=0;
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

end

