function GAOpt=GetGAOption(Plm)

GAOpt.PopNum=80;
GAOpt.TotalIterat=100;
GAOpt.Pc=0.80;
GAOpt.Pm=0.10;

GAOpt.div=0.01;

GAOpt.Min=1;

% Monitor Param
GAOpt.Mon.Enb=0;
if GAOpt.Mon.Enb
    if Plm.Dim==2
        GAOpt.Mon.Step=(Plm.High-Plm.Low)/30;
        GAOpt.Mon.X=Plm.Low(1):GAOpt.Mon.Step:Plm.High(1);
        GAOpt.Mon.Y=Plm.Low(2):GAOpt.Mon.Step:Plm.High(2);
        [GAOpt.Mon.X,GAOpt.Mon.Y]=meshgrid(GAOpt.Mon.X,GAOpt.Mon.Y);
        Nmon=numel(GAOpt.Mon.X);
        index=1:Nmon;
        X_(:,1)=GAOpt.Mon.X(index)';
        X_(:,2)=GAOpt.Mon.Y(index)';
        GAOpt.Mon.Z=GAOpt.Mon.X;
        GAOpt.Mon.Z(index)=TestFunction(X_,Plm.FunNum);
    else
        GAOpt.Mon.Enb=0;
    end
end