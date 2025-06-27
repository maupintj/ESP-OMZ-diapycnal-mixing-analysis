close all; clear 
data_dir='/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
file=dir(fullfile(data_dir,'GLIDER/CP/CP_2*'));
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures';
sf=false;  % Save figure flag

for i3=5%1:length(file) %TU i3=5
file_name=file(i3).name;
load(fullfile(file(i3).folder,file(i3).name));

[minlo, aux]=min(lo); 
lo1 = lo(1:aux); la1=la(1:aux);
vx1 = vx(1:aux); vy1=vy(1:aux);
lo2 = lo(aux+1:end); la2=la(aux+1:end);
vx2 = vx(aux+1:end); vy2=vy(aux+1:end);

figure()
set(gcf,'position',[10,10,500,500])
m_proj('mercator','lon',[-76 -72],'lat',[-38 -35]);
m_gshhs_h('patch',[.5 .5 .5]);
m_grid('box','out','tickdir','in');
hold on
m_plot(lo1,la1,'ko','markersize',5)
m_quiver(lo1,la1,vx1,vy1,2,'k')
m_plot(lo2,la2,'ro','markersize',5)
quiver(lo2,la2,vx2,vy2,2,'r')
f=gcf;
pause(1)
%exportgraphics(f,fullfile(FolderName,[file_name(1:15) '_MAP.png']),'Resolution',400,'BackgroundColor','white')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SEPARA TRANSECTAS DE IDA Y VUELTA
% Define el límite de la transecta en base al punto más al oeste: min(LONG)
[nf, nc]=size(LONG); % numero de filas (nf) y número de columnas (nc)
[a, aux]=min(LONG(:)); 
% separa transecta de ida (1) de la devuelta (2)
aux=floor(aux/nf); % aux contiene la columna más al oeste
S1 = SALT(:,1:aux); T1=TEMP(:,1:aux); P1=PRESS(:,1:aux); 
O1 = OXYG(:,1:aux); L1=LONG(:,1:aux); M1=LATI(:,1:aux); 
Ti1= TIME(:,1:aux);
Tm1=Ti1+datenum(str2double(file_name(4:7)),str2double(file_name(8:9)),str2double(file_name(10:11)),str2double(file_name(12:13)),str2double(file_name(14:15)),0);
time1=datetime([min(min(Tm1)) max(max(Tm1))],'ConvertFrom','datenum');
a=string(time1); a1=char(a(1)); a2=char(a(2));
time1=strcat(a1(1:6)," to ",a2(1:11));

S2 = SALT(:,aux+1:end); T2=TEMP(:,aux+1:end); P2=PRESS(:,aux+1:end); 
O2 = OXYG(:,aux+1:end); L2=LONG(:,aux+1:end); M2=LATI(:,aux+1:end);
Ti2= TIME(:,aux+1:end); 
Tm2=Ti2+datenum(str2double(file_name(4:7)),str2double(file_name(8:9)),str2double(file_name(10:11)),str2double(file_name(12:13)),str2double(file_name(14:15)),0);
time2=datetime([min(min(Tm2)) max(max(Tm2))],'ConvertFrom','datenum');
a=string(time2); a1=char(a(1)); a2=char(a(2));
time2=strcat(a1(1:6)," to ",a2(1:11));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcula salinidad absoluta, temperatura conservativa y densidad potencial
[SA1, ~] = gsw_SA_from_SP(S1,P1,-74,-36.5);
CT1  = gsw_CT_from_t(SA1,T1,P1);
PRO1 = gsw_rho(SA1,CT1,0); % Usa p_ref=0  valores van 1024 a 1028
% Transecta de vuelta
[SA2, ~] = gsw_SA_from_SP(S2,P2,-74,-36.5);
CT2 = gsw_CT_from_t(SA2,T2,P2);
PRO2 = gsw_rho(SA2,CT2,0); % Usa p_ref=0  valores van 1024 a 1028
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xi=linspace(-75,-73,250)';
%xi=linspace(min(min(LONG)),max(max(LONG)),250)';
zi = xi*0;
dx = 5/111;  dz=5/111;
w=[1 2 3 4 3 2 1]'; w=w/sum(w); % PESOS DE FILTRO TRIANGULAR GRILLA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  TRANSECTA IDA
%%%%%%%%%%%%%%%%%%%%%
% Prelocaliza arreglos en memoria
CT1i = zeros(800,length(xi));
SA1i = CT1i;
DO1i = CT1i;
 for i=1:800 % por ejemplo solo hacer grilla hasta 800 depende de transecta
    % temperature
    [aux, ~] = grilladata(L1(i,:),P1(i,:),CT1(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux = filtergap(aux,w);
    CT1i(i,:) = aux';
    % sal
    [aux, ~] = grilladata(L1(i,:),P1(i,:),SA1(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux = filtergap(aux,w);
    SA1i(i,:) = aux';
    % Oxigen
    [aux, nd]=grilladata(L1(i,:),P1(i,:),O1(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux=filtergap(aux,w);
    DO1i(i,:)=aux';
 end
SA1i(SA1i<33)=NaN;
CT1i(SA1i<33)=NaN;
PRO1i=gsw_rho(SA1i,CT1i,0);
[Tu1,~, p_mid1] = gsw_Turner_Rsubrho(SA1i(1:10:800,:),CT1i(1:10:800,:),(1:10:800)');;
nanaux=isnan(Tu1);
Tu1(Tu1>90 | Tu1<-90)=NaN;
p_mid1=mean(p_mid1,2,'omitnan');
[X,Y]=meshgrid(xi,p_mid1(:,1));
Tu1=griddata(X(~isnan(Tu1)),Y(~isnan(Tu1)),Tu1(~isnan(Tu1)),X,Y);
Tu1(nanaux)=NaN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  TRANSECTA VUELTA
%%%%%%%%%%%%%%%%%%%%%
CT2i = zeros(800,length(xi));
SA2i = CT2i;
DO2i = CT2i;
 for i = 1:800 % por ejemplo solo hacer grilla hasta 800 depende de transecta
    % Temperature
    [aux, ~] = grilladata(L2(i,:),P2(i,:),CT2(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux=filtergap(aux,w);
    CT2i(i,:) = aux';
    % Sal
    [aux, ~] = grilladata(L2(i,:),P2(i,:),SA2(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux = filtergap(aux,w);
    SA2i(i,:) = aux';
    % Oxígeno
    [aux, nd] = grilladata(L2(i,:),P2(i,:),O2(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux = filtergap(aux,w);
    DO2i(i,:) = aux';
 end
SA2i(SA2i<33)=NaN;
CT2i(SA2i<33)=NaN;
PRO2i = gsw_rho(SA2i,CT2i,0);
[Tu2,~, p_mid2] = gsw_Turner_Rsubrho(SA2i(1:10:800,:),CT2i(1:10:800,:),(1:10:800)');
clear nanaux
nanaux=isnan(Tu2);
Tu2(Tu2>90 | Tu2<-90)=NaN;
p_mid2=mean(p_mid2,2,'omitnan');
[X,Y]=meshgrid(xi,p_mid2(:,1));
Tu2=griddata(X(~isnan(Tu2)),Y(~isnan(Tu2)),Tu2(~isnan(Tu2)),X,Y);
Tu2(nanaux)=NaN;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load(fullfile(data_dir,'Tu_colormap.mat'))


tiledlayout(4,2,"TileSpacing","compact");
set(gcf,'position',[10,10,1200,700])

nexttile
pcolor(xi,(1:10:800),CT1i(1:10:800,:)); shading interp 
axis ij
colmap=cmocean('thermal');
colormap(gca,colmap); colorbar; 
clim([4 14])
title(time1)
xticks([])
yticks([100 300 500 700])
xlim([-74.5 -73.2])

nexttile
pcolor(xi,(1:10:800),CT2i(1:10:800,:)); shading interp 
axis ij
colmap=cmocean('thermal');
colormap(gca,colmap); colorbar; 
clim([4 14])
title(time2)
xticks([])
yticks([100 300 500 700])
xlim([-74.5 -73.2])

nexttile
pcolor(xi,(1:10:800),SA1i(1:10:800,:)); shading interp 
axis ij
colmap=cmocean('haline');
colormap(gca,colmap); colorbar; 
clim([34 34.8])
xticks([])
yticks([100 300 500 700])
xlim([-74.5 -73.2])

nexttile
pcolor(xi,(1:10:800),SA2i(1:10:800,:)); shading interp 
axis ij
colmap=cmocean('haline');
colormap(gca,colmap); colorbar; 
clim([34 34.8])
xticks([])
yticks([100 300 500 700])
xlim([-74.5 -73.2])

nexttile
pcolor(xi,(1:10:800),DO1i(1:10:800,:)*44.63); shading interp 
axis ij
colmap=cmocean('oxy');
colormap(gca,colmap); colorbar; 
xticks([])
yticks([100 300 500 700])
xlim([-74.5 -73.2])

nexttile
pcolor(xi,(1:10:800),DO2i(1:10:800,:)*44.63); shading interp 
axis ij
colmap=cmocean('oxy');
colormap(gca,colmap); colorbar; 
xticks([])
yticks([100 300 500 700])
xlim([-74.5 -73.2])

nexttile
pcolor(xi,p_mid1,Tu1); shading interp 
colormap(gca,Tu2_Vfinal); colorbar ; hold on; axis ij
yticks([100 300 500 700])
xlim([-74.5 -73.2])

nexttile
pcolor(xi,p_mid2,Tu2); shading interp 
colormap(gca,Tu2_Vfinal); colorbar; hold on; axis ij
yticks([100 300 500 700])
xlim([-74.5 -73.2])

f=gcf;
pause(1)
%exportgraphics(f,fullfile(FolderName,[file_name(1:15) '.png']),'Resolution',400,'BackgroundColor','white')
end


%% Transecto ejemplo
sf=true;
close all
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';
gebco_file = fullfile(data_dir, 'GEBCO', 'gebco_2023_n-34.5_s-38.8_w-76.5_e-71.5.nc');

% Bathymetry
band1 = ncread(gebco_file, 'elevation', [1 1], [1200 1032]);
lat = ncread(gebco_file, 'lat', [1], [1032]);
lon = ncread(gebco_file, 'lon', [1], [1200]);
levels = [-6000:1000:-1000, -1000:250:-250, -250:100:-10];



fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 7.5 4];
contourf(xi,p_mid2,Tu2,[-90:1:90],'linecolor','none')
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
contour(xi,(1:10:800)',SA2i(1:10:800,:),[34.75 34.85 35.15],'LineWidth',1,'linecolor',[50 50 50]/255)
[C,H]=contour(xi,(1:10:800)',SA2i(1:10:800,:),[34.65 34.9 35.25],'LineWidth',1,'linecolor',[50 50 50]/255);
clabel(C,H,'color',[50 50 50]/255)
[C,H]=contour(xi,(1:10:800)',DO2i(1:10:800,:)*44.63,[60 60],'LineWidth',1.5,'linecolor','m');
clabel(C,H,'color','m')
contour(xi,(1:800)',DO2i*44.63,[5 10 22],'LineWidth',1,'linecolor','m');
set(gca,'YDir','reverse')
clim([-90 90])
contour(xi,(1:10:800)',PRO2i(1:10:800,:)-1000,[25.8 27 27.3],'LineWidth',1,'linecolor','w');
[C,H]=contour(xi,(1:10:800)',PRO2i(1:10:800,:)-1000,[26.3 26.55 26.8],'LineWidth',1,'linecolor','w');

clabel(C,H,'color','w')
y = [1000 1000 0 0];
x = [-36.65 -36.35 -36.35 -36.65];
patch(x,y,[1 1 1]*0.5,'EdgeColor','k', 'FaceAlpha',0.2)



% Ensure row vectors
lon_vec = lon(:)';
bathy_vec = -band1(:,552)';  % bathymetry: negative = water, positive = seafloor

% Define max depth (in meters, positive down)
bottom_limit = 2000;

% Mask out anything shallower than the bottom limit
bathy_clipped = min(bathy_vec, bottom_limit);

% Create polygon from bathy line down to 1000 m and back
x_poly = [lon_vec, fliplr(lon_vec)];
y_poly = [bathy_clipped, repmat(bottom_limit, 1, length(lon_vec))];

% Plot
hold on
patch(x_poly, y_poly, [0.6 0.6 0.6], 'EdgeColor', 'none')  % Gray fill
% Draw bathymetry line for reference
plot(lon_vec, bathy_vec, '-k', 'LineWidth', 1.5)
text(-73.55, 400, 'Continental Shelf', 'FontSize', 13, 'FontAngle', 'italic')
xlim([-74.5 -73.2])
ylim([0,750])
ax = gca;
pos = ax.Position;
pos(4) = 0.95 * pos(4);  % Shrink width to 75% of original
pos(2)=pos(2)+0.05;
ax.Position = pos;

ylabel('Depth (m)')
hxl = xlabel('Longitude');
hxl.Position(2) = 820;  % Move label closer to x-axis
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['Turner_glider.png']),'Resolution',800,'BackgroundColor','white')
end
