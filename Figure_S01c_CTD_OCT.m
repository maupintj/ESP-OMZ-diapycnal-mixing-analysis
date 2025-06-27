close all; clear all;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';

load(fullfile(data_dir,'CTD','All_CTD_data.mat'));

O_CTD2020=O_CTD2020*44.6596./((sigmat_CTD2020+1000)/1000);
O_CTD2021=O_CTD2021*44.6596./((sigmat_CTD2021+1000)/1000);
O_CTD2022=O_CTD2022*44.6596./((sigmat_CTD2022+1000)/1000);

sf=true;
close all

count=0;
aa=0.13
for i1=1:7
    d(i1)=(0.012+aa)*i1
    count=count+1;
end
d=d-aa,
a=ones(7,1)*aa
pos1=[d(1)    0.17    a(1)    0.7];
pos2=[d(2)    0.17    a(2)    0.7];
pos3=[d(3)    0.17    a(3)    0.7];
pos4=[d(4)    0.17    a(4)    0.7];
pos5=[d(5)    0.17    a(5)    0.7];
pos6=[d(6)    0.17    a(6)    0.7];
pos7=[d(7)    0.17    a(7)    0.7];
font=12;
hf=figure;
set(gcf,'position',[10,10,1400,500])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      Panel 1      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
%%%%%%%%%%%%%%%%%%%%%% TEMPERATURA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=plot(TC_CTD2022(:,1),P_CTD2022(:,1),'k-','LineWidth',2);
xlim([5.5 13.5])
%text(8,250,'A','FontSize',14,'Color','blue')
hold on
% y = [325 325 225 225];
% x = [5 17 17 5];
% patch(x,y,[0.5 0.5 .5]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[4:3:17])
xlim([5.5 13.5])
ylim([20 550])
% xlim([min(floor(T)) max(ceil(T))])
set(gca,'Ydir','reverse')
%ylabel(['Pressure [dbar]'],'FontSize',14)
%%%%%%%%%%%%%%%%%%%%%%  SALINIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
hp=plot(SA_CTD2022(:,1),P_CTD2022(:,1),'r-','LineWidth',2);
xlim([34 34.75])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos1(1) pos1(2)-.038 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor','r','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[34.1:.25:34.9])
xlim([34 34.75])
ylim([20 550])
%%%%%%%%%%%%%%%%%%%%%%   DENSIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
hp=plot(sigmat_CTD2022(:,1),P_CTD2022(:,1),'b-','LineWidth',2);
xlim([25.57 27.1])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos1(1) pos1(2)-.038*2 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor','b','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[25:0.4:27])
xlim([25.57 27.1])
ylim([20 550])
%%%%%%%%%%%%%%%%%%%%%%%%    OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
hp=plot(O_CTD2022(:,1),P_CTD2022(:,1),'m-','LineWidth',2);
% xlim([0 6])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos1(1) pos1(2)-.038*3 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor','m','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',floor([15 50 100 150 200 250]))
ylim([20 550])
xlim([0 250])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      Panel 2      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
%%%%%%%%%%%%%%%%%%%%%% TEMPERATURA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=plot(TC_CTD2022(:,2),P_CTD2022(:,2),'k-','LineWidth',2);
xlim([5.5 13.5])
%text(8,250,'A','FontSize',14,'Color','blue')
hold on
% y = [325 325 225 225];
% x = [5 17 17 5];
% patch(x,y,[0.5 0.5 .5]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[4:3:17])
xlim([5.5 13.5])
ylim([20 550])
% xlim([min(floor(T)) max(ceil(T))])
set(gca,'Ydir','reverse')
%ylabel(['Pressure [dbar]'],'FontSize',14)
yticklabels([])
%%%%%%%%%%%%%%%%%%%%%%  SALINIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
hp=plot(SA_CTD2022(:,2),P_CTD2022(:,2),'r-','LineWidth',2);
xlim([34 34.75])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos2(1) pos2(2)-.038 pos2(3) .01],'fontsize',font);
set(h,'color','none','xcolor','r','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[34.1:.25:34.9])
xlim([34 34.75])
ylim([20 550])
%%%%%%%%%%%%%%%%%%%%%%   DENSIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
hp=plot(sigmat_CTD2022(:,2),P_CTD2022(:,2),'b-','LineWidth',2);
xlim([25.57 27.1])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos2(1) pos2(2)-.038*2 pos2(3) .01],'fontsize',font);
set(h,'color','none','xcolor','b','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[25:0.4:27])
xlim([25.57 27.1])
ylim([20 550])
%%%%%%%%%%%%%%%%%%%%%%%%    OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
hp=plot(O_CTD2022(:,2),P_CTD2022(:,2),'m-','LineWidth',2);
% xlim([0 6])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos2(1) pos2(2)-.038*3 pos2(3) .01],'fontsize',font);
set(h,'color','none','xcolor','m','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',floor([15 50 100 150 200 250]))
ylim([20 550])
xlim([0 250])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      Panel 3      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos3);
%%%%%%%%%%%%%%%%%%%%%% TEMPERATURA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=plot(TC_CTD2022(:,3),P_CTD2022(:,3),'k-','LineWidth',2);
xlim([5.5 13.5])
%text(8,250,'A','FontSize',14,'Color','blue')
hold on
% y = [325 325 225 225];
% x = [5 17 17 5];
% patch(x,y,[0.5 0.5 .5]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[4:3:17])
xlim([5.5 13.5])
ylim([20 550])
% xlim([min(floor(T)) max(ceil(T))])
set(gca,'Ydir','reverse')
%ylabel(['Pressure [dbar]'],'FontSize',14)
yticklabels([])
%%%%%%%%%%%%%%%%%%%%%%  SALINIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos3);
hp=plot(SA_CTD2022(:,3),P_CTD2022(:,3),'r-','LineWidth',2);
xlim([34 34.75])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos3(1) pos3(2)-.038 pos3(3) .01],'fontsize',font);
set(h,'color','none','xcolor','r','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[34.1:.25:34.9])
xlim([34 34.75])
ylim([20 550])
%%%%%%%%%%%%%%%%%%%%%%   DENSIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos3);
hp=plot(sigmat_CTD2022(:,3),P_CTD2022(:,3),'b-','LineWidth',2);
xlim([25.57 27.1])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos3(1) pos3(2)-.038*2 pos3(3) .01],'fontsize',font);
set(h,'color','none','xcolor','b','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[25:0.4:27])
xlim([25.57 27.1])
ylim([20 550])
%%%%%%%%%%%%%%%%%%%%%%%%    OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos3);
hp=plot(O_CTD2022(:,3),P_CTD2022(:,3),'m-','LineWidth',2);
% xlim([0 6])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos3(1) pos3(2)-.038*3 pos3(3) .01],'fontsize',font);
set(h,'color','none','xcolor','m','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',floor([15 50 100 150 200 250]))
ylim([20 550])
xlim([0 250])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      Panel 4      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos4);
%%%%%%%%%%%%%%%%%%%%%% TEMPERATURA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=plot(TC_CTD2022(:,4),P_CTD2022(:,4),'k-','LineWidth',2);
xlim([5.5 13.5])
%text(8,250,'A','FontSize',14,'Color','blue')
hold on
% y = [325 325 225 225];
% x = [5 17 17 5];
% patch(x,y,[0.5 0.5 .5]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[4:3:17])
xlim([5.5 13.5])
ylim([20 550])
% xlim([min(floor(T)) max(ceil(T))])
set(gca,'Ydir','reverse')
%ylabel(['Pressure [dbar]'],'FontSize',14)
yticklabels([])
%%%%%%%%%%%%%%%%%%%%%%  SALINIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos4);
hp=plot(SA_CTD2022(:,4),P_CTD2022(:,4),'r-','LineWidth',2);
xlim([34 34.75])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos4(1) pos4(2)-.038 pos4(3) .01],'fontsize',font);
set(h,'color','none','xcolor','r','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[34.1:.25:34.9])
xlim([34 34.75])
ylim([20 550])
%%%%%%%%%%%%%%%%%%%%%%   DENSIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos4);
hp=plot(sigmat_CTD2022(:,4),P_CTD2022(:,4),'b-','LineWidth',2);
xlim([25.57 27.1])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos4(1) pos4(2)-.038*2 pos4(3) .01],'fontsize',font);
set(h,'color','none','xcolor','b','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[25:0.4:27])
xlim([25.57 27.1])
ylim([20 550])
%%%%%%%%%%%%%%%%%%%%%%%%    OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos4);
hp=plot(O_CTD2022(:,4),P_CTD2022(:,4),'m-','LineWidth',2);
% xlim([0 6])
ylim([20 550])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos4(1) pos4(2)-.038*3 pos4(3) .01],'fontsize',font);
set(h,'color','none','xcolor','m','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',floor([15 50 100 150 200 250]))
ylim([20 550])
xlim([0 250])
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['CTD_OCT.png']),'Resolution',400,'BackgroundColor','white')
end
%exportgraphics(f,fullfile(FolderName,['CTD_OCTUBRE.png']),'Resolution',400,'BackgroundColor','white')


