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
close all;
cmap=cmocean('balance');
cmap = interp1( linspace(0,1,256), cmap, linspace(0,1,11) );
figure()
set(gcf,'position',[10,10,600,800])
aux1=Ri2021_vmp(63:141,5:end);
aux1(aux1==1.1)=NaN;

aux11=sqrt(U_2021_vmp(63:141,5:end).^2+V_2021_vmp(63:141,5:end).^2);
u_2021=(U_2021_vmp(63:141,5:end));
v_2021=V_2021_vmp(63:141,5:end);
dudz_2021=dUdz_2021_vmp(63:141,5:end);
dvdz_2021=dVdz_2021_vmp(63:141,5:end);


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

aux22=sqrt(U_2022_vmp(53:108,:).^2+V_2022_vmp(53:108,:).^2);
u_2022=(U_2022_vmp(53:108,:));
v_2022=V_2022_vmp(53:108,:);
dudz_2022=(dUdz_2022_vmp(53:108,:));
dvdz_2022=dVdz_2022_vmp(53:108,:);



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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% VELOCITY  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cmap=cmocean('diff');
figure()
set(gcf,'position',[10,10,600,800])
subplot 221
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X1,P1,(u_2021))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-0.1 0.1])
ylim([144 300])
xlim([1 10])

subplot 222
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X1,P1,(v_2021))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-0.1 0.1])
ylim([144 300])
xlim([1 10])

P2=Pslow_2022(53:108,1);
X2=[1:10];
subplot 223
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X2,P2,(u_2022))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-0.1 0.1])
ylim([124 234])
xlim([1 10])
set(gca, 'FontSize', 14)

subplot 224
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X2,P2,(v_2022))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-0.1 0.1])
ylim([124 234])
xlim([1 10])
set(gca, 'FontSize', 14)
f=gcf;
%exportgraphics(f,fullfile(FolderName,['Ri_gradient.png']),'Resolution',400,'BackgroundColor','white')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% SHEAR     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cmap=cmocean('diff');
figure()
set(gcf,'position',[10,10,600,800])
subplot 221
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X1,P1,(dudz_2021))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-0.01 0.01])
ylim([144 300])
xlim([1 10])

subplot 222
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X1,P1,(dvdz_2021))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-0.01 0.01])
ylim([144 300])
xlim([1 10])

P2=Pslow_2022(53:108,1);
X2=[1:10];
subplot 223
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X2,P2,(dvdz_2022))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-0.01 0.01])
ylim([124 234])
xlim([1 10])
set(gca, 'FontSize', 14)

subplot 224
set(gca, 'color', [0.5 0.5 0.5]);
hold on
pcolor(X2,P2,(dvdz_2022))
shading flat
set(gca,'Ydir','reverse')
colormap(cmap)
colorbar
clim([-0.01 0.01])
ylim([124 234])
xlim([1 10])
set(gca, 'FontSize', 14)
f=gcf;
%exportgraphics(f,fullfile(FolderName,['Ri_gradient.png']),'Resolution',400,'BackgroundColor','white')







%%
cmap=cmocean('balance')
close all
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 4 3.5];
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
fig.Position = [1 1 4 3.5];
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
cmap=cmocean('diff')
%close all
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 4 2];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P1);
xvalues=num2cell(X1);
h=heatmap(xvalues,yvalues,u_2021)
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap);
colorbar;
caxis([-0.1 0.1])
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
    exportgraphics(f,fullfile(figure_dir,['U_JUL.png']),'Resolution',800,'BackgroundColor','white')
end
cmap=cmocean('diff')
%close all
fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 4 2];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P1);
xvalues=num2cell(X1);
h=heatmap(xvalues,yvalues,v_2021)
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap);
colorbar;
caxis([-0.1 0.1])
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
    exportgraphics(f,fullfile(figure_dir,['V_JUL.png']),'Resolution',800,'BackgroundColor','white')
end

%%%%%%%%%%%%%%%%%


fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 4 2];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P2);
xvalues=num2cell(X2);
h=heatmap(xvalues,yvalues,u_2022)
%title('ACUMULADO')
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap);
colorbar;
caxis([-0.1 0.1])
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
    exportgraphics(f,fullfile(figure_dir,['U_OCT.png']),'Resolution',800,'BackgroundColor','white')
end


fig = figure;
fig.Units = 'inches';
fig.Position = [1 1 4 2];
set(gca, 'color', [0.5 0.5 0.5]);
yvalues=num2cell(P2);
xvalues=num2cell(X2);
h=heatmap(xvalues,yvalues,v_2022)
%title('ACUMULADO')
h.GridVisible="off"
h.MissingDataColor=([0.5 0.5 0.5])
colormap(cmap);
colorbar;
caxis([-0.1 0.1])
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
    exportgraphics(f,fullfile(figure_dir,['V_OCT.png']),'Resolution',800,'BackgroundColor','white')
end
