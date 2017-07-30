%GSA BY SAJJAD YAZDANI
%Special tanks to Dr. NEZAMABADYPOUR
%tanks to Mrs. M.Rashedy
function Output=GSAFun(Plm,GSAOpt)
% Initialization
V=zeros(GSAOpt.N,Plm.Dim);           %Velocity

Low=repmat(Plm.Low,GSAOpt.N,1);
High=repmat(Plm.High,GSAOpt.N,1);
X=unifrnd(Low,High);%first place    
BestByEvaluation=[];
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
    BestByEvaluation=[BestByEvaluation,ones(1,GSAOpt.N)*Best_So_Far(t)]; %#ok<AGROW>
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
        a(:,i)=Force(:,i)./(Mass); %#ok<AGROW>
    end
    % Calculating Velocity
    V=rand(GSAOpt.N,Plm.Dim).*V+a;
    
    % Calculating New Position
    X=X+V;
    X=max(min(X,High),Low);
% %     Mask=X>High|X<Low;
% %     X=Mask.*rand(size(Mask)).*(High-Low)+~Mask.*X;
end

Output.BestSoFar=Best_So_Far;
Output.Ans=Final_solve;
Output.BestByEvaluation=BestByEvaluation;
