%Simulated Anneling Code By Sajjad Yazdani
function Output=SAFun(Plm,SAOpt)
%% Initialization
X=Plm.Low+(Plm.High-Plm.Low).*rand(1,Plm.Dim);
fit=TestFunction(X,Plm.FunNum);
Output.BestByEvaluation=fit;

Ans=X;
Ans_fit=fit;

Try=1;
%% main loop
for Itr=1:SAOpt.MaxIteration
    Y=X;
    ind=1+fix(rand*(Plm.Dim));

    Y(ind)=Y(ind)+SAOpt.Dx(ind)*(2*rand-1);
    Y=Y.*((Y>Plm.Low).*(Y<Plm.High))+(Plm.Low+(Plm.High-Plm.Low).*rand(1,Plm.Dim)).*((Y<Plm.Low)+(Y>Plm.High));
    Y_fit=TestFunction(Y,Plm.FunNum);
    if ((Y_fit>fit)&&~SAOpt.Min)||(Y_fit<fit)&&SAOpt.Min
        X=Y;
        fit=Y_fit;
    else
        P=exp(-abs(fit-Y_fit)/SAOpt.T);
        if rand<P
            X=Y;
            fit=Y_fit;
        end
    end

    if ((fit>Ans_fit)&&~SAOpt.Min)||(fit<Ans_fit)&&SAOpt.Min
        Ans=X;
        Ans_fit=fit;
    end
    % Monitor What hapend!!
    if SAOpt.Mon.Enb
        mesh(SAOpt.Mon.X,SAOpt.Mon.Y,SAOpt.Mon.Z);
        hold on
            plot3(Ans(1),Ans(2),Ans_fit,'sb')
            plot3(X(1),X(2),fit,'ok')
        hold off
        view(2)
        pause(.001);
    end
    
    BestSoFar(Itr)=Ans_fit;  %#ok<AGROW>
    Output.BestByEvaluation=[Output.BestByEvaluation,Ans_fit];
    Try=Try+1;
    if Try>SAOpt.MaxTry
        Try=1;
        SAOpt.T=SAOpt.Landa*SAOpt.T;
        SAOpt.Dx=SAOpt.Dx*SAOpt.Landa;
    end
end
Output.BestSoFar=BestSoFar;
Output.Ans=Ans;
