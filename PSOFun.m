%PSO CODE By Sajjad Yazdani <V 2013.1>
function Output=PSOFun(Plm,PSOOpt)
%Initialization
Low=repmat(Plm.Low,PSOOpt.SwarmNum,1);
High=repmat(Plm.High,PSOOpt.SwarmNum,1);
Swarms.X=unifrnd(Low,High);

Swarms.V=zeros(PSOOpt.SwarmNum,PSOOpt.Dim);

Swarms.Fit=TestFunction(Swarms.X,Plm.FunNum);

Swarms.pBest.X=Swarms.X;
Swarms.pBest.Fit=Swarms.Fit;

[Best,BestLoc]=max(Swarms.Fit);
Swarms.gBest.X=Swarms.X(BestLoc,:);
Swarms.gBest.Fit=Best;

BestByEvaluation=ones(1,PSOOpt.SwarmNum)*Best;

for t=1:PSOOpt.TotalIterat
    % Update w
    PSOOpt.w(t)=PSOOpt.wMax-(PSOOpt.wMax-PSOOpt.wMin)*t/PSOOpt.TotalIterat;
    % calculate V
    Swarms.V=PSOOpt.w(t)*Swarms.V+...
        PSOOpt.C1*rand(PSOOpt.SwarmNum,PSOOpt.Dim).*(Swarms.pBest.X-Swarms.X)+...
        PSOOpt.C2*rand(PSOOpt.SwarmNum,PSOOpt.Dim).*(repmat(Swarms.gBest.X,PSOOpt.SwarmNum,1)-Swarms.X);
    Swarms.V=min(max(PSOOpt.VMin,Swarms.V),PSOOpt.VMax);
    % Update X
    Swarms.X=Swarms.X+Swarms.V;
    Swarms.X=min(max(Low,Swarms.X),High);
    % Evaluate Positions
    Swarms.Fit=TestFunction(Swarms.X,Plm.FunNum);
    if PSOOpt.Min
        % Update Local Best
        Improved=find(Swarms.Fit<Swarms.pBest.Fit);
        Swarms.pBest.Fit(Improved)=Swarms.Fit(Improved);
        Swarms.pBest.X(Improved,:)=Swarms.X(Improved,:);
        % Update Global Best
        [Best,BestLoc]=min(Swarms.Fit);
        if Best<Swarms.gBest.Fit
            Swarms.gBest.X=Swarms.X(BestLoc,:);
            Swarms.gBest.Fit=Best;
        end

    else
        % Update Local Best
        Improved=find(Swarms.Fit>Swarms.pBest.Fit);
        Swarms.pBest.Fit(Improved)=Swarms.Fit(Improved);
        Swarms.pBest.X(Improved,:)=Swarms.X(Improved,:);
        % Update Global Best
        [Best,BestLoc]=max(Swarms.Fit);
        if Best>Swarms.gBest.Fit
            Swarms.gBest.X=Swarms.X(BestLoc,:);
            Swarms.gBest.Fit=Best;
        end
    end
    Output.BestSoFar(t)=Swarms.gBest.Fit;
    BestByEvaluation=[BestByEvaluation,ones(1,PSOOpt.SwarmNum)*Swarms.gBest.Fit]; %#ok<AGROW>
    %% Monitor What hapend!!
    if PSOOpt.Mon.Enb
        mesh(PSOOpt.Mon.X,PSOOpt.Mon.Y,PSOOpt.Mon.Z);
        hold on
            plot3(Swarms.gBest.X(1),Swarms.gBest.X(2),Swarms.gBest.Fit,'sb')
            plot3(Swarms.X(:,1),Swarms.X(:,2),Swarms.Fit,'ok')
        hold off
        view(2)
        pause(.001);
    end
end
Output.Ans=Swarms.gBest.X;
Output.BestByEvaluation=BestByEvaluation;
