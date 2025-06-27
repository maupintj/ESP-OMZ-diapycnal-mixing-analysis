close all; clear all;

data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
load(fullfile(data_dir,'VMP','JAN','VMP_Data_2020.mat'));
load(fullfile(data_dir,'VMP','JUL','VMP_Data_2021.mat'));
load(fullfile(data_dir,'VMP','OCT','VMP_Data_2022.mat'));
l(1)=25.80;
l(2)=26.10;
l(3)=26.30;
l(4)=26.55;
l(5)=26.70;
l(6)=26.80;

figure()
subplot 311
histogram(sort(Rho_2020(:)),100)
subplot 312
histogram(sort(Rho_2021(:)),100)
subplot 313
histogram(sort(Rho_2022(:)),100)
% DENSITY INTERVALS JAN 2020
I(1).e=Rho_2020<=l(1);
I(2).e=Rho_2020<=l(2) & Rho_2020>l(1);
I(3).e=Rho_2020<=l(3) & Rho_2020>l(2);
I(4).e=Rho_2020<=l(4) & Rho_2020>l(3);%
I(5).e=Rho_2020<=l(5) & Rho_2020>l(4);
I(6).e=Rho_2020<=l(6) & Rho_2020>l(5);
I(7).e=Rho_2020<=max(max(Rho_2020)) & Rho_2020>l(6);
% DENSITY INTERVALS JUL 2021
I(1).j=Rho_2021<=l(1);
I(2).j=Rho_2021<=l(2) & Rho_2021>l(1);
I(3).j=Rho_2021<=l(3) & Rho_2021>l(2);
I(4).j=Rho_2021<=l(4) & Rho_2021>l(3);%
I(5).j=Rho_2021<=l(5) & Rho_2021>l(4);
I(6).j=Rho_2021<=l(6) & Rho_2021>l(5);
I(7).j=Rho_2021<=max(max(Rho_2021)) & Rho_2021>l(6);
% DENSITY INTERVALS OCTOBER 2022
I(1).o=Rho_2022<=l(1);
I(2).o=Rho_2022<=l(2) & Rho_2022>l(1);
I(3).o=Rho_2022<=l(3) & Rho_2022>l(2);
I(4).o=Rho_2022<=l(4) & Rho_2022>l(3);%
I(5).o=Rho_2022<=l(5) & Rho_2022>l(4);
I(6).o=Rho_2022<=l(6) & Rho_2022>l(5);
I(7).o=Rho_2022<=max(max(Rho_2022)) & Rho_2022>l(6);

clearvars -except I
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% SAVING DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
path2save=fullfile(data_dir, 'VMP/');

vars = who;
% Extract only those variable names
varsToSave = vars;
% Save them to a MAT-file (change filename as needed)
save(fullfile(path2save,'density_intervals.mat'), varsToSave{:});


