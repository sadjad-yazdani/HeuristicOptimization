clc,clear all
%% Run Parameters
RunNumber=10;
SaveRes=0;
%% Problem Parametters
Plm.FunNum=24;
Plm.Dim=2;
[Plm.Low,Plm.High]=LowHighTestFunction(Plm.FunNum,1,Plm.Dim);

plm.GlobalAns=[pi/2 pi/2];

Step=(Plm.High-Plm.Low)/5;
X=Plm.Low(1):Step:Plm.High(1);
Y=Plm.Low(2):Step:Plm.High(2);
[X,Y]=meshgrid(X,Y);
Z1=X;
Z2=X;
Z3=X;
[XNum,YNum]=size(X);
Solutin=zeros(RunNumber,2,XNum*YNum);
SolFit=zeros(RunNumber,1,XNum*YNum);
k=1;
%% Algoritms Parameters
for XIndex=1:XNum
for YIndex=1:YNum
GVSOpt=GetGVSOption(Plm);
GVSOpt.Mon.Enb=0;
GVSOpt.ScatterSearch=0;
GVSOpt.Memor.En=0;
GVSOpt.StartPoint=[X(XIndex,YIndex),Y(XIndex,YIndex)];
for Run=1:RunNumber
    fprintf('\nRun=%d of %d  | Problem %d | ',Run,RunNumber,Plm.FunNum);
    fprintf('XIndex=%d/%d  YIndex=%d/%d ',XIndex,XNum,YIndex,YNum)
    Output=GVS515Fun(Plm,GVSOpt);
    Solutin(Run,:,k)=Output.Ans;
    SolFit(Run,k)=Output.BestSoFar(end);
    
end
Z1(XIndex,YIndex)=mean(SolFit(:,:,k));
Z2(XIndex,YIndex)=min (SolFit(:,:,k));
Z3(XIndex,YIndex)=max (SolFit(:,:,k));
k=k+1;
save('D:\Dropbox\1-Thesis\GVS\GVS Code\V5_final\Res\StartPositionData.mat');

end
end
fprintf('\n')
figure(1), mesh(X,Y,Z1)
figure(2),mesh(X,Y,Z2)
figure(3),mesh(X,Y,Z3)
