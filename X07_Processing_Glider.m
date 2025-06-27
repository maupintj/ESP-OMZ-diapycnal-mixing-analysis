close all; clear 
cd('/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/GLIDER/CP')
file=dir('CP*');
%for i1=1:length(file)
count=0;
aa=1:2:16;
aa2=2:2:16;
for i3=1:8
file_name=file(i3).name;
load(file_name)
% t=datenum(str2double(file_name(4:7)),str2double(file_name(8:9)),str2double(file_name(10:11)),0,0,0);
% time=datetime(t,'ConvertFrom','datenum');
% Chequeo preliminar Grafica posiciones y velocidad integrada del glider
% grafica posiciones de transecta y velocidades del glider
[minlo, aux]=min(lo); 
lo1 = lo(1:aux); la1=la(1:aux);
vx1 = vx(1:aux); vy1=vy(1:aux);
lo2 = lo(aux+1:end); la2=la(aux+1:end);
vx2 = vx(aux+1:end); vy2=vy(aux+1:end);

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
% GENERA DATOS GRILLADOS 
% usa grilladata (e interpola) usando promedio ponderado por distancia
%xi = -(0:1:180)'; 
xi=linspace(-74.5,-73,250)';
zi = xi*0;
dx = 5/111;  dz=5/111;
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
[Tu1,~, p_mid1] = gsw_Turner_Rsubrho(SA1i,CT1i,(1:800)');
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



SA(:,aa(i3):aa2(i3))=[SA1i(:,84) SA2i(:,84)];
TC(:,aa(i3):aa2(i3))=[CT1i(:,84) CT2i(:,84)];
O(:,aa(i3):aa2(i3))=[DO1i(:,84) DO2i(:,84)];
P(:,aa(i3):aa2(i3))=[(1:800)' (1:800)'];
Rho(:,aa(i3):aa2(i3))=[PRO1i(:,84) PRO2i(:,84)];
tiempo(:,aa(i3):aa2(i3))=[time1 time2];
% SAmean(:,aa(i3):aa2(i3))=[nanmean(SA1i,2) nanmean(SA2i,2)];
% TCmean(:,aa(i3):aa2(i3))=[nanmean(CT1i,2) nanmean(CT2i,2)];
%  Omean(:,aa(i3):aa2(i3))=[nanmean(DO1i,2) nanmean(DO2i,2)];
%  Pmean(:,aa(i3):aa2(i3))=[(1:800)' (1:800)'];
% Rhomean(:,aa(i3):aa2(i3))=[nanmean(PRO1i,2) nanmean(PRO2i,2)];

end

clearvars -except SA TC O
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
path2save=fullfile(data_dir, 'GLIDER','CP');
save(fullfile(path2save,'CP_Processed.mat'), 'SA','TC','O', '-v7.3')




