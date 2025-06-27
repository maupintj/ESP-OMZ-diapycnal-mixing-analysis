clearvars -except cl
close all;
cl = [11, 17];
sf = true;

% Directories
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';
gebco_file = fullfile(data_dir, 'GEBCO', 'gebco_2023_n-34.5_s-38.8_w-76.5_e-71.5.nc');

% Bathymetry
band1 = ncread(gebco_file, 'elevation', [1 1], [1200 1032]);
lat = ncread(gebco_file, 'lat', [1], [1032]);
lon = ncread(gebco_file, 'lon', [1], [1200]);
levels = [-6000:1000:-1000, -1000:250:-250, -250:100:-10];

% Panel info
months = {'JAN', 'JUL', 'OCT'};
titles = {'January 2020', 'July 2021', 'October 2022'};
titles2 = {'(a)', '(b)', '(c)'};

sst_files = {...
    '20200107090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc',...
    '20210707090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc',...
    '20221006090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc'};
ssh_files = {...
    'nrt_global_allsat_phy_l4_20200107_20200320.nc',...
    'nrt_global_allsat_phy_l4_20210701_20210707.nc',...
    'nrt_global_allsat_phy_l4_20221006_20221012.nc'};

fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 7.2 3.5];
tiledlayout(1, 3, 'Padding', 'compact', 'TileSpacing', 'tight');
for k = 1:3
    nexttile;
    % Map setup
    m_proj('mercator', 'lon', [-76 -72], 'lat', [-38 -35]);
    m_gshhs_f('patch', [.5 .5 .5]);
    if k == 1
        m_grid('box', 'fancy', 'tickdir', 'in', 'fontsize', 8);
    else
        m_grid('box', 'fancy', 'tickdir', 'in', ...
               'xticklabels', [], 'yticklabels', [], 'fontsize', 8);
    end

    hold on;

    % Bathymetry
    demcmap([-5000 0]);
    m_contour(lon, lat, band1', levels, 'linecolor', 'w', 'linewidth', 0.1);

    % SST
    sst_file = fullfile(data_dir, 'SSTA', months{k}, sst_files{k});
    lat_sst = ncread(sst_file, 'lat', [5200], [301]);
    lon_sst = ncread(sst_file, 'lon', [10400], [401]);
    mask = ncread(sst_file, 'mask', [10400 5200 1], [401 301 1]);
    sst = ncread(sst_file, 'analysed_sst', [10400 5200 1], [401 301 1]) - 273.15;
    colormap(cmocean('thermal'));
    m_contourf(lon_sst, lat_sst, (sst .* mask)', min(sst(:)):0.05:max(sst(:)), 'linecolor', 'none');
    caxis(cl);

    % SSH
    ssh_file = fullfile(data_dir, 'SSH', months{k}, ssh_files{k});
    lat_ssh = ncread(ssh_file, 'latitude', [208], [14]);
    lon_ssh = ncread(ssh_file, 'longitude', [416], [18]);
    sla = ncread(ssh_file, 'sla', [416 208 1], [18 14 1]);
    ugosa = ncread(ssh_file, 'ugosa', [416 208 1], [18 14 1]);
    vgosa = ncread(ssh_file, 'vgosa', [416 208 1], [18 14 1]);
    [lon_ssh, lat_ssh] = meshgrid(lon_ssh, lat_ssh);
    m_quiver(lon_ssh, lat_ssh, ugosa', vgosa', 1, 'k');
    m_contour(lon_ssh, lat_ssh, sla', 'linecolor', '#808080', 'linewidth', 0.5);

    % Vector scale + label
    m_quiver(-73.47, -37.7, 0.15, 0, 1.0, 'color', [.0 .0 .0], 'linewidth', 1, 'MaxHeadSize', 1.5);
    m_text(-73.5, -37.8, '15 cm/s', 'fontsize', 8);
    m_text(-73.55, -37.55, titles{k}, 'fontsize', 8);
    m_text(-75.88, -35.25, titles2{k}, 'fontsize', 12);
    
    % 
    m_plot([-74.5 -72.9],[-36.5 -36.5],'--k','linewidth',2)
    m_line([-74],[-36.5],'marker','x','color','k','markersize',8,'linewidth',3);
    
    % Station markers (for January as an example)
    if k == 1
        E1 = mean(-[73+36/60+.840/60,36+25/60+.854/60;
                    73+37/60+.028/60,36+25/60+.981/60;
                    73+36/60+.887/60,36+25/60+.673/60]);
        m_line(E1(1), E1(2), 'marker','d','color','k','markerfacecolor','w','markersize',8,'linewidth',0.5);
    elseif k == 2
        E1=-[73+37/60+.67/60,36+25/60+.33/60;
             73+37/60+.67/60,36+25/60+.39/60;
             73+37/60+.51/60,36+24/60+.57/60;
             73+37/60+.45/60,36+23/60+.87/60];
        E2=-[73+38/60+.110/60,36+28/60+.007/60;
             73+37/60+.940/60,36+28/60+.181/60;
             73+37/60+.702/60,36+28/60+.362/60;
             73+38/60+.265/60,36+28/60+.203/60;
             73+38/60+.029/60,36+28/60+.355/60;
             73+37/60+.815/60,36+28/60+.495/60;
             73+37/60+.887/60,36+28/60+.149/60;
             73+37/60+.629/60,36+28/60+.213/60;
             73+37/60+.217/60,36+28/60+.552/60;
             73+37/60+.493/60,36+28/60+.042/60;
             73+37/60+.294/60,36+28/60+.390/60;
             73+37/60+.458/60,36+27/60+.972/60];
            for i1=1:4
                h1=m_line(E1(i1,1),E1(i1,2),'marker','d','color','k','markerfacecolor','w','markersize',8,'linewidth',0.5);
            end
            
            for i1=1:12
                h2=m_line(E2(i1,1),E2(i1,2),'marker','d','color','k','markerfacecolor','w','markersize',8,'linewidth',0.5);
            end
    
    elseif k == 3
            clear E*
            E01=-[73+37/60+.402/60,36+29/60+.664/60;
                 73+37/60+.402/60,36+29/60+.664/60;
                 73+36/60+.730/60,36+29/60+.203/60;
                 73+36/60+.567/60,36+29/60+.118/60;
                 73+37/60+.112/60,36+29/60+.454/60;
                 73+36/60+.869/60,36+29/60+.278/60;
                 73+36/60+.661/60,36+29/60+.094/60;
                 73+37/60+.015/60,36+29/60+.443/60;
                 73+36/60+.534/60,36+29/60+.241/60;
                 73+36/60+.118/60,36+29/60+.034/60];
            for i1=1:10
                h10=m_plot(E01(i1,1),E01(i1,2),'marker','d','color','k','markerfacecolor','w','markersize',8,'linewidth',0.5);
            end 
        % October stations
        % Use your E01 coordinates here if needed
    end
end

% >>> Place this AFTER the for-loop
% Get the middle axis (tile 2)
ax = findall(gcf, 'Type', 'Axes');
ax_sorted = flipud(ax);  % Tile 1 is last, so flip order
mid_ax = ax_sorted(2);   % Second tile (middle panel)
pos = get(mid_ax, 'Position');

% Place horizontal colorbar below middle tile
cb = colorbar('Position', [pos(1), pos(2)-0.03, pos(3), 0.02], ...
              'Orientation', 'horizontal');
cb.Label.String = 'SST (°C)';
cb.Label.FontSize = 9;
cb.FontSize = 8;
cb.AxisLocation = 'out';

% Save Figure
if sf
    exportgraphics(gcf, fullfile(figure_dir, 'map_studyzone.png'), 'Resolution', 800, 'BackgroundColor', 'white');
end

