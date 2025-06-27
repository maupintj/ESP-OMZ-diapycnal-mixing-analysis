close all; clear all;
% Base directories
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
sd=false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% JUL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_VMP=[];
t_VMP=[];
File=dir(fullfile(data_dir,'VMP','JUL','DAT*.mat'));
for i1=1:length(File)
    [P,rec] = show_ch(fullfile(File(i1).folder,File(i1).name(1:end-4)),'P');
    [~,d] = read_odas(fullfile(File(i1).folder,File(i1).name(1:end-4)));
    t_ = d.filetime;
    t_ = addtodate(t_, -1, 'second');
    t_ = datetime(t_,'ConvertFrom','datenum');
    tt=t_+seconds(d.t_slow);
    
    ti=(dateshift(tt(1), 'start', 'second', 'nearest'):seconds(1):dateshift(tt(end), 'start', 'second', 'nearest'))';
    
    P=interp1(tt,P,ti);
    P_VMP=[P_VMP;P];
    t_VMP=[t_VMP;ti];
    clc;
    clearvars -except t_VMP P_VMP File data_dir sd
end
% ADCP 300 kz
DataU300=load(fullfile(data_dir,'ADCP','JUL','300kHz','adcpU_qc1.dat'));
DataV300=load(fullfile(data_dir,'ADCP','JUL','300kHz','adcpV_qc1.dat'));  

dt= datetime(DataU300(:,1), DataU300(:,2), DataU300(:,3), DataU300(:,4),DataU300(:,5),DataU300(:,6));
% dataU
values=DataU300(:,7:end);
TT = timetable(dt, values);
TT2 = retime(TT, 'regular', @(x) nanmean(x), 'TimeStep', minutes(2));
t_300=TT2.dt;
U300=TT2.values;
% dataV
values=DataV300(:,7:end);
TT = timetable(dt, values);
TT2 = retime(TT, 'regular', @(x) nanmean(x), 'TimeStep', minutes(2));
V300=TT2.values;

% ADCP 600 kz
DataU600=load(fullfile(data_dir,'ADCP','JUL','600kHz','adcpU_qc1.dat'));
DataV600=load(fullfile(data_dir,'ADCP','JUL','600kHz','adcpV_qc1.dat'));  

dt= datetime(DataU600(:,1), DataU600(:,2), DataU600(:,3), DataU600(:,4),DataU600(:,5),DataU600(:,6));
% dataU
values=DataU600(:,7:end);
TT = timetable(dt, values);
TT2 = retime(TT, 'regular', @(x) nanmean(x), 'TimeStep', minutes(2));
t_600=TT2.dt;
U600=TT2.values;
% dataV
values=DataV600(:,7:end);
TT = timetable(dt, values);
TT2 = retime(TT, 'regular', @(x) nanmean(x), 'TimeStep', minutes(2));
V600=TT2.values;

% ADCP 1200 kz
DataU1200=load(fullfile(data_dir,'ADCP','JUL','1200kHz','adcpU_qc1.dat'));
DataV1200=load(fullfile(data_dir,'ADCP','JUL','1200kHz','adcpV_qc1.dat'));  
DataU1200(1,:)=[];
DataV1200(1,:)=[];

dt= datetime(DataU1200(:,1), DataU1200(:,2), DataU1200(:,3), DataU1200(:,4),DataU1200(:,5),DataU1200(:,6));
% dataU
values=DataU1200(:,7:end);
TT = timetable(dt, values);
TT2 = retime(TT, 'regular', @(x) nanmean(x), 'TimeStep', minutes(2));
t_1200=TT2.dt;
U1200=TT2.values;
% dataV
values=DataV1200(:,7:end);
TT = timetable(dt, values);
TT2 = retime(TT, 'regular', @(x) nanmean(x), 'TimeStep', minutes(2));
V1200=TT2.values;

%1200 va de 141 cada 0.5 hasta 152 %Efectivo desde 142.5
% 600 va de 150 cada 1 hasta 205 %Efectivo en realidad desde 158 m
% 300 va de 215 cada 1 hasta 300 

%%%%%%%%%% LLEVO A TIEMPO COMUN %%%%%%%%%%%%%%%% 
%%%%%%%%%% 00:30 8 julio al 8 julio 18:30
ind=38:578;

U300=U300(ind,:)';
V300=V300(ind,:)';
t_300=t_300(ind,:);

U600=U600(ind,9:end)';
V600=V600(ind,9:end)';
t_600=t_600(ind,:);

U1200=U1200(ind,5:end)';
V1200=V1200(ind,5:end)';
t_1200=t_1200(ind,:);
% El de 1200 lo promedio para dejarlo cada 1 metro desde 143
count=0;
for i1=1:2:20 %143:0.5:153
    count=count+1;
    auxU(count,:)=nanmean(U1200(i1:i1+1,:));
    auxV(count,:)=nanmean(V1200(i1:i1+1,:));
end
U1200=auxU;
V1200=auxV;
Prof2021=(143:300)';
time2021=t_1200;

DataU2021=NaN(length(Prof2021),length(time2021)); DataV2021=DataU2021;

DataU2021(1:10,:)=U1200;
DataV2021(1:10,:)=V1200;
DataU2021(16:63,:)=U600;
DataV2021(16:63,:)=V600;
DataU2021(73:end,:)=U300;
DataV2021(73:end,:)=V300;

t_VMP2021=t_VMP;
P_VMP2021=P_VMP;
%%%%%%%%%% Promedio movil para suavizar las perturbaciones %%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%% 121 pesos para promedios de 2 hora %%%%%%%%%%%%%%%%%%%%%%%

DataU2021=movmean(DataU2021,31,2,'omitnan');% En time
DataU2021_filt=movmean(DataU2021,11,1,'omitnan');% Vertical
DataV2021=movmean(DataV2021,31,2,'omitnan');
DataV2021_filt=movmean(DataV2021,11,1,'omitnan');
idU=isnan(DataU2021);
DataU2021_filt(idU)=NaN;
idV=isnan(DataV2021);
DataV2021_filt(idV)=NaN;



clearvars -except *2021 data_dir *filt sd


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% OCT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
File=dir(fullfile(data_dir,'VMP','OCT','DAT*.mat'));
P_VMP=[];
t_VMP=[];

for i1=1:length(File)
    [P,rec] = show_ch(fullfile(File(i1).folder,File(i1).name(1:end-4)),'P');
    [~,d] = read_odas(fullfile(File(i1).folder,File(i1).name(1:end-4)));
    t_ = d.filetime;
    t_ = addtodate(t_, -1, 'second');
    t_ = datetime(t_,'ConvertFrom','datenum');
    tt=t_+seconds(d.t_slow);
    
    ti=(dateshift(tt(1), 'start', 'second', 'nearest'):seconds(1):dateshift(tt(end), 'start', 'second', 'nearest'))';
    
    P=interp1(tt,P,ti);
    P_VMP=[P_VMP;P];
    t_VMP=[t_VMP;ti];
    clc;
    clearvars -except t_VMP P_VMP File data_dir *2021 *filt sd
end

% ADCP 300 kz
DataU300=load(fullfile(data_dir,'ADCP','OCT','300kHz','adcpU_qc1.dat'));
DataV300=load(fullfile(data_dir,'ADCP','OCT','300kHz','adcpV_qc1.dat'));  
clear m
count=2;
m(1)=DataU300(1,5);
ind1=1;
count2=1;
Index=nan(1,8);
while 1
    m(count)=DataU300(count,5);
    if m(count)~=m(count-1)
        ind2=count-1;
        %%%% haz las operaciones entre esto
        Index(count2,1:ind2-ind1+1)=ind1:ind2;
        t_300(count2,1)=datetime(DataU300(ind1,1),DataU300(ind1,2),DataU300(ind1,3),DataU300(ind1,4),DataU300(ind1,5),0); 
        U300(count2,:)=nanmean(DataU300(ind1:ind2,7:end),1);
        V300(count2,:)=nanmean(DataV300(ind1:ind2,7:end),1);
        %%%% haz las operaciones entre esto
        ind1=ind2+1;
        count2=count2+1;
    end
    count=count+1;
    if count>size(DataU300,1)
        break
    end
end
Index(Index==0)=NaN;    
% ADCP 600 kz
DataU600=load(fullfile(data_dir,'ADCP','OCT','600kHz','adcpU_qc1.dat'));
DataV600=load(fullfile(data_dir,'ADCP','OCT','600kHz','adcpV_qc1.dat'));   
clear m
count=2;
m(1)=DataU600(1,5);
ind1=1;
count2=1;
Index=nan(1,8);
while 1
    m(count)=DataU600(count,5);
    if m(count)~=m(count-1)
        ind2=count-1;
        %%%% haz las operaciones entre esto
        Index(count2,1:ind2-ind1+1)=ind1:ind2;
        t_600(count2,1)=datetime(DataU600(ind1,1),DataU600(ind1,2),DataU600(ind1,3),DataU600(ind1,4),DataU600(ind1,5),0); 
        U600(count2,:)=nanmean(DataU600(ind1:ind2,7:end),1);
        V600(count2,:)=nanmean(DataV600(ind1:ind2,7:end),1);
        %%%% haz las operaciones entre esto
        ind1=ind2+1;
        count2=count2+1;
    end
    count=count+1;
    if count>size(DataU600,1)
        break
    end
end
Index(Index==0)=NaN;
% 600 va de 124 cada 1 hasta 154 %Efectivo en realidad desde 158 m
% 300 va de 164 cada 1 hasta 234

% %%%%%%%%%% LLEVO A TIEMPO COMUN %%%%%%%%%%%%%%%% 
%
Prof2022=(124:2:234)';
time2022=t_300;
DataU2022=NaN(length(Prof2022),length(time2022)); DataV2022=DataU2022;

DataU2022(1:16,:)=U600(:,12:end-2)';
DataV2022(1:16,:)=V600(:,12:end-2)';
DataU2022(21:end,:)=U300(:,2:end-8)';
DataV2022(21:end,:)=V300(:,2:end-8)';

t_VMP2022=t_VMP;
P_VMP2022=P_VMP;
% 
% %%%%%%%%%% Promedio movil para suavizar las perturbaciones %%%%%%%%%%%%%%%% 
% %%%%%%%%%%%%%%%%% 61 pesos para promedios de 2 hora %%%%%%%%%%%%%%%%%%%%%%%
DataU2022=movmean(DataU2022,31,2,'omitnan');% En time
DataU2022_filt=movmean(DataU2022,5,1,'omitnan');% Vertical
DataV2022=movmean(DataV2022,31,2,'omitnan');
DataV2022_filt=movmean(DataV2022,5,1,'omitnan');
idU=isnan(DataU2022);
DataU2022_filt(idU)=NaN;
idV=isnan(DataV2022);
DataV2022_filt(idV)=NaN;


% Create new depth vector (1 meter spacing)
new_depth = (Prof2022(1):1:Prof2022(end))';

% Interpolate DataU2022_filt to the new depth
% Assuming columns represent different profiles or variables
DataU2022_filt = interp1(Prof2022, DataU2022_filt, new_depth);
DataV2022_filt = interp1(Prof2022, DataV2022_filt, new_depth);
Prof2022=new_depth;

clearvars -except t_VMP File *2021 *2022 data_dir *filt sd

[dUt2021, dUz2021]=gradient(DataU2021_filt);
[dVt2021, dVz2021]=gradient(DataU2021_filt);

[dUt2022, dUz2022]=gradient(DataU2022_filt);
[dVt2022, dVz2022]=gradient(DataU2022_filt);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Some Figures %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% CURRENTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
figure()
set(gcf,'position',[10,10,600,800])
subplot 311
pos1=gca;
pos1=pos1.Position;
subplot 312
pos2=gca;
pos2=pos2.Position;
subplot 313
pos3=gca;
pos3=pos3.Position;

idx=gradient(movmean(P_VMP2021,351))>0;
figure()
set(gcf,'position',[10,10,600,800])
h=axes('position',pos1);
pcolor((time2021),Prof2021,sqrt(DataU2021_filt.^2+DataV2021_filt.^2));
shading interp
set(gca,'Ydir','reverse')
title('July 2021')
cmap=cmocean('tempo');
colormap(cmap)
colorbar
%title('Magnitud')
caxis([0 15])
hold on
plot(t_VMP2021(idx),P_VMP2021(idx),'.','Color','k','MarkerSize',5)
% 
h=axes('position',pos2);
pcolor(time2021,Prof2021,DataU2021_filt);
shading interp
set(gca,'Ydir','reverse')
title('U')
colorbar
cmap=cmocean('tarn');
colormap(cmap)
%title('U')
caxis([-10 10])
hold on
plot(t_VMP2021(idx),P_VMP2021(idx),'.','Color','k','MarkerSize',5)

h=axes('position',pos3);
pcolor(time2021,Prof2021,DataV2021_filt);
shading interp
set(gca,'Ydir','reverse')
%title('July 2021')
colorbar
title('V')
caxis([-10 10])
hold on
plot(t_VMP2021(idx),P_VMP2021(idx),'.','Color','k','MarkerSize',5)
%print('-dpng',fullfile(FolderName,['corriente_2021']),'-r400')

idx=gradient(movmean(P_VMP2022,351))>0;

figure()
set(gcf,'position',[10,10,600,800])
h=axes('position',pos1);
pcolor((time2022),Prof2022,sqrt(DataU2022_filt.^2+DataV2022_filt.^2));
shading interp
set(gca,'Ydir','reverse')
title('October 2022')
cmap=cmocean('tempo');
colormap(cmap)
colorbar
%title('Magnitud')
caxis([0 15])
hold on
plot(t_VMP2022(idx),P_VMP2022(idx),'.','Color','k','MarkerSize',5)
% 
h=axes('position',pos2);
pcolor(time2022,Prof2022,DataU2022_filt);
shading interp
set(gca,'Ydir','reverse')
title('U')
colorbar
cmap=cmocean('tarn');
colormap(cmap)
%title('U')
caxis([-10 10])
hold on
plot(t_VMP2022(idx),P_VMP2022(idx),'.','Color','k','MarkerSize',5)

h=axes('position',pos3);
pcolor(time2022,Prof2022,DataV2022_filt);
shading interp
set(gca,'Ydir','reverse')
%title('October 2022')
colorbar
title('V')
caxis([-10 10])
hold on
plot(t_VMP2022(idx),P_VMP2022(idx),'.','Color','k','MarkerSize',5)
%print('-dpng',fullfile(FolderName,['corriente_2022']),'-r400')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%   SHEAR  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


idx=gradient(movmean(P_VMP2021,351))>0;
figure()
set(gcf,'position',[10,10,600,800])
h=axes('position',pos1);
pcolor((time2021),Prof2021,sqrt(dUz2021.^2+dVz2021.^2));
shading interp
set(gca,'Ydir','reverse')
title('July 2021')
cmap=cmocean('tempo');
colormap(cmap)
colorbar
%title('Magnitud')
caxis([0 1])
hold on
plot(t_VMP2021(idx),P_VMP2021(idx),'.','Color','k','MarkerSize',5)
% 
h=axes('position',pos2);
pcolor(time2021,Prof2021,dUz2021);
shading interp
set(gca,'Ydir','reverse')
title('U')
colorbar
cmap=cmocean('tarn');
colormap(cmap)
%title('U')
caxis([-1 1])
hold on
plot(t_VMP2021(idx),P_VMP2021(idx),'.','Color','k','MarkerSize',5)

h=axes('position',pos3);
pcolor(time2021,Prof2021,dVz2021);
shading interp
set(gca,'Ydir','reverse')
%title('July 2021')
colorbar
title('V')
caxis([-1 1])
hold on
plot(t_VMP2021(idx),P_VMP2021(idx),'.','Color','k','MarkerSize',5)
%print('-dpng',fullfile(FolderName,['corriente_2021']),'-r400')

idx=gradient(movmean(P_VMP2022,351))>0;

figure()
set(gcf,'position',[10,10,600,800])
h=axes('position',pos1);
pcolor((time2022),Prof2022,sqrt(dUz2022.^2+dVz2022.^2));
shading interp
set(gca,'Ydir','reverse')
title('October 2022')
cmap=cmocean('tempo');
colormap(cmap)
colorbar
%title('Magnitud')
caxis([0 1])
hold on
plot(t_VMP2022(idx),P_VMP2022(idx),'.','Color','k','MarkerSize',5)
% 
h=axes('position',pos2);
pcolor(time2022,Prof2022,dUz2022);
shading interp
set(gca,'Ydir','reverse')
title('dUdz')
colorbar
cmap=cmocean('tarn');
colormap(cmap)
%title('U')
caxis([-1 1])
hold on
plot(t_VMP2022(idx),P_VMP2022(idx),'.','Color','k','MarkerSize',5)

h=axes('position',pos3);
pcolor(time2022,Prof2022,dVz2022);
shading interp
set(gca,'Ydir','reverse')
%title('October 2022')
colorbar
title('dVdz')
caxis([-1 1])
hold on
plot(t_VMP2022(idx),P_VMP2022(idx),'.','Color','k','MarkerSize',5)
%print('-dpng',fullfile(FolderName,['corriente_2022']),'-r400')


DataU2022=DataU2022_filt;
DataV2022=DataV2022_filt;
DataU2021=DataU2021_filt;
DataV2021=DataV2021_filt;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% SAVING DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear *filt 
clearvars -except *2021 *2022 sd
if sd
    data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
    vars = who;
    
    % Find variables that end with '2021'
    match = endsWith(vars, '2021');
    % Extract only those variable names
    varsToSave = vars(match);
    path2save=fullfile(data_dir, 'ADCP', 'JUL/');
    % Save them to a MAT-file (change filename as needed)
    save(fullfile(path2save,'ADCP_Data_2021.mat'), varsToSave{:});
    
    % Find variables that end with '2022'
    match = endsWith(vars, '2022');
    % Extract only those variable names
    varsToSave = vars(match);
    path2save=fullfile(data_dir, 'ADCP', 'OCT/');
    % Save them to a MAT-file (change filename as needed)
    save(fullfile(path2save,'ADCP_Data_2022.mat'), varsToSave{:});
end
