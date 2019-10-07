function [] = DataAnalysis_02(fname,dapath)

% 4 - ANALYSIS
%[fname, pathname] = uigetfile('*.mat')
cd(dapath)
load(fname);
for i = 1:length(SessionData.gait_params.data)
    GPlabel(i) = {SessionData.gait_params.data(i).label};
    GPmean(i) = SessionData.gait_params.data(i).values.mean;
    GPstd(i) = SessionData.gait_params.data(i).values.std;
end

resultsGP = array2table([GPmean', GPstd'], 'VariableNames', {'mean', 'sts'});
resultsGP.Properties.RowNames = GPlabel

idx = zeros(length(GPlabel),2); %column1 = left; column2 = right
GPlabel = string(GPlabel);
for i = 1:length(GPlabel)
    
    iL = strfind(GPlabel(i), 'L.');
    if iL == 1
        idx(i,1) = i;
    end
    iR = strfind(GPlabel(i), 'R.');
    if iR == 1
        idx(i,2) = i;
    end
end
clear iR iL

GPlabelRL(:,1) = erase(GPlabel(nonzeros(idx(:,1))),'L.');
GPlabelRL(:,2) = erase(GPlabel(nonzeros(idx(:,2))),'R.');
GPmeanRL(:,1) = GPmean(nonzeros(idx(:,1)));
GPmeanRL(:,2) = GPmean(nonzeros(idx(:,2)));
GPstdRL(:,1) = GPstd(nonzeros(idx(:,1)));
GPstdRL(:,2) = GPstd(nonzeros(idx(:,2)));

for i = 1:length(GPlabelRL)
    for j = 1:length(GPlabelRL)
        if (strcmp(GPlabelRL(i,1),GPlabelRL(j,2)) == 1)
            meanGP(i,1) = GPmeanRL(i,1);
            meanGP(i,2) = GPmeanRL(j,2);
            stdGP(i,1) = GPstdRL(i,1);
            stdGP(i,2) = GPstdRL(j,2);
            labelGP(i,1) = GPlabelRL(i,1);
            labelGP(i,2) = GPlabelRL(j,2);
        end
    end
end

figure(1)
hold on
L = bar(1:2:2*length(meanGP), meanGP(:,1), 0.4);
set(L,'FaceColor',[0.4 0.2 1],'EdgeColor',[0.4 0.2 1],'LineWidth',1.5);
R = bar(1.6:2:2*length(meanGP)+1, meanGP(:,2), 0.4);
set(R,'FaceColor',[0 0.8 0.8],'EdgeColor',[0 0.8, 0.8],'LineWidth',1.5);
errorbar(1:2:2*length(meanGP),meanGP(:,1),stdGP(:,1),'.','color','black')
errorbar(1.6:2:2*length(meanGP)+1,meanGP(:,2),stdGP(:,2),'.','color','black')
title('Spatio-temporal gait parameters: left vs right', 'FontSize', 20)
ylabel('Mean')
xlabel('Gait parameters')
legend('Left','Right')
set(gca,'xtick',1:2:2*length(meanGP),'xticklabel', labelGP)
xtickangle(45)

%%
Amean = zeros(length(SessionData.angles.data),length(SessionData.angles.data(1).values));
for j = 1:length(SessionData.angles.data)
    Alabel(j) = {SessionData.angles.data(j).label};
    for k = 1:length(SessionData.angles.data(j).values)
        Amean(j,k) = SessionData.angles.data(j).values(k).mean;
    end
end

resultsA = array2table(Amean);
resultsA.Properties.RowNames = Alabel
 

Alabel = string(Alabel);
var = {'HipFlex','KneeFlex','AnkleFlex','HipAbAd','HipRot','AnklePron','PelvicTil'};
AlabelB = erase(Alabel, 'Rotation ');
AlabelOK = erase(AlabelB, ' base');
AlabelOK = erase(AlabelB, ' comf');


for i = 1:length(AlabelOK)
    for j = 1:length(var)
        if strcmp(strcat('R',string(var(j))),AlabelOK(i)) == 1
            AlabelR(j) = AlabelOK(i);
            AmeanR(j,:) = Amean(i,:);
        end
        if strcmp(strcat('L',string(var(j))),AlabelOK(i)) == 1
            AlabelL(j) = AlabelOK(i);
            AmeanL(j,:) = Amean(i,:);
        end
    end
end

for i = 1:length(AlabelR)
    AR = char(AlabelR(i));
    for j=1:length(AlabelL)
        AL = char(AlabelL(j));
        if strcmp(AR(2:end), AL(2:end))
            AmR(i,:) = AmeanR(i,:);
            AmL(i,:) = AmeanL(j,:);
        end
    end
end

figure(2)
for u = 1:6
    subplot(3,2,u)
    plot(AmR(u,:),'color',[0.4 0.2 1], 'Linewidth',2)
    hold on
    plot(AmL(u,:),'color',[0 0.8 0.8], 'Linewidth',2)
    grid on
    xlabel('Gait Cycle [%]')
    ylabel('Angle')
    legend('R','L','Location','SouthWest')
    title(var(u))
end
