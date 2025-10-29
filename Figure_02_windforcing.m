clear all
close all
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';
sf=false;  % Save figure flag

%% Open Wind data

era_lat = ncread(fullfile(data_dir,'ERA5','ERA5_data.nc'),'latitude');
era_lon = ncread(fullfile(data_dir,'ERA5','ERA5_data.nc'),'longitude');
time_era = hourly_vec(2019,2022,0,23,1);

uwind = ncread(fullfile(data_dir,'ERA5','ERA5_data.nc'),'u10');
vwind = ncread(fullfile(data_dir,'ERA5','ERA5_data.nc'),'v10');

%% Enero 2020, 6-8
E1=-[73+36/60+.840/60,36+25/60+.854/60;
     73+37/60+.028/60,36+25/60+.981/60;
     73+36/60+.887/60,36+25/60+.673/60];
 E1=mean(E1);
 E2=-[73+ 43/60+.414/60,36+ 26/60+.045/60;
     73+ 43/60+.095/60,36+ 26/60+.029/60;
     73+ 42/60+.867/60,36+ 25/60+.966/60];
E2=mean(E2);
E3=-[73+ 32/60+.063/60, 36+ 26/60+.016/60;
    73+ 31/60+.941/60, 36+ 26/60+.002/60;
    73+ 31/60+.928/60, 36+ 26/60+.019/60];
E3=mean(E3);

idxlat = find(era_lat>=-37 & era_lat<=-36);
idxlon = find(era_lon>=-74.25 & era_lon<=-73);

vwind_obs = vwind(idxlon,idxlat,:);
vwind_obs = nanmean(vwind_obs,1);
vwind_obs = nanmean(squeeze(vwind_obs),1)';
clear vwind
uwind_obs = uwind(idxlon,idxlat,:);
uwind_obs = nanmean(uwind_obs,1);
uwind_obs = nanmean(squeeze(uwind_obs),1)';
clear uwind
U10=sqrt(uwind_obs.^2+vwind_obs.^2);
p_air = 1.225; %kg/m3
%Cd = (1.2 + 0.065 .* U10) * 1e-3;
Cd= calculate_CD10n(U10);

twind_obs = Cd.*p_air.*vwind_obs.*sqrt(uwind_obs.^2+vwind_obs.^2);
% Find 5 previous days 
idxtime1 = find(time_era>=datenum(2020,1,1) & time_era<datenum(2020,1,10));

%% Julio 6-8 2021

E11=-[73+37/60+.67/60,36+25/60+.33/60;
     73+37/60+.67/60,36+25/60+.39/60;
     73+37/60+.51/60,36+24/60+.57/60;
     73+37/60+.45/60,36+23/60+.87/60];
E11 = mean(E11);
E22=-[73+38/60+.110/60,36+28/60+.007/60;
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
E22 = mean(E22);
idxtime2 = find(time_era>=datenum(2021,7,1) & time_era<datenum(2021,7,10));

%% Octubre 5-7 2022

E111=-[73+37/60+.402/60,36+29/60+.664/60;
     73+37/60+.402/60,36+29/60+.664/60;
     73+36/60+.730/60,36+29/60+.203/60;
     73+36/60+.567/60,36+29/60+.118/60;
     73+37/60+.112/60,36+29/60+.454/60;
     73+36/60+.869/60,36+29/60+.278/60;
     73+36/60+.661/60,36+29/60+.094/60;
     73+37/60+.015/60,36+29/60+.443/60;
     73+36/60+.534/60,36+29/60+.241/60;
     73+36/60+.118/60,36+29/60+.034/60];
E111 = mean(E111);

idxtime3 = find(time_era>=datenum(2022,9,30) & time_era<datenum(2022,10,9));

%% Wind Impulse previous to the measurements

idx =  find(time_era>=datenum(2020,1,1) & time_era<=datenum(2020,1,8));
impulse_2020 = cumsum(twind_obs(idx),3600);
idx =  find(time_era>=datenum(2021,7,1) & time_era<=datenum(2021,7,8));
impulse_2021 = cumsum(twind_obs(idx),3600);
idx =  find(time_era>=datenum(2022,9,30) & time_era<=datenum(2022,10,7));
impulse_2022 = cumsum(twind_obs(idx),3600);



%% Figure
% figure()
% set(gcf, 'Position', [10, 10, 600, 500])
% t = tiledlayout(3,1, 'TileSpacing', 'compact', 'Padding', 'compact');
% 
% nexttile
% %yyaxis left
% patch([datenum(2020,1,6) datenum(2020,1,8) datenum(2020,1,8) datenum(2020,1,6)],...
%     [-0.5 -0.5 0.6 0.6], [.85 .85 .85],'FaceAlpha',0.6,'EdgeColor',[0.6350 0.0780 0.1840],'Linewidth',2,'HandleVisibility','off')
% hold on
% box on
% plot(time_era(idxtime1),twind_obs(idxtime1),'linewidth',2.5)
% line([datenum(2020,1,1) datenum(2020,1,10)],[0 0],'color','k','linestyle','--','linewidth',1.5)
% grid on
% ax = gca;
% ax.GridAlpha = 0.4;
% ylabel('Wind Stress (Pa)')
% ylim([-0.5 0.6])
% xlim([datenum(2020,1,1) datenum(2020,1,10)])
% set(ax, 'XTick', datenum(2020,1,1:10), 'XTickLabel', [], 'FontSize', 12)
% 
% nexttile
% patch([datenum(2021,7,6) datenum(2021,7,8) datenum(2021,7,8) datenum(2021,7,6)],...
%     [-0.5 -0.5 0.6 0.6], [.85 .85 .85],'FaceAlpha',0.6,'EdgeColor',[0.6350 0.0780 0.1840],'Linewidth',2,'HandleVisibility','off')
% hold on
% box on
% plot(time_era(idxtime2),twind_obs(idxtime2),'linewidth',2.5)
% line([datenum(2021,7,1) datenum(2021,7,10)],[0 0],'color','k','linestyle','--','linewidth',1.5)
% grid on
% ax = gca;
% ax.GridAlpha = 0.4;
% ylabel('Wind Stress (Pa)')
% ylim([-0.5 0.6])
% set(gca,'XTick',datenum(2021,7,1:10), 'XTickLabel', [], 'FontSize', 12)
% xlim([datenum(2021,7,1) datenum(2021,7,10)])
% %ylim([12.8 14.1])
% 
% nexttile
% %yyaxis left
% patch([datenum(2022,10,5) datenum(2022,10,7) datenum(2022,10,7) datenum(2022,10,5)],...
%     [-0.5 -0.5 0.6 0.6], [.85 .85 .85],'FaceAlpha',0.6,'EdgeColor',[0.6350 0.0780 0.1840],'Linewidth',2,'HandleVisibility','off')
% hold on
% box on
% ticks = [datenum(2022,9,30) datenum(2022,10,1) datenum(2022,10,2) datenum(2022,10,3) datenum(2022,10,4)...
%     datenum(2022,10,5) datenum(2022,10,6) datenum(2022,10,7) datenum(2022,10,8) datenum(2022,10,9)];
% plot(time_era(idxtime3),twind_obs(idxtime3),'linewidth',2.5)
% line([datenum(2022,9,1) datenum(2022,11,1)],[0 0],'color','k','linestyle','--','linewidth',1.5)
% grid on
% ax = gca;
% ax.GridAlpha = 0.4;
% xlabel('Days from campaing')
% ylabel('Wind Stress (Pa)')
% ylim([-0.5 0.6])
% xlim([datenum(2022,9,30) datenum(2022,10,9)])
% set(gca,'XTick',ticks, 'XTickLabel', (-5:4), 'FontSize', 12)

%%
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 7 3.2];
patch([121 169 169 121],...
    [-0.4 -0.4 0.6 0.6], [.85 .85 .85],'FaceAlpha',0.6,'EdgeColor',[0.6350 0.0780 0.1840],'Linewidth',2,'HandleVisibility','off')
hold on
box on
plot(1:216,twind_obs(idxtime1),'linewidth',2.5)
grid on
plot(1:216,twind_obs(idxtime2),'linewidth',2.5)
plot(1:216,twind_obs(idxtime3),'linewidth',2.5)
line([0 217],[0 0],'color','k','linestyle','--','linewidth',1.5)
ylabel('Wind Stress (Pa)')
xlabel('Days since beginning of campaign')
xlim([1 169])
ylim([-0.4,0.4])
ax = gca;
ax.GridAlpha = 0.4;
set(gca,'XTick',[1:24:216],'XTickLabel',[-5:1:4],'Fontsize',14)
legend('January 2020','July 2021','October 2022','location','southwest','fontsize',14)
f=gcf;

if sf
    exportgraphics(f,fullfile(figure_dir,['wind_stress.png']),'Resolution',800,'BackgroundColor','white')
end


%% Wind Impulse
% 
% fig = figure;
% fig.Units = 'inches';
% fig.Position = [1 1 7 3.2];
% patch([121 169 169 121],...
%     [-0.4 -0.4 0.6 0.6], [.85 .85 .85],'FaceAlpha',0.6,'EdgeColor',[0.6350 0.0780 0.1840],'Linewidth',2,'HandleVisibility','off')
% hold on
% box on
% plot(1:169,impulse_2020,'linewidth',2.5)
% grid on
% plot(1:169,impulse_2021,'linewidth',2.5)
% plot(1:169,impulse_2022,'linewidth',2.5)
% line([0 170],[0 0],'color','k','linestyle','--','linewidth',1.5)
% ylabel('Wind Impulse (kg m^{-1} s^{-1})')
% xlabel('Days since beginning of campaign')
% xlim([1 169])
% ax = gca;
% ax.GridAlpha = 0.4;
% set(gca,'XTick',[1:24:169],'XTickLabel',[-5:1:2],'Fontsize',14)
% legend('January 2020','July 2021','October 2022','location','southwest','fontsize',14)
% f=gcf;
% 
% if sf
%     exportgraphics(f,fullfile(figure_dir,['wind_impulse.png']),'Resolution',800,'BackgroundColor','white')
% end


%%
function CD10n = calculate_CD10n(U10n)
% Calculates the 10-m neutral drag coefficient (CD10n) based on 
% the piecewise formula provided by the user.
%
% INPUT:
%   U10n = vector or scalar of 10-m neutral wind speeds (m/s)
%
% OUTPUT:
%   CD10n = vector or scalar of the drag coefficient (unitless)

% Initialize the output array with NaN (Not-a-Number)
% This helps find wind speeds that don't fall into any category.
CD10n_scaled = NaN(size(U10n));

% --- Condition 1: Low wind speeds (3 <= U10n <= 6) ---
% Create a logical mask for this wind speed range
low_wind_mask = (U10n <= 6);

% Apply the first formula ONLY to the elements identified by the mask
CD10n_scaled(low_wind_mask) = 0.29 + (3.1 ./ U10n(low_wind_mask)) + (7.7 ./ U10n(low_wind_mask).^2);

% --- Condition 2: High wind speeds (6 < U10n <= 26) ---
% Create a logical mask for this wind speed range
high_wind_mask = (U10n > 6) & (U10n <= 26);

% Apply the second formula
CD10n_scaled(high_wind_mask) = 0.60 + (0.070 .* U10n(high_wind_mask));

% --- Final Step: Rescale ---
% The formulas were for 1000*CD10n, so we divide by 1000
CD10n = CD10n_scaled / 1000;

% Optional: Warn if some inputs were outside the 3-26 m/s range
if any(isnan(CD10n))
    warning('Some input wind speeds were outside the valid 3-26 m/s range.');
end

end