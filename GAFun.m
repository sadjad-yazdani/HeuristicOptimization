% GA Code By Sajjad Yazdani
function Output=GAFun(Plm,GAOpt)

% Generate random initial population.
Low=repmat(Plm.Low,GAOpt.PopNum,1);
High=repmat(Plm.High,GAOpt.PopNum,1);
Pop.Value=unifrnd(Low,High);%first place    
BestByEvaluation=[];
Best=[];
for t=1:GAOpt.TotalIterat
    Pop.Obj=TestFunction(Pop.Value,Plm.FunNum);
    if GAOpt.Min
        Pop.Fit=max(Pop.Obj)-Pop.Obj;
        [Min,MinLoc]=min(Pop.Obj);
        if t==1
            Best.Value=Pop.Value(MinLoc,:);
            Best.Obj=Min;
        elseif Min<Best.Obj(t-1)
            Best.Value(t,:)=Pop.Value(MinLoc,:);
            Best.Obj(t)=Min;
        else
            Best.Value(t,:)=Best.Value(t-1,:);
            Best.Obj(t)=Best.Obj(t-1);
        end
        
    else
        Pop.Fit=Pop.Obj;
        [Max,MaxLoc]=max(Pop.Obj);
        if t==1
            Best.Value=Pop.Value(MaxLoc,:);
            Best.Obj=Max;
        elseif Max>Best.Obj(t-1)
            Best.Value(t,:)=Pop.Value(MaxLoc,:);
            Best.Obj(t)=Max;
        else
            Best.Value(t,:)=Best.Value(t-1,:);
            Best.Obj(t)=Best.Obj(t-1);
        end
    end
    
    BestByEvaluation=[BestByEvaluation,ones(1,GAOpt.PopNum)*Best.Obj(t)]; %#ok<AGROW>
    
    % Monitor What hapend!!
    if GAOpt.Mon.Enb
        mesh(GAOpt.Mon.X,GAOpt.Mon.Y,GAOpt.Mon.Z);
        hold on
            plot3(Best.Value(t,1),Best.Value(t,2),Best.Obj(t),'sb')
            plot3(Pop.Value(:,1),Pop.Value(:,2),Pop.Obj,'ok')
        hold off
        view(2)
        pause(.001);
    end
    
    Pop.SelectionProbility=Pop.Fit/sum(Pop.Fit);
    
    % Selection (By Roulette Wheel)
    num=1:GAOpt.PopNum;
    index=randsample(num,GAOpt.PopNum,true,Pop.SelectionProbility);
    for i=1:GAOpt.PopNum
        mating_pool(i,:)=Pop.Value(index(i),:);
    end
    
    % Crossover Linear Real Crossover
    parent_num=randperm(GAOpt.PopNum);
    for j=1:2:GAOpt.PopNum
        pointer1=parent_num(j);
        pointer2=parent_num(j+1);
        off1=mating_pool(pointer1,:);
        off2=mating_pool(pointer2,:);
        if rand<GAOpt.Pc
            L=rand;
            temp=off1;
            off1=L*off1+(1-L)*off2;
            off2=L*off2+(1-L)*temp;
        end
        new_pop(j,:)=off1;
        new_pop(j+1,:)=off2;
    end

    %Mutation
    sigma=GAOpt.div*(High-Low);
    Mask=sigma.*(rand(GAOpt.PopNum,Plm.Dim)<=GAOpt.Pm);
    pop=new_pop+Mask.*randn(GAOpt.PopNum,Plm.Dim);
    
    % Placement
     Pop.Value=pop;
     
end
Output.BestSoFar=Best.Obj;
Output.Ans=Best.Value(GAOpt.TotalIterat,:);
Output.BestByEvaluation=BestByEvaluation;