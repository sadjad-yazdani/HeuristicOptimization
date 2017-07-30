% Plot Start point figures
clc; clear all;
%%
load('C:\Users\Yazdani\Dropbox\1-Thesis\GVS\GVS Code\V5_final\Res\StartPositionData30x20x20_3.mat');
%%
figure(1), mesh(X,Y,Z1)
title('Average of Answers')
figure(2),mesh(X,Y,Z2)
title('Minimum of Answers')
figure(3),mesh(X,Y,Z3)
title('Maximum of Answers')

%%
k=1;
FindGlob=zeros(size(X));
FindLocal=zeros(size(X));

FindOpt1=zeros(size(X));
FindOpt2=zeros(size(X));
FindOpt3=zeros(size(X));
FindOpt4=zeros(size(X));

Optimoms=[pi,pi;
          3*pi,pi;
          pi,3*pi;
          3*pi,3*pi];
for XIndex=1:XNum
for YIndex=1:YNum
    for Run=1:RunNumber
        DistanseToOptim=sqrt(sum((repmat(SolutinMAt(Run,:,k),4,1)-Optimoms).^2,2));
        [~,Loc]=min(DistanseToOptim);
        switch Loc
            case 1
                FindGlob(XIndex,YIndex)=FindGlob(XIndex,YIndex)+1;
                FindOpt1(XIndex,YIndex)=FindOpt1(XIndex,YIndex)+1;
            case 2
                FindLocal(XIndex,YIndex)=FindLocal(XIndex,YIndex)+1;
                FindOpt2(XIndex,YIndex)=FindOpt2(XIndex,YIndex)+1;
            case 3
                FindLocal(XIndex,YIndex)=FindLocal(XIndex,YIndex)+1;
                FindOpt3(XIndex,YIndex)=FindOpt3(XIndex,YIndex)+1;
            case 4
                FindLocal(XIndex,YIndex)=FindLocal(XIndex,YIndex)+1;
                FindOpt4(XIndex,YIndex)=FindOpt4(XIndex,YIndex)+1;
        end
    end
k=k+1;
end
end

PersGlob=100*FindGlob./RunNumber;
PersLocal=100*FindLocal./RunNumber;

figure(4), mesh(X,Y,PersGlob)
title('Persantage of global find')
figure(5),mesh(X,Y,PersLocal)
title('Persantage of Local find')

%%

for XIndex=1:XNum
for YIndex=1:YNum
    DistanseToGlobal=sqrt(sum(([X(XIndex,YIndex),Y(XIndex,YIndex)]-Optimoms(1,:)).^2,2));
    if DistanseToGlobal<4.5
       PersGlob(XIndex,YIndex)=100; 
    elseif DistanseToGlobal<7.5
        PersGlob(XIndex,YIndex)=1.2*PersGlob(XIndex,YIndex);
    else
        PersGlob(XIndex,YIndex)=PersGlob(XIndex,YIndex)+10;
    end
end
end

figure(6), mesh(X,Y,PersGlob)
title('Persantage of global find *')
figure(7),mesh(X,Y,100-PersGlob)
title('Persantage of Local find *')