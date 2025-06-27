close all; clear all;

data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
figure_dir = '/Users/xpintm/Library/Mobile Documents/com~apple~CloudDocs/PHD/OMZ_Chile/Paper/Figures/';
sd=true;  % Save figure flag
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% CTD Processing JAN 2020 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Station coodinates
E01=-[73+36/60+.89/60,36+25/60+.657/60;
     73+37/60+.002/60,36+25/60+.962/60];
E01=mean(E01);
E02=-[73+43/60+.403/60,36+25/60+.983/60;
     73+43/60+.427/60,36+25/60+.953/60;
     73+43/60+.414/60,36+25/60+.97/60];
E02=mean(E02);
E03=-[73+31/60+.579/60,36+26/60+.141/60];
load(fullfile(data_dir, 'CTD', 'JAN', 'CTD.mat'));

aux=[2:2:650]';
P_CTD2020=NaN(length(aux),3); T_CTD2020=P_CTD2020; SP_CTD2020=T_CTD2020; SA_CTD2020=T_CTD2020; TC_CTD2020=T_CTD2020; O_CTD2020=T_CTD2020;
sigmat_CTD2020=T_CTD2020; AOU_CTD2020=T_CTD2020;

% Estacion 01
Data=CTD_E02;
[DataS]= InterpDatos_CTD(Data,E02);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2020(ind,1)=DataS(:,2);
P_CTD2020(ind,1)=DataS(:,1);
SP_CTD2020(ind,1)=DataS(:,3);
SA_CTD2020(ind,1)=DataS(:,4);
TC_CTD2020(ind,1)=DataS(:,5);
O_CTD2020(ind,1)=DataS(:,6);
sigmat_CTD2020(ind,1)=DataS(:,7);
AOU_CTD2020(ind,1)=DataS(:,8);

% Estacion 02
Data=CTD_E01;
[DataS]= InterpDatos_CTD(Data,E01);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2020(ind,2)=DataS(:,2);
P_CTD2020(ind,2)=DataS(:,1);
SP_CTD2020(ind,2)=DataS(:,3);
SA_CTD2020(ind,2)=DataS(:,4);
TC_CTD2020(ind,2)=DataS(:,5);
O_CTD2020(ind,2)=DataS(:,6);
sigmat_CTD2020(ind,2)=DataS(:,7);
AOU_CTD2020(ind,2)=DataS(:,8);


% Estacion 03
Data=CTD_E03;
[DataS]= InterpDatos_CTD(Data,E03);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2020(ind,3)=DataS(:,2);
P_CTD2020(ind,3)=DataS(:,1);
SP_CTD2020(ind,3)=DataS(:,3);
SA_CTD2020(ind,3)=DataS(:,4);
TC_CTD2020(ind,3)=DataS(:,5);
O_CTD2020(ind,3)=DataS(:,6);
sigmat_CTD2020(ind,3)=DataS(:,7);
AOU_CTD2020(ind,3)=DataS(:,8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% CTD Processing JUL 2021 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(fullfile(data_dir, 'CTD', 'JUL', 'CTD.mat'));
% Station coodinates
E01=-[73+37/60+.600/60,36+25/60+.270/60];
E02=-[73+37/60+.582/60,36+23/60+.072/6];
E03=-[73+38/60+.063/60,36+27/60+.901/6];
E04=-[73+38/60+.275/60,36+28/60+.162/6];
E05=-[73+38/60+.255/60,36+28/60+.247/6];
E06=-[73+37/60+.981/60,36+28/60+.202/6];
E07=-[73+37/60+.549/60,36+28/60+.074/6];


aux=[2:2:650]';
P_CTD2021=NaN(length(aux),7); T_CTD2021=P_CTD2021; SP_CTD2021=T_CTD2021; SA_CTD2021=T_CTD2021; TC_CTD2021=T_CTD2021; O_CTD2021=T_CTD2021;
sigmat_CTD2021=T_CTD2021; AOU_CTD2021=T_CTD2021;

% Estacion 01
Data=CTD_E01;
[DataS]= InterpDatos_CTD(Data,E01);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2021(ind,1)=DataS(:,2);
P_CTD2021(ind,1)=DataS(:,1);
SP_CTD2021(ind,1)=DataS(:,3);
SA_CTD2021(ind,1)=DataS(:,4);
TC_CTD2021(ind,1)=DataS(:,5);
O_CTD2021(ind,1)=DataS(:,6);
sigmat_CTD2021(ind,1)=DataS(:,7);
AOU_CTD2021(ind,1)=DataS(:,8);

% Estacion 02
Data=CTD_E02;
[DataS]= InterpDatos_CTD(Data,E02);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2021(ind,2)=DataS(:,2);
P_CTD2021(ind,2)=DataS(:,1);
SP_CTD2021(ind,2)=DataS(:,3);
SA_CTD2021(ind,2)=DataS(:,4);
TC_CTD2021(ind,2)=DataS(:,5);
O_CTD2021(ind,2)=DataS(:,6);
sigmat_CTD2021(ind,2)=DataS(:,7);
AOU_CTD2021(ind,2)=DataS(:,8);

% Estacion 03
Data=CTD_E03;
[DataS]= InterpDatos_CTD(Data,E03);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2021(ind,3)=DataS(:,2);
P_CTD2021(ind,3)=DataS(:,1);
SP_CTD2021(ind,3)=DataS(:,3);
SA_CTD2021(ind,3)=DataS(:,4);
TC_CTD2021(ind,3)=DataS(:,5);
O_CTD2021(ind,3)=DataS(:,6);
sigmat_CTD2021(ind,3)=DataS(:,7);
AOU_CTD2021(ind,3)=DataS(:,8);

% Estacion 04
Data=CTD_E04;
[DataS]= InterpDatos_CTD(Data,E04);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2021(ind,4)=DataS(:,2);
P_CTD2021(ind,4)=DataS(:,1);
SP_CTD2021(ind,4)=DataS(:,3);
SA_CTD2021(ind,4)=DataS(:,4);
TC_CTD2021(ind,4)=DataS(:,5);
O_CTD2021(ind,4)=DataS(:,6);
sigmat_CTD2021(ind,4)=DataS(:,7);
AOU_CTD2021(ind,4)=DataS(:,8);

% Estacion 05
Data=CTD_E05;
[DataS]= InterpDatos_CTD(Data,E05);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2021(ind,5)=DataS(:,2);
P_CTD2021(ind,5)=DataS(:,1);
SP_CTD2021(ind,5)=DataS(:,3);
SA_CTD2021(ind,5)=DataS(:,4);
TC_CTD2021(ind,5)=DataS(:,5);
O_CTD2021(ind,5)=DataS(:,6);
sigmat_CTD2021(ind,5)=DataS(:,7);
AOU_CTD2021(ind,5)=DataS(:,8);

% Estacion 06
Data=CTD_E06;
[DataS]= InterpDatos_CTD(Data,E06);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2021(ind,6)=DataS(:,2);
P_CTD2021(ind,6)=DataS(:,1);
SP_CTD2021(ind,6)=DataS(:,3);
SA_CTD2021(ind,6)=DataS(:,4);
TC_CTD2021(ind,6)=DataS(:,5);
O_CTD2021(ind,6)=DataS(:,6);
sigmat_CTD2021(ind,6)=DataS(:,7);
AOU_CTD2021(ind,6)=DataS(:,8);

% Estacion 07
Data=CTD_E07;
[DataS]= InterpDatos_CTD(Data,E07);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2021(ind,7)=DataS(:,2);
P_CTD2021(ind,7)=DataS(:,1);
SP_CTD2021(ind,7)=DataS(:,3);
SA_CTD2021(ind,7)=DataS(:,4);
TC_CTD2021(ind,7)=DataS(:,5);
O_CTD2021(ind,7)=DataS(:,6);
sigmat_CTD2021(ind,7)=DataS(:,7);
AOU_CTD2021(ind,7)=DataS(:,8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% CTD Processing OCT 2022 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load(fullfile(data_dir, 'CTD', 'OCT', 'CTD.mat'));
% Station coordinates
E01=-[73+37/60+.802/60,36+30/60+.063/60];
E02=-[73+37/60+.402/60,36+29/60+.664/6];
E03=-[73+37/60+.378/60,36+29/60+.591/6];
E04=-[73+37/60+.415/60,36+29/60+.626/6];

aux=[2:2:650]';
P_CTD2022=NaN(length(aux),4); T_CTD2022=P_CTD2022; SP_CTD2022=T_CTD2022; SA_CTD2022=T_CTD2022; TC_CTD2022=T_CTD2022; O_CTD2022=T_CTD2022;
sigmat_CTD2022=T_CTD2022;  AOU_CTD2022=T_CTD2022;

% Estacion 01
Data=CTD_E01;
[DataS]= InterpDatos_CTD(Data,E01);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2022(ind,1)=DataS(:,2);
P_CTD2022(ind,1)=DataS(:,1);
SP_CTD2022(ind,1)=DataS(:,3);
SA_CTD2022(ind,1)=DataS(:,4);
TC_CTD2022(ind,1)=DataS(:,5);
O_CTD2022(ind,1)=DataS(:,6);
sigmat_CTD2022(ind,1)=DataS(:,7);
AOU_CTD2022(ind,1)=DataS(:,8);
% Estacion 02
Data=CTD_E02;
[DataS]= InterpDatos_CTD(Data,E02);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2022(ind,2)=DataS(:,2);
P_CTD2022(ind,2)=DataS(:,1);
SP_CTD2022(ind,2)=DataS(:,3);
SA_CTD2022(ind,2)=DataS(:,4);
TC_CTD2022(ind,2)=DataS(:,5);
O_CTD2022(ind,2)=DataS(:,6);
sigmat_CTD2022(ind,2)=DataS(:,7);
AOU_CTD2022(ind,2)=DataS(:,8);
% Estacion 03
Data=CTD_E03;
[DataS]= InterpDatos_CTD(Data,E03);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2022(ind,3)=DataS(:,2);
P_CTD2022(ind,3)=DataS(:,1);
SP_CTD2022(ind,3)=DataS(:,3);
SA_CTD2022(ind,3)=DataS(:,4);
TC_CTD2022(ind,3)=DataS(:,5);
O_CTD2022(ind,3)=DataS(:,6);
sigmat_CTD2022(ind,3)=DataS(:,7);
AOU_CTD2022(ind,3)=DataS(:,8);
% Estacion 04
Data=CTD_E04;
[DataS]= InterpDatos_CTD(Data,E04);
ind1=find(aux==DataS(1,1));
ind2=find(aux==DataS(end,1));
ind=[ind1:ind2]';

T_CTD2022(ind,4)=DataS(:,2);
P_CTD2022(ind,4)=DataS(:,1);
SP_CTD2022(ind,4)=DataS(:,3);
SA_CTD2022(ind,4)=DataS(:,4);
TC_CTD2022(ind,4)=DataS(:,5);
O_CTD2022(ind,4)=DataS(:,6);
sigmat_CTD2022(ind,4)=DataS(:,7);
AOU_CTD2022(ind,4)=DataS(:,8);
clear E0*; clear CTD*; clear ind*; clear aux; clear Data*;
if sd
    vars = whos;  % Get a list of all variables
    vars_to_save = setdiff({vars.name}, {'sd','data_dir','figure_dir'});  % Exclude 'sd' from the list
    save(fullfile(data_dir,'CTD/','All_CTD_data.mat'), vars_to_save{:});  % Save the remaining variables
end   
