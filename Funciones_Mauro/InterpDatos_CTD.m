function [DataSlow]= InterpDatos_CTD(CTD_E01,E01)
% DataSlow=[P_E01_CTD,T_E01_CTD,SP_E01_CTD,SA_E01_CTD,TC_E01_CTD,O_E01_CTD,sigmat_E01_CTD]

% close all; clear all;
% load CTD_0708E.mat
% E01=-[73+36/60+.89/60,36+25/60+.657/60;
%      73+37/60+.002/60,36+25/60+.962/60];
% E01=mean(E01);

T_E01_CTD=CTD_E01(:,2);
P_E01_CTD=CTD_E01(:,1);
SP_E01_CTD=CTD_E01(:,3);
SA_E01_CTD=gsw_SA_from_SP(SP_E01_CTD,P_E01_CTD,E01(1),E01(2));
TC_E01_CTD=gsw_CT_from_t(SA_E01_CTD,T_E01_CTD,P_E01_CTD);
O_E01_CTD=CTD_E01(:,6)*44.6596;
sigmat_E01_CTD=gsw_rho(SA_E01_CTD,TC_E01_CTD,0)-1000;
O2_sat = gsw_O2sol(SA_E01_CTD,T_E01_CTD,P_E01_CTD,E01(1),E01(2));
AOU_E01_CTD=O2_sat-O_E01_CTD;

%% Indices de intepolacion
i1=mod(floor(min(P_E01_CTD)),2);
i2=mod(floor(max(P_E01_CTD)),2);
if i1==0
    P1=floor(min(P_E01_CTD))+2;
else
    P1=floor(min(P_E01_CTD))+1;
end
if i2==0
    P2=floor(max(P_E01_CTD))-2;
else
    P2=floor(max(P_E01_CTD))-1;
end
Pres1=20:2:P2;
Pres1=Pres1(:);
%%
% - All variables

S = whos; 

% - Get sizes and indices
junk = zeros(size(S,1),2);
for k = 1:size(S,1)
    junk(k,:) = S(k).size; % Get the size of every variable
end
index_slow = find((junk(:,1) == size(P_E01_CTD,1)) & junk(:,2) == 1); % index_slow points to the slow channels.

for k = 1:size(index_slow,1)
    slow_name = S(index_slow(k)).name;
    if string(slow_name)==string('P_E01_CTD') || string(slow_name)==string('Pres1')
        continue
    else    
        eval([slow_name '=' 'interp1(P_E01_CTD,' S(index_slow(k)).name ',Pres1);']);
    end
end
P_E01_CTD=Pres1;
clear junk

DataSlow=[P_E01_CTD,T_E01_CTD,SP_E01_CTD,SA_E01_CTD,TC_E01_CTD,O_E01_CTD,sigmat_E01_CTD,AOU_E01_CTD];


end