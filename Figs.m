%% Figures and tabels
LineWidth=2;
MarkerSize=2;
if Methodes(1)
    figure(1),semilogy(GVS.BestSoFar(1:GVS.NumValidBestSoFar),'-r','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    figure(2),semilogy(GVS.BestByEvaluation(1:GVS.NumValidBestByEval),'-r','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    Legend{1}='GVS';
else
    figure(1),clf;
    figure(2),clf;
    Legend={};
end
if Methodes(2)
    figure(1)
    hold on
    semilogy(HS.BestSoFar,'-b','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    figure(2)
    hold on
    semilogy(HS.BestByEvaluation,'-b','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    Legend{end+1}='HS';
end
if Methodes(3)
    figure(1)
    hold on
    semilogy(SA.BestSoFar,'-g','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    figure(2)
    hold on
    semilogy(SA.BestByEvaluation,'-g','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    Legend{end+1}='SA';
end
if Methodes(4)
    figure(1)
    hold on
    semilogy(ARO.BestSoFar,'-c','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    figure(2)
    hold on
    semilogy(ARO.BestByEvaluation,'-c','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    Legend{end+1}='ARO';
end
if Methodes(5)
    figure(1)
    hold on
    semilogy(GA.BestSoFar,'k','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    figure(2)
    hold on
    semilogy(GA.BestByEvaluation,'k','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    Legend{end+1}='GA';
end
if Methodes(6)
    figure(1)
    hold on
    semilogy(PSO.BestSoFar,'--k','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    figure(2)
    hold on
    semilogy(PSO.BestByEvaluation,'--k','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    Legend{end+1}='PSO';
end
if Methodes(7)
    figure(1)
    hold on
    semilogy(GSA.BestSoFar,'-.k','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    figure(2)
    hold on
    semilogy(GSA.BestByEvaluation,'-.k','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    Legend{end+1}='GSA';
end
if Methodes(8)
    figure(1)
    hold on
    semilogy(GVS2.BestSoFar,'--r','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    figure(2)
    hold on
    semilogy(GVS2.BestByEvaluation,'--r','LineWidth',LineWidth,'MarkerFaceColor','k','MarkerSize',MarkerSize);
    hold off
    Legend{end+1}='GVS2';
end

Title=sprintf('Test Function %d  (dimention=%d)',Plm.FunNum,Plm.Dim);
figure(1),legend(Legend);title(Title);xlabel('Iteration');ylabel('Fitness value');
figure(2),legend(Legend);title(Title);xlabel('Evalutation');ylabel('Fitness value');
% presentation=1;         %if true then show figure and result
% %presentation______________________________________________________________
% if presentation
%     clc
%     x=1:T;
%     plot(x,Best_So_Far,'r',x,average_fitness,'b.')
%     legend('Best So Far','Average of Fitness')
%     Optimom_Answer=Best_So_Far(T)
%     Optimom_Solution
% end

% % Plot place of X
%     figure(1),mesh(x,y,z)
%     hold on;
%     plot3(X(1),X(2),TempQ(1,M),'--bs','LineWidth',2,'MarkerFaceColor','k','MarkerSize',5);
%     plot3(NX(1),NX(2),NTempQ(1,M),'--rs','LineWidth',2,'MarkerFaceColor','k','MarkerSize',5);
%     hold off;
%     view(2);
