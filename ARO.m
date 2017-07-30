%ARO or Revised Online Genetic Algorithm (OGA2)- Real code representation
% Modified By Sajjad Yazdani
clc;clear all;%close all;
%% Problem Parametters
Plm.FunNum=9;
Plm.Dim=2;
[Plm.Low,Plm.High]=LowHighTestFunction(Plm.FunNum,1,Plm.Dim);


%% Algorithem Parametters
AROOpt.Min=1;
AROOpt.Tmax=500;%maximun number of needed iteration

AROOpt.MutMethod='Uniform'; % Arithmatic or Uniform
AROOpt.alfa=0.4;

AROOpt.StopFitValue=-1^AROOpt.Min*inf;

AROOpt.DecMutIvl=fix((Plm.High-Plm.Low)/10)+1;% Decimal Mutation Interval (Maximom amount af decimal chenge)
AROOpt.FrcMutIvl=0.25*ones(1,Plm.Dim);% Fraction Mutation Interval (Maximom amount af decimal chenge)

% Monitor Param
AROOpt.Mon.Enb=1;
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

%% Initialization
t=1;

n=Plm.Dim;%dimention of the problem
M=2*n+1;

Q(1,1:n)=Plm.Low+fix(rand(1,n).*(Plm.High-Plm.Low));
Q(1,n+1:2*n)=rand(1,n);
Q(1,2*n+1)=0;


X=Q(1:n)+Q(n+1:2*n);
Q(1,M)=TestFunction(X,Plm.FunNum);
Solution=X;


%% Main Loop
for t=1:AROOpt.Tmax
    if ((Q(M)< AROOpt.StopFitValue)&&AROOpt.Min)||((Q(M)> AROOpt.StopFitValue)&&~AROOpt.Min)
        break
    end
    % Mutation
    TempQ=Q;
    Nu=randi(n);
    m1=randperm(n,Nu);
    m2=randperm(n,Nu);
    for i=1:Nu
        TempQ(m1(i))=Q(m1(i))+(randi(2*AROOpt.DecMutIvl(m1(i)))-AROOpt.DecMutIvl(m1(i)));
        TempQ(m1(i))=max(min(TempQ(m1(i)),Plm.High(m1(i))),Plm.Low(m1(i)));
        
        if rand<0.5
            TempQ(n+m2(i))=Q(n+m2(i))+2*AROOpt.FrcMutIvl(m1(i))*rand-AROOpt.FrcMutIvl(m1(i));
            TempQ(1,n+m2(i))=TempQ(1,n+m2(i))-fix(TempQ(1,n+m2(i)));
%             TempQ(1,n+m2(i))=max(min(TempQ(1,n+m2(i)),1),-1);
        else
            TempQ(n+m2(i))=Q(n+m2(i))*(2*AROOpt.FrcMutIvl(m1(i))*rand-AROOpt.FrcMutIvl(m1(i)));
        end
    end
    
    
    X=TempQ(1:n)+TempQ(n+1:2*n);
    TempQ(1,M)=TestFunction(X,Plm.FunNum);


    NTempQ=zeros(1,M);
    if strcmpi(AROOpt.MutMethod,'Arithmatic')
    %Arithmatic Crossover
        X2=AROOpt.alfa*(Q(1,:))+(1-AROOpt.alfa)*(TempQ(1,:));
        NTempQ(1,1:n)=floor(X2(1,1:n));
        NTempQ(1,n+1:2*n)=X2(1,n+1:2*n)+(X2(1,1:n)-floor(X2(1,1:n)));
        for i=1:n
            if (NTempQ(1,i+n)<-1) ||(NTempQ(1,i+n)>1)
                NTempQ(1,i+n)=rand;
            end
        end
    else 
    %Uniform Crossover
        for i=1:2*n
            if rand<0.5
                NTempQ(1,i)=Q(1,i);
            else
                NTempQ(1,i)=TempQ(1,i);
            end
        end
    end
    NX=NTempQ(1:n)+NTempQ(n+1:2*n);
    NTempQ(1,M)=TestFunction(NX,Plm.FunNum);
    
    A=[ Q(M);
        TempQ(M);
        NTempQ(M)];
    if AROOpt.Min
        [E D]=min(A);
    else
        [E D]=max(A);
    end
    if D==2
        Q=TempQ;
        Solution=X;
    elseif D==3
        Q=NTempQ;
        Solution=NX;
    end
    % Monitor What hapend!!
    if AROOpt.Mon.Enb
        mesh(AROOpt.Mon.X,AROOpt.Mon.Y,AROOpt.Mon.Z);
        hold on
            plot3(Solution(1),Solution(2),Q(M),'sr')
            plot3(X(1),X(2),TempQ(M),'ok')
            plot3(NX(1),NX(2),NTempQ(M),'ob')
        hold off
        view(2)
        pause(.001);
    end
    
    BestSofar(t)=Q(M); %#ok<SAGROW>
end
%% Present Solution
display(Q(M))
figure
plot(BestSofar)
