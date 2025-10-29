close all; clear all;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir='/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures';
load(fullfile(data_dir,'VMP','JAN','VMP_Data_2020.mat'));
load(fullfile(data_dir,'VMP','JUL','VMP_Data_2021.mat'));
load(fullfile(data_dir,'VMP','OCT','VMP_Data_2022.mat'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Procesamiento Calculo de pesos Pf y Pt %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loading density intervals
load(fullfile(data_dir,'VMP','density_intervals.mat'));
% Loading ADCP data on VMP time
load(fullfile(data_dir,'VMP','ADCP_VMPtime_2021.mat'));
load(fullfile(data_dir,'VMP','ADCP_VMPtime_2022.mat'));
load(fullfile(data_dir,'CTD','Oxi_grad_microMkg.mat'));

% save table st
st=false;


%% PREPARACION VARIABLES
Ri2020=ones(size(e1_2020))*1.1;
Ri2021=Ri2021_vmp;
%Ri2021(isnan(Ri2021))=1.1;
Ri2022=Ri2022_vmp;
%Ri2022(isnan(Ri2022))=1.1;

Ri2021(Ri2021==1.1)=nan;
Ri2022(Ri2022==1.1)=nan;

%%
Ri2021=Ri2021(~isnan(Ri2021));
Ri2022=Ri2022(~isnan(Ri2022));
%%

(length(find(Ri2021>0.75))/length(Ri2021))*100
(length(find(Ri2022>0.75))/length(Ri2022))*100


%%