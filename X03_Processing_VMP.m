close all; clear;
ql_info=quick_look;
ql_info.overlap=4;
ql_info.diss_length=8;
ql_info.fft_length=4;
ql_info.full_output = true;
ql_info.HP_cut=0.08;
ql_info.goodman_despike=false;
ql_info.goodman_fft_length=5;
ql_info.profile_min_P=20;
data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Procesamiento datos de ENERO 2020 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(fullfile(data_dir, 'VMP', 'JAN'))
path2save=fullfile(data_dir, 'VMP', 'JAN/');
E02=-[73+36/60+.840/60,36+25/60+.854/60;
     73+37/60+.028/60,36+25/60+.981/60;
     73+36/60+.887/60,36+25/60+.673/60];
E02_2020=mean(E02);
E01=-[73+ 43/60+.414/60,36+ 26/60+.045/60;
     73+ 43/60+.095/60,36+ 26/60+.029/60;
     73+ 42/60+.867/60,36+ 25/60+.966/60];
E01_2020=mean(E01);
E03=-[73+ 32/60+.063/60, 36+ 26/60+.016/60;
    73+ 31/60+.941/60, 36+ 26/60+.002/60;
    73+ 31/60+.928/60, 36+ 26/60+.019/60]; 
E03_2020=mean(E03);

aux=[20:2:650]';
aux2=[20:0.002:650]';
Pslow_2020=NaN(length(aux),9); e1_2020=Pslow_2020; e2_2020=e1_2020; TC_2020=e1_2020; SA_2020=e1_2020; Rho_2020=e1_2020;
alpha_2020=e1_2020; beta_2020=e1_2020; dT_2020=e1_2020; dSA_2020=e1_2020; drhodP_2020=e1_2020; nu_2020=e1_2020; N2_2020=e1_2020;
Tu_2020=e1_2020; Chi1_2020=e1_2020; Chi2_2020=e1_2020; tt_2020=e1_2020; FM1_2020=e1_2020; FM2_2020=e1_2020; QC1_2020=e1_2020; QC2_2020=e1_2020;
Pfast_2020=NaN(length(aux2),9); ShBP1_2020=Pfast_2020; ShBP2_2020=Pfast_2020; ShHP1_2020=Pfast_2020; ShHP2_2020=Pfast_2020;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% LECTURA DE DATOS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
Data='DAT_043'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E02_2020);

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
% ind1=find(aux2==DataF(1,1));
% ind2=find(aux2==DataF(end,1));
% ind2=[ind1:ind2]';

Pslow_2020(ind,1)=DataS(:,1);
e1_2020(ind,1)=DataS(:,2);
e2_2020(ind,1)=DataS(:,3);
TC_2020(ind,1)=DataS(:,4);
SA_2020(ind,1)=DataS(:,5);
Rho_2020(ind,1)=DataS(:,6);
alpha_2020(ind,1)=DataS(:,7);
beta_2020(ind,1)=DataS(:,8);
dT_2020(ind,1)=DataS(:,9);
dSA_2020(ind,1)=DataS(:,10);
drhodP_2020(ind,1)=DataS(:,11);
nu_2020(ind,1)=DataS(:,12);
N2_2020(ind,1)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2020(ind,1)=DataS(:,14);
Chi2_2020(ind,1)=DataS(:,15);
Tu_2020(ind,1)=DataS(:,16);
Lo1_2020(ind,1)=DataS(:,17);
Lo2_2020(ind,1)=DataS(:,18);
tt_2020(ind,1)=DataS(:,19);
FM1_2020(ind,1)=DataS(:,20);
FM2_2020(ind,1)=DataS(:,21);
QC1_2020(ind,1)=DataS(:,22);
QC2_2020(ind,1)=DataS(:,23);


Data='DAT_043'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E02_2020);

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2020(ind,2)=DataS(:,1);
e1_2020(ind,2)=DataS(:,2);
e2_2020(ind,2)=DataS(:,3);
TC_2020(ind,2)=DataS(:,4);
SA_2020(ind,2)=DataS(:,5);
Rho_2020(ind,2)=DataS(:,6);
alpha_2020(ind,2)=DataS(:,7);
beta_2020(ind,2)=DataS(:,8);
dT_2020(ind,2)=DataS(:,9);
dSA_2020(ind,2)=DataS(:,10);
drhodP_2020(ind,2)=DataS(:,11);
nu_2020(ind,2)=DataS(:,12);
N2_2020(ind,2)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2020(ind,2)=DataS(:,14);
Chi2_2020(ind,2)=DataS(:,15);
Tu_2020(ind,2)=DataS(:,16);
Lo1_2020(ind,2)=DataS(:,17);
Lo2_2020(ind,2)=DataS(:,18);
tt_2020(ind,2)=DataS(:,19);
FM1_2020(ind,2)=DataS(:,20);
FM2_2020(ind,2)=DataS(:,21);
QC1_2020(ind,2)=DataS(:,22);
QC2_2020(ind,2)=DataS(:,23);


Pfast_2020(ind2,2)=DataF(:,1);
ShBP1_2020(ind2,2)=DataF(:,2);
ShBP2_2020(ind2,2)=DataF(:,3);
ShHP1_2020(ind2,2)=DataF(:,4);
ShHP2_2020(ind2,2)=DataF(:,5);

Data='DAT_043'
ql_info.profile_num=3;
[DataF, DataS]= InterpDatos(Data,ql_info,E02_2020);

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2020(ind,3)=DataS(:,1);
e1_2020(ind,3)=DataS(:,2);
e2_2020(ind,3)=DataS(:,3);
TC_2020(ind,3)=DataS(:,4);
SA_2020(ind,3)=DataS(:,5);
Rho_2020(ind,3)=DataS(:,6);
alpha_2020(ind,3)=DataS(:,7);
beta_2020(ind,3)=DataS(:,8);
dT_2020(ind,3)=DataS(:,9);
dSA_2020(ind,3)=DataS(:,10);
drhodP_2020(ind,3)=DataS(:,11);
nu_2020(ind,3)=DataS(:,12);
N2_2020(ind,3)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2020(ind,3)=DataS(:,14);
Chi2_2020(ind,3)=DataS(:,15);
Tu_2020(ind,3)=DataS(:,16);
Lo1_2020(ind,3)=DataS(:,17);
Lo2_2020(ind,3)=DataS(:,18);
tt_2020(ind,3)=DataS(:,19);
FM1_2020(ind,3)=DataS(:,20);
FM2_2020(ind,3)=DataS(:,21);
QC1_2020(ind,3)=DataS(:,22);
QC2_2020(ind,3)=DataS(:,23);


Pfast_2020(ind2,3)=DataF(:,1);
ShBP1_2020(ind2,3)=DataF(:,2);
ShBP2_2020(ind2,3)=DataF(:,3);
ShHP1_2020(ind2,3)=DataF(:,4);
ShHP2_2020(ind2,3)=DataF(:,5);

Data='DAT_041'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E01_2020);

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2020(ind,4)=DataS(:,1);
e1_2020(ind,4)=DataS(:,2);
e2_2020(ind,4)=DataS(:,3);
TC_2020(ind,4)=DataS(:,4);
SA_2020(ind,4)=DataS(:,5);
Rho_2020(ind,4)=DataS(:,6);
alpha_2020(ind,4)=DataS(:,7);
beta_2020(ind,4)=DataS(:,8);
dT_2020(ind,4)=DataS(:,9);
dSA_2020(ind,4)=DataS(:,10);
drhodP_2020(ind,4)=DataS(:,11);
nu_2020(ind,4)=DataS(:,12);
N2_2020(ind,4)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2020(ind,4)=DataS(:,14);
Chi2_2020(ind,4)=DataS(:,15);
Tu_2020(ind,4)=DataS(:,16);
Lo1_2020(ind,4)=DataS(:,17);
Lo2_2020(ind,4)=DataS(:,18);
tt_2020(ind,4)=DataS(:,19);
FM1_2020(ind,4)=DataS(:,20);
FM2_2020(ind,4)=DataS(:,21);
QC1_2020(ind,4)=DataS(:,22);
QC2_2020(ind,4)=DataS(:,23);


Pfast_2020(ind2,4)=DataF(:,1);
ShBP1_2020(ind2,4)=DataF(:,2);
ShBP2_2020(ind2,4)=DataF(:,3);
ShHP1_2020(ind2,4)=DataF(:,4);
ShHP2_2020(ind2,4)=DataF(:,5);

Data='DAT_042'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E01_2020);

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2020(ind,5)=DataS(:,1);
e1_2020(ind,5)=DataS(:,2);
e2_2020(ind,5)=DataS(:,3);
TC_2020(ind,5)=DataS(:,4);
SA_2020(ind,5)=DataS(:,5);
Rho_2020(ind,5)=DataS(:,6);
alpha_2020(ind,5)=DataS(:,7);
beta_2020(ind,5)=DataS(:,8);
dT_2020(ind,5)=DataS(:,9);
dSA_2020(ind,5)=DataS(:,10);
drhodP_2020(ind,5)=DataS(:,11);
nu_2020(ind,5)=DataS(:,12);
N2_2020(ind,5)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2020(ind,5)=DataS(:,14);
Chi2_2020(ind,5)=DataS(:,15);
Tu_2020(ind,5)=DataS(:,16);
Lo1_2020(ind,5)=DataS(:,17);
Lo2_2020(ind,5)=DataS(:,18);
tt_2020(ind,5)=DataS(:,19);
FM1_2020(ind,5)=DataS(:,20);
FM2_2020(ind,5)=DataS(:,21);
QC1_2020(ind,5)=DataS(:,22);
QC2_2020(ind,5)=DataS(:,23);


Pfast_2020(ind2,5)=DataF(:,1);
ShBP1_2020(ind2,5)=DataF(:,2);
ShBP2_2020(ind2,5)=DataF(:,3);
ShHP1_2020(ind2,5)=DataF(:,4);
ShHP2_2020(ind2,5)=DataF(:,5);


Data='DAT_042'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E01_2020);

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2020(ind,6)=DataS(:,1);
e1_2020(ind,6)=DataS(:,2);
e2_2020(ind,6)=DataS(:,3);
TC_2020(ind,6)=DataS(:,4);
SA_2020(ind,6)=DataS(:,5);
Rho_2020(ind,6)=DataS(:,6);
alpha_2020(ind,6)=DataS(:,7);
beta_2020(ind,6)=DataS(:,8);
dT_2020(ind,6)=DataS(:,9);
dSA_2020(ind,6)=DataS(:,10);
drhodP_2020(ind,6)=DataS(:,11);
nu_2020(ind,6)=DataS(:,12);
N2_2020(ind,6)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2020(ind,6)=DataS(:,14);
Chi2_2020(ind,6)=DataS(:,15);
Tu_2020(ind,6)=DataS(:,16);
Lo1_2020(ind,6)=DataS(:,17);
Lo2_2020(ind,6)=DataS(:,18);
tt_2020(ind,6)=DataS(:,19);
FM1_2020(ind,6)=DataS(:,20);
FM2_2020(ind,6)=DataS(:,21);
QC1_2020(ind,6)=DataS(:,22);
QC2_2020(ind,6)=DataS(:,23);


Pfast_2020(ind2,6)=DataF(:,1);
ShBP1_2020(ind2,6)=DataF(:,2);
ShBP2_2020(ind2,6)=DataF(:,3);
ShHP1_2020(ind2,6)=DataF(:,4);
ShHP2_2020(ind2,6)=DataF(:,5);

Data='DAT_044'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E03_2020);

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2020(ind,7)=DataS(:,1);
e1_2020(ind,7)=DataS(:,2);
e2_2020(ind,7)=DataS(:,3);
TC_2020(ind,7)=DataS(:,4);
SA_2020(ind,7)=DataS(:,5);
Rho_2020(ind,7)=DataS(:,6);
alpha_2020(ind,7)=DataS(:,7);
beta_2020(ind,7)=DataS(:,8);
dT_2020(ind,7)=DataS(:,9);
dSA_2020(ind,7)=DataS(:,10);
drhodP_2020(ind,7)=DataS(:,11);
nu_2020(ind,7)=DataS(:,12);
N2_2020(ind,7)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2020(ind,7)=DataS(:,14);
Chi2_2020(ind,7)=DataS(:,15);
Tu_2020(ind,7)=DataS(:,16);
Lo1_2020(ind,7)=DataS(:,17);
Lo2_2020(ind,7)=DataS(:,18);
tt_2020(ind,7)=DataS(:,19);
FM1_2020(ind,7)=DataS(:,20);
FM2_2020(ind,7)=DataS(:,21);
QC1_2020(ind,7)=DataS(:,22);
QC2_2020(ind,7)=DataS(:,23);


Pfast_2020(ind2,7)=DataF(:,1);
ShBP1_2020(ind2,7)=DataF(:,2);
ShBP2_2020(ind2,7)=DataF(:,3);
ShHP1_2020(ind2,7)=DataF(:,4);
ShHP2_2020(ind2,7)=DataF(:,5);

Data='DAT_044'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E03_2020);

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2020(ind,8)=DataS(:,1);
e1_2020(ind,8)=DataS(:,2);
e2_2020(ind,8)=DataS(:,3);
TC_2020(ind,8)=DataS(:,4);
SA_2020(ind,8)=DataS(:,5);
Rho_2020(ind,8)=DataS(:,6);
alpha_2020(ind,8)=DataS(:,7);
beta_2020(ind,8)=DataS(:,8);
dT_2020(ind,8)=DataS(:,9);
dSA_2020(ind,8)=DataS(:,10);
drhodP_2020(ind,8)=DataS(:,11);
nu_2020(ind,8)=DataS(:,12);
N2_2020(ind,8)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2020(ind,8)=DataS(:,14);
Chi2_2020(ind,8)=DataS(:,15);
Tu_2020(ind,8)=DataS(:,16);
Lo1_2020(ind,8)=DataS(:,17);
Lo2_2020(ind,8)=DataS(:,18);
tt_2020(ind,8)=DataS(:,19);
FM1_2020(ind,8)=DataS(:,20);
FM2_2020(ind,8)=DataS(:,21);
QC1_2020(ind,8)=DataS(:,22);
QC2_2020(ind,8)=DataS(:,23);


Pfast_2020(ind2,8)=DataF(:,1);
ShBP1_2020(ind2,8)=DataF(:,2);
ShBP2_2020(ind2,8)=DataF(:,3);
ShHP1_2020(ind2,8)=DataF(:,4);
ShHP2_2020(ind2,8)=DataF(:,5);

Data='DAT_045'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E03_2020);

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2020(ind,9)=DataS(:,1);
e1_2020(ind,9)=DataS(:,2);
e2_2020(ind,9)=DataS(:,3);
TC_2020(ind,9)=DataS(:,4);
SA_2020(ind,9)=DataS(:,5);
Rho_2020(ind,9)=DataS(:,6);
alpha_2020(ind,9)=DataS(:,7);
beta_2020(ind,9)=DataS(:,8);
dT_2020(ind,9)=DataS(:,9);
dSA_2020(ind,9)=DataS(:,10);
drhodP_2020(ind,9)=DataS(:,11);
nu_2020(ind,9)=DataS(:,12);
N2_2020(ind,9)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2020(ind,9)=DataS(:,14);
Chi2_2020(ind,9)=DataS(:,15);
Tu_2020(ind,9)=DataS(:,16);
Lo1_2020(ind,9)=DataS(:,17);
Lo2_2020(ind,9)=DataS(:,18);
tt_2020(ind,9)=DataS(:,19);
FM1_2020(ind,9)=DataS(:,20);
FM2_2020(ind,9)=DataS(:,21);
QC1_2020(ind,9)=DataS(:,22);
QC2_2020(ind,9)=DataS(:,23);


Pfast_2020(ind2,9)=DataF(:,1);
ShBP1_2020(ind2,9)=DataF(:,2);
ShBP2_2020(ind2,9)=DataF(:,3);
ShHP1_2020(ind2,9)=DataF(:,4);
ShHP2_2020(ind2,9)=DataF(:,5);
% toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% SAVING DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vars = who;

% Find variables that end with '2020'
match = endsWith(vars, '2020');

% Extract only those variable names
varsToSave = vars(match);

% Save them to a MAT-file (change filename as needed)
save(fullfile(path2save,'VMP_Data_2020.mat'), varsToSave{:});
clearvars -except ql_info data_dir

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Procesamiento datos de JULIO 2021 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(fullfile(data_dir, 'VMP', 'JUL'))
path2save=fullfile(data_dir, 'VMP', 'JUL/');
E01=-[73+37/60+.67/60,36+25/60+.33/60;
     73+37/60+.67/60,36+25/60+.39/60;
     73+37/60+.51/60,36+24/60+.57/60;
     73+37/60+.45/60,36+23/60+.87/60];
E02=-[73+38/60+.110/60,36+28/60+.007/60;
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

aux=[20:2:650]';
aux2=[20:0.002:650]';
Pslow_2021=NaN(length(aux),15); e1_2021=Pslow_2021; e2_2021=e1_2021; TC_2021=e1_2021; SA_2021=e1_2021; Rho_2021=e1_2021;
alpha_2021=e1_2021; beta_2021=e1_2021; dT_2021=e1_2021; dSA_2021=e1_2021; drhodP_2021=e1_2021; nu_2021=e1_2021; N2_2021=e1_2021;
Tu_2021=e1_2021; Chi1_2021=e1_2021; Chi2_2021=e1_2021; tt_2021=e1_2021; FM1_2021=e1_2021; FM2_2021=e1_2021; QC1_2021=e1_2021; QC2_2021=e1_2021;
Pfast_2021=NaN(length(aux2),15); ShBP1_2021=Pfast_2021; ShBP2_2021=Pfast_2021; ShHP1_2021=Pfast_2021; ShHP2_2021=Pfast_2021;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% LECTURA DE DATOS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tic
% 1 Julio
Data='DAT_056'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(1,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,1)=DataS(:,1);
e1_2021(ind,1)=DataS(:,2);
e2_2021(ind,1)=DataS(:,3);
TC_2021(ind,1)=DataS(:,4);
SA_2021(ind,1)=DataS(:,5);
Rho_2021(ind,1)=DataS(:,6);
alpha_2021(ind,1)=DataS(:,7);
beta_2021(ind,1)=DataS(:,8);
dT_2021(ind,1)=DataS(:,9);
dSA_2021(ind,1)=DataS(:,10);
drhodP_2021(ind,1)=DataS(:,11);
nu_2021(ind,1)=DataS(:,12);
N2_2021(ind,1)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,1)=DataS(:,14);
Chi2_2021(ind,1)=DataS(:,15);
Tu_2021(ind,1)=DataS(:,16);
Lo1_2021(ind,1)=DataS(:,17);
Lo2_2021(ind,1)=DataS(:,18);
tt_2021(ind,1)=DataS(:,19);
FM1_2021(ind,1)=DataS(:,20);
FM2_2021(ind,1)=DataS(:,21);
QC1_2021(ind,1)=DataS(:,22);
QC2_2021(ind,1)=DataS(:,23);

Pfast_2021(ind2,1)=DataF(:,1);
ShBP1_2021(ind2,1)=DataF(:,2);
ShBP2_2021(ind2,1)=DataF(:,3);
ShHP1_2021(ind2,1)=DataF(:,4);
ShHP2_2021(ind2,1)=DataF(:,5);

Data='DAT_058'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(2,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,2)=DataS(:,1);
e1_2021(ind,2)=DataS(:,2);
e2_2021(ind,2)=DataS(:,3);
TC_2021(ind,2)=DataS(:,4);
SA_2021(ind,2)=DataS(:,5);
Rho_2021(ind,2)=DataS(:,6);
alpha_2021(ind,2)=DataS(:,7);
beta_2021(ind,2)=DataS(:,8);
dT_2021(ind,2)=DataS(:,9);
dSA_2021(ind,2)=DataS(:,10);
drhodP_2021(ind,2)=DataS(:,11);
nu_2021(ind,2)=DataS(:,12);
N2_2021(ind,2)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,2)=DataS(:,14);
Chi2_2021(ind,2)=DataS(:,15);
Tu_2021(ind,2)=DataS(:,16);
Lo1_2021(ind,2)=DataS(:,17);
Lo2_2021(ind,2)=DataS(:,18);
tt_2021(ind,2)=DataS(:,19);
FM1_2021(ind,2)=DataS(:,20);
FM2_2021(ind,2)=DataS(:,21);
QC1_2021(ind,2)=DataS(:,22);
QC2_2021(ind,2)=DataS(:,23);

Pfast_2021(ind2,2)=DataF(:,1);
ShBP1_2021(ind2,2)=DataF(:,2);
ShBP2_2021(ind2,2)=DataF(:,3);
ShHP1_2021(ind2,2)=DataF(:,4);
ShHP2_2021(ind2,2)=DataF(:,5);

Data='DAT_058'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(3,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,3)=DataS(:,1);
e1_2021(ind,3)=DataS(:,2);
e2_2021(ind,3)=DataS(:,3);
TC_2021(ind,3)=DataS(:,4);
SA_2021(ind,3)=DataS(:,5);
Rho_2021(ind,3)=DataS(:,6);
alpha_2021(ind,3)=DataS(:,7);
beta_2021(ind,3)=DataS(:,8);
dT_2021(ind,3)=DataS(:,9);
dSA_2021(ind,3)=DataS(:,10);
drhodP_2021(ind,3)=DataS(:,11);
nu_2021(ind,3)=DataS(:,12);
N2_2021(ind,3)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,3)=DataS(:,14);
Chi2_2021(ind,3)=DataS(:,15);
Tu_2021(ind,3)=DataS(:,16);
Lo1_2021(ind,3)=DataS(:,17);
Lo2_2021(ind,3)=DataS(:,18);
tt_2021(ind,3)=DataS(:,19);
FM1_2021(ind,3)=DataS(:,20);
FM2_2021(ind,3)=DataS(:,21);
QC1_2021(ind,3)=DataS(:,22);
QC2_2021(ind,3)=DataS(:,23);

Pfast_2021(ind2,3)=DataF(:,1);
ShBP1_2021(ind2,3)=DataF(:,2);
ShBP2_2021(ind2,3)=DataF(:,3);
ShHP1_2021(ind2,3)=DataF(:,4);
ShHP2_2021(ind2,3)=DataF(:,5);

Data='DAT_058'
ql_info.profile_num=3;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(4,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,4)=DataS(:,1);
e1_2021(ind,4)=DataS(:,2);
e2_2021(ind,4)=DataS(:,3);
TC_2021(ind,4)=DataS(:,4);
SA_2021(ind,4)=DataS(:,5);
Rho_2021(ind,4)=DataS(:,6);
alpha_2021(ind,4)=DataS(:,7);
beta_2021(ind,4)=DataS(:,8);
dT_2021(ind,4)=DataS(:,9);
dSA_2021(ind,4)=DataS(:,10);
drhodP_2021(ind,4)=DataS(:,11);
nu_2021(ind,4)=DataS(:,12);
N2_2021(ind,4)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,4)=DataS(:,14);
Chi2_2021(ind,4)=DataS(:,15);
Tu_2021(ind,4)=DataS(:,16);
Lo1_2021(ind,4)=DataS(:,17);
Lo2_2021(ind,4)=DataS(:,18);
tt_2021(ind,4)=DataS(:,19);
FM1_2021(ind,4)=DataS(:,20);
FM2_2021(ind,4)=DataS(:,21);
QC1_2021(ind,4)=DataS(:,22);
QC2_2021(ind,4)=DataS(:,23);

Pfast_2021(ind2,4)=DataF(:,1);
ShBP1_2021(ind2,4)=DataF(:,2);
ShBP2_2021(ind2,4)=DataF(:,3);
ShHP1_2021(ind2,4)=DataF(:,4);
ShHP2_2021(ind2,4)=DataF(:,5);

% 7 Julio
Data='DAT_059'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(1,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,5)=DataS(:,1);
e1_2021(ind,5)=DataS(:,2);
e2_2021(ind,5)=DataS(:,3);
TC_2021(ind,5)=DataS(:,4);
SA_2021(ind,5)=DataS(:,5);
Rho_2021(ind,5)=DataS(:,6);
alpha_2021(ind,5)=DataS(:,7);
beta_2021(ind,5)=DataS(:,8);
dT_2021(ind,5)=DataS(:,9);
dSA_2021(ind,5)=DataS(:,10);
drhodP_2021(ind,5)=DataS(:,11);
nu_2021(ind,5)=DataS(:,12);
N2_2021(ind,5)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,5)=DataS(:,14);
Chi2_2021(ind,5)=DataS(:,15);
Tu_2021(ind,5)=DataS(:,16);
Lo1_2021(ind,5)=DataS(:,17);
Lo2_2021(ind,5)=DataS(:,18);
tt_2021(ind,5)=DataS(:,19);
FM1_2021(ind,5)=DataS(:,20);
FM2_2021(ind,5)=DataS(:,21);
QC1_2021(ind,5)=DataS(:,22);
QC2_2021(ind,5)=DataS(:,23);

Pfast_2021(ind2,5)=DataF(:,1);
ShBP1_2021(ind2,5)=DataF(:,2);
ShBP2_2021(ind2,5)=DataF(:,3);
ShHP1_2021(ind2,5)=DataF(:,4);
ShHP2_2021(ind2,5)=DataF(:,5);


Data='DAT_060'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(2,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,6)=DataS(:,1);
e1_2021(ind,6)=DataS(:,2);
e2_2021(ind,6)=DataS(:,3);
TC_2021(ind,6)=DataS(:,4);
SA_2021(ind,6)=DataS(:,5);
Rho_2021(ind,6)=DataS(:,6);
alpha_2021(ind,6)=DataS(:,7);
beta_2021(ind,6)=DataS(:,8);
dT_2021(ind,6)=DataS(:,9);
dSA_2021(ind,6)=DataS(:,10);
drhodP_2021(ind,6)=DataS(:,11);
nu_2021(ind,6)=DataS(:,12);
N2_2021(ind,6)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,6)=DataS(:,14);
Chi2_2021(ind,6)=DataS(:,15);
Tu_2021(ind,6)=DataS(:,16);
Lo1_2021(ind,6)=DataS(:,17);
Lo2_2021(ind,6)=DataS(:,18);
tt_2021(ind,6)=DataS(:,19);
FM1_2021(ind,6)=DataS(:,20);
FM2_2021(ind,6)=DataS(:,21);
QC1_2021(ind,6)=DataS(:,22);
QC2_2021(ind,6)=DataS(:,23);

Pfast_2021(ind2,6)=DataF(:,1);
ShBP1_2021(ind2,6)=DataF(:,2);
ShBP2_2021(ind2,6)=DataF(:,3);
ShHP1_2021(ind2,6)=DataF(:,4);
ShHP2_2021(ind2,6)=DataF(:,5);

Data='DAT_060'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(3,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,7)=DataS(:,1);
e1_2021(ind,7)=DataS(:,2);
e2_2021(ind,7)=DataS(:,3);
TC_2021(ind,7)=DataS(:,4);
SA_2021(ind,7)=DataS(:,5);
Rho_2021(ind,7)=DataS(:,6);
alpha_2021(ind,7)=DataS(:,7);
beta_2021(ind,7)=DataS(:,8);
dT_2021(ind,7)=DataS(:,9);
dSA_2021(ind,7)=DataS(:,10);
drhodP_2021(ind,7)=DataS(:,11);
nu_2021(ind,7)=DataS(:,12);
N2_2021(ind,7)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,7)=DataS(:,14);
Chi2_2021(ind,7)=DataS(:,15);
Tu_2021(ind,7)=DataS(:,16);
Lo1_2021(ind,7)=DataS(:,17);
Lo2_2021(ind,7)=DataS(:,18);
tt_2021(ind,7)=DataS(:,19);
FM1_2021(ind,7)=DataS(:,20);
FM2_2021(ind,7)=DataS(:,21);
QC1_2021(ind,7)=DataS(:,22);
QC2_2021(ind,7)=DataS(:,23);

Pfast_2021(ind2,7)=DataF(:,1);
ShBP1_2021(ind2,7)=DataF(:,2);
ShBP2_2021(ind2,7)=DataF(:,3);
ShHP1_2021(ind2,7)=DataF(:,4);
ShHP2_2021(ind2,7)=DataF(:,5);

Data='DAT_061'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(4,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,8)=DataS(:,1);
e1_2021(ind,8)=DataS(:,2);
e2_2021(ind,8)=DataS(:,3);
TC_2021(ind,8)=DataS(:,4);
SA_2021(ind,8)=DataS(:,5);
Rho_2021(ind,8)=DataS(:,6);
alpha_2021(ind,8)=DataS(:,7);
beta_2021(ind,8)=DataS(:,8);
dT_2021(ind,8)=DataS(:,9);
dSA_2021(ind,8)=DataS(:,10);
drhodP_2021(ind,8)=DataS(:,11);
nu_2021(ind,8)=DataS(:,12);
N2_2021(ind,8)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,8)=DataS(:,14);
Chi2_2021(ind,8)=DataS(:,15);
Tu_2021(ind,8)=DataS(:,16);
Lo1_2021(ind,8)=DataS(:,17);
Lo2_2021(ind,8)=DataS(:,18);
tt_2021(ind,8)=DataS(:,19);
FM1_2021(ind,8)=DataS(:,20);
FM2_2021(ind,8)=DataS(:,21);
QC1_2021(ind,8)=DataS(:,22);
QC2_2021(ind,8)=DataS(:,23);

Pfast_2021(ind2,8)=DataF(:,1);
ShBP1_2021(ind2,8)=DataF(:,2);
ShBP2_2021(ind2,8)=DataF(:,3);
ShHP1_2021(ind2,8)=DataF(:,4);
ShHP2_2021(ind2,8)=DataF(:,5);

Data='DAT_061'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(5,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,9)=DataS(:,1);
e1_2021(ind,9)=DataS(:,2);
e2_2021(ind,9)=DataS(:,3);
TC_2021(ind,9)=DataS(:,4);
SA_2021(ind,9)=DataS(:,5);
Rho_2021(ind,9)=DataS(:,6);
alpha_2021(ind,9)=DataS(:,7);
beta_2021(ind,9)=DataS(:,8);
dT_2021(ind,9)=DataS(:,9);
dSA_2021(ind,9)=DataS(:,10);
drhodP_2021(ind,9)=DataS(:,11);
nu_2021(ind,9)=DataS(:,12);
N2_2021(ind,9)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,9)=DataS(:,14);
Chi2_2021(ind,9)=DataS(:,15);
Tu_2021(ind,9)=DataS(:,16);
Lo1_2021(ind,9)=DataS(:,17);
Lo2_2021(ind,9)=DataS(:,18);
tt_2021(ind,9)=DataS(:,19);
FM1_2021(ind,9)=DataS(:,20);
FM2_2021(ind,9)=DataS(:,21);
QC1_2021(ind,9)=DataS(:,22);
QC2_2021(ind,9)=DataS(:,23);

Pfast_2021(ind2,9)=DataF(:,1);
ShBP1_2021(ind2,9)=DataF(:,2);
ShBP2_2021(ind2,9)=DataF(:,3);
ShHP1_2021(ind2,9)=DataF(:,4);
ShHP2_2021(ind2,9)=DataF(:,5);

Data='DAT_061'
ql_info.profile_num=3;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(6,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,10)=DataS(:,1);
e1_2021(ind,10)=DataS(:,2);
e2_2021(ind,10)=DataS(:,3);
TC_2021(ind,10)=DataS(:,4);
SA_2021(ind,10)=DataS(:,5);
Rho_2021(ind,10)=DataS(:,6);
alpha_2021(ind,10)=DataS(:,7);
beta_2021(ind,10)=DataS(:,8);
dT_2021(ind,10)=DataS(:,9);
dSA_2021(ind,10)=DataS(:,10);
drhodP_2021(ind,10)=DataS(:,11);
nu_2021(ind,10)=DataS(:,12);
N2_2021(ind,10)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,10)=DataS(:,14);
Chi2_2021(ind,10)=DataS(:,15);
Tu_2021(ind,10)=DataS(:,16);
Lo1_2021(ind,10)=DataS(:,17);
Lo2_2021(ind,10)=DataS(:,18);
tt_2021(ind,10)=DataS(:,19);
FM1_2021(ind,10)=DataS(:,20);
FM2_2021(ind,10)=DataS(:,21);
QC1_2021(ind,10)=DataS(:,22);
QC2_2021(ind,10)=DataS(:,23);

Pfast_2021(ind2,10)=DataF(:,1);
ShBP1_2021(ind2,10)=DataF(:,2);
ShBP2_2021(ind2,10)=DataF(:,3);
ShHP1_2021(ind2,10)=DataF(:,4);
ShHP2_2021(ind2,10)=DataF(:,5);

Data='DAT_061'
ql_info.profile_num=4;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(6,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,10)=DataS(:,1);
e1_2021(ind,10)=DataS(:,2);
e2_2021(ind,10)=DataS(:,3);
TC_2021(ind,10)=DataS(:,4);
SA_2021(ind,10)=DataS(:,5);
Rho_2021(ind,10)=DataS(:,6);
alpha_2021(ind,10)=DataS(:,7);
beta_2021(ind,10)=DataS(:,8);
dT_2021(ind,10)=DataS(:,9);
dSA_2021(ind,10)=DataS(:,10);
drhodP_2021(ind,10)=DataS(:,11);
nu_2021(ind,10)=DataS(:,12);
N2_2021(ind,10)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,10)=DataS(:,14);
Chi2_2021(ind,10)=DataS(:,15);
Tu_2021(ind,10)=DataS(:,16);
Lo1_2021(ind,10)=DataS(:,17);
Lo2_2021(ind,10)=DataS(:,18);
tt_2021(ind,10)=DataS(:,19);
FM1_2021(ind,10)=DataS(:,20);
FM2_2021(ind,10)=DataS(:,21);
QC1_2021(ind,10)=DataS(:,22);
QC2_2021(ind,10)=DataS(:,23);

Pfast_2021(ind2,10)=DataF(:,1);
ShBP1_2021(ind2,10)=DataF(:,2);
ShBP2_2021(ind2,10)=DataF(:,3);
ShHP1_2021(ind2,10)=DataF(:,4);
ShHP2_2021(ind2,10)=DataF(:,5);

Data='DAT_062'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(7,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,11)=DataS(:,1);
e1_2021(ind,11)=DataS(:,2);
e2_2021(ind,11)=DataS(:,3);
TC_2021(ind,11)=DataS(:,4);
SA_2021(ind,11)=DataS(:,5);
Rho_2021(ind,11)=DataS(:,6);
alpha_2021(ind,11)=DataS(:,7);
beta_2021(ind,11)=DataS(:,8);
dT_2021(ind,11)=DataS(:,9);
dSA_2021(ind,11)=DataS(:,10);
drhodP_2021(ind,11)=DataS(:,11);
nu_2021(ind,11)=DataS(:,12);
N2_2021(ind,11)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,11)=DataS(:,14);
Chi2_2021(ind,11)=DataS(:,15);
Tu_2021(ind,11)=DataS(:,16);
Lo1_2021(ind,11)=DataS(:,17);
Lo2_2021(ind,11)=DataS(:,18);
tt_2021(ind,11)=DataS(:,19);
FM1_2021(ind,11)=DataS(:,20);
FM2_2021(ind,11)=DataS(:,21);
QC1_2021(ind,11)=DataS(:,22);
QC2_2021(ind,11)=DataS(:,23);

Pfast_2021(ind2,11)=DataF(:,1);
ShBP1_2021(ind2,11)=DataF(:,2);
ShBP2_2021(ind2,11)=DataF(:,3);
ShHP1_2021(ind2,11)=DataF(:,4);
ShHP2_2021(ind2,11)=DataF(:,5);

Data='DAT_063'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(8,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,12)=DataS(:,1);
e1_2021(ind,12)=DataS(:,2);
e2_2021(ind,12)=DataS(:,3);
TC_2021(ind,12)=DataS(:,4);
SA_2021(ind,12)=DataS(:,5);
Rho_2021(ind,12)=DataS(:,6);
alpha_2021(ind,12)=DataS(:,7);
beta_2021(ind,12)=DataS(:,8);
dT_2021(ind,12)=DataS(:,9);
dSA_2021(ind,12)=DataS(:,10);
drhodP_2021(ind,12)=DataS(:,11);
nu_2021(ind,12)=DataS(:,12);
N2_2021(ind,12)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,12)=DataS(:,14);
Chi2_2021(ind,12)=DataS(:,15);
Tu_2021(ind,12)=DataS(:,16);
Lo1_2021(ind,12)=DataS(:,17);
Lo2_2021(ind,12)=DataS(:,18);
tt_2021(ind,12)=DataS(:,19);
FM1_2021(ind,12)=DataS(:,20);
FM2_2021(ind,12)=DataS(:,21);
QC1_2021(ind,12)=DataS(:,22);
QC2_2021(ind,12)=DataS(:,23);

Pfast_2021(ind2,12)=DataF(:,1);
ShBP1_2021(ind2,12)=DataF(:,2);
ShBP2_2021(ind2,12)=DataF(:,3);
ShHP1_2021(ind2,12)=DataF(:,4);
ShHP2_2021(ind2,12)=DataF(:,5);

Data='DAT_063'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(9,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,13)=DataS(:,1);
e1_2021(ind,13)=DataS(:,2);
e2_2021(ind,13)=DataS(:,3);
TC_2021(ind,13)=DataS(:,4);
SA_2021(ind,13)=DataS(:,5);
Rho_2021(ind,13)=DataS(:,6);
alpha_2021(ind,13)=DataS(:,7);
beta_2021(ind,13)=DataS(:,8);
dT_2021(ind,13)=DataS(:,9);
dSA_2021(ind,13)=DataS(:,10);
drhodP_2021(ind,13)=DataS(:,11);
nu_2021(ind,13)=DataS(:,12);
N2_2021(ind,13)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,13)=DataS(:,14);
Chi2_2021(ind,13)=DataS(:,15);
Tu_2021(ind,13)=DataS(:,16);
Lo1_2021(ind,13)=DataS(:,17);
Lo2_2021(ind,13)=DataS(:,18);
tt_2021(ind,13)=DataS(:,19);
FM1_2021(ind,13)=DataS(:,20);
FM2_2021(ind,13)=DataS(:,21);
QC1_2021(ind,13)=DataS(:,22);
QC2_2021(ind,13)=DataS(:,23);

Pfast_2021(ind2,13)=DataF(:,1);
ShBP1_2021(ind2,13)=DataF(:,2);
ShBP2_2021(ind2,13)=DataF(:,3);
ShHP1_2021(ind2,13)=DataF(:,4);
ShHP2_2021(ind2,13)=DataF(:,5);

Data='DAT_063'
ql_info.profile_num=3;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(9,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,13)=DataS(:,1);
e1_2021(ind,13)=DataS(:,2);
e2_2021(ind,13)=DataS(:,3);
TC_2021(ind,13)=DataS(:,4);
SA_2021(ind,13)=DataS(:,5);
Rho_2021(ind,13)=DataS(:,6);
alpha_2021(ind,13)=DataS(:,7);
beta_2021(ind,13)=DataS(:,8);
dT_2021(ind,13)=DataS(:,9);
dSA_2021(ind,13)=DataS(:,10);
drhodP_2021(ind,13)=DataS(:,11);
nu_2021(ind,13)=DataS(:,12);
N2_2021(ind,13)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,13)=DataS(:,14);
Chi2_2021(ind,13)=DataS(:,15);
Tu_2021(ind,13)=DataS(:,16);
Lo1_2021(ind,13)=DataS(:,17);
Lo2_2021(ind,13)=DataS(:,18);
tt_2021(ind,13)=DataS(:,19);
FM1_2021(ind,13)=DataS(:,20);
FM2_2021(ind,13)=DataS(:,21);
QC1_2021(ind,13)=DataS(:,22);
QC2_2021(ind,13)=DataS(:,23);

Pfast_2021(ind2,13)=DataF(:,1);
ShBP1_2021(ind2,13)=DataF(:,2);
ShBP2_2021(ind2,13)=DataF(:,3);
ShHP1_2021(ind2,13)=DataF(:,4);
ShHP2_2021(ind2,13)=DataF(:,5);

Data='DAT_064'
ql_info.profile_num=5;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(11,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,14)=DataS(:,1);
e1_2021(ind,14)=DataS(:,2);
e2_2021(ind,14)=DataS(:,3);
TC_2021(ind,14)=DataS(:,4);
SA_2021(ind,14)=DataS(:,5);
Rho_2021(ind,14)=DataS(:,6);
alpha_2021(ind,14)=DataS(:,7);
beta_2021(ind,14)=DataS(:,8);
dT_2021(ind,14)=DataS(:,9);
dSA_2021(ind,14)=DataS(:,10);
drhodP_2021(ind,14)=DataS(:,11);
nu_2021(ind,14)=DataS(:,12);
N2_2021(ind,14)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,14)=DataS(:,14);
Chi2_2021(ind,14)=DataS(:,15);
Tu_2021(ind,14)=DataS(:,16);
Lo1_2021(ind,14)=DataS(:,17);
Lo2_2021(ind,14)=DataS(:,18);
tt_2021(ind,14)=DataS(:,19);
FM1_2021(ind,14)=DataS(:,20);
FM2_2021(ind,14)=DataS(:,21);
QC1_2021(ind,14)=DataS(:,22);
QC2_2021(ind,14)=DataS(:,23);

Pfast_2021(ind2,14)=DataF(:,1);
ShBP1_2021(ind2,14)=DataF(:,2);
ShBP2_2021(ind2,14)=DataF(:,3);
ShHP1_2021(ind2,14)=DataF(:,4);
ShHP2_2021(ind2,14)=DataF(:,5);

Data='DAT_064'
ql_info.profile_num=6;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(11,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,14)=DataS(:,1);
e1_2021(ind,14)=DataS(:,2);
e2_2021(ind,14)=DataS(:,3);
TC_2021(ind,14)=DataS(:,4);
SA_2021(ind,14)=DataS(:,5);
Rho_2021(ind,14)=DataS(:,6);
alpha_2021(ind,14)=DataS(:,7);
beta_2021(ind,14)=DataS(:,8);
dT_2021(ind,14)=DataS(:,9);
dSA_2021(ind,14)=DataS(:,10);
drhodP_2021(ind,14)=DataS(:,11);
nu_2021(ind,14)=DataS(:,12);
N2_2021(ind,14)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,14)=DataS(:,14);
Chi2_2021(ind,14)=DataS(:,15);
Tu_2021(ind,14)=DataS(:,16);
Lo1_2021(ind,14)=DataS(:,17);
Lo2_2021(ind,14)=DataS(:,18);
tt_2021(ind,14)=DataS(:,19);
FM1_2021(ind,14)=DataS(:,20);
FM2_2021(ind,14)=DataS(:,21);
QC1_2021(ind,14)=DataS(:,22);
QC2_2021(ind,14)=DataS(:,23);


Pfast_2021(ind2,14)=DataF(:,1);
ShBP1_2021(ind2,14)=DataF(:,2);
ShBP2_2021(ind2,14)=DataF(:,3);
ShHP1_2021(ind2,14)=DataF(:,4);
ShHP2_2021(ind2,14)=DataF(:,5);

Data='DAT_065'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E02(12,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2021(ind,15)=DataS(:,1);
e1_2021(ind,15)=DataS(:,2);
e2_2021(ind,15)=DataS(:,3);
TC_2021(ind,15)=DataS(:,4);
SA_2021(ind,15)=DataS(:,5);
Rho_2021(ind,15)=DataS(:,6);
alpha_2021(ind,15)=DataS(:,7);
beta_2021(ind,15)=DataS(:,8);
dT_2021(ind,15)=DataS(:,9);
dSA_2021(ind,15)=DataS(:,10);
drhodP_2021(ind,15)=DataS(:,11);
nu_2021(ind,15)=DataS(:,12);
N2_2021(ind,15)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2021(ind,15)=DataS(:,14);
Chi2_2021(ind,15)=DataS(:,15);
Tu_2021(ind,15)=DataS(:,16);
Lo1_2021(ind,15)=DataS(:,17);
Lo2_2021(ind,15)=DataS(:,18);
tt_2021(ind,15)=DataS(:,19);
FM1_2021(ind,15)=DataS(:,20);
FM2_2021(ind,15)=DataS(:,21);
QC1_2021(ind,15)=DataS(:,22);
QC2_2021(ind,15)=DataS(:,23);

Pfast_2021(ind2,15)=DataF(:,1);
ShBP1_2021(ind2,15)=DataF(:,2);
ShBP2_2021(ind2,15)=DataF(:,3);
ShHP1_2021(ind2,15)=DataF(:,4);
ShHP2_2021(ind2,15)=DataF(:,5);
% toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% SAVING DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vars = who;

% Find variables that end with '2021'
match = endsWith(vars, '2021');

% Extract only those variable names
varsToSave = vars(match);

% Save them to a MAT-file (change filename as needed)
save(fullfile(path2save,'VMP_Data_2021.mat'), varsToSave{:});
clearvars -except ql_info data_dir


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Procesamiento datos de Octubre 2022 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd(fullfile(data_dir, 'VMP', 'OCT'))
path2save=fullfile(data_dir, 'VMP', 'OCT/');

E01=-[73+37/60+.402/60,36+29/60+.664/60;
     73+37/60+.402/60,36+29/60+.664/60;
     73+36/60+.730/60,36+29/60+.203/60;
     73+36/60+.567/60,36+29/60+.118/60;
     73+37/60+.112/60,36+29/60+.454/60;
     73+36/60+.869/60,36+29/60+.278/60;
     73+36/60+.661/60,36+29/60+.094/60;
     73+37/60+.015/60,36+29/60+.443/60;
     73+36/60+.534/60,36+29/60+.241/60;
     73+36/60+.118/60,36+29/60+.034/60];

aux=[20:2:650]';
aux2=[20:0.002:650]';
Pslow_2022=NaN(length(aux),10); e1_2022=Pslow_2022; e2_2022=e1_2022; TC_2022=e1_2022; SA_2022=e1_2022; Rho_2022=e1_2022;
alpha_2022=e1_2022; beta_2022=e1_2022; dT_2022=e1_2022; dSA_2022=e1_2022; drhodP_2022=e1_2022; nu_2022=e1_2022; N2_2022=e1_2022;
Tu_2022=e1_2022; Chi1_2022=e1_2022; Chi2_2022=e1_2022; tt_2022=e1_2022; FM1_2022=e1_2022; FM2_2022=e1_2022; QC1_2022=e1_2022; QC2_2022=e1_2022;
Pfast_2022=NaN(length(aux2),15); ShBP1_2022=Pfast_2022; ShBP2_2022=Pfast_2022; ShHP1_2022=Pfast_2022; ShHP2_2022=Pfast_2022;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% LECTURA DE DATOS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tic

Data='DAT_009'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(1,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,1)=DataS(:,1);
e1_2022(ind,1)=DataS(:,2);
e2_2022(ind,1)=DataS(:,3);
TC_2022(ind,1)=DataS(:,4);
SA_2022(ind,1)=DataS(:,5);
Rho_2022(ind,1)=DataS(:,6);
alpha_2022(ind,1)=DataS(:,7);
beta_2022(ind,1)=DataS(:,8);
dT_2022(ind,1)=DataS(:,9);
dSA_2022(ind,1)=DataS(:,10);
drhodP_2022(ind,1)=DataS(:,11);
nu_2022(ind,1)=DataS(:,12);
N2_2022(ind,1)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,1)=DataS(:,14);
Chi2_2022(ind,1)=DataS(:,15);
Tu_2022(ind,1)=DataS(:,16);
Lo1_2022(ind,1)=DataS(:,17);
Lo2_2022(ind,1)=DataS(:,18);
tt_2022(ind,1)=DataS(:,19);
FM1_2022(ind,1)=DataS(:,20);
FM2_2022(ind,1)=DataS(:,21);
QC1_2022(ind,1)=DataS(:,22);
QC2_2022(ind,1)=DataS(:,23);


Pfast_2022(ind2,1)=DataF(:,1);
ShBP1_2022(ind2,1)=DataF(:,2);
ShBP2_2022(ind2,1)=DataF(:,3);
ShHP1_2022(ind2,1)=DataF(:,4);
ShHP2_2022(ind2,1)=DataF(:,5);

Data='DAT_010'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(2,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,2)=DataS(:,1);
e1_2022(ind,2)=DataS(:,2);
e2_2022(ind,2)=DataS(:,3);
TC_2022(ind,2)=DataS(:,4);
SA_2022(ind,2)=DataS(:,5);
Rho_2022(ind,2)=DataS(:,6);
alpha_2022(ind,2)=DataS(:,7);
beta_2022(ind,2)=DataS(:,8);
dT_2022(ind,2)=DataS(:,9);
dSA_2022(ind,2)=DataS(:,10);
drhodP_2022(ind,2)=DataS(:,11);
nu_2022(ind,2)=DataS(:,12);
N2_2022(ind,2)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,2)=DataS(:,14);
Chi2_2022(ind,2)=DataS(:,15);
Tu_2022(ind,2)=DataS(:,16);
Lo1_2022(ind,2)=DataS(:,17);
Lo2_2022(ind,2)=DataS(:,18);
tt_2022(ind,2)=DataS(:,19);
FM1_2022(ind,2)=DataS(:,20);
FM2_2022(ind,2)=DataS(:,21);
QC1_2022(ind,2)=DataS(:,22);
QC2_2022(ind,2)=DataS(:,23);

Pfast_2022(ind2,2)=DataF(:,1);
ShBP1_2022(ind2,2)=DataF(:,2);
ShBP2_2022(ind2,2)=DataF(:,3);
ShHP1_2022(ind2,2)=DataF(:,4);
ShHP2_2022(ind2,2)=DataF(:,5);

Data='DAT_010'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(3,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,3)=DataS(:,1);
e1_2022(ind,3)=DataS(:,2);
e2_2022(ind,3)=DataS(:,3);
TC_2022(ind,3)=DataS(:,4);
SA_2022(ind,3)=DataS(:,5);
Rho_2022(ind,3)=DataS(:,6);
alpha_2022(ind,3)=DataS(:,7);
beta_2022(ind,3)=DataS(:,8);
dT_2022(ind,3)=DataS(:,9);
dSA_2022(ind,3)=DataS(:,10);
drhodP_2022(ind,3)=DataS(:,11);
nu_2022(ind,3)=DataS(:,12);
N2_2022(ind,3)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,3)=DataS(:,14);
Chi2_2022(ind,3)=DataS(:,15);
Tu_2022(ind,3)=DataS(:,16);
Lo1_2022(ind,3)=DataS(:,17);
Lo2_2022(ind,3)=DataS(:,18);
tt_2022(ind,3)=DataS(:,19);
FM1_2022(ind,3)=DataS(:,20);
FM2_2022(ind,3)=DataS(:,21);
QC1_2022(ind,3)=DataS(:,22);
QC2_2022(ind,3)=DataS(:,23);

Pfast_2022(ind2,3)=DataF(:,1);
ShBP1_2022(ind2,3)=DataF(:,2);
ShBP2_2022(ind2,3)=DataF(:,3);
ShHP1_2022(ind2,3)=DataF(:,4);
ShHP2_2022(ind2,3)=DataF(:,5);

Data='DAT_010'
ql_info.profile_num=3;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(4,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,4)=DataS(:,1);
e1_2022(ind,4)=DataS(:,2);
e2_2022(ind,4)=DataS(:,3);
TC_2022(ind,4)=DataS(:,4);
SA_2022(ind,4)=DataS(:,5);
Rho_2022(ind,4)=DataS(:,6);
alpha_2022(ind,4)=DataS(:,7);
beta_2022(ind,4)=DataS(:,8);
dT_2022(ind,4)=DataS(:,9);
dSA_2022(ind,4)=DataS(:,10);
drhodP_2022(ind,4)=DataS(:,11);
nu_2022(ind,4)=DataS(:,12);
N2_2022(ind,4)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,4)=DataS(:,14);
Chi2_2022(ind,4)=DataS(:,15);
Tu_2022(ind,4)=DataS(:,16);
Lo1_2022(ind,4)=DataS(:,17);
Lo2_2022(ind,4)=DataS(:,18);
tt_2022(ind,4)=DataS(:,19);
FM1_2022(ind,4)=DataS(:,20);
FM2_2022(ind,4)=DataS(:,21);
QC1_2022(ind,4)=DataS(:,22);
QC2_2022(ind,4)=DataS(:,23);

Pfast_2022(ind2,4)=DataF(:,1);
ShBP1_2022(ind2,4)=DataF(:,2);
ShBP2_2022(ind2,4)=DataF(:,3);
ShHP1_2022(ind2,4)=DataF(:,4);
ShHP2_2022(ind2,4)=DataF(:,5);

Data='DAT_011'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(5,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,5)=DataS(:,1);
e1_2022(ind,5)=DataS(:,2);
e2_2022(ind,5)=DataS(:,3);
TC_2022(ind,5)=DataS(:,4);
SA_2022(ind,5)=DataS(:,5);
Rho_2022(ind,5)=DataS(:,6);
alpha_2022(ind,5)=DataS(:,7);
beta_2022(ind,5)=DataS(:,8);
dT_2022(ind,5)=DataS(:,9);
dSA_2022(ind,5)=DataS(:,10);
drhodP_2022(ind,5)=DataS(:,11);
nu_2022(ind,5)=DataS(:,12);
N2_2022(ind,5)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,5)=DataS(:,14);
Chi2_2022(ind,5)=DataS(:,15);
Tu_2022(ind,5)=DataS(:,16);
Lo1_2022(ind,5)=DataS(:,17);
Lo2_2022(ind,5)=DataS(:,18);
tt_2022(ind,5)=DataS(:,19);
FM1_2022(ind,5)=DataS(:,20);
FM2_2022(ind,5)=DataS(:,21);
QC1_2022(ind,5)=DataS(:,22);
QC2_2022(ind,5)=DataS(:,23);

Pfast_2022(ind2,5)=DataF(:,1);
ShBP1_2022(ind2,5)=DataF(:,2);
ShBP2_2022(ind2,5)=DataF(:,3);
ShHP1_2022(ind2,5)=DataF(:,4);
ShHP2_2022(ind2,5)=DataF(:,5);


Data='DAT_011'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(6,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,6)=DataS(:,1);
e1_2022(ind,6)=DataS(:,2);
e2_2022(ind,6)=DataS(:,3);
TC_2022(ind,6)=DataS(:,4);
SA_2022(ind,6)=DataS(:,5);
Rho_2022(ind,6)=DataS(:,6);
alpha_2022(ind,6)=DataS(:,7);
beta_2022(ind,6)=DataS(:,8);
dT_2022(ind,6)=DataS(:,9);
dSA_2022(ind,6)=DataS(:,10);
drhodP_2022(ind,6)=DataS(:,11);
nu_2022(ind,6)=DataS(:,12);
N2_2022(ind,6)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,6)=DataS(:,14);
Chi2_2022(ind,6)=DataS(:,15);
Tu_2022(ind,6)=DataS(:,16);
Lo1_2022(ind,6)=DataS(:,17);
Lo2_2022(ind,6)=DataS(:,18);
tt_2022(ind,6)=DataS(:,19);
FM1_2022(ind,6)=DataS(:,20);
FM2_2022(ind,6)=DataS(:,21);
QC1_2022(ind,6)=DataS(:,22);
QC2_2022(ind,6)=DataS(:,23);

Pfast_2022(ind2,6)=DataF(:,1);
ShBP1_2022(ind2,6)=DataF(:,2);
ShBP2_2022(ind2,6)=DataF(:,3);
ShHP1_2022(ind2,6)=DataF(:,4);
ShHP2_2022(ind2,6)=DataF(:,5);

Data='DAT_011'
ql_info.profile_num=3;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(7,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,7)=DataS(:,1);
e1_2022(ind,7)=DataS(:,2);
e2_2022(ind,7)=DataS(:,3);
TC_2022(ind,7)=DataS(:,4);
SA_2022(ind,7)=DataS(:,5);
Rho_2022(ind,7)=DataS(:,6);
alpha_2022(ind,7)=DataS(:,7);
beta_2022(ind,7)=DataS(:,8);
dT_2022(ind,7)=DataS(:,9);
dSA_2022(ind,7)=DataS(:,10);
drhodP_2022(ind,7)=DataS(:,11);
nu_2022(ind,7)=DataS(:,12);
N2_2022(ind,7)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,7)=DataS(:,14);
Chi2_2022(ind,7)=DataS(:,15);
Tu_2022(ind,7)=DataS(:,16);
Lo1_2022(ind,7)=DataS(:,17);
Lo2_2022(ind,7)=DataS(:,18);
tt_2022(ind,7)=DataS(:,19);
FM1_2022(ind,7)=DataS(:,20);
FM2_2022(ind,7)=DataS(:,21);
QC1_2022(ind,7)=DataS(:,22);
QC2_2022(ind,7)=DataS(:,23);

Pfast_2022(ind2,7)=DataF(:,1);
ShBP1_2022(ind2,7)=DataF(:,2);
ShBP2_2022(ind2,7)=DataF(:,3);
ShHP1_2022(ind2,7)=DataF(:,4);
ShHP2_2022(ind2,7)=DataF(:,5);

Data='DAT_012'
ql_info.profile_num=1;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(8,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,8)=DataS(:,1);
e1_2022(ind,8)=DataS(:,2);
e2_2022(ind,8)=DataS(:,3);
TC_2022(ind,8)=DataS(:,4);
SA_2022(ind,8)=DataS(:,5);
Rho_2022(ind,8)=DataS(:,6);
alpha_2022(ind,8)=DataS(:,7);
beta_2022(ind,8)=DataS(:,8);
dT_2022(ind,8)=DataS(:,9);
dSA_2022(ind,8)=DataS(:,10);
drhodP_2022(ind,8)=DataS(:,11);
nu_2022(ind,8)=DataS(:,12);
N2_2022(ind,8)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,8)=DataS(:,14);
Chi2_2022(ind,8)=DataS(:,15);
Tu_2022(ind,8)=DataS(:,16);
Lo1_2022(ind,8)=DataS(:,17);
Lo2_2022(ind,8)=DataS(:,18);
tt_2022(ind,8)=DataS(:,19);
FM1_2022(ind,8)=DataS(:,20);
FM2_2022(ind,8)=DataS(:,21);
QC1_2022(ind,8)=DataS(:,22);
QC2_2022(ind,8)=DataS(:,23);

Pfast_2022(ind2,8)=DataF(:,1);
ShBP1_2022(ind2,8)=DataF(:,2);
ShBP2_2022(ind2,8)=DataF(:,3);
ShHP1_2022(ind2,8)=DataF(:,4);
ShHP2_2022(ind2,8)=DataF(:,5);

Data='DAT_012'
ql_info.profile_num=2;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(9,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,9)=DataS(:,1);
e1_2022(ind,9)=DataS(:,2);
e2_2022(ind,9)=DataS(:,3);
TC_2022(ind,9)=DataS(:,4);
SA_2022(ind,9)=DataS(:,5);
Rho_2022(ind,9)=DataS(:,6);
alpha_2022(ind,9)=DataS(:,7);
beta_2022(ind,9)=DataS(:,8);
dT_2022(ind,9)=DataS(:,9);
dSA_2022(ind,9)=DataS(:,10);
drhodP_2022(ind,9)=DataS(:,11);
nu_2022(ind,9)=DataS(:,12);
N2_2022(ind,9)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,9)=DataS(:,14);
Chi2_2022(ind,9)=DataS(:,15);
Tu_2022(ind,9)=DataS(:,16);
Lo1_2022(ind,9)=DataS(:,17);
Lo2_2022(ind,9)=DataS(:,18);
tt_2022(ind,9)=DataS(:,19);
FM1_2022(ind,9)=DataS(:,20);
FM2_2022(ind,9)=DataS(:,21);
QC1_2022(ind,9)=DataS(:,22);
QC2_2022(ind,9)=DataS(:,23);

Pfast_2022(ind2,9)=DataF(:,1);
ShBP1_2022(ind2,9)=DataF(:,2);
ShBP2_2022(ind2,9)=DataF(:,3);
ShHP1_2022(ind2,9)=DataF(:,4);
ShHP2_2022(ind2,9)=DataF(:,5);

Data='DAT_012'
ql_info.profile_num=3;
[DataF, DataS]= InterpDatos(Data,ql_info,E01(10,:));

ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';
ind1=find(aux2==DataF(1,1));
ind2=find(aux2==DataF(end,1));
ind2=[ind1:ind2]';

Pslow_2022(ind,10)=DataS(:,1);
e1_2022(ind,10)=DataS(:,2);
e2_2022(ind,10)=DataS(:,3);
TC_2022(ind,10)=DataS(:,4);
SA_2022(ind,10)=DataS(:,5);
Rho_2022(ind,10)=DataS(:,6);
alpha_2022(ind,10)=DataS(:,7);
beta_2022(ind,10)=DataS(:,8);
dT_2022(ind,10)=DataS(:,9);
dSA_2022(ind,10)=DataS(:,10);
drhodP_2022(ind,10)=DataS(:,11);
nu_2022(ind,10)=DataS(:,12);
N2_2022(ind,10)=movmean(DataS(:,13),5,1,'omitnan');
Chi1_2022(ind,10)=DataS(:,14);
Chi2_2022(ind,10)=DataS(:,15);
Tu_2022(ind,10)=DataS(:,16);
Lo1_2022(ind,10)=DataS(:,17);
Lo2_2022(ind,10)=DataS(:,18);
tt_2022(ind,10)=DataS(:,19);
FM1_2022(ind,10)=DataS(:,20);
FM2_2022(ind,10)=DataS(:,21);
QC1_2022(ind,10)=DataS(:,22);
QC2_2022(ind,10)=DataS(:,23);

Pfast_2022(ind2,10)=DataF(:,1);
ShBP1_2022(ind2,10)=DataF(:,2);
ShBP2_2022(ind2,10)=DataF(:,3);
ShHP1_2022(ind2,10)=DataF(:,4);
ShHP2_2022(ind2,10)=DataF(:,5);

toc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% SAVING DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vars = who;

% Find variables that end with '2022'
match = endsWith(vars, '2022');

% Extract only those variable names
varsToSave = vars(match);

% Save them to a MAT-file (change filename as needed)
save(fullfile(path2save,'VMP_Data_2022.mat'), varsToSave{:});
clearvars -except ql_info data_dir




