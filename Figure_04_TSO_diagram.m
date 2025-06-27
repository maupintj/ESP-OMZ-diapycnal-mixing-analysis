close all; clear;

data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
load(fullfile(data_dir,'CTD','All_CTD_data.mat'));
l(1)=25.80;
l(2)=26.10;
l(3)=26.30;
l(4)=26.55;
l(5)=26.70;
l(6)=26.80;
levels=[25.4 l 26.9 27 27.15 27.30 27.5];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%        DGTS CTD   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';
sf=false;  % Save figure flag

% figure()
% set(gcf,'position',[10,10,1400,500])
% subplot 131
% dgts_tesis_O(SA_CTD2020,TC_CTD2020,O_CTD2020,0,levels,[33.9 34.9 5 15])
% subplot 132
% dgts_tesis_O(SA_CTD2021,TC_CTD2021,O_CTD2021,0,levels,[33.9 34.9 5 15])
% subplot 133
% dgts_tesis_O(SA_CTD2022,TC_CTD2022,O_CTD2022,0,levels,[33.9 34.9 5 15])
% if sf
%     print('-dpng',fullfile(FolderName,['TSO_Colorbar']),'-r400')
% end

fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 10.1 4.5];
tiledlayout(1, 3, 'Padding', 'compact', 'TileSpacing', 'tight');
% FIRST
nexttile
dgts_tesis_O(SA_CTD2020,TC_CTD2020,O_CTD2020,0,levels,[33.9 34.9 5 15])
xlabel('Absolute Salinity (g kg^{-1})');
ylabel('Conservative Temperature (°C)')
axis square
set(gca, 'FontSize', 14)
% SECOND
nexttile
dgts_tesis_O(SA_CTD2021,TC_CTD2021,O_CTD2021,0,levels,[33.9 34.9 5 15])
axis square
set(gca, 'FontSize', 14)
%THIRD
nexttile
dgts_tesis_O(SA_CTD2022,TC_CTD2022,O_CTD2022,0,levels,[33.9 34.9 5 15])
axis square
set(gca, 'FontSize', 14)

% >>> Place this AFTER the for-loop
% Get the middle axis (tile 2)
ax = findall(gcf, 'Type', 'Axes');
ax_sorted = flipud(ax);  % Tile 1 is last, so flip order
mid_ax = ax_sorted(2);   % Second tile (middle panel)
pos = get(mid_ax, 'Position');

% Place horizontal colorbar below middle tile
cb = colorbar('Position', [pos(1), pos(2)-0.1, pos(3), 0.02], ...
              'Orientation', 'horizontal');
cb.Label.String = 'Dissolved Oxygen (\mumol L^{-1})';
%cb.Label.Interpreter = 'tex';  % Use TeX (default) to avoid LaTeX font
cb.Label.FontSize = 12;
cb.FontSize = 14;
cb.AxisLocation = 'out';
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['TSO_CTD.png']),'Resolution',400,'BackgroundColor','white')
end