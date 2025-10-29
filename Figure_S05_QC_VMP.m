close all; clear all;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';
sf=false;  % Save figure flag
load(fullfile(data_dir,'VMP','ADCP_VMPtime_2021.mat'));
load(fullfile(data_dir,'VMP','JUL','VMP_Data_2021.mat'));
load(fullfile(data_dir,'VMP','ADCP_VMPtime_2022.mat'));
load(fullfile(data_dir,'VMP','OCT','VMP_Data_2022.mat'));
load(fullfile(data_dir,'VMP','JAN','VMP_Data_2020.mat'));
%%
% Define your colors (same as Python)
colors = [
    1.000  1.000  1.000;   % white
    0.000  0.447  0.741;   % blue
    0.850  0.325  0.098;   % orange
    0.929  0.694  0.125;   % yellow
    0.635  0.078  0.184;   % dark red
    0.466  0.674  0.188    % green
];

% Create the colormap
cmap_flag = colors;
%% 2020
P2=(20:2:max(max(Pslow_2022))+230)';
X2=[1:9];
%cmap=cmocean('dense')
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 5 7];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P2);
xvalues=num2cell(X2);
h=heatmap(xvalues,yvalues,QC1_2020)
%title('ACUMULADO')
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap_flag);
colorbar;
caxis([-0.5 5.5]);
n = length(P2);
labels = strings(n, 1);
for i = 1:n
    if mod(i, 10) == 1  % <-- adjust this to match spacing (e.g., 10 for every other 5th)
        labels(i) = string(P2(i));
    else
        labels(i) = "";  % empty label
    end
end
h.YDisplayLabels = labels;
xlabel('VMP Profile Number')
ylabel('Depth (m)')
set(gca, 'FontSize', 14)
ylim([20,612])
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['QC1_2020.png']),'Resolution',800,'BackgroundColor','white')
end

%cmap=cmocean('dense')
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 5 7];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P2);
xvalues=num2cell(X2);
h=heatmap(xvalues,yvalues,QC2_2020)
%title('ACUMULADO')
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap_flag);
colorbar;
caxis([-0.5 5.5]);
n = length(P2);
labels = strings(n, 1);
for i = 1:n
    if mod(i, 10) == 1  % <-- adjust this to match spacing (e.g., 10 for every other 5th)
        labels(i) = string(P2(i));
    else
        labels(i) = "";  % empty label
    end
end
h.YDisplayLabels = labels;
xlabel('VMP Profile Number')
ylabel('Depth (m)')
set(gca, 'FontSize', 14)
ylim([20,612])
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['QC2_2020.png']),'Resolution',800,'BackgroundColor','white')
end

%% 2021
P2=(20:2:max(max(Pslow_2022))+230)';
X2=[1:15];
%cmap=cmocean('dense')
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 5 7];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P2);
xvalues=num2cell(X2);
h=heatmap(xvalues,yvalues,QC1_2021)
%title('ACUMULADO')
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap_flag);
colorbar;
caxis([-0.5 5.5]);
n = length(P2);
labels = strings(n, 1);
for i = 1:n
    if mod(i, 10) == 1  % <-- adjust this to match spacing (e.g., 10 for every other 5th)
        labels(i) = string(P2(i));
    else
        labels(i) = "";  % empty label
    end
end
h.YDisplayLabels = labels;
xlabel('VMP Profile Number')
ylabel('Depth (m)')
set(gca, 'FontSize', 14)
ylim([20,542])
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['QC1_2021.png']),'Resolution',800,'BackgroundColor','white')
end

%cmap=cmocean('dense')
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 5 7];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P2);
xvalues=num2cell(X2);
h=heatmap(xvalues,yvalues,QC2_2021)
%title('ACUMULADO')
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap_flag);
colorbar;
caxis([-0.5 5.5]);
n = length(P2);
labels = strings(n, 1);
for i = 1:n
    if mod(i, 10) == 1  % <-- adjust this to match spacing (e.g., 10 for every other 5th)
        labels(i) = string(P2(i));
    else
        labels(i) = "";  % empty label
    end
end
h.YDisplayLabels = labels;
xlabel('VMP Profile Number')
ylabel('Depth (m)')
set(gca, 'FontSize', 14)
ylim([20,542])
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['QC2_2021.png']),'Resolution',800,'BackgroundColor','white')
end






%% 2022
P2=(20:2:max(max(Pslow_2022))+230)';
X2=[1:10];
%cmap=cmocean('dense')
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 5 7];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P2);
xvalues=num2cell(X2);
h=heatmap(xvalues,yvalues,QC1_2022)
%title('ACUMULADO')
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap_flag);
colorbar;
caxis([-0.5 5.5]);
n = length(P2);
labels = strings(n, 1);
for i = 1:n
    if mod(i, 10) == 1  % <-- adjust this to match spacing (e.g., 10 for every other 5th)
        labels(i) = string(P2(i));
    else
        labels(i) = "";  % empty label
    end
end
h.YDisplayLabels = labels;
xlabel('VMP Profile Number')
ylabel('Depth (m)')
set(gca, 'FontSize', 14)
ylim([20,430])
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['QC1_2022.png']),'Resolution',800,'BackgroundColor','white')
end

P2=(20:2:max(max(Pslow_2022))+230)';
X2=[1:10];
%cmap=cmocean('dense')
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 5 7];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P2);
xvalues=num2cell(X2);
h=heatmap(xvalues,yvalues,QC2_2022)
%title('ACUMULADO')
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap_flag);
colorbar;
caxis([-0.5 5.5]);
n = length(P2);
labels = strings(n, 1);
for i = 1:n
    if mod(i, 10) == 1  % <-- adjust this to match spacing (e.g., 10 for every other 5th)
        labels(i) = string(P2(i));
    else
        labels(i) = "";  % empty label
    end
end
h.YDisplayLabels = labels;
xlabel('VMP Profile Number')
ylabel('Depth (m)')
set(gca, 'FontSize', 14)
ylim([20,430])
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['QC2_2022.png']),'Resolution',800,'BackgroundColor','white')
end





