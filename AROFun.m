%ARO or Revised Online Genetic Algorithm (OGA2)- Real code representation
% Modified By Sajjad Yazdani
function Output=AROFun(Plm,AROOpt)
%% Initialization

n=Plm.Dim;%dimention of the problem
M=2*n+1;

Q(1,1:n)=Plm.Low+fix(rand(1,n).*(Plm.High-Plm.Low));
Q(1,n+1:2*n)=rand(1,n);
Q(1,2*n+1)=0;


X=Q(1:n)+Q(n+1:2*n);
Q(1,M)=TestFunction(X,Plm.FunNum);
Solution=X;
Output.BestByEvaluation=Q(1,M);

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
        [E D]=min(A);%#ok<ASGLU>
    else
        [E D]=max(A); %#ok<ASGLU>
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
    
    BestSofar(t)=Q(M); %#ok<AGROW>
    Output.BestByEvaluation=[Output.BestByEvaluation,Q(M),Q(M)];
end
%% Present Solution
Output.BestSoFar=BestSofar;
Output.Ans=Solution;
