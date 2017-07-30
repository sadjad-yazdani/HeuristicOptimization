%GSA BY SAJJAD YAZDANI
%Special tanks to Dr. NEZAMABADYPOUR
%tanks to Mrs. M.Rashedy
% clc;
clear all;

Plm.FunNum=1;
Plm.Dim=2;
[Plm.Low,Plm.High]=LowHighTestFunction(Plm.FunNum,1,Plm.Dim);


%GSA Parametters __________________________________________________________

GSAOpt.N=20;                   %number of gravitational mass row

GSAOpt.TotalIteration=100;                   %Number of iteration
GSAOpt.Alpha=20;                %parametr for G
GSAOpt.Min=1;

% Monitor Param
GSAOpt.Mon.Enb=1;
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


% Initialization
V=zeros(GSAOpt.N,Plm.Dim);           %Velocity
Low=repmat(Plm.Low,GSAOpt.N,1);
High=repmat(Plm.High,GSAOpt.N,1);
X=unifrnd(Low,High);%first place    


%main cycle________________________________________________________________
for t=1:GSAOpt.TotalIteration
    % Evaluate Gravitation
    fitness=TestFunction(X,Plm.FunNum);
    
    if GSAOpt.Min
        Worst=max(fitness);
        [Best,Best_location]=min(fitness);
    else
        Worst=min(fitness);
        [Best,Best_location]=max(fitness);
    end
    %Save Best Position
    Optimom_Solution=X(Best_location,:);
    Optimom_Answer=fitness(Best_location,1);
    if t==1
        Best_So_Far=Optimom_Answer;
        Final_solve=Optimom_Solution;
    elseif Optimom_Answer<Best_So_Far
        Best_So_Far(t)=Optimom_Answer;
        Final_solve=Optimom_Solution;
    else
        Best_So_Far(t)=Best_So_Far(t-1);
    end
    
    % Monitor What hapend!!
    if GSAOpt.Mon.Enb
        mesh(GSAOpt.Mon.X,GSAOpt.Mon.Y,GSAOpt.Mon.Z);
        hold on
            plot3(Final_solve(1),Final_solve(2),Best_So_Far(t),'sb')
            plot3(X(:,1),X(:,2),fitness,'ok')
        hold off
        view(2)
        pause(.001);
    end
    
    % Calculating Mass
    Mass=(Worst-fitness)/(Worst-Best)+eps; %A/P mass
    %Update Param
    Beta=3-2*(GSAOpt.TotalIteration-t+1)/GSAOpt.TotalIteration;
    G=Beta^(-GSAOpt.Alpha*t/GSAOpt.TotalIteration);
    % Calculating Force
    Force=eps*ones(GSAOpt.N,Plm.Dim);
    for i=1:GSAOpt.N
        for j=1:GSAOpt.N
            if j~=i
                for k=1:Plm.Dim
                    for l=1:Plm.Dim
                        R=abs(X(i,k)-X(j,l));
                        F=G*(Mass(i)*Mass(j))/(R+eps)*(X(j,l)-X(i,k));
                        Force(i,k)=Force(i,k)+rand*F;
                    end
                end
            end
        end
    end
    
    % Calculating Acceleration
    for i=1:Plm.Dim
        a(:,i)=Force(:,i)./(Mass); %#ok<SAGROW>
    end
    % Calculating Velocity
    V=rand(GSAOpt.N,Plm.Dim).*V+a;
    
    % Calculating New Position
    X=X+V;
    Mask=X>High|X<Low;
    X=Mask.*rand(size(Mask))+~Mask.*X;
end


presentation=0;         %if true then show figure and result
%presentation______________________________________________________________
if presentation
    x=1:GSAOpt.TotalIteration;
    plot(x,Best_So_Far,'r')
    legend('Best So Far')
    Optimom_Answer=Best_So_Far(GSAOpt.TotalIteration)
    Optimom_Solution
end

display(Optimom_Solution)

display(Best_So_Far(GSAOpt.TotalIteration))
