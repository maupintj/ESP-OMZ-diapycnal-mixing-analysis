% Base directories
close all; clear;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures';
sf=true;  % Save figure flag
load(fullfile(data_dir,'VMP','JUL','VMP_Data_2021.mat'));
load(fullfile(data_dir,'ADCP','JUL','ADCP_Data_2021.mat'));
load(fullfile(data_dir,'VMP','OCT','VMP_Data_2022.mat'));
load(fullfile(data_dir,'ADCP','OCT','ADCP_Data_2022.mat'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% CURRENTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% JULY    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
tiledlayout(3,1,"TileSpacing","compact");
set(gcf,'position',[10,10,600,800])
nexttile
pcolor(time2021,Prof2021,sqrt(DataU2021.^2+DataV2021.^2));
shading interp
set(gca,'Ydir','reverse')
title('July 2021')
cmap=cmocean('dense');
colormap(gca,cmap); colorbar; 
%title('Magnitud')
caxis([0 15])
hold on
plot(datetime(tt_2021,"ConvertFrom","datenum"),Pslow_2021,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")

nexttile
pcolor(time2021,Prof2021,DataU2021);
shading interp
set(gca,'Ydir','reverse')
title('U')
cmap=cmocean('balance');
colormap(gca,cmap); colorbar; 
%title('U')
caxis([-10 10])
hold on
plot(datetime(tt_2021,"ConvertFrom","datenum"),Pslow_2021,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")

nexttile
pcolor(time2021,Prof2021,DataV2021);
shading interp
set(gca,'Ydir','reverse')
cmap=cmocean('balance');
colormap(gca,cmap); colorbar; 
title('V')
caxis([-10 10])
hold on
plot(datetime(tt_2021,"ConvertFrom","datenum"),Pslow_2021,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['ADCP_JUL.png']),'Resolution',400,'BackgroundColor','white')
end

%%%%% SHEAR %%%%%%%%
figure()
tiledlayout(3,1,"TileSpacing","compact");
set(gcf,'position',[10,10,600,800])
nexttile
pcolor(time2021,Prof2021,sqrt(dUz2021.^2+dVz2021.^2));
shading interp
set(gca,'Ydir','reverse')
title('July 2021')
cmap=cmocean('dense');
colormap(gca,cmap); colorbar; 
%title('Magnitud')
caxis([0 1])
hold on
plot(datetime(tt_2021,"ConvertFrom","datenum"),Pslow_2021,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")

nexttile
pcolor(time2021,Prof2021,dUz2021);
shading interp
set(gca,'Ydir','reverse')
title('dUdz')
cmap=cmocean('balance');
colormap(gca,cmap); colorbar; 
%title('U')
caxis([-1 1])
hold on
plot(datetime(tt_2021,"ConvertFrom","datenum"),Pslow_2021,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")

nexttile
pcolor(time2021,Prof2021,dVz2021);
shading interp
set(gca,'Ydir','reverse')
%title('July 2021')
cmap=cmocean('balance');
colormap(gca,cmap); colorbar;
title('dVdz')
caxis([-1 1])
hold on
plot(datetime(tt_2021,"ConvertFrom","datenum"),Pslow_2021,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['Shear_JUL.png']),'Resolution',400,'BackgroundColor','white')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% OCTOBER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
tiledlayout(3,1,"TileSpacing","compact");
set(gcf,'position',[10,10,600,800])
nexttile
pcolor(time2022,Prof2022,sqrt(DataU2022.^2+DataV2022.^2));
shading interp
set(gca,'Ydir','reverse')
title('October 2022')
cmap=cmocean('dense');
colormap(gca,cmap); colorbar;
%title('Magnitud')
caxis([0 15])
hold on
plot(datetime(tt_2022,"ConvertFrom","datenum"),Pslow_2022,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")

nexttile
pcolor(time2022,Prof2022,DataU2022);
shading interp
set(gca,'Ydir','reverse')
title('U')
cmap=cmocean('balance');
colormap(gca,cmap); colorbar;
%title('U')
caxis([-10 10])
hold on
plot(datetime(tt_2022,"ConvertFrom","datenum"),Pslow_2022,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")


nexttile
pcolor(time2022,Prof2022,DataV2022);
shading interp
set(gca,'Ydir','reverse')
%title('July 2022')
cmap=cmocean('balance');
colormap(gca,cmap); colorbar;
title('V')
caxis([-10 10])
hold on
plot(datetime(tt_2022,"ConvertFrom","datenum"),Pslow_2022,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['ADCP_OCT.png']),'Resolution',400,'BackgroundColor','white')
end


%print('-dpng',fullfile(FolderName,['currents_2022']),'-r400')

%%%%% SHEAR %%%%%%%%

figure()
tiledlayout(3,1,"TileSpacing","compact");
set(gcf,'position',[10,10,600,800])
nexttile
pcolor(time2022,Prof2022,sqrt(dUz2022.^2+dVz2022.^2));
shading interp
set(gca,'Ydir','reverse')
title('July 2022')
cmap=cmocean('dense');
colormap(gca,cmap); colorbar;
%title('Magnitud')
caxis([0 1])
hold on
plot(datetime(tt_2022,"ConvertFrom","datenum"),Pslow_2022,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")
nexttile
pcolor(time2022,Prof2022,dUz2022);
shading interp
set(gca,'Ydir','reverse')
title('dUdz')
cmap=cmocean('balance');
colormap(gca,cmap); colorbar;
%title('U')
caxis([-1 1])
hold on
plot(datetime(tt_2022,"ConvertFrom","datenum"),Pslow_2022,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")

nexttile
pcolor(time2022,Prof2022,dVz2022);
shading interp
set(gca,'Ydir','reverse')
%title('July 2022')
cmap=cmocean('balance');
colormap(gca,cmap); colorbar;
title('dVdz')
caxis([-1 1])
hold on
plot(datetime(tt_2022,"ConvertFrom","datenum"),Pslow_2022,'.','Color','k','MarkerSize',5)
set(gca, 'Color', [0.8 0.8 0.8]); % Sets axes (plot area) background to gray
grid("off")
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['Shear_OCT.png']),'Resolution',400,'BackgroundColor','white')
end

%print('-dpng',fullfile(FolderName,['Shear_2022']),'-r400')
