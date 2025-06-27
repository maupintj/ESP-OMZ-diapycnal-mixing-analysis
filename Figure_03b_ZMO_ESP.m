close all; clear;
% Base directories
close all; clear;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures';
sf=false;  % Save figure flag
load(fullfile(data_dir,'WOA','SouthPacific','filtered','CTD_WOA_20101000_25degrees.mat'));
load(fullfile(data_dir,'WOA','SouthPacific','filtered','Oxi_WOA_20101000_25degrees.mat'));
dt_c = datetime(time_c*24*3600, 'ConvertFrom', 'epochtime', 'Epoch', '1770-01-01 00:00:00');
[y_c,~,~] = ymd(dt_c);
dt_o = datetime(time_o*24*3600, 'ConvertFrom', 'epochtime', 'Epoch', '1770-01-01 00:00:00');
[y_o,~,~] = ymd(dt_o);

rho = gsw_rho(SA,TC,0);

load coastlines
coastlat(coastlat>=-5 | coastlat<=-40)=NaN;
coastlon(coastlon>=-68 | coastlon<=-90)=NaN;
latt=coastlat(~isnan(coastlat) & ~isnan(coastlon));
lonn=coastlon(~isnan(coastlat) & ~isnan(coastlon));

% CAST CON OXIGENO
figure()
set(gcf,'position',[10,10,1200,800])
m_proj('miller','lon',[-90 -66],'lat',[-60 5]);
m_gshhs_l('patch',[.6 .6 .6]);
m_grid('box','on','tickdir','in');
hold on
m_sacatter(lon_c,lat_c,8,'blue','filled');
m_sacatter(lon_o,lat_o,8,'red','filled');
vertlatt=[latt; latt(end); latt(end)-0.5; flipud(latt)-0.5;latt(1);latt(1)-0.5];
vertlonn=[lonn; lonn(end); lonn(end)-2.5; flipud(lonn)-2.5;lonn(1);lonn(1)-2.5];
m_plot(vertlonn,vertlatt,'-k','linewidth',2)

f=gcf;
if sf
    pause(1)
    exportgraphics(f,fullfile(FolderName,['WODB_DATA_ESP.png']),'Resolution',400,'BackgroundColor','white')
end


SA(SA==0)=NaN;
a1=(-40:0.5:-10)';
mSA=nan(size(P,1),length(a1)-1);
mTC=nan(size(P,1),length(a1)-1);
mOxi=nan(size(P,1),length(a1)-1);
mRho=nan(size(P,1),length(a1)-1);
mlat=nan(length(a1)-1,1);
for i1=1:length(a1)-1
    pos1=a1(i1);
    pos2=a1(i1+1);
    mlat(i1,1)=(pos1+pos2)/2;
    id=lat_c>pos1 & lat_c<pos2;
    mSA(:,i1)=mean(SA(:,id),2,'omitnan');
    mTC(:,i1)=mean(TC(:,id),2,'omitnan');
    mRho(:,i1)=mean(rho(:,id),2,'omitnan');
end
Oxi(Oxi<0)=NaN;
for i1=1:length(a1)-1
    pos1=a1(i1);
    pos2=a1(i1+1);
    id=lat_o>pos1 & lat_o<pos2;
    mOxi(:,i1)=mean(Oxi(:,id),2,'omitnan');
end

% INTERPOLO LOS VALORES EN EL ESPACIO
mTCint=nan*mTC;
mSAint=nan*mTC;
mOxiint=nan*mOxi;
for i1=1:length(P(:,1))
    mTCint(i1,:)=interp1(mlat(~isnan(mTC(i1,:))),mTC(i1,~isnan(mTC(i1,:))),mlat);
    mSAint(i1,:)=interp1(mlat(~isnan(mSA(i1,:))),mSA(i1,~isnan(mSA(i1,:))),mlat);
    mOxiint(i1,:)=interp1(mlat(~isnan(mOxi(i1,:))),mOxi(i1,~isnan(mOxi(i1,:))),mlat);
end

[Tu, Rsubrho, p_mid] = gsw_Turner_Rsubrho(mSA,mTC,P(:,1));
%Tu(Tu<=45 & Tu>=-45)=NaN;
Tu(Tu>90 | Tu<-90)=NaN;
[X,Y]=meshgrid(mlat,p_mid(:,1));
Tu2=griddata(X(~isnan(Tu)),Y(~isnan(Tu)),Tu(~isnan(Tu)),X,Y);
[X,Y]=meshgrid(mlat,P(:,1));
mSA=griddata(X(~isnan(mSA)),Y(~isnan(mSA)),mSA(~isnan(mSA)),X,Y);
mSA=movmean(mSA,3,2,'omitnan');
mOxi=griddata(X(~isnan(mOxi)),Y(~isnan(mOxi)),mOxi(~isnan(mOxi)),X,Y);
mOxi=movmean(mOxi,3,2,'omitnan');
mRho=griddata(X(~isnan(mRho)),Y(~isnan(mRho)),mRho(~isnan(mRho)),X,Y);
mRho=movmean(mRho,3,2,'omitnan')-1000;


%%
sf=true;
load(fullfile(data_dir,'Tu_colormap.mat'));
close all
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 7.5 4];
contourf(mlat,p_mid(:,1),Tu2,[-90:1:90],'linecolor','none')
colormap(Tu2_Vfinal)
% Set axis properties
ax = gca;
set(ax, 'YDir', 'reverse', ...
        'CLim', [-90 90], ...
        'FontSize', 14)

% Create colorbar (outside, vertical, thin)
cb = colorbar('eastoutside');
cb.FontSize = 9;

% Adjust colorbar size and position
cb.Position(3) = 0.02;
cb.Position(4) = 0.7;
cb.Position(1) = cb.Position(1) + 0.07;
cb.Position(2) = cb.Position(2) + 0.1;

% Remove default label
cb.Label.String = '';

% Add horizontal label manually using text()
% Arguments: x, y, string
xlab = 1.04;
ylab = 0.02;  % Slightly below the colorbar
text(xlab, ylab, 'Tu °', ...
     'Units', 'normalized', ...
     'HorizontalAlignment', 'center', ...
     'FontSize', 12, ...
     'Parent', gca)

hold on
contour(mlat,P(:,1),mSA,[34.75 34.85 35.15],'LineWidth',1,'linecolor',[50 50 50]/255)
[C,H]=contour(mlat,P(:,1),mSA,[34.65 34.9 35.25],'LineWidth',1,'linecolor',[50 50 50]/255);
clabel(C,H,'color',[50 50 50]/255)
[C,H]=contour(mlat,P(:,1),mOxi,[60 60],'LineWidth',1.5,'linecolor','m');
clabel(C,H,'color','m')
contour(mlat,P(:,1),mOxi,[5 10 22],'LineWidth',1,'linecolor','m');
set(gca,'YDir','reverse')
clim([-90 90])
contour(mlat,P(:,1),mRho,[25.8 27.1 27.3],'LineWidth',1,'linecolor','w');
[C,H]=contour(mlat,P(:,1),mRho,[26.3 26.55 26.8],'LineWidth',1,'linecolor','w');

clabel(C,H,'color','w')
y = [1000 1000 0 0];
x = [-36.65 -36.35 -36.35 -36.65];
%patch(x,y,[1 1 1]*0.5,'EdgeColor','k', 'FaceAlpha',0.2)
set(gca, 'YDir', 'reverse','CLim', [-90 90],'FontSize', 14)
ylim([0,750])
ax = gca;
pos = ax.Position;
pos(4) = 0.95 * pos(4);  % Shrink width to 75% of original
pos(2)=pos(2)+0.05;
ax.Position = pos;

ylabel('Depth (m)')
xlabel('Latitude');
hxl = xlabel('Latitude');
hxl.Position(2) = 820;  % Move label closer to x-axis

f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['Turner_ZMO.png']),'Resolution',800,'BackgroundColor','white')
end
%%
close all; clear;
% Base directories
close all; clear;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures';
sf=false;  % Save figure flag
load(fullfile(data_dir,'WOA','SouthPacific','filtered','CTD_WOA_20101000_25degrees.mat'));
load(fullfile(data_dir,'WOA','SouthPacific','filtered','Oxi_WOA_20101000_25degrees.mat'));
dt_c = datetime(time_c*24*3600, 'ConvertFrom', 'epochtime', 'Epoch', '1770-01-01 00:00:00');
[y_c,~,~] = ymd(dt_c);
dt_o = datetime(time_o*24*3600, 'ConvertFrom', 'epochtime', 'Epoch', '1770-01-01 00:00:00');
[y_o,~,~] = ymd(dt_o);

rho = gsw_rho(SA,TC,0);

load coastlines
coastlat(coastlat>=-5 | coastlat<=-40)=NaN;
coastlon(coastlon>=-68 | coastlon<=-90)=NaN;
latt=coastlat(~isnan(coastlat) & ~isnan(coastlon));
lonn=coastlon(~isnan(coastlat) & ~isnan(coastlon));

% CAST CON OXIGENO
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 3 3];
m_proj('miller','lon',[-85 -55],'lat',[-45 0]);
m_gshhs_l('patch',[.6 .6 .6]);

% Reduce number of longitude ticks (e.g., every 10°)
m_grid('box','on','tickdir','in','fontsize',10, 'XTick', -80:10:-55);

hold on

% Define polygon vertices
vertlatt = [latt; latt(end); latt(end)-0.5; flipud(latt)-0.5; latt(1); latt(1)-0.5];
vertlonn = [lonn; lonn(end); lonn(end)-2.5; flipud(lonn)-2.5; lonn(1); lonn(1)-2.5];

% Add red patch with transparency
m_patch(vertlonn, vertlatt, [1 0 0], 'FaceAlpha', 0.2, 'EdgeColor', 'r', 'LineWidth', 0.1);

f=gcf;
if true
    exportgraphics(f,fullfile(figure_dir,['mini_map.png']),'Resolution',800,'BackgroundColor','white')
end