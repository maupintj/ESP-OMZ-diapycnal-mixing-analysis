%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROYECTO FONDECYT 11 81 872 SAMES
% Subproyecto estudio de remolinos subsuperficiales y 
% Corrientes oceánica de Concepción
%
% ANALIZA DATOS DE GLIDERS Y REMOLINOS
% Orpa Agosto 2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
% clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROCESA DATOS DE TRANSECTA DE GLIDER JUNIO 2010
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define el camino donde están los datos de glider
% camino = 'E:\RESPALDO\DATA\GLIDER\data\CP_201006G\processed_data\';
camino = '';
archig='CP_201006261842-deployment_gladis_pass10.mat';
load([camino archig])
% Retorna las siguientes variables (matrices):
%   Name          Size                Bytes  Class   
% --------------------------------------------------
%   CHLO        913x1114            8136656  double              
%   COND        913x1114            8136656  double              
%   DENS        913x1114            8136656  double              
%   LATI        913x1114            8136656  double              
%   LONG        913x1114            8136656  double              
%   OXYG        913x1114            8136656  double              
%   PRESS       913x1114            8136656  double              
%   SALT        913x1114            8136656  double              
%   TEMP        913x1114            8136656  double              
%   TIME        913x1114            8136656  double              
%   TURB        913x1114            8136656  double              
%   archig        1x44                   88  char                
%   camino        1x60                  120  char                
%   la           77x1                   616  double              
%   lo           77x1                   616  double              
%   ti           77x1                   616  double              
%   vx           77x1                   616  double              
%   vy           77x1                   616  double 
% --------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chequeo preliminar Grafica posiciones y velocidad integrada del glider
% grafica posiciones de transecta y velocidades del glider
[minlo, aux]=min(lo); 
lo1 = lo(1:aux); la1=la(1:aux);
vx1 = vx(1:aux); vy1=vy(1:aux);
lo2 = lo(aux+1:end); la2=la(aux+1:end);
vx2 = vx(aux+1:end); vy2=vy(aux+1:end);
figure
subplot(1,2,1); plot(lo1,la1,'ko','markersize',5)
hold on; quiver(lo1,la1,vx1,vy1,2,'k')
axis([-75 -73 -37.5 -35.5]); axis square
aux=[archig(4:7), '-', archig(8:9),'-', archig(10:11)];
title([aux,' I'])

subplot(1,2,2); plot(lo2,la2,'ro','markersize',5)
hold on; quiver(lo2,la2,vx2,vy2,2,'r')
axis([-75 -73 -37.5 -35.5]); axis square
title([aux,' R'])

% aux='E:\RESPALDO\D\matlab-toolbox\orpa\Gliders\Grafica_Secciones\GliderPath\';
% aux=['print -dpng ' [aux, ...
%           ['path_' archig(4:7), '-', archig(8:9),'-', archig(10:11) ]]];
% % eval(aux) 
% % return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carga datos de batimetría típica de Conce para hacer gráficos
load(['E:\RESPALDO\D\matlab-toolbox\orpa\Gliders\Grafica_Secciones\' ... 
      'linea_batimetria.mat'])
% Retorna:
 % ii        1x805             6440  double              
 % xi        1x171             1368  double  % distancia de la costa            
 % xii       1x113              904  double              
 % y         1x113              904  double              
 % yi        1x171             1368  double   % Profundidad
 xib = xi-2.5;   % corre 2.5 km punto inicial por costa en este caso -73°
 yib = yi;
 yib(1:11) = 25; % Reemplaza NaN cerca de la costa y cierra el cuadrado
 xib = [ xib max(xib) min(xib) min(xib)]; 
 yib = [ yib max(yib)+10 max(yib)+10 yib(1)];
% usar por ejemplo: hold on; plot(-xib,-yib,'k-','linewidth',2)
clear ii xi xii y yi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SEPARA TRANSECTAS DE IDA Y VUELTA
% Define el límite de la transecta en base al punto más al oeste: min(LONG)
[nf, nc]=size(LONG); % numero de filas (nf) y número de columnas (nc)
[a, aux]=min(LONG(:)); 
% separa transecta de ida (1) de la devuelta (2)
aux=floor(aux/nf); % aux contiene la columna más al oeste
S1 = SALT(:,1:aux); T1=TEMP(:,1:aux); P1=PRESS(:,1:aux); 
O1 = OXYG(:,1:aux); L1=LONG(:,1:aux); M1=LATI(:,1:aux); 
S2 = SALT(:,aux+1:end); T2=TEMP(:,aux+1:end); P2=PRESS(:,aux+1:end); 
O2 = OXYG(:,aux+1:end); L2=LONG(:,aux+1:end); M2=LATI(:,aux+1:end); 
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
% convierte LON a Distancia de la costa
% Convierte Laty y Long a coordenadas x,y tomando origen en -72°56' -36°30' 
L0 = -72-56/60; M0=-36.5;
d = geodist(M0,0,M0,1); % escala para longitud
X1 = (L1-L0)*d; % Y1=(M1-M0)*111; % No USA Y
X2 = (L2-L0)*d; % Y2=(M2-M0)*111; % No USA Y

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Grafica datos originales usndo SCATTER PLOT
%  figure
%  subplot(2,1,1) % Note que usa distanci en lugar de longitud
%  scatter(X1(:),-P1(:),8,CT1(:));  % scatter(L1(:),-P1(:),8,T1(:));
%  axis([-180 0 -1000 0]); set(gca,'tickdir','out'); 
%  colormap(gca,jet(16)); colorbar
%  hold on; plot(-xib,-yib,'k-','linewidth',2)
%  subplot(2,1,2)
%  scatter(X1(:),-P1(:),8,SA1(:)); %scatter(L1(:),-P1(:),8,SA1(:));
%  axis([-180 0 -1000 0]); set(gca,'tickdir','out'); 
%  colormap(gca,jet(16)); colorbar
%  hold on; plot(-xib,-yib,'k-','linewidth',2)
% 
%  figure
%  subplot(2,1,1) % Note que usa distanci en lugar de longitud
%  scatter(X2(:),-P2(:),8,CT2(:));  % scatter(L2(:),-P2(:),8,TC2(:));
%  axis([-180 0 -1000 0]); set(gca,'tickdir','out'); 
%  colormap(gca,jet(16)); colorbar
%  hold on; plot(-xib,-yib,'k-','linewidth',2)
%  subplot(2,1,2)
%  scatter(X2(:),-P2(:),8,SA2(:)); %scatter(L1(:),-P2(:),8,SA2(:));
%  axis([-180 0 -1000 0]); set(gca,'tickdir','out'); 
%  colormap(gca,jet(16)); colorbar
%  hold on; plot(-xib,-yib,'k-','linewidth',2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERA DATOS GRILLADOS 
% usa grilladata (e interpola) usando promedio ponderado por distancia
xi = -(0:1:180)'; 
zi = xi*0;
dx = 5;  dz=5;
w=[1 2 3 4 3 2 1]'; w=w/sum(w); % PESOS DE FILTRO TRIANGULAR GRILLA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  TRANSECTA IDA
% Convierte (Lat,Long) a coordenadas (x,y) toma origen en -72°56' -36°30' 
% grilla entre 0 y 180 km y entre 0 y 800 m y usa 
%%%%%%%%%%%%%%%%%%%%%
% Prelocaliza arreglos en memoria
CT1i = zeros(800,length(xi));
SA1i = CT1i;
DO1i = CT1i;
%
 for i=1:800 % por ejemplo solo hacer grilla hasta 800 depende de transecta
    % temperature
    [aux, ~] = grilladata(X1(i,:),P1(i,:),CT1(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux = filtergap(aux,w);
    CT1i(i,:) = aux';
    % sal
    [aux, ~] = grilladata(X1(i,:),P1(i,:),SA1(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux = filtergap(aux,w);
    SA1i(i,:) = aux';
    % Oxigen
    [aux, nd]=grilladata(X1(i,:),P1(i,:),O1(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux=filtergap(aux,w);
    DO1i(i,:)=aux';
 end
PRO1i=gsw_rho(SA1i,CT1i,0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAFICA DATOS GRILLADOS
% TRANSECTA DE IDA
% Carga paleta de oxigeno
load colormap_DO_3
ftri = figure;
subplot(3,1,1); pcolor(xi,-(1:800),CT1i); shading interp
caxis([4 14]); colormap(gca,jet(32)); colorbar; 
title('Conservative Temperature [°C] I')
hold on; plot(-xib,-yib,'k-','linewidth',2)
contour(xi,-(1:800),PRO1i,(1024.5:0.2:1028),'k'); % claves 26.3 26.5 26.7
contour(xi,-(1:800),PRO1i,(1026.3:0.2:1026.7),'linecolor','k','linewidth',1.2);

subplot(3,1,2); pcolor(xi,-(1:800),SA1i); shading interp
caxis([33.8 34.8]); colormap(gca,jet(32)); colorbar; 
title('Absolute Salinity [gr Kg^{-1}] I')
hold on; plot(-xib,-yib,'k-','linewidth',2)
contour(xi,-(1:800),PRO1i,(1024.5:0.2:1028),'k'); % claves 26.3 26.5 26.7
contour(xi,-(1:800),PRO1i,(1026.3:0.2:1026.7),'linecolor','k','linewidth',1.2);

subplot(3,1,3); pcolor(xi,-(1:800),DO1i); shading interp
caxis([0 6]); colormap(gca,colormap_DO_3); colorbar; 
title('Dissolved Oxigen [mL L^{-1}] I')
hold on; plot(-xib,-yib,'k-','linewidth',2)
contour(xi,-(1:800),PRO1i,(1024.5:0.2:1028),'k'); % claves 26.3 26.5 26.7
contour(xi,-(1:800),PRO1i,(1026.3:0.2:1026.7),'linecolor','k','linewidth',1.2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  TRANSECTA VUELTA
% entre 0 y 180 km y entre 0 y 800 m y usa 
%%%%%%%%%%%%%%%%%%%%%
CT2i = zeros(800,length(xi));
SA2i = CT2i;
DO2i = CT2i;
 for i = 1:800 % por ejemplo solo hacer grilla hasta 800 depende de transecta
    % Temperature
    [aux, ~] = grilladata(X2(i,:),P2(i,:),CT2(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux=filtergap(aux,w);
    CT2i(i,:) = aux';
    % Sal
    [aux, ~] = grilladata(X2(i,:),P2(i,:),SA2(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux = filtergap(aux,w);
    SA2i(i,:) = aux';
    % Oxígeno
    [aux, nd] = grilladata(X2(i,:),P2(i,:),O2(i,:),xi,zi+i-1,dx,dz,2);
    % filtra ligeramente manteniendo NaN
    aux = filtergap(aux,w);
    DO2i(i,:) = aux';
 end
PRO2i = gsw_rho(SA2i,CT2i,0);

ftrr = figure;
subplot(3,1,1); pcolor(xi,-(1:800),CT2i); shading interp
caxis([4 14]); colormap(gca,jet(32)); colorbar; 
title('Conservative Temperature [°C] R')
hold on; plot(-xib,-yib,'k-','linewidth',2)
contour(xi,-(1:800),PRO2i,(1024.5:0.2:1028),'k'); % claves 26.3 26.5 26.7
contour(xi,-(1:800),PRO2i,(1026.3:0.2:1026.7),'linecolor','k','linewidth',1.2);

subplot(3,1,2); pcolor(xi,-(1:800),SA2i); shading interp
caxis([33.8 34.8]); colormap(gca,jet(32)); colorbar; 
title('Absolute Salinity [gr Kg^{-1}] R')
hold on; plot(-xib,-yib,'k-','linewidth',2)
contour(xi,-(1:800),PRO2i,(1024.5:0.2:1028),'k'); % claves 26.3 26.5 26.7
contour(xi,-(1:800),PRO2i,(1026.3:0.2:1026.7),'linecolor','k','linewidth',1.2);

subplot(3,1,3); pcolor(xi,-(1:800),DO2i); shading interp
caxis([0 6]); colormap(gca,colormap_DO_3); colorbar; 
title('Dissolved Oxigen [mL L^{-1}] R')
hold on; plot(-xib,-yib,'k-','linewidth',2)
contour(xi,-(1:800),PRO2i,(1024.5:0.2:1028),'k'); % claves 26.3 26.5 26.7
contour(xi,-(1:800),PRO2i,(1026.3:0.2:1026.7),'linecolor','k','linewidth',1.2);
% return
% %%%%%%%%%%%%%%%%%%%
% % Codigo auxiliar para estimar desplazamientos
% figure
% [c1,h1] = contour(xi,-(1:800),PRO1i,(1026.3:0.1:1026.9),'linecolor','k','linewidth',1.2);
% hold on
% [c2,h2] = contour(xi+7,-(1:800),PRO2i,(1026.3:0.1:1026.9),'linecolor','r','linewidth',1.2);
% %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VELOCIDADES GEOSTROFICAS
%
% Calcula velocidad geostrófica transecta de ida
% interpola datos faltantes en parte oceánica de la grilla y filtra 15 km
iSA1i = interpola_1DNaN(SA1i','linear')';
iCT1i = interpola_1DNaN(CT1i','linear')';
w2 = ones(15,1)./15;
iSA1i = filtermgap(iSA1i',w2)';
iCT1i = filtermgap(iCT1i',w2)';
% recordar que para convertir longitud:
% L0=-72-56/60; M0=-36.5;
long=xi/d+L0; latg=long*0-36.5;
geo_strf_dyn_height = gsw_geo_strf_dyn_height(iSA1i,iCT1i,(1:800)',800);
[GV1, mid_lat1, ~] = ...
    gsw_geostrophic_velocity(geo_strf_dyn_height,long,latg,0);
%%%%%%%%%%%%%%%%
% Calcula velocidad geostrófica transecta de vuelta
% interpola datos faltantes en parte oceánica de la grilla y filtra 15 km
iSA2i = interpola_1DNaN(SA2i','linear')';
iCT2i = interpola_1DNaN(CT2i','linear')';
w2 = ones(15,1)./15;
iSA2i = filtermgap(iSA2i',w2)';
iCT2i = filtermgap(iCT2i',w2)';
% recordar que para convertir longitud:
% L0=-72-56/60; M0=-36.5;
long = xi/d+L0; latg=long*0-36.5;
geo_strf_dyn_height = gsw_geo_strf_dyn_height(iSA2i,iCT2i,(1:800)',800);
[GV2, mid_lat, mid_long] = ...
    gsw_geostrophic_velocity(geo_strf_dyn_height,long,latg,0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRAFICA VELOCIDADES GEOSTRÓFICAS IDA
% figure
% pcolor((mid_long-L0)*d,-(1:800),-GV1); shading interp
% caxis([-0.25 0.25]); colormap(gca,jet(32))
% hold on
% contour((mid_long(1,:)-L0)*d,-(1:800),-GV1,[0 0],...
%          'w','linewidth',2);
% contour((mid_long(1,:)-L0)*d,-(1:800),-GV1, (-0.5:0.05:0),'w--');
% contour((mid_long(1,:)-L0)*d,-(1:800),-GV1, (0:0.05:0.5),'w-');
% % IMPRIME FIGURA
% set(gcf,'paperposition',[0 0 8*2.54 11*2.54]*0.65)
% %print -dpng Glider_Tr_Jun2010_ida
% GRAFICA VELOCIDADES GEOSTRÓFICAS REGRESO
% figure
% pcolor((mid_long-L0)*d,-(1:800),-GV2); shading interp
% caxis([-0.25 0.25]); colormap(gca,jet(32))
% hold on
% contour((mid_long(1,:)-L0)*d,-(1:800),-GV2,[0 0],...
%          'w','linewidth',2);
% contour((mid_long(1,:)-L0)*d,-(1:800),-GV2,(-0.5:0.05:0),'w--');
% contour((mid_long(1,:)-L0)*d,-(1:800),-GV2,(0:0.05:0.5),'w-');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grafica contornos de velocidad geostrófica en curvas de Salinidad
% Transecta de ida
figure(ftri); subplot(3,1,2) % actualiza figura y subplot
hold on
contour((mid_long(1,:)-L0)*d,-(1:800),-GV1,(-0.5:0.05:0),'w:','linewidth',1.6);
contour((mid_long(1,:)-L0)*d,-(1:800),-GV1,(0:0.05:0.5),'w-','linewidth',1.4);
contour((mid_long(1,:)-L0)*d,-(1:800),-GV1,[0 0],...
         '-','linewidth',2,'color',[0.7 0.7 0.7]);
% Transecta de vuelta
figure(ftrr); subplot(3,1,2) % actualiza figura y subplot
hold on
contour((mid_long(1,:)-L0)*d,-(1:800),-GV2,(-0.5:0.05:0),'w:','linewidth',1.6);
contour((mid_long(1,:)-L0)*d,-(1:800),-GV2,(0:0.05:0.5),'w-','linewidth',1.4);
contour((mid_long(1,:)-L0)*d,-(1:800),-GV2,[0 0],...
         '-','linewidth',2,'color',[0.7 0.7 0.7]);

return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % IMPRIME FIGURAS
% % Transecta ida
% figure(ftri)
% set(ftri,'paperposition',[0 0 6*2.54 11*2.54]*0.65)
% %print -dpng Glider_Tr_Jun_2010_IDA
% % transecta vuelta
% figure(ftrr)
% set(gcf,'paperposition',[0 0 6*2.54 11*2.54]*0.65)
% %print -dpng Glider_Tr_Jun_2010_REG
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CARACTERIZA REMOLINO
% Find values in range of pot. density 1026.3 y 1026.7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SE DEBE EJECUTAR HASTA LINEA 115 para tener variables necesarias
% TRANSECTA DE IDA
nc=length(L1(1,:));
zmin=nan(1,nc)';
zmax=zmin; Oiso=zmin; SAiso=zmin; Liso=zmin; Xiso=zmin;
for i=1:nc
    % encuentra valores entre rango de densidad al oeste de -73.75
    if max(L1(:,i)) <= -73.75 
       zmin(i)=findz(P1(:,i),PRO1(:,i),1026.3,1); % 1026.7
       zmax(i)=findz(P1(:,i),PRO1(:,i),1026.7,1);  
       ind=(round(zmin(i)):round(zmax(i)));
       if length(ind) > 5
            Oiso(i) = nanmean(O1(ind,i));
            SAiso(i) = nanmean(SA1(ind,i));
            Liso(i) = nanmean(L1(ind,i));
            Xiso(i) = nanmean(X1(ind,i));
       end
    end
end
Oiso1=Oiso; SAiso1=SAiso; Liso1=Liso; Xiso1=Xiso;
% TRANSECTA DE VUELTA
nc=length(L2(1,:));
zmin=nan(1,nc)';
zmax=zmin; Oiso=zmin; SAiso=zmin; Liso=zmin; Xiso=zmin;
for i=1:nc
    % encuentra valores entre rango de densidad al oeste de -73.75
    if max(L2(:,i)) <= -73.75 
       zmin(i)=findz(P2(:,i),PRO2(:,i),1026.3,1); % 1026.7
       zmax(i)=findz(P2(:,i),PRO2(:,i),1026.7,1);  
       ind=(round(zmin(i)):round(zmax(i)));
       if length(ind) > 5
            Oiso(i) = nanmean(O2(ind,i));
            SAiso(i) = nanmean(SA2(ind,i));
            Liso(i) = nanmean(L2(ind,i));
            Xiso(i) = nanmean(X2(ind,i));
       end
    end
end
Oiso2 = Oiso; SAiso2 = SAiso; Liso2 = Liso; Xiso2 = Xiso;

%%%%%%%
figure
Xcen=115;
subplot(2,1,1)
plot(Xiso1+Xcen,SAiso1,'ro','markerfacecolor','r');
hold on
plot(Xiso2+Xcen,SAiso2,'ro','markerfacecolor','r');
axis([-45 45 34.4 34.8])
grid on
ylabel('Salinity (g kg^{-1})')

subplot(2,1,2)
plot(Xiso1+Xcen,Oiso1,'bo','markerfacecolor','b');
hold on
plot(Xiso2+Xcen,Oiso2,'bo','markerfacecolor','b');
axis([-45 45 0 2])
grid on
xlabel('Distance (km)')
ylabel('(m L L^{-1})')
 set(gcf,'paperposition',[0 0 8*2.54 10*2.54]*0.55)
 %print -dpng Glider_Tr_Jun_2010_DO&SAL_eddy


