close all; clear all;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';
sf=true;  % Save figure flag
load(fullfile(data_dir,'VMP','ADCP_VMPtime_2021.mat'));
load(fullfile(data_dir,'VMP','JUL','VMP_Data_2021.mat'));
load(fullfile(data_dir,'VMP','ADCP_VMPtime_2022.mat'));
load(fullfile(data_dir,'VMP','OCT','VMP_Data_2022.mat'));

%%
close all;
cmap=cmocean('balance');
cmap = interp1( linspace(0,1,256), cmap, linspace(0,1,11) );
figure()
set(gcf,'position',[10,10,600,800])
aux1=Ri2021_vmp(63:141,5:end);
aux1(aux1==1.1)=NaN;

P1=Pslow_2021(63:141,5);
X1=[1:11];

subplot 211
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X1,P1,log10(aux1))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-2 2])
ylim([144 300])
xlim([1 10])

aux2=Ri2022_vmp(53:108,:);
aux2(aux2==1.1)=NaN;
P2=Pslow_2022(53:108,1);
X2=[1:10];
subplot 212
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X2,P2,log10(aux2))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-2 2])
ylim([124 234])
xlim([1 10])
set(gca, 'FontSize', 14)
f=gcf;
%exportgraphics(f,fullfile(FolderName,['Ri_gradient.png']),'Resolution',400,'BackgroundColor','white')


%%
close all
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 4 3];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P1);
xvalues=num2cell(X1);
h=heatmap(xvalues,yvalues,log10(aux1))
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap);
colorbar;
caxis([-2 2])
n = length(P1);
labels = strings(n, 1);
for i = 1:n
    if mod(i, 10) == 1  % <-- adjust this to match spacing (e.g., 10 for every other 5th)
        labels(i) = string(P1(i));
    else
        labels(i) = "";  % empty label
    end
end
h.YDisplayLabels = labels;
xlabel('VMP Profile Number')
ylabel('Depth (m)')
set(gca, 'FontSize', 14)
f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['Ri_gradient_JUL.png']),'Resolution',800,'BackgroundColor','white')
end

fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 4 3];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P2);
xvalues=num2cell(X2);
h=heatmap(xvalues,yvalues,log10(aux2))
%title('ACUMULADO')
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap);
colorbar;
caxis([-2 2])
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

f=gcf;
if sf
    exportgraphics(f,fullfile(figure_dir,['Ri_gradient_OCT.png']),'Resolution',800,'BackgroundColor','white')
end
%%
% aux1=aux1(:);
% aux2=aux2(:);
% 
% Ri2021_prct=round((length(aux1(aux1>1))/length(aux1))*1000)/10
% Ri2022_prct=round((length(aux2(aux2>1))/length(aux2))*1000)/10



