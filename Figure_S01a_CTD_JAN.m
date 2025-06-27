close all; clear all;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';

load(fullfile(data_dir,'CTD','All_CTD_data.mat'));
sf=true;

% O_CTD2020=O_CTD2020*44.6596./((sigmat_CTD2020+1000)/1000);
% O_CTD2021=O_CTD2021*44.6596./((sigmat_CTD2021+1000)/1000);
% O_CTD2022=O_CTD2022*44.6596./((sigmat_CTD2022+1000)/1000);

close all
count=0;
aa=0.13
for i1=1:7
    d(i1)=(0.03+aa)*i1
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


posS1=[0.370 0.350 0.15 0.4]
posS2=[0.640 0.350 0.15 0.4]
posS11=[0.370 0.20 0.15 0.5]
posS22=[0.640 0.20 0.15 0.5]

font=12;
hf=figure;
set(gcf,'position',[10,10,1400,500])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      Panel 1      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
%%%%%%%%%%%%%%%%%%%%%% TEMPERATURA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=plot(TC_CTD2020(:,1),P_CTD2020(:,1),'k-','LineWidth',2);
xlim([5 17])
text(8,250,'A','FontSize',14,'Color','blue')
hold on
y = [325 325 225 225];
x = [5 17 17 5];
patch(x,y,[0.5 0.5 .5]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[4:3:17])
xlim([min(min(TC_CTD2020)) max(max(TC_CTD2020))])
ylim([20 600])
% xlim([min(floor(T)) max(ceil(T))])
set(gca,'Ydir','reverse')
ylabel(['Pressure [dbar]'],'FontSize',14)
%%%%%%%%%%%%%%%%%%%%%%  SALINIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
hp=plot(SA_CTD2020(:,1),P_CTD2020(:,1),'r-','LineWidth',2);
xlim([min(min(SA_CTD2020)) max(max(SA_CTD2020))])
ylim([20 600])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos1(1) pos1(2)-.038 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor','r','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[34.3:.2:34.8])
xlim([min(min(SA_CTD2020)) max(max(SA_CTD2020))])
ylim([20 600])
%%%%%%%%%%%%%%%%%%%%%%   DENSIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
hp=plot(sigmat_CTD2020(:,1),P_CTD2020(:,1),'b-','LineWidth',2);
xlim([min(min(sigmat_CTD2020)) max(max(sigmat_CTD2020))])
ylim([20 600])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos1(1) pos1(2)-.038*2 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor','b','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[25:0.5:27])
xlim([min(min(sigmat_CTD2020)) max(max(sigmat_CTD2020))])
ylim([20 600])
%%%%%%%%%%%%%%%%%%%%%%%%    OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
hp=plot(O_CTD2020(:,1),P_CTD2020(:,1),'m-','LineWidth',2);
% xlim([0 6])
ylim([20 600])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos1(1) pos1(2)-.038*3 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor','m','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',floor([15 50 100 150 200 250]))
ylim([20 600])
xlim([min(min(O_CTD2020)) max(max(O_CTD2020))])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      Panel 2      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
%%%%%%%%%%%%%%%%%%%%%% TEMPERATURA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=plot(TC_CTD2020(:,2),P_CTD2020(:,2),'k-','LineWidth',2);
xlim([5 17])
text(8,150,'B','FontSize',14,'Color','blue')
hold on
y = [225 225 125 125];
x = [5 17 17 5];
patch(x,y,[0.5 0.5 .5]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[4:3:17])
xlim([min(min(TC_CTD2020)) max(max(TC_CTD2020))])
ylim([20 600])
% xlim([min(floor(T)) max(ceil(T))])
set(gca,'Ydir','reverse')
%ylabel(['Presión [dbar]'],'FontSize',14)
yticklabels([])
%%%%%%%%%%%%%%%%%%%%%%  SALINIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
hp=plot(SA_CTD2020(:,2),P_CTD2020(:,2),'r-','LineWidth',2);
xlim([min(min(SA_CTD2020)) max(max(SA_CTD2020))])
ylim([20 600])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos2(1) pos2(2)-.038 pos2(3) .01],'fontsize',font);
set(h,'color','none','xcolor','r','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[34.3:.2:34.8])
xlim([min(min(SA_CTD2020)) max(max(SA_CTD2020))])
ylim([20 600])
%%%%%%%%%%%%%%%%%%%%%%   DENSIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
hp=plot(sigmat_CTD2020(:,2),P_CTD2020(:,2),'b-','LineWidth',2);
xlim([min(min(sigmat_CTD2020)) max(max(sigmat_CTD2020))])
ylim([20 600])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos2(1) pos2(2)-.038*2 pos2(3) .01],'fontsize',font);
set(h,'color','none','xcolor','b','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[25:0.5:27])
xlim([min(min(sigmat_CTD2020)) max(max(sigmat_CTD2020))])
ylim([20 600])
%%%%%%%%%%%%%%%%%%%%%%%%    OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
hp=plot(O_CTD2020(:,2),P_CTD2020(:,2),'m-','LineWidth',2);
% xlim([0 6])
ylim([20 600])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos2(1) pos2(2)-.038*3 pos2(3) .01],'fontsize',font);
set(h,'color','none','xcolor','m','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',floor([15 50 100 150 200 250]))
ylim([20 600])
xlim([min(min(O_CTD2020)) max(max(O_CTD2020))])
yticklabels([])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      Panel 3      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos3);
%%%%%%%%%%%%%%%%%%%%%% TEMPERATURA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=plot(TC_CTD2020(:,3),P_CTD2020(:,3),'k-','LineWidth',2);
xlim([5 17])
%text(8,250,'B','FontSize',14,'Color','blue')
hold on
y = [325 325 225 225];
x = [5 17 17 5];
%patch(x,y,[0.5 0.5 .5]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[4:3:17])
xlim([min(min(TC_CTD2020)) max(max(TC_CTD2020))])
ylim([20 600])
% xlim([min(floor(T)) max(ceil(T))])
set(gca,'Ydir','reverse')
%ylabel(['Presión [dbar]'],'FontSize',14)
yticklabels([])
%%%%%%%%%%%%%%%%%%%%%%  SALINIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos3);
hp=plot(SA_CTD2020(:,3),P_CTD2020(:,3),'r-','LineWidth',2);
xlim([min(min(SA_CTD2020)) max(max(SA_CTD2020))])
ylim([20 600])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos3(1) pos3(2)-.038 pos3(3) .01],'fontsize',font);
set(h,'color','none','xcolor','r','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[34.3:.2:34.8])
xlim([min(min(SA_CTD2020)) max(max(SA_CTD2020))])
ylim([20 600])
%%%%%%%%%%%%%%%%%%%%%%   DENSIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos3);
hp=plot(sigmat_CTD2020(:,3),P_CTD2020(:,3),'b-','LineWidth',2);
xlim([min(min(sigmat_CTD2020)) max(max(sigmat_CTD2020))])
ylim([20 600])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos3(1) pos3(2)-.038*2 pos3(3) .01],'fontsize',font);
set(h,'color','none','xcolor','b','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[25:0.5:27])
xlim([min(min(sigmat_CTD2020)) max(max(sigmat_CTD2020))])
ylim([20 600])
%%%%%%%%%%%%%%%%%%%%%%%%    OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos3);
hp=plot(O_CTD2020(:,3),P_CTD2020(:,3),'m-','LineWidth',2);
% xlim([0 6])
ylim([20 600])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos3(1) pos3(2)-.038*3 pos3(3) .01],'fontsize',font);
set(h,'color','none','xcolor','m','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',floor([15 50 100 150 200 250]))
ylim([20 600])
xlim([min(min(O_CTD2020)) max(max(O_CTD2020))])
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['CTD_JAN.png']),'Resolution',400,'BackgroundColor','white')
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%   SUBPANELES   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
set(gcf,'position',[10,10,600,400])
subplot 121
pos1=gca;
pos1=pos1.Position;
subplot 122
pos2=gca;
pos2=pos2.Position

font=12;
hf=figure;
set(gcf,'position',[10,10,600,400])
pos2(4)=0.6;
pos1(4)=0.6;
pos2(2)=0.3;
pos1(2)=0.3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      Panel 1      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pos1(1)=pos1(1)-0.08;
pos1(2)=pos1(2)+0.05;
h=axes('position',pos1);
%%%%%%%%%%%%%%%%%%%%%% TEMPERATURA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=plot(TC_CTD2020(112:163,1),P_CTD2020(112:163,1),'k-','LineWidth',2);
xlim([9 10.5])
text(8,250,'A','FontSize',14,'Color','blue')
hold on
y = [325 325 225 225];
x = [5 17 17 5];
%patch(x,y,[0.5 0.5 .5]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[9:0.5:10])
xlim([9 10.5])
ylim([225 325])
% xlim([min(floor(T)) max(ceil(T))])
set(gca,'Ydir','reverse')
ylabel(['Pressure [dbar]'],'FontSize',14)
%%%%%%%%%%%%%%%%%%%%%%  SALINIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
hp=plot(SA_CTD2020(112:163,1),P_CTD2020(112:163,1),'r-','LineWidth',2);
xlim([34.68 34.8])
ylim([225 325])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos1(1) pos1(2)-.06 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor','r','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[34.68:.05:34.8])
xlim([34.68 34.8])
ylim([225 325])
%%%%%%%%%%%%%%%%%%%%%%   DENSIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
hp=plot(sigmat_CTD2020(112:163,1),P_CTD2020(112:163,1),'b-','LineWidth',2);
xlim([26.58 26.75])
ylim([225 325])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos1(1) pos1(2)-.06*2 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor','b','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[25.58:0.5:26.73])
xlim([25.58 26.75])
ylim([225 325])
%%%%%%%%%%%%%%%%%%%%%%%%    OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos1);
hp=plot(O_CTD2020(112:163,1),P_CTD2020(112:163,1),'m-','LineWidth',2);
xlim([6 23])
ylim([225 325])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos1(1) pos1(2)-.06*3 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor','m','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',floor([8 15 23]))
ylim([225 325])
xlim([6 23])
%xlim([min(min(O_CTD2020)) max(max(O_CTD2020))])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%      Panel 2      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pos2(1)=pos2(1)-0.08;
pos2(2)=pos2(2)+0.05;
h=axes('position',pos2);
%%%%%%%%%%%%%%%%%%%%%% TEMPERATURA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=plot(TC_CTD2020(62:113,2),P_CTD2020(62:113,2),'k-','LineWidth',2);
xlim([10.18 10.91])
%text(8,250,'B','FontSize',14,'Color','blue')
hold on
y = [225 225 125 125];
x = [5 17 17 5];
%patch(x,y,[0.5 0.5 .5]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[10.18:.25:10.91])
xlim([10.18 10.91])
ylim([125 225])
% xlim([min(floor(T)) max(ceil(T))])
set(gca,'Ydir','reverse')
%ylabel(['Presión [dbar]'],'FontSize',14)
%%%%%%%%%%%%%%%%%%%%%%  SALINIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
hp=plot(SA_CTD2020(62:113,2),P_CTD2020(62:113,2),'r-','LineWidth',2);
xlim([34.705 34.815])
ylim([125 225])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos2(1) pos2(2)-.06 pos2(3) .01],'fontsize',font);
set(h,'color','none','xcolor','r','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[34.71:0.05:34.81])
xlim([34.705 34.815])
ylim([125 225])
%%%%%%%%%%%%%%%%%%%%%%   DENSIDAD  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
hp=plot(sigmat_CTD2020(62:113,2),P_CTD2020(62:113,2),'b-','LineWidth',2);
xlim([26.46 26.63])
ylim([125 225])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos2(1) pos2(2)-.06*2 pos2(3) .01],'fontsize',font);
set(h,'color','none','xcolor','b','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[26.46:0.05:26.63])
xlim([26.46 26.63])
ylim([125 225])
%%%%%%%%%%%%%%%%%%%%%%%%    OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h=axes('position',pos2);
hp=plot(O_CTD2020(62:113,2),P_CTD2020(62:113,2),'m-','LineWidth',2);
xlim([5 19])
ylim([125 225])
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font)
axis off
set(gca,'Ydir','reverse')
h=axes('position',[pos2(1) pos2(2)-.06*3 pos2(3) .01],'fontsize',font);
set(h,'color','none','xcolor','m','ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',floor([5 10 15]))
xlim([5 19])
ylim([125 225])
% close figure 1
close figure 2
f=gcf;

if sf
    exportgraphics(f,fullfile(figure_dir,['CTD_JAN_Sub.png']),'Resolution',400,'BackgroundColor','white')
end



