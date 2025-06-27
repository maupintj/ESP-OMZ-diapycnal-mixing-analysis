%% plot en densidad
close all; 
clear all;

data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
load(fullfile(data_dir,'VMP','JAN','VMP_Data_2020.mat'));
load(fullfile(data_dir,'VMP','JUL','VMP_Data_2021.mat'));
load(fullfile(data_dir,'VMP','OCT','VMP_Data_2022.mat'));

FolderName='/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';
sf=true;  % Save figure flag

e1_2021(e1_2021>1e-6)=NaN;
e2_2021(e2_2021>1e-6)=NaN;
Chi1_2021(e1_2021>1e-6)=NaN;
Chi2_2021(e2_2021>1e-6)=NaN;
e1_2022(e1_2022>1e-8)=NaN;
e2_2022(e2_2022>1e-8)=NaN;
Chi1_2022(e1_2022>1e-8)=NaN;
Chi2_2022(e2_2022>1e-8)=NaN;

% Rho_2020=movmean(Rho_2020,10,2,'omitnan');
% e1_2020=movmean(e1_2020,10,2,'omitnan');
% e2_2020=movmean(e2_2020,10,2,'omitnan');
% Chi1_2020=movmean(Chi1_2020,10,2,'omitnan');
% Chi2_2020=movmean(Chi2_2020,10,2,'omitnan');

close all
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 3.5 3.8];
subplot1(1,3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% ENERO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux2=nanmedian(Rho_2020,2);
subplot1(1)
y = [max(max([Rho_2020])) max(max(Rho_2020)) 20 20];
x = [-90 -45 -45 -90];
patch(x,y,[1 0 0]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
hold on
y = [max(max(Rho_2020)) max(max(Rho_2020)) 20 20];
x = [45 90 90 45];
patch(x,y,[0 0 1]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
ylim([25.7 max(max([Rho_2020]))]); min(aux2);
xlim([-90 90])
xticks([-45 0 45])
xtickangle(0)
set(gca,'Ydir','reverse')
a = get(gca,'XTickLabel');
%set(gca,'XTickLabel',a,'fontsize',12)
%ylabel('Presión [dbar]')
plot(Tu_2020,Rho_2020,'LineStyle','none','Marker','.','color','blue','MarkerSize',9)
h=plot([45 45],[24.5 max(max([Rho_2020]))],'k','LineWidth',2);
h=plot([-45 -45],[24.5 max(max([Rho_2020]))],'k','LineWidth',2);
grid on
%title('Enero 2020')
box on
yticks([25.8 26.1 26.3 26.55 26.7 26.8 26.9])
ylabel('Density kg m^{-3}')
set(gca, 'FontSize', 14)

subplot1(2)

aux1=log10(nanmedian([e1_2020 e2_2020],2));
aux2=nanmedian(Rho_2020,2);
aux3=log10(min([e1_2020 e2_2020],[],2));
aux4=log10(max([e1_2020 e2_2020],[],2));

plot(aux1,aux2,'.b','MarkerSize',9)
hold on
y=[aux2(~isnan(aux2)); flipud(aux2(~isnan((aux2))))];
x=[aux3(~isnan(aux3)); flipud(aux4(~isnan((aux4))))];
patch(x,y,'b','facealpha',0.2)
set(gca,'Ydir','reverse')
grid on
plot(aux3,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
plot(aux4,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
set(gca,'Ydir','reverse')
grid on
xlim(log10([5e-11 1e-6]))
ylim([25.7 max(max([Rho_2020]))]); min(aux2);
xticks(log10([1e-10 1e-9 1e-8 1e-7]));
tickslabel={'-10', '-9', '-8','-7'};
xticklabels(tickslabel)
xtickangle(0)
yticks([25.8 26.1 26.3 26.55 26.7 26.8 26.9])
set(gca,'yticklabel',[])
set(gca, 'FontSize', 14)

subplot1(3)

aux1=log10(nanmedian([Chi1_2020 Chi2_2020],2));
aux2=nanmedian(Rho_2020,2);
aux3=log10(min([Chi1_2020 Chi2_2020],[],2));
aux4=log10(max([Chi1_2020 Chi2_2020],[],2));

plot(aux1,aux2,'.b','MarkerSize',9)
hold on
y=[aux2(~isnan(aux2)); flipud(aux2(~isnan((aux2))))];
x=[aux3(~isnan(aux3)); flipud(aux4(~isnan((aux4))))];
patch(x,y,'b','facealpha',0.2)
set(gca,'Ydir','reverse')
grid on
plot(aux3,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
plot(aux4,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
set(gca,'Ydir','reverse')
grid on
xlim(log10([1e-11 1e-5]))
ylim([25.7 max(max([Rho_2020]))]); min(aux2);
yticks([25.8 26.1 26.3 26.55 26.7 26.8 26.9])
set(gca,'yticklabel',[])
xticks(log10([1e-10 1e-9 1e-8 1e-7 1e-6]))
tickslabel={'-10','', '-8','', '-6'};
xticklabels(tickslabel)
xtickangle(0)
set(gca, 'FontSize', 14)

f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['Tuepsichi_rho_JAN.png']),'Resolution',400,'BackgroundColor','white')
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% JULIO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux2=nanmedian(Rho_2021,2);
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 3.5 3.8];
subplot1(1,3)
subplot1(1)
y = [max(max([Rho_2020])) max(max(Rho_2020)) 20 20];
x = [-90 -45 -45 -90];
patch(x,y,[1 0 0]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
hold on
y = [max(max(Rho_2020)) max(max(Rho_2020)) 20 20];
x = [45 90 90 45];
patch(x,y,[0 0 1]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
ylim([25.7 max(max([Rho_2020]))]); min(aux2);
xlim([-90 90])
xticks([-45 0 45])
xtickangle(0)

set(gca,'Ydir','reverse')
a = get(gca,'XTickLabel');
%set(gca,'XTickLabel',a,'fontsize',12)
%ylabel('Presión [dbar]')
plot(Tu_2021,Rho_2021,'LineStyle','none','Marker','.','color','blue','MarkerSize',9)
h=plot([45 45],[24.5 max(max([Rho_2020]))],'k','LineWidth',2);
h=plot([-45 -45],[24.5 max(max([Rho_2020]))],'k','LineWidth',2);
grid on
%title('Enero 2021')
box on
yticks([25.8 26.1 26.3 26.55 26.7 26.8 26.9])
set(gca, 'FontSize', 14)

subplot1(2)

aux1=log10(nanmedian([e1_2021 e2_2021],2));
aux2=nanmedian(Rho_2021,2);
aux3=log10(min([e1_2021 e2_2021],[],2));
aux4=log10(max([e1_2021 e2_2021],[],2));

plot(aux1,aux2,'.b','MarkerSize',9)
hold on
y=[aux2(~isnan(aux2)); flipud(aux2(~isnan((aux2))))];
x=[aux3(~isnan(aux3)); flipud(aux4(~isnan((aux4))))];
patch(x,y,'b','facealpha',0.2)
set(gca,'Ydir','reverse')
grid on
plot(aux3,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
plot(aux4,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
set(gca,'Ydir','reverse')
grid on
xlim(log10([5e-11 1e-6]))
ylim([25.7 max(max([Rho_2020]))]); min(aux2);
xticks(log10([1e-10 1e-9 1e-8 1e-7]));
tickslabel={'-10', '-9', '-8','-7'};
xticklabels(tickslabel)
xtickangle(0)
yticks([25.8 26.1 26.3 26.55 26.7 26.8 26.9])
set(gca,'yticklabel',[])
set(gca, 'FontSize', 14)

subplot1(3)
aux1=log10(nanmedian([Chi1_2021 Chi2_2021],2));
aux2=nanmedian(Rho_2021,2);
aux3=log10(min([Chi1_2021 Chi2_2021],[],2));
aux4=log10(max([Chi1_2021 Chi2_2021],[],2));

plot(aux1,aux2,'.b','MarkerSize',9)
hold on
y=[aux2(~isnan(aux2)); flipud(aux2(~isnan((aux2))))];
x=[aux3(~isnan(aux3)); flipud(aux4(~isnan((aux4))))];
patch(x,y,'b','facealpha',0.2)
set(gca,'Ydir','reverse')
grid on
plot(aux3,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
plot(aux4,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
set(gca,'Ydir','reverse')
grid on
xlim(log10([1e-11 1e-5]))
ylim([25.7 max(max([Rho_2020]))]); min(aux2);
yticks([25.8 26.1 26.3 26.55 26.7 26.8 26.9])
set(gca,'yticklabel',[])
xticks(log10([1e-10 1e-9 1e-8 1e-7 1e-6]))
tickslabel={'-10','', '-8','', '-6'};
xticklabels(tickslabel)
xtickangle(0)
set(gca, 'FontSize', 14)
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['Tuepsichi_rho_JUL.png']),'Resolution',400,'BackgroundColor','white')
end


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% OCTUBRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aux2=nanmedian(Rho_2022,2);
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 3.5 3.8];
subplot1(1,3)
subplot1(1)
y = [max(max([Rho_2020])) max(max(Rho_2020)) 20 20];
x = [-90 -45 -45 -90];
patch(x,y,[1 0 0]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
hold on
y = [max(max(Rho_2020)) max(max(Rho_2020)) 20 20];
x = [45 90 90 45];
patch(x,y,[0 0 1]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
ylim([25.7 max(max([Rho_2020]))]); min(aux2);
xlim([-90 90])
xticks([-45 0 45])
xtickangle(0)

set(gca,'Ydir','reverse')
a = get(gca,'XTickLabel');
%set(gca,'XTickLabel',a,'fontsize',12)
%ylabel('Presión [dbar]')
plot(Tu_2022,Rho_2022,'LineStyle','none','Marker','.','color','blue','MarkerSize',9)
h=plot([45 45],[24.5 max(max([Rho_2020]))],'k','LineWidth',2);
h=plot([-45 -45],[24.5 max(max([Rho_2020]))],'k','LineWidth',2);
grid on
%title('Enero 2022')
box on
yticks([25.8 26.1 26.3 26.55 26.7 26.8 26.9])
set(gca, 'FontSize', 14)


subplot1(2)
aux1=log10(nanmedian([e1_2022 e2_2022],2));
aux2=nanmedian(Rho_2022,2);
aux3=log10(min([e1_2022 e2_2022],[],2));
aux4=log10(max([e1_2022 e2_2022],[],2));

plot(aux1,aux2,'.b','MarkerSize',9)
hold on
y=[aux2(~isnan(aux2)); flipud(aux2(~isnan((aux2))))];
x=[aux3(~isnan(aux3)); flipud(aux4(~isnan((aux4))))];
patch(x,y,'b','facealpha',0.2)
set(gca,'Ydir','reverse')
grid on
plot(aux3,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
plot(aux4,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
set(gca,'Ydir','reverse')
grid on
xlim(log10([5e-11 1e-6]))
ylim([25.7 max(max([Rho_2020]))]); min(aux2);
xticks(log10([1e-10 1e-9 1e-8 1e-7]));
tickslabel={'-10', '-9', '-8','-7'};
xticklabels(tickslabel)
xtickangle(0)
yticks([25.8 26.1 26.3 26.55 26.7 26.8 26.9])
set(gca,'yticklabel',[])
set(gca, 'FontSize', 14)

subplot1(3)
aux1=log10(nanmedian([Chi1_2022 Chi2_2022],2));
aux2=nanmedian(Rho_2022,2);
aux3=log10(min([Chi1_2022 Chi2_2022],[],2));
aux4=log10(max([Chi1_2022 Chi2_2022],[],2));

plot(aux1,aux2,'.b','MarkerSize',9)
hold on
y=[aux2(~isnan(aux2)); flipud(aux2(~isnan((aux2))))];
x=[aux3(~isnan(aux3)); flipud(aux4(~isnan((aux4))))];
patch(x,y,'b','facealpha',0.2)
set(gca,'Ydir','reverse')
grid on
plot(aux3,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
plot(aux4,aux2,'LineStyle','-','color','#6495ED','linewidth',0.5)
set(gca,'Ydir','reverse')
grid on
xlim(log10([1e-11 1e-5]))
ylim([25.7 max(max([Rho_2020]))]); min(aux2);
yticks([25.8 26.1 26.3 26.55 26.7 26.8 26.9])
set(gca,'yticklabel',[])
xticks(log10([1e-10 1e-9 1e-8 1e-7 1e-6]))
tickslabel={'-10','', '-8','', '-6'};
xticklabels(tickslabel)
xtickangle(0)
set(gca, 'FontSize', 14)
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['Tuepsichi_rho_OCT.png']),'Resolution',400,'BackgroundColor','white')
end


%%
id1=isnan(e1_2020);
QC1_2020(id1)=NaN;
id2=isnan(e1_2020);
QC2_2020(id2)=NaN;


cmap = [
    1.000, 1.000, 1.000;  % white
    0.000, 0.447, 0.741;  % blue
    0.850, 0.325, 0.098;  % orange
    0.929, 0.694, 0.125;  % yellow
    0.635, 0.078, 0.184;  % red
    0.466, 0.674, 0.188;  % green
];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% JAN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ind=3:295;

P1=Pslow_2020(ind,2);
X1=[1:9];

figure()
set(gcf,'position',[10,10,600,500])
subplot(121)
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P1);
xvalues=num2cell(X1);
h=heatmap(xvalues,yvalues,QC1_2020(ind,:))
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
h.YDisplayLabels = repmat({''}, size(yvalues));  % Hide y-tick labels
colormap(cmap);
colorbar;
caxis([-0.5 5.5])

subplot(122)
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P1);
xvalues=num2cell(X1);
h=heatmap(xvalues,yvalues,QC2_2020(ind,:))
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
h.YDisplayLabels = repmat({''}, size(yvalues));  % Hide y-tick labels
colormap(cmap);
colorbar;
caxis([-0.5 5.5])
f=gcf;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% JUL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ind=3:261;

P1=Pslow_2021(ind,5);
X1=[1:15];

figure()
set(gcf,'position',[10,10,600,500])
subplot(121)
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P1);
xvalues=num2cell(X1);
h=heatmap(xvalues,yvalues,QC1_2021(ind,:))
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
h.YDisplayLabels = repmat({''}, size(yvalues));  % Hide y-tick labels
colormap(cmap);
colorbar;
caxis([-0.5 5.5])

subplot(122)
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P1);
xvalues=num2cell(X1);
h=heatmap(xvalues,yvalues,QC2_2021(ind,:))
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
h.YDisplayLabels = repmat({''}, size(yvalues));  % Hide y-tick labels
colormap(cmap);
colorbar;
caxis([-0.5 5.5])
f=gcf;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OCT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ind=4:201;

P1=Pslow_2022(ind,2);
X1=[1:10];

figure()
set(gcf,'position',[10,10,600,500])
subplot(121)
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P1);
xvalues=num2cell(X1);
h=heatmap(xvalues,yvalues,QC1_2022(ind,:))
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
h.YDisplayLabels = repmat({''}, size(yvalues));  % Hide y-tick labels
colormap(cmap);
colorbar;
caxis([-0.5 5.5])

subplot(122)
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P1);
xvalues=num2cell(X1);
h=heatmap(xvalues,yvalues,QC2_2022(ind,:))
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
h.YDisplayLabels = repmat({''}, size(yvalues));  % Hide y-tick labels
colormap(cmap);
colorbar;
caxis([-0.5 5.5])
f=gcf;




