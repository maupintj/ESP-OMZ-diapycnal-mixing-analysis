close all;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
load(fullfile(data_dir, 'GLIDER','CP','CP_Processed.mat'));
l(1)=25.80;
l(2)=26.10;
l(3)=26.30;
l(4)=26.55;
l(5)=26.70;
l(6)=26.80;
levels=[25.4 l 26.9 27 27.15 27.30 27.5];

aa=1:2:16;
aa2=2:2:16;
figure()
set(gcf,'position',[10,10,700,600])
dgts_tesis_O(SA,TC,O,0,levels,[33.9 34.9 5 15])

% figure()
% set(gcf,'position',[10,10,500,500])
% dgts_tesis_O(SAmean,TCmean,Omean,0,[25.4 25.6 25.8 25.95 26.1 26.3 26.45 26.55 26.6 26.7 26.8 26.9 27 27.15 27.30],[33.9 34.9 5 15])
% 

% INTERVALOS
ind1=(linspace(0,230,8)/255)';
ind2=zeros(9,1);
ind3=ones(9,1);
Color=nan(16,3);

for i1=1:8
Color(aa(i1),:)=[ind1(i1),ind1(i1),ind1(i1)];
Color(aa2(i1),:)=[ind1(i1),ind1(i1),ind1(i1)];
end
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 3.7 4];
dgts_tesis3(SA,TC,Color,0,levels,[33.8 35.2 4 14])
h1=plot(0,0,'o','Color',Color(aa(1),:),'MarkerFaceColor',Color(aa(1),:));
h2=plot(0,0,'o','Color',Color(aa(2),:),'MarkerFaceColor',Color(aa(2),:));
h3=plot(0,0,'o','Color',Color(aa(3),:),'MarkerFaceColor',Color(aa(3),:));
h4=plot(0,0,'o','Color',Color(aa(4),:),'MarkerFaceColor',Color(aa(4),:));
h5=plot(0,0,'o','Color',Color(aa(5),:),'MarkerFaceColor',Color(aa(5),:));
h6=plot(0,0,'o','Color',Color(aa(6),:),'MarkerFaceColor',Color(aa(6),:));
h7=plot(0,0,'o','Color',Color(aa(7),:),'MarkerFaceColor',Color(aa(7),:));
h8=plot(0,0,'o','Color',Color(aa(8),:),'MarkerFaceColor',Color(aa(8),:));

s1=33.8;%gsw_SA_from_SP(33.8,100,-74,-36.5);
s2=34.8;
s3=34.15;
t1=12.7;
t2=11.5;
t3=4.5;
text(s1,t1,'SSMW','color',[0 0 0],'EdgeColor',[0 0 0],'BackgroundColor',[1 1 1],FontSize=12)
text(s2,t2,'ESSW','color',[0 0 0],'EdgeColor',[0 0 0],'BackgroundColor',[1 1 1],FontSize=12)
text(s3,t3,'AAIW','color',[0 0 0],'EdgeColor',[0 0 0],'BackgroundColor',[1 1 1],FontSize=12)
xlim([33.8 35])
ylim([4 14])
% Define colormap (from Color matrix) and labels
colormap(Color(aa,:))

% Fix color axis to match 8 discrete levels
caxis([0.5, 8.5])  % Center ticks at 1, 2, ..., 8

cb = colorbar('Ticks', 1:8, ...
              'TickLabels', {...
                  '\it JJ10', '\it SO10', '\it N10', '\it JF11', ...
                  '\it MA11', '\it JA11', '\it MA12', '\it D12'}, ...
              'Direction', 'normal', ...
              'FontSize', 8, ...
              'Location', 'eastoutside');
% Adjust colorbar size and position
cb.Position(3) = 0.02;
cb.Position(4) = 0.7;
cb.Position(1) = cb.Position(1) + 0.1;
cb.Position(2) = cb.Position(2) + 0.12;
cb.Label.FontSize = 9;
cb.Label.Rotation = 90;
cb.TickLabelInterpreter = 'tex';  % Enable LaTeX-style formatting

%legend([h1 h2 h3 h4 h5 h6 h7 h8],'26 Jun to 09 Jul 2010','25 Sep to 06 Oct 2010','05 Nov to 25 Nov 2010','19 Jan to 03 Feb 2011','25 Mar to 12 Apr 2011','30 Jul to 15 Aug 2011','16 Mar to 02 Apr 2012','04 Dec to 12 Dec 2012','fontsize',8,'location','southwest')  
%legend([h1 h2 h3 h4 h5 h6 h7 h8],'26 Jun to 09 Jul 2010','25 Sep to 06 Oct 2010','05 Nov to 25 Nov 2010','19 Jan to 03 Feb 2011','25 Mar to 12 Apr 2011','30 Jul to 15 Aug 2011','16 Mar to 02 Apr 2012','04 Dec to 12 Dec 2012')  
%axis square
ax=gca
ax.FontSize=14
hxl = xlabel('Absolute Salinity (g kg^{-1})');
hxl.Position(2) = hxl.Position(2) + 0.4;  % Move label closer to x-axis
ylabel('Conservative Temperature (°C)')
ax = gca;
pos = ax.Position;
pos(3) = 0.9 * pos(3);  % Shrink width to 75% of original
pos(4) = 0.9 * pos(4);  % Shrink width to 75% of original
pos(2) = pos(2)+0.1;  % Shrink width to 75% of original

ax.Position = pos;
f=gcf;

%exportgraphics(f,fullfile(figure_dir,['TS_GLIDER_legend.png']),'Resolution',800,'BackgroundColor','white')
%exportgraphics(f,fullfile(FolderName,['TS_GLIDER.png']),'Resolution',800,'BackgroundColor','white')


