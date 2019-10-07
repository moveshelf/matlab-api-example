%% Compare 2 gait trials

clipID = {"TW9jYXBDbGlwJHvLUj32RlWXsLymeiTIjA","TW9jYXBDbGlwB2CxcyUZTeK1kfVhwCqtsg"};

for file = 1:2
    cid = string(clipIDc(file));
    ii = {'PRE','POST'};
    path = strcat(mainPath, '/', char(cid));
    cd(path)
    fname = 'ClipStruct.mat';
    Data.(char(ii(file))) = load(fname);
end

for i = 1:length(Data.PRE.SessionData.gait_params.data)
    GPlabel(1,i) = {Data.PRE.SessionData.gait_params.data(i).label};
    GPmean(1,i) = Data.PRE.SessionData.gait_params.data(i).values.mean;
    GPstd(1,i) = Data.PRE.SessionData.gait_params.data(i).values.std;
    GPlabel(2,i) = {Data.POST.SessionData.gait_params.data(i).label};
    GPmean(2,i) = Data.POST.SessionData.gait_params.data(i).values.mean;
    GPstd(2,i) = Data.POST.SessionData.gait_params.data(i).values.std;
end

resultsGP = array2table([GPmean(1,:)', GPmean(2,:)', GPmean(1,:)' - GPmean(2,:)'], 'VariableNames',{'mean_before', 'mean_after','mean_delta'});
resultsGP.Properties.RowNames = GPlabel(1,:)


Amean_a = zeros(length(Data.PRE.SessionData.angles.data),length(Data.PRE.SessionData.angles.data(1).values));
for j = 1:length(Data.PRE.SessionData.angles.data)
    Alabel_a(j) = {Data.PRE.SessionData.angles.data(j).label};
    for k = 1:length(Data.PRE.SessionData.angles.data(j).values)
        Amean_a(j,k) = Data.PRE.SessionData.angles.data(j).values(k).mean;
    end
end

Amean_b = zeros(length(Data.POST.SessionData.angles.data),length(Data.POST.SessionData.angles.data(1).values));
for j = 1:length(Data.POST.SessionData.angles.data)
    Alabel_b(j) = {Data.POST.SessionData.angles.data(j).label};
    for k = 1:length(Data.POST.SessionData.angles.data(j).values)
        Amean_b(j,k) = Data.POST.SessionData.angles.data(j).values(k).mean;
    end
end


ts = {'RightHipFlexion','RightKneeFlexion','RightAnkleFlexion','LeftHipFlexion','LeftKneeFlexion','RightAnkleFlexion'};
figure(11)
for u = 1:6
    subplot(3,2,u)
    plot(Amean_a(u,:),'color',[0.4 0.2 1],'Linewidth',2)
    hold on
    plot(Amean_b(u,:),'color',[0 0.8 0.8],'Linewidth',2)
    grid on
    xlabel('Gait Cycle [%]')
    ylabel('Angle')
    legend('Before','After','Location','SouthWest')
    title(ts(u))
end

GPmean = GPmean(:,3:end-2);
GPstd = GPstd(:,3:end-2);
GPlabel = GPlabel(:,3:end-2);
l = 1;
GPmeanOK = zeros(40,1);
GPstdOK = zeros(40,1);

for ii = 1:2:39
    GPmeanOK(ii) = GPmean(1,l);
    GPmeanOK(ii+1) = GPmean(2,l);
    GPstdOK(ii) = GPstd(1,l);
    GPstdOK(ii+1) = GPstd(2,l);
    l = l+1;
end

figure(44)
hold on
for jj = 1:20
    L = bar(1.4:2:40,GPmeanOK(1:2:end),0.2);
    errorbar(1.4:2:40,GPmeanOK(1:2:end),GPstdOK(1:2:end),'.','color','black')
    set(L,'FaceColor',[0.4 0.2 1],'EdgeColor',[0.4 0.2 1],'LineWidth',1.5)
    R = bar(1.8:2:40, GPmeanOK(2:2:end),0.2);
    set(R,'FaceColor',[0 0.8 0.8],'EdgeColor',[0 0.8, 0.8],'LineWidth',1.5)%viola
    errorbar(1.8:2:40,GPmeanOK(2:2:end),GPstdOK(2:2:end),'.','color','black')
end
title('Spatio-temporal Gait Parameters: pre/post intervention', 'FontSize', 20)
ylabel('Mean')
xlabel('Gait parameters')
set(gca,'xtick',1.5:2:40,'xticklabel', GPlabel(1,:))
legend('pre','std','post')
xtickangle(45)
