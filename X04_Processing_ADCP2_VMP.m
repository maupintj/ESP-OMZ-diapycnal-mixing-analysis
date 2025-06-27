close all; clear all;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
load(fullfile(data_dir,'VMP','JUL','VMP_Data_2021.mat'));
load(fullfile(data_dir,'ADCP','JUL','ADCP_Data_2021.mat'));
sd=false;
time2021=datenum(time2021);



[DepthGrid, TimeGrid] = meshgrid(Prof2021, time2021);
TimeGrid = TimeGrid';        % Transpose so dimensions are depth x time
DepthGrid = DepthGrid';      % Match DataU2021 size
% Interpolate at new times and pressures
U_2021_vmp = interp2(TimeGrid, DepthGrid, DataU2021/100, tt_2021, Pslow_2021);
V_2021_vmp = interp2(TimeGrid, DepthGrid, DataV2021/100, tt_2021, Pslow_2021);
dUdz_2021_vmp = interp2(TimeGrid, DepthGrid, dUz2021/100, tt_2021, Pslow_2021);
dVdz_2021_vmp = interp2(TimeGrid, DepthGrid, dVz2021/100, tt_2021, Pslow_2021);

Ri2021_vmp=N2_2021./(dUdz_2021_vmp.^2+dVdz_2021_vmp.^2);
Ri2021_vmp(isnan(Ri2021_vmp))=1.1;


clearvars -except data_dir *vmp sd

load(fullfile(data_dir,'VMP','OCT','VMP_Data_2022.mat'));
load(fullfile(data_dir,'ADCP','OCT','ADCP_Data_2022.mat'));

time2022=datenum(time2022);

[DepthGrid, TimeGrid] = meshgrid(Prof2022, time2022);
TimeGrid = TimeGrid';        % Transpose so dimensions are depth x time
DepthGrid = DepthGrid';      % Match DataU2022 size
% Interpolate at new times and pressures
U_2022_vmp = interp2(TimeGrid, DepthGrid, DataU2022/100, tt_2022, Pslow_2022);
V_2022_vmp = interp2(TimeGrid, DepthGrid, DataV2022/100, tt_2022, Pslow_2022);
dUdz_2022_vmp = interp2(TimeGrid, DepthGrid, dUz2022/100, tt_2022, Pslow_2022);
dVdz_2022_vmp = interp2(TimeGrid, DepthGrid, dVz2022/100, tt_2022, Pslow_2022);

Ri2022_vmp=N2_2022./(dUdz_2022_vmp.^2+dVdz_2022_vmp.^2);
Ri2022_vmp(isnan(Ri2022_vmp))=1.1;

clearvars -except *vmp sd

if sd
    data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
    vars = who;
    
    % Find variables that end with '2021'
    match = endsWith(vars, '2021_vmp');
    % Extract only those variable names
    varsToSave = vars(match);
    path2save=fullfile(data_dir, 'VMP');
    % Save them to a MAT-file (change filename as needed)
    save(fullfile(path2save,'ADCP_VMPtime_2021.mat'), varsToSave{:});
    
    % Find variables that end with '2022'
    match = endsWith(vars, '2022_vmp');
    % Extract only those variable names
    varsToSave = vars(match);
    path2save=fullfile(data_dir, 'VMP');
    % Save them to a MAT-file (change filename as needed)
    save(fullfile(path2save,'ADCP_VMPtime_2022.mat'), varsToSave{:});
 end



