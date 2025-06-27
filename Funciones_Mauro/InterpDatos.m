function [DataFast, DataSlow]= InterpDatos(Data,ql_info,Coords)
%function [DataFast, DataSlow]= InterpDatos(Data,ql_info,Latlon)
% DataFast=[data_Pfast, data_ShBP1, data_ShBP2, data_ShHP1, data_ShHP2];
% DataSlow=[data_P, data_e1, data_e2, data_TC, data_SA, data_rho, data_alpha, data_beta, ...
%     data_dT, data_dSA, data_drhodP, data_nu, data_N2,Chi_data_e1,Chi_data_e2,data_Tu,...
%     data_Lo1,data_Lo2,tt,data_FM1,data_FM2,data_QC1,data_QC2];

out= quick_look(Data,[],[],ql_info,'make_figures',false);

aux1=str2double(Data(end-2:end));
if aux1==9 || aux1==10 || aux1==11 || aux1==12
    % PARAMETROS PARA XI
    ChiOpt.fastR=1.2; % impatient
    ChiOpt.tplot=0;
    ChiOpt.segment=1:1:length(out.speed);%seg;%
    ChiOpt.dec=0.7;
    out.scalar_spectra.scalar_spec=out.scalar_spectra.scalar_spec(:,1,:);
    RSIspeT=out.scalar_spectra;
    SpecT=freqTcorrect(RSIspeT);
    SpecT.dof=out.dof_spec(1);
    %vF={'kd','nu'};
    SpecT.nu=out.nu;
    SpecT.kd=out.nu/7;
else
    % PARAMETROS PARA XI
    ChiOpt.fastR=1.2; % impatient
    ChiOpt.tplot=0;
    ChiOpt.segment=1:1:length(out.speed);%seg;%
    ChiOpt.dec=0.7;
    RSIspeT=out.scalar_spectra;
    SpecT=freqTcorrect(RSIspeT);
    SpecT.dof=out.dof_spec(1);
    %vF={'kd','nu'};
    SpecT.nu=out.nu;
    SpecT.kd=out.nu/7;

end

data_FM1=out.FM(1,:)';
data_FM2=out.FM(2,:)';
data_QC1=out.flag(1,:)';
data_QC2=out.flag(2,:)';
t_ = out.filetime;
t_ = addtodate(t_, -1, 'second');
t_ = datetime(t_,'ConvertFrom','datenum');
tt=t_+seconds(out.t);
data_e1=out.e(1,:)';
data_e2=out.e(2,:)';
% Determinacion de CHI
% [ChiF_data_e1,ChiI_data_e1,~]=calc_chi_profile(SpecT,data_e1,ChiOpt);
% [ChiF_data_e2,ChiI_data_e2,~]=calc_chi_profile(SpecT,data_e2,ChiOpt);
[~,ChiI_data_e1,~]=calc_chi_profile(SpecT,data_e1,ChiOpt);
[~,ChiI_data_e2,~]=calc_chi_profile(SpecT,data_e2,ChiOpt);

% Chi_data_e1=nanmean([ChiF_data_e1,ChiI_data_e1],2);
% Chi_data_e2=nanmean([ChiF_data_e2,ChiI_data_e2],2);
Chi_data_e1=nanmean([ChiI_data_e1,ChiI_data_e2],2);
Chi_data_e2=nanmean([ChiI_data_e1,ChiI_data_e2],2);
% 
data_ShHP1=out.SH_HP(:,1);
data_ShHP2=out.SH_HP(:,2);
data_ShBP1=out.SH_BP(:,1);
data_ShBP2=out.SH_BP(:,2);
data_Pfast=out.P_fast;
data_nu=out.nu;
[~, ~, data_C, ~, data_T, ~, data_P] = offsets_CTD(Data,ql_info);
data_SP=gsw_SP_from_C(data_C,data_T,data_P);
data_SA=gsw_SA_from_SP(data_SP,data_P,Coords(1),Coords(2));
data_TC=gsw_CT_from_t(data_SA,data_T,data_P);
%[~, data_alpha, data_beta] = gsw_specvol_alpha_beta(data_SA,data_TC,data_P);
data_rho=gsw_rho(data_SA,data_TC,0)-1000;
[data_drhodP, data_rho, ~, ~] = calc_pend(data_rho,data_P,ql_info);
[data_dT,data_TC,~,~] = calc_diff(data_TC,data_P,ql_info);
[data_dSA,data_SA,data_P,~] = calc_diff(data_SA,data_P,ql_info);
[~, data_alpha, data_beta] = gsw_specvol_alpha_beta(data_SA,data_TC,data_P);
data_N2=9.8.*data_drhodP./(data_rho+1000);
data_N2=interpN2(data_N2,data_P);

data_Tu = atan2((data_alpha.*data_dT + data_beta.*data_dSA),(data_alpha.*data_dT - data_beta.*data_dSA));
data_Tu = data_Tu.*(180/pi);
data_Lo1 = sqrt(data_e1)./(sqrt(data_N2).^(3/2));
data_Lo2 = sqrt(data_e2)./(sqrt(data_N2).^(3/2));

%% Indices de intepolacion
i1=mod(floor(min(data_P)),2);
i2=mod(floor(max(data_P)),2);
if i1==0
    P1=floor(min(data_P))+2;
else
    P1=floor(min(data_P))+1;
end
if i2==0
    P2=floor(max(data_P))-2;
else
    P2=floor(max(data_P))-1;
end
Pres1=P1:2:P2;
Pres1=Pres1(:);
Pres2=P1:0.002:P2;
Pres2=Pres2(:);
%%
% - All variables

S = whos; 

% - Get sizes and indices
junk = zeros(size(S,1),2);
for k = 1:size(S,1)
    junk(k,:) = S(k).size; % Get the size of every variable
end
index_fast = find((junk(:,1) == size(data_Pfast,1)) & junk(:,2) == 1); % index_fast points to the fast channels.
index_slow = find((junk(:,1) == size(data_P,1)) & junk(:,2) == 1); % index_slow points to the slow channels.

% - Trim vectors to the profile segment
for k = 1:size(index_fast,1)
    fast_name = S(index_fast(k)).name;
    if string(fast_name)==string('data_Pfast') || string(fast_name)==string('Pres2')
        continue
    else
        eval([fast_name '=' 'interp1(data_Pfast,' S(index_fast(k)).name ',Pres2,"nearest");']); % trim to n
    end
end
data_Pfast=Pres2;

for k = 1:size(index_slow,1)
    slow_name = S(index_slow(k)).name;
    if string(slow_name)==string('data_P') || string(slow_name)==string('Pres1')
        continue
    else    
        eval([slow_name '=' 'interp1(data_P,' S(index_slow(k)).name ',Pres1,"nearest");']);
    end
end
data_P=Pres1;
clear junk

DataFast=[data_Pfast, data_ShBP1, data_ShBP2, data_ShHP1, data_ShHP2];

DataSlow=[data_P, data_e1, data_e2, data_TC, data_SA, data_rho, data_alpha, data_beta, ...
    data_dT, data_dSA, data_drhodP, data_nu, data_N2,Chi_data_e1,Chi_data_e2,data_Tu,...
    data_Lo1,data_Lo2,datenum(tt),data_FM1,data_FM2,data_QC1,data_QC2];
end