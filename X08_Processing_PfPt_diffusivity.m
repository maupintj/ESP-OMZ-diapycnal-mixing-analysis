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
Ri2021(isnan(Ri2021))=1.1;
Ri2022=Ri2022_vmp;
Ri2022(isnan(Ri2022))=1.1;

Ri2021_=Ri2021(~isnan(Ri2021));
Ri2022_=Ri2022(~isnan(Ri2022));
Ri2021_=sort(Ri2021_);
Ri2022_=sort(Ri2022_);

% Density ratio
Rrho_2020=(alpha_2020.*dT_2020)./(beta_2020.*dSA_2020);
Rrho_2021=(alpha_2021.*dT_2021)./(beta_2021.*dSA_2021);
Rrho_2022=(alpha_2022.*dT_2022)./(beta_2022.*dSA_2022);

Chit_prom.e=nan(9,1); Chit_std.e=nan(9,1); Chif_prom.e=nan(9,1); Chif_std.e=nan(9,1);
ef_prom.e=nan(9,1); ef_std.e=nan(9,1); et_prom.e=nan(9,1); et_std.e=nan(9,1);

%%%%%%%%%%%%%%%% QUITO MEDIA VARIABLES 2020 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TC_2020sm=nan(size(TC_2020));%sm_sin media
SA_2020sm=nan(size(TC_2020));%sm_sin media
Pslow_2020sm=nan(size(TC_2020));%sm_sin media)
Rho_2020sm=nan(size(TC_2020));%sm_sin media

for i1=1:size(TC_2020,2)
    for i2=1:size(I,2)
        TC_2020sm(I(i2).e(:,i1),i1)=TC_2020(I(i2).e(:,i1),i1)-mean(TC_2020(I(i2).e(:,i1),i1),'omitnan');
        SA_2020sm(I(i2).e(:,i1),i1)=SA_2020(I(i2).e(:,i1),i1)-mean(SA_2020(I(i2).e(:,i1),i1),'omitnan');
        Rho_2020sm(I(i2).e(:,i1),i1)=Rho_2020(I(i2).e(:,i1),i1)-mean(Rho_2020(I(i2).e(:,i1),i1),'omitnan');
        Pslow_2020sm(I(i2).e(:,i1),i1)=Pslow_2020(I(i2).e(:,i1),i1)-mean(Pslow_2020(I(i2).e(:,i1),i1),'omitnan');
    end
end

%%%%%%%%%%%%%%%% QUITO MEDIA VARIABLES 2021 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TC_2021sm=nan(size(TC_2021));%sm_sin media
SA_2021sm=nan(size(TC_2021));%sm_sin media
Pslow_2021sm=nan(size(TC_2021));%sm_sin media)
Rho_2021sm=nan(size(TC_2021));%sm_sin media

for i1=1:size(TC_2021,2)
    for i2=1:size(I,2)
        TC_2021sm(I(i2).j(:,i1),i1)=TC_2021(I(i2).j(:,i1),i1)-mean(TC_2021(I(i2).j(:,i1),i1),'omitnan');
        SA_2021sm(I(i2).j(:,i1),i1)=SA_2021(I(i2).j(:,i1),i1)-mean(SA_2021(I(i2).j(:,i1),i1),'omitnan');
        Rho_2021sm(I(i2).j(:,i1),i1)=Rho_2021(I(i2).j(:,i1),i1)-mean(Rho_2021(I(i2).j(:,i1),i1),'omitnan');
        Pslow_2021sm(I(i2).j(:,i1),i1)=Pslow_2021(I(i2).j(:,i1),i1)-mean(Pslow_2021(I(i2).j(:,i1),i1),'omitnan');
    end
end
%%%%%%%%%%%%%%%% QUITO MEDIA VARIABLES 2022 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TC_2022sm=nan(size(TC_2022));%sm_sin media
SA_2022sm=nan(size(TC_2022));%sm_sin media
Pslow_2022sm=nan(size(TC_2022));%sm_sin media)
Rho_2022sm=nan(size(TC_2022));%sm_sin media

for i1=1:size(TC_2022,2)
    for i2=1:size(I,2)
        TC_2022sm(I(i2).o(:,i1),i1)=TC_2022(I(i2).o(:,i1),i1)-mean(TC_2022(I(i2).o(:,i1),i1),'omitnan');
        SA_2022sm(I(i2).o(:,i1),i1)=SA_2022(I(i2).o(:,i1),i1)-mean(SA_2022(I(i2).o(:,i1),i1),'omitnan');
        Rho_2022sm(I(i2).o(:,i1),i1)=Rho_2022(I(i2).o(:,i1),i1)-mean(Rho_2022(I(i2).o(:,i1),i1),'omitnan');
        Pslow_2022sm(I(i2).o(:,i1),i1)=Pslow_2022(I(i2).o(:,i1),i1)-mean(Pslow_2022(I(i2).o(:,i1),i1),'omitnan');
    end
end
%%%%%%%%%%%%%%%% CALCULO DE VARIABLES PARA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2020 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i1=1:7%numero de intervalos
    clear aux*
    auxTC=TC_2020sm(I(i1).e);
    %auxTC=auxTC-nanmean(auxTC);
    auxSA=SA_2020sm(I(i1).e);
    %auxSA=auxSA-nanmean(auxSA);
    auxP=Pslow_2020sm(I(i1).e);
    %auxP=auxP-nanmean(auxP);
    auxRho=Rho_2020sm(I(i1).e);
    %auxRho=auxRho-nanmean(auxRho);
%     auxa=alpha_2020(I(i1).e);
%     auxa=auxa-nanmean(auxa);
%     auxb=beta_2020(I(i1).e);
%     auxb=auxb-nanmean(auxb);
    auxChi1=Chi1_2020(I(i1).e);
    auxChi2=Chi2_2020(I(i1).e);
    auxChi=mean([auxChi1,auxChi2],2,'omitnan');
    auxe1=e1_2020(I(i1).e);
    auxe2=e2_2020(I(i1).e);
    auxe=mean([auxe1,auxe2],2,'omitnan');
    %AJUSTE LINEAL
    p_TC=polyfit(auxP,auxTC,1);
    p_SA=polyfit(auxP,auxSA,1);
    p_rho=polyfit(auxP,auxRho,1);
    
    figure()
    subplot 311
    plot(auxP,auxTC,'.b','MarkerSize',12)
    hold on
    plot(auxP,p_TC(1)*(auxP)+p_TC(2),'-r')
    hold on
    grid on
    ylabel('Temperatura [°C]')
    xlabel('Presion [dbar]')
    title('2020')
    subplot 312
    plot(auxP,auxSA,'.b','MarkerSize',12)
    hold on
    plot(auxP,p_SA(1)*(auxP)+p_SA(2),'-r')
    hold on
    grid on
    ylabel('Salinidad [g/kg]')
    xlabel('Presion [dbar]')
    subplot 313
    plot(auxP,auxRho,'.b','MarkerSize',12)
    hold on
    plot(auxP,p_rho(1)*(auxP)+p_rho(2),'-r')
    hold on
    grid on
    ylabel('densidad')
    xlabel('Presion [dbar]')
    f=gcf;
    %exportgraphics(f,fullfile(FolderName,strcat(['TSRho_gradients__SM_2020',char(string(i1)),'.png'])),'Resolution',400,'BackgroundColor','white')
    pause(1)
    %pause
    %PRESION
    P_prom(i1).e=mean(Pslow_2020(I(i1).e));
    P_med(i1).e=median(Pslow_2020(I(i1).e));
    P_std(i1).e=std(Pslow_2020(I(i1).e));
    P_min(i1).e=min(Pslow_2020(I(i1).e));
    P_max(i1).e=max(Pslow_2020(I(i1).e));

    %Temperatura
    dTCdP(i1).e=p_TC(1);
    S_TC(i1).e=sqrt(sum((auxTC-(p_TC(1)*(auxP)+p_TC(2))).^2)/(length(auxTC)-2));
    Err_TC(i1).e=S_TC(i1).e/sqrt(sum((auxP-mean(auxP)).^2));
    TC_prom(i1).e=mean(TC_2020(I(i1).e));
    TC_med(i1).e=median(TC_2020(I(i1).e));
    TC_std(i1).e=std(TC_2020(I(i1).e));

    %Salinidad
    dSAdP(i1).e=p_SA(1);
    S_SA(i1).e=sqrt(sum((auxSA-(p_SA(1)*(auxP)+p_SA(2))).^2)/(length(auxSA)-2));
    Err_SA(i1).e=S_SA(i1).e/sqrt(sum((auxP-mean(auxP)).^2));    
    SA_prom(i1).e=mean(SA_2020(I(i1).e));
    SA_med(i1).e=median(SA_2020(I(i1).e));
    SA_std(i1).e=std(SA_2020(I(i1).e));

    %Rho
    drhodP(i1).e=p_rho(1);
    S_rho(i1).e=sqrt(sum((auxRho-(p_rho(1)*(auxP)+p_rho(2))).^2)/(length(auxRho)-2));
    Err_rho(i1).e=S_rho(i1).e/sqrt(sum((auxP-mean(auxP)).^2));
    Rho_prom(i1).e=mean(Rho_2020(I(i1).e));
    Rho_med(i1).e=median(Rho_2020(I(i1).e));
    Rho_std(i1).e=std(Rho_2020(I(i1).e));

    %ALPHA
    alpha_prom(i1).e=mean(alpha_2020(I(i1).e));
    alpha_med(i1).e=median(alpha_2020(I(i1).e));
    alpha_std(i1).e=std(alpha_2020(I(i1).e));

    %BETA
    beta_prom(i1).e=mean(beta_2020(I(i1).e));
    beta_med(i1).e=median(beta_2020(I(i1).e));
    beta_std(i1).e=std(beta_2020(I(i1).e));   

    %Peso
    auxRrho=Rrho_2020(I(i1).e);
    auxRi=Ri2020(I(i1).e);
    aux_f=(auxRrho>1 & auxRrho<2) & auxRi>1;
    aux_t=~aux_f;
    Peso_f(i1).e=length(find(aux_f))/length(aux_f);
    Peso_t(i1).e=length(find(aux_t))/length(aux_t);
    try
    %EPSILON FINGER
    statse = bootstrp(length(auxe(aux_f))*8,@(x)[nanmean(x)],auxe(aux_f));
    ef_prom(i1).e=mean(statse);
    ef_std(i1).e=std(statse);

    %CHI FINGER
    statschi = bootstrp(length(auxChi(aux_f))*8,@(x)[nanmean(x)],auxChi(aux_f));
    Chif_prom(i1).e=mean(statschi);
    Chif_std(i1).e=std(statschi);
    end
    try
    %EPSILON TURBULENCE
    statse = bootstrp(length(auxe(aux_t))*8,@(x)[nanmean(x)],auxe(aux_t));
    et_prom(i1).e=mean(statse);
    et_std(i1).e=std(statse);

    %CHI TURBULENCE
    statschi = bootstrp(length(auxChi(aux_t))*8,@(x)[nanmean(x)],auxChi(aux_t));
    Chit_prom(i1).e=mean(statschi);
    Chit_std(i1).e=std(statschi);
    end
end
%%%%%%%%%%%%%%%% CALCULO DE VARIABLES PARA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2021 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i1=1:7%numero de intervalos
    clear aux*
    auxTC=TC_2021sm(I(i1).j);
    %auxTC=auxTC-nanmean(auxTC);
    auxSA=SA_2021sm(I(i1).j);
    %auxSA=auxSA-nanmean(auxSA);
    auxP=Pslow_2021sm(I(i1).j);
    %auxP=auxP-nanmean(auxP);
    auxRho=Rho_2021sm(I(i1).j);
    %auxRho=auxRho-nanmean(auxRho);
%     auxa=alpha_2021(I(i1).j);
%     auxa=auxa-nanmean(auxa);
%     auxb=beta_2021(I(i1).j);
%     auxb=auxb-nanmean(auxb);
    auxChi1=Chi1_2021(I(i1).j);
    auxChi2=Chi2_2021(I(i1).j);
    auxChi=mean([auxChi1,auxChi2],2,'omitnan');
    auxe1=e1_2021(I(i1).j);
    auxe2=e2_2021(I(i1).j);
    auxe=mean([auxe1,auxe2],2,'omitnan');
    %AJUSTE LINEAL
    p_TC=polyfit(auxP,auxTC,1);
    p_SA=polyfit(auxP,auxSA,1);
    p_rho=polyfit(auxP,auxRho,1);
    
    figure()
    subplot 311
    plot(auxP,auxTC,'.b','MarkerSize',12)
    hold on
    plot(auxP,p_TC(1)*(auxP)+p_TC(2),'-r')
    legend("TC",strcat("M1: ",string(p_TC(1))))
    hold on
    grid on
    ylabel('Temperatura [°C]')
    xlabel('Presion [dbar]')
    title('2021')
    subplot 312
    plot(auxP,auxSA,'.b','MarkerSize',12)
    hold on
    plot(auxP,p_SA(1)*(auxP)+p_SA(2),'-r')
    hold on
    grid on
    ylabel('Salinidad [g/kg]')
    xlabel('Presion [dbar]')
    subplot 313
    plot(auxP,auxRho,'.b','MarkerSize',12)
    hold on
    plot(auxP,p_rho(1)*(auxP)+p_rho(2),'-r')
    hold on
    grid on
    ylabel('densidad')
    xlabel('Presion [dbar]')
    %pause
    f=gcf;
    %exportgraphics(f,fullfile(FolderName,strcat(['TSRho_gradients__SM',char(string(i1)),'.png'])),'Resolution',400,'BackgroundColor','white')
    pause(1)
    %PRESION
    P_prom(i1).j=mean(Pslow_2021(I(i1).j));
    P_med(i1).j=median(Pslow_2021(I(i1).j));
    P_std(i1).j=std(Pslow_2021(I(i1).j));
    P_min(i1).j=min(Pslow_2021(I(i1).j));
    P_max(i1).j=max(Pslow_2021(I(i1).j));

    %Temperatura
    dTCdP(i1).j=p_TC(1);
    S_TC(i1).j=sqrt(sum((auxTC-(p_TC(1)*(auxP)+p_TC(2))).^2)/(length(auxTC)-2));
    Err_TC(i1).j=S_TC(i1).j/sqrt(sum((auxP-mean(auxP)).^2));
    TC_prom(i1).j=mean(TC_2021(I(i1).j));
    TC_med(i1).j=median(TC_2021(I(i1).j));
    TC_std(i1).j=std(TC_2021(I(i1).j));

    %Salinidad
    dSAdP(i1).j=p_SA(1);
    S_SA(i1).j=sqrt(sum((auxSA-(p_SA(1)*(auxP)+p_SA(2))).^2)/(length(auxSA)-2));
    Err_SA(i1).j=S_SA(i1).j/sqrt(sum((auxP-mean(auxP)).^2));    
    SA_prom(i1).j=mean(SA_2021(I(i1).j));
    SA_med(i1).j=median(SA_2021(I(i1).j));
    SA_std(i1).j=std(SA_2021(I(i1).j));

    %Rho
    drhodP(i1).j=p_rho(1);
    S_rho(i1).j=sqrt(sum((auxRho-(p_rho(1)*(auxP)+p_rho(2))).^2)/(length(auxRho)-2));
    Err_rho(i1).j=S_rho(i1).j/sqrt(sum((auxP-mean(auxP)).^2));
    Rho_prom(i1).j=mean(Rho_2021(I(i1).j));
    Rho_med(i1).j=median(Rho_2021(I(i1).j));
    Rho_std(i1).j=std(Rho_2021(I(i1).j));

    %ALPHA
    alpha_prom(i1).j=mean(alpha_2021(I(i1).j));
    alpha_med(i1).j=median(alpha_2021(I(i1).j));
    alpha_std(i1).j=std(alpha_2021(I(i1).j));

    %BETA
    beta_prom(i1).j=mean(beta_2021(I(i1).j));
    beta_med(i1).j=median(beta_2021(I(i1).j));
    beta_std(i1).j=std(beta_2021(I(i1).j));   

    %Peso
    auxRrho=Rrho_2021(I(i1).j);
    auxRi=Ri2021(I(i1).j);
    aux_f=(auxRrho>1 & auxRrho<2) & auxRi>1;
    aux_t=~aux_f;
    Peso_f(i1).j=length(find(aux_f))/length(aux_f);
    Peso_t(i1).j=length(find(aux_t))/length(aux_t);
    try
    %EPSILON FINGER
    statse = bootstrp(length(auxe(aux_f))*8,@(x)[nanmean(x)],auxe(aux_f));
    ef_prom(i1).j=mean(statse);
    ef_std(i1).j=std(statse);
    end
    try
    %CHI FINGER
    statschi = bootstrp(length(auxChi(aux_f))*8,@(x)[nanmean(x)],auxChi(aux_f));
    Chif_prom(i1).j=mean(statschi);
    Chif_std(i1).j=std(statschi);
    end
    try
    %EPSILON TURBULENCE
    statse = bootstrp(length(auxe(aux_t))*8,@(x)[nanmean(x)],auxe(aux_t));
    et_prom(i1).j=mean(statse);
    et_std(i1).j=std(statse);
    end
    try
    %CHI TURBULENCE
    statschi = bootstrp(length(auxChi(aux_t))*8,@(x)[nanmean(x)],auxChi(aux_t));
    Chit_prom(i1).j=mean(statschi);
    Chit_std(i1).j=std(statschi);
    end
end
%%%%%%%%%%%%%%%% CALCULO DE VARIABLES PARA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2022 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i1=1:7%numero de intervalos
    clear aux*
    auxTC=TC_2022sm(I(i1).o);
    %auxTC=auxTC-nanmean(auxTC);
    auxSA=SA_2022sm(I(i1).o);
    %auxSA=auxSA-nanmean(auxSA);
    auxP=Pslow_2022sm(I(i1).o);
    %auxP=auxP-nanmean(auxP);
    auxRho=Rho_2022sm(I(i1).o);
    %auxRho=auxRho-nanmean(auxRho);
%     auxa=alpha_2022(I(i1).o);
%     auxa=auxa-nanmean(auxa);
%     auxb=beta_2022(I(i1).o);
%     auxb=auxb-nanmean(auxb);
    auxChi1=Chi1_2022(I(i1).o);
    auxChi2=Chi2_2022(I(i1).o);
    auxChi=mean([auxChi1,auxChi2],2,'omitnan');
    auxe1=e1_2022(I(i1).o);
    auxe2=e2_2022(I(i1).o);
    auxe=mean([auxe1,auxe2],2,'omitnan');
    %AJUSTE LINEAL
    p_TC=polyfit(auxP,auxTC,1);
    p_SA=polyfit(auxP,auxSA,1);
    p_rho=polyfit(auxP,auxRho,1);
    
    figure()
    subplot 311
    plot(auxP,auxTC,'.b','MarkerSize',12)
    hold on
    plot(auxP,p_TC(1)*(auxP)+p_TC(2),'-r')
    hold on
    grid on
    ylabel('Temperatura [°C]')
    xlabel('Presion [dbar]')
    title('2022')
    subplot 312
    plot(auxP,auxSA,'.b','MarkerSize',12)
    hold on
    plot(auxP,p_SA(1)*(auxP)+p_SA(2),'-r')
    hold on
    grid on
    ylabel('Salinidad [g/kg]')
    xlabel('Presion [dbar]')
    subplot 313
    plot(auxP,auxRho,'.b','MarkerSize',12)
    hold on
    plot(auxP,p_rho(1)*(auxP)+p_rho(2),'-r')
    hold on
    grid on
    ylabel('densidad')
    xlabel('Presion [dbar]')
    %pause
    %PRESION
    P_prom(i1).o=mean(Pslow_2022(I(i1).o));
    P_med(i1).o=median(Pslow_2022(I(i1).o));
    P_std(i1).o=std(Pslow_2022(I(i1).o));
    P_min(i1).o=min(Pslow_2022(I(i1).o));
    P_max(i1).o=max(Pslow_2022(I(i1).o));

    %Temperatura
    dTCdP(i1).o=p_TC(1);
    S_TC(i1).o=sqrt(sum((auxTC-(p_TC(1)*(auxP)+p_TC(2))).^2)/(length(auxTC)-2));
    Err_TC(i1).o=S_TC(i1).o/sqrt(sum((auxP-mean(auxP)).^2));
    TC_prom(i1).o=mean(TC_2022(I(i1).o));
    TC_med(i1).o=median(TC_2022(I(i1).o));
    TC_std(i1).o=std(TC_2022(I(i1).o));

    %Salinidad
    dSAdP(i1).o=p_SA(1);
    S_SA(i1).o=sqrt(sum((auxSA-(p_SA(1)*(auxP)+p_SA(2))).^2)/(length(auxSA)-2));
    Err_SA(i1).o=S_SA(i1).o/sqrt(sum((auxP-mean(auxP)).^2));    
    SA_prom(i1).o=mean(SA_2022(I(i1).o));
    SA_med(i1).o=median(SA_2022(I(i1).o));
    SA_std(i1).o=std(SA_2022(I(i1).o));

    %Rho
    drhodP(i1).o=p_rho(1);
    S_rho(i1).o=sqrt(sum((auxRho-(p_rho(1)*(auxP)+p_rho(2))).^2)/(length(auxRho)-2));
    Err_rho(i1).o=S_rho(i1).o/sqrt(sum((auxP-mean(auxP)).^2));
    Rho_prom(i1).o=mean(Rho_2022(I(i1).o));
    Rho_med(i1).o=median(Rho_2022(I(i1).o));
    Rho_std(i1).o=std(Rho_2022(I(i1).o));

    %ALPHA
    alpha_prom(i1).o=mean(alpha_2022(I(i1).o));
    alpha_med(i1).o=median(alpha_2022(I(i1).o));
    alpha_std(i1).o=std(alpha_2022(I(i1).o));

    %BETA
    beta_prom(i1).o=mean(beta_2022(I(i1).o));
    beta_med(i1).o=median(beta_2022(I(i1).o));
    beta_std(i1).o=std(beta_2022(I(i1).o));   

    %Peso
    auxRrho=Rrho_2022(I(i1).o);
    auxRi=Ri2022(I(i1).o);
    aux_f=(auxRrho>1 & auxRrho<2) & auxRi>1;
    aux_t=~aux_f;
    Peso_f(i1).o=length(find(aux_f))/length(aux_f);
    Peso_t(i1).o=length(find(aux_t))/length(aux_t);
        
    try
    %EPSILON FINGER
    statse = bootstrp(length(auxe(aux_f))*8,@(x)[nanmean(x)],auxe(aux_f));
    ef_prom(i1).o=mean(statse);
    ef_std(i1).o=std(statse);

    %CHI FINGER
    statschi = bootstrp(length(auxChi(aux_f))*8,@(x)[nanmean(x)],auxChi(aux_f));
    Chif_prom(i1).o=mean(statschi);
    Chif_std(i1).o=std(statschi);
    end
    try
    %EPSILON TURBULENCE
    statse = bootstrp(length(auxe(aux_t))*8,@(x)[nanmean(x)],auxe(aux_t));
    et_prom(i1).o=mean(statse);
    et_std(i1).o=std(statse);

    %CHI TURBULENCE
    statschi = bootstrp(length(auxChi(aux_t))*8,@(x)[nanmean(x)],auxChi(aux_t));
    Chit_prom(i1).o=mean(statschi);
    Chit_std(i1).o=std(statschi);
    end
end
for i1=1:7
%%%%%%%%%%%%%%%  CALCULO DE DIFUSIVIDADES   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2020 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Razon de densidad gran escala
    Rrho_GE(i1).e=alpha_prom(i1).e.*dTCdP(i1).e./(beta_prom(i1).e.*dSAdP(i1).e);
    Err_Rrho_GE(i1).e=abs(Rrho_GE(i1).e).*sqrt((Err_TC(i1).e./dTCdP(i1).e).^2+(Err_SA(i1).e./dSAdP(i1).e).^2);

    % Frecuencia brunt vaisalla gran escala
    N2_GE(i1).e=9.8.*drhodP(i1).e./(Rho_prom(i1).e+1000);
    Err_N2_GE(i1).e=N2_GE(i1).e.*sqrt((Err_rho(i1).e./drhodP(i1).e).^2+(Rho_std(i1).e./(Rho_prom(i1).e+1000)).^2);

    %Peso
    Peso_f(i1).e=round(Peso_f(i1).e*100)/100;
    Peso_t(i1).e=round(Peso_t(i1).e*100)/100;

    Kst(i1).e=0.2*et_prom(i1).e./N2_GE(i1).e;
    Err_Kst(i1).e=Kst(i1).e.*sqrt((et_std(i1).e./et_prom(i1).e).^2+(Err_N2_GE(i1).e./N2_GE(i1).e).^2);

    Ktf(i1).e=0.5*Chif_prom(i1).e./(dTCdP(i1).e.^2);
    Err_Ktf(i1).e=Ktf(i1).e.*sqrt((Chif_std(i1).e./Chif_prom(i1).e).^2+(2*Err_TC(i1).e./dTCdP(i1).e).^2);

    r=0.6;
    Err_r=0.04;

    Ksf(i1).e=Rrho_GE(i1).e.*Ktf(i1).e/r;
    Err_Ksf(i1).e=Ksf(i1).e.*sqrt((Err_Rrho_GE(i1).e./Rrho_GE(i1).e).^2+(Err_Ktf(i1).e./Ktf(i1).e).^2+(Err_r./r).^2);
%%%%%%%%%%%%%%%  CALCULO DE DIFUSIVIDADES   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2021 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Razon de densidad gran escala
    Rrho_GE(i1).j=alpha_prom(i1).j.*dTCdP(i1).j./(beta_prom(i1).j.*dSAdP(i1).j);
    Err_Rrho_GE(i1).j=abs(Rrho_GE(i1).j).*sqrt((Err_TC(i1).j./dTCdP(i1).j).^2+(Err_SA(i1).j./dSAdP(i1).j).^2);

    % Frecuencia brunt vaisalla gran escala
    N2_GE(i1).j=9.8.*drhodP(i1).j./(Rho_prom(i1).j+1000);
    Err_N2_GE(i1).j=N2_GE(i1).j.*sqrt((Err_rho(i1).j./drhodP(i1).j).^2+(Rho_std(i1).j./(Rho_prom(i1).j+1000)).^2);

    %Peso
    Peso_f(i1).j=round(Peso_f(i1).j*100)/100;
    Peso_t(i1).j=round(Peso_t(i1).j*100)/100;

    Kst(i1).j=0.2*et_prom(i1).j./N2_GE(i1).j;
    Err_Kst(i1).j=Kst(i1).j.*sqrt((et_std(i1).j./et_prom(i1).j).^2+(Err_N2_GE(i1).j./N2_GE(i1).j).^2);

    Ktf(i1).j=0.5*Chif_prom(i1).j./(dTCdP(i1).j.^2);
    Err_Ktf(i1).j=Ktf(i1).j.*sqrt((Chif_std(i1).j./Chif_prom(i1).j).^2+(2*Err_TC(i1).j./dTCdP(i1).j).^2);

    r=0.6;
    Err_r=0.04;

    Ksf(i1).j=Rrho_GE(i1).j.*Ktf(i1).j/r;
    Err_Ksf(i1).j=Ksf(i1).j.*sqrt((Err_Rrho_GE(i1).j./Rrho_GE(i1).j).^2+(Err_Ktf(i1).j./Ktf(i1).j).^2+(Err_r./r).^2);

%%%%%%%%%%%%%%%  CALCULO DE DIFUSIVIDADES   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2022 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Razon de densidad gran escala
    Rrho_GE(i1).o=alpha_prom(i1).o.*dTCdP(i1).o./(beta_prom(i1).o.*dSAdP(i1).o);
    Err_Rrho_GE(i1).o=abs(Rrho_GE(i1).o).*sqrt((Err_TC(i1).o./dTCdP(i1).o).^2+(Err_SA(i1).o./dSAdP(i1).o).^2);

    % Frecuencia brunt vaisalla gran escala
    N2_GE(i1).o=9.8.*drhodP(i1).o./(Rho_prom(i1).o+1000);
    Err_N2_GE(i1).o=N2_GE(i1).o.*sqrt((Err_rho(i1).o./drhodP(i1).o).^2+(Rho_std(i1).o./(Rho_prom(i1).o+1000)).^2);

    %Peso
    Peso_f(i1).o=round(Peso_f(i1).o*100)/100;
    Peso_t(i1).o=round(Peso_t(i1).o*100)/100;

    Kst(i1).o=0.2*et_prom(i1).o./N2_GE(i1).o;
    Err_Kst(i1).o=Kst(i1).o.*sqrt((et_std(i1).o./et_prom(i1).o).^2+(Err_N2_GE(i1).o./N2_GE(i1).o).^2);

    Ktf(i1).o=0.5*Chif_prom(i1).o./(dTCdP(i1).o.^2);
    Err_Ktf(i1).o=Ktf(i1).o.*sqrt((Chif_std(i1).o./Chif_prom(i1).o).^2+(2*Err_TC(i1).o./dTCdP(i1).o).^2);

    r=0.6;
    Err_r=0.04;

    Ksf(i1).o=Rrho_GE(i1).o.*Ktf(i1).o/r;
    Err_Ksf(i1).o=Ksf(i1).o.*sqrt((Err_Rrho_GE(i1).o./Rrho_GE(i1).o).^2+(Err_Ktf(i1).o./Ktf(i1).o).^2+(Err_r./r).^2);

end
% DIFUSIVIDAD
%LIMPIEZA FINAL
for i1=1:7
    if Peso_f(i1).e<0.11 | Rrho_GE(i1).e<1
        Peso_f(i1).e=0;
        Peso_t(i1).e=1;
        Chif_prom(i1).e=0;
        Chif_std(i1).e=0;
        Ksf(i1).e=0;
        Err_Ksf(i1).e=0;
        
    end
    if Peso_f(i1).j<0.11 | Rrho_GE(i1).j<1
        Peso_f(i1).j=0;
        Peso_t(i1).j=1;
        Chif_prom(i1).j=0;
        Chif_std(i1).j=0;
        Ksf(i1).j=0;
        Err_Ksf(i1).j=0;

    end
    if Peso_f(i1).o<0.11 | Rrho_GE(i1).o<1
        Peso_f(i1).o=0;
        Peso_t(i1).o=1;
        Chif_prom(i1).o=0;
        Chif_std(i1).o=0;
        Ksf(i1).o=0;
        Err_Ksf(i1).o=0;
    end
end


for i1=1:7
    K(i1).e=Peso_t(i1).e.*Kst(i1).e+Ksf(i1).e.*Peso_f(i1).e;
    Err_K(i1).e=sqrt((Peso_t(i1).e.*Err_Kst(i1).e).^2+(Peso_f(i1).e.*Err_Ksf(i1).e).^2);

    K(i1).j=Peso_t(i1).j.*Kst(i1).j+Ksf(i1).j.*Peso_f(i1).j;
    Err_K(i1).j=sqrt((Peso_t(i1).j.*Err_Kst(i1).j).^2+(Peso_f(i1).j.*Err_Ksf(i1).j).^2);

    K(i1).o=Peso_t(i1).o.*Kst(i1).o+Ksf(i1).o.*Peso_f(i1).o;
    Err_K(i1).o=sqrt((Peso_t(i1).o.*Err_Kst(i1).o).^2+(Peso_f(i1).o.*Err_Ksf(i1).o).^2);
end
%% Construccion grafico final
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%% ENERO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
set(gcf,'position',[10,10,1200,800])
subplot 131
hold on
for i1=1:7
    plot([Rrho_GE(i1).e(1) Rrho_GE(i1).e(1)],[P_min(i1).e(1) P_max(i1).e(1)],'-','color','#6495ED','LineWidth',2)
    plot([Rrho_GE(i1).e(1)-Err_Rrho_GE(i1).e(1) Rrho_GE(i1).e(1)+Err_Rrho_GE(i1).e(1)],[P_prom(i1).e(1) P_prom(i1).e(1)],'-r','LineWidth',2)
end
set(gca,'Ydir','Reverse')
grid on
ylim([20 max(max(Pslow_2020))]);
xlim([-16 13])
box on
subplot 132
hold on
for i1=1:7
    plot([N2_GE(i1).e(1) N2_GE(i1).e(1)]*10000,[P_min(i1).e(1) P_max(i1).e(1)],'-','color','#6495ED','LineWidth',2)
    plot([N2_GE(i1).e(1)-Err_N2_GE(i1).e(1) N2_GE(i1).e(1)+Err_N2_GE(i1).e(1)]*10000,[P_prom(i1).e(1) P_prom(i1).e(1)],'-r','LineWidth',2)
end
set(gca,'Ydir','Reverse')
grid on
ylim([20 max(max(Pslow_2020))]);
box on
set(gca,'yticklabel',[]);
xlim([0 1.5])
subplot 133
hold on
for i1=1:7
    plot([K(i1).e(1) K(i1).e(1)],[P_min(i1).e(1) P_max(i1).e(1)],'-','color','#6495ED','LineWidth',2)
    plot([K(i1).e(1)-Err_K(i1).e(1) K(i1).e(1)+Err_K(i1).e(1)],[P_prom(i1).e(1) P_prom(i1).e(1)],'-r','LineWidth',2)
    %pause
end
set(gca,'Ydir','Reverse')
grid on
ylim([20 max(max(Pslow_2020))]);
box on
set(gca,'yticklabel',[]);
set(gca, 'XScale', 'log');
xlim([1e-6 1e-2])
%print('-dpng',fullfile(FolderName,['K_Enero_intP']),'-r400')

%%%%%%%%%%%%%%%%%%%%%%%%%%% Julio %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
set(gcf,'position',[10,10,1200,800])
subplot 131
hold on
for i1=1:7
    plot([Rrho_GE(i1).j(1) Rrho_GE(i1).j(1)],[P_min(i1).j(1) P_max(i1).j(1)],'-','color','#6495ED','LineWidth',2)
    plot([Rrho_GE(i1).j(1)-Err_Rrho_GE(i1).j(1) Rrho_GE(i1).j(1)+Err_Rrho_GE(i1).j(1)],[P_prom(i1).j(1) P_prom(i1).j(1)],'-r','LineWidth',2)
end
set(gca,'Ydir','Reverse')
grid on
ylim([20 max(max(Pslow_2020))]);
xlim([-16 13])
box on

subplot 132
hold on
for i1=1:7
    plot([N2_GE(i1).j(1) N2_GE(i1).j(1)]*10000,[P_min(i1).j(1) P_max(i1).j(1)],'-','color','#6495ED','LineWidth',2)
    plot([N2_GE(i1).j(1)-Err_N2_GE(i1).j(1) N2_GE(i1).j(1)+Err_N2_GE(i1).j(1)]*10000,[P_prom(i1).j(1) P_prom(i1).j(1)],'-r','LineWidth',2)
end
set(gca,'Ydir','Reverse')
grid on
ylim([20 max(max(Pslow_2020))]);
box on
set(gca,'yticklabel',[]);
xlim([0 1.5])
subplot 133
hold on
for i1=1:7
    plot([K(i1).j(1) K(i1).j(1)],[P_min(i1).j(1) P_max(i1).j(1)],'-','color','#6495ED','LineWidth',2)
    plot([K(i1).j(1)-Err_K(i1).j(1) K(i1).j(1)+Err_K(i1).j(1)],[P_prom(i1).j(1) P_prom(i1).j(1)],'-r','LineWidth',2)
    %pause
end
set(gca,'Ydir','Reverse')
grid on
ylim([20 max(max(Pslow_2020))]);
box on
set(gca,'yticklabel',[]);
set(gca, 'XScale', 'log');
xlim([1e-6 1e-2])
%print('-dpng',fullfile(FolderName,['K_Julio_intP']),'-r400')


%%%%%%%%%%%%%%%%%%%%%%%%%%% OCTUBRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure()
set(gcf,'position',[10,10,1200,800])
subplot 131
hold on
for i1=1:7
    plot([Rrho_GE(i1).o(1) Rrho_GE(i1).o(1)],[P_min(i1).o(1) P_max(i1).o(1)],'-','color','#6495ED','LineWidth',2)
    plot([Rrho_GE(i1).o(1)-Err_Rrho_GE(i1).o(1) Rrho_GE(i1).o(1)+Err_Rrho_GE(i1).o(1)],[P_prom(i1).o(1) P_prom(i1).o(1)],'-r','LineWidth',2)
end
set(gca,'Ydir','Reverse')
grid on
ylim([20 max(max(Pslow_2020))]);
xlim([-16 13])
box on
subplot 132
hold on
for i1=1:7
    plot([N2_GE(i1).o(1) N2_GE(i1).o(1)]*10000,[P_min(i1).o(1) P_max(i1).o(1)],'-','color','#6495ED','LineWidth',2)
    plot([N2_GE(i1).o(1)-Err_N2_GE(i1).o(1) N2_GE(i1).o(1)+Err_N2_GE(i1).o(1)]*10000,[P_prom(i1).o(1) P_prom(i1).o(1)],'-r','LineWidth',2)
end
set(gca,'Ydir','Reverse')
grid on
ylim([20 max(max(Pslow_2020))]);
box on
set(gca,'yticklabel',[]);
xlim([0 1.5])
subplot 133
hold on
for i1=1:7
    plot([K(i1).o(1) K(i1).o(1)],[P_min(i1).o(1) P_max(i1).o(1)],'-','color','#6495ED','LineWidth',2)
    plot([K(i1).o(1)-Err_K(i1).o(1) K(i1).o(1)+Err_K(i1).o(1)],[P_prom(i1).o(1) P_prom(i1).o(1)],'-r','LineWidth',2)
    %pause
end
set(gca,'Ydir','Reverse')
grid on
ylim([20 max(max(Pslow_2020))]);
box on
set(gca,'yticklabel',[]);
set(gca, 'XScale', 'log');
xlim([1e-6 1e-2])
%print('-dpng',fullfile(FolderName,['K_Octubre_intP']),'-r400')
%%
%%%%%%%%%%%%%%%%%%%    CALCULO FLUJO DE OXIGENO    %%%%%%%%%%%%%%%%%%%%%%%%
for i1=1:7
    % ENERO
    flujo(i1).e=round((-K(i1).e.*-dOdP(i1).e*24*60*60)*1000)/1000;%%(\mu mol/L) (m) (1/day) 
    err_Flujo(i1).e=round((abs(flujo(i1).e).*sqrt((Err_K(i1).e./K(i1).e).^2+(Err_O(i1).e./dOdP(i1).e).^2))*1000)/1000;
    % JULIO
    flujo(i1).j=round((-K(i1).j.*-dOdP(i1).j*24*60*60)*1000)/1000;%*100%Paso de mmol m s-1 a mmol m dia-1
    err_Flujo(i1).j=round((abs(flujo(i1).j).*sqrt((Err_K(i1).j./K(i1).j).^2+(Err_O(i1).j./dOdP(i1).j).^2))*1000)/1000;
    % ENERO
    flujo(i1).o=round((-K(i1).o.*-dOdP(i1).o*24*60*60)*1000)/1000;%*100%Paso de mmol m s-1 a mmol m dia-1
    err_Flujo(i1).o=round((abs(flujo(i1).o).*sqrt((Err_K(i1).o./K(i1).o).^2+(Err_O(i1).o./dOdP(i1).o).^2))*1000)/1000;
end
%%%%%%%%%%%%%%%  CALCULO DIVERGENCIA DE OXIGENO   %%%%%%%%%%%%%%%%%%%%%%%%%

for i1=1:6
    divF(i1).e=round((-(flujo(i1+1).e-flujo(i1).e)./(P_prom(i1+1).e-P_prom(i1).e))*100000)/100000; %(\mu mol/L) (1/day) 
    err_divF(i1).e=round((abs(divF(i1).e).*sqrt(((err_Flujo(i1+1).e-err_Flujo(i1).e)./(flujo(i1+1).e-flujo(i1).e)).^2+((P_std(i1+1).e-P_std(i1).e)./(P_prom(i1+1).e-P_prom(i1).e)).^2))*100000)/100000;

    divF(i1).j=round((-(flujo(i1+1).j-flujo(i1).j)./(P_prom(i1+1).j-P_prom(i1).j))*100000)/100000;
    err_divF(i1).j=round((abs(divF(i1).j).*sqrt(((err_Flujo(i1+1).j-err_Flujo(i1).j)./(flujo(i1+1).j-flujo(i1).j)).^2+((P_std(i1+1).j-P_std(i1).j)./(P_prom(i1+1).j-P_prom(i1).j)).^2))*100000)/100000;


    divF(i1).o=round((-(flujo(i1+1).o-flujo(i1).o)./(P_prom(i1+1).o-P_prom(i1).o))*100000)/100000;
    err_divF(i1).o=round((abs(divF(i1).o).*sqrt(((err_Flujo(i1+1).o-err_Flujo(i1).o)./(flujo(i1+1).o-flujo(i1).o)).^2+((P_std(i1+1).o-P_std(i1).o)./(P_prom(i1+1).o-P_prom(i1).o)).^2))*100000)/100000;

end
%%
for i1=1:6
    divF(i1).e=sign(divF(i1).e)*ceil(abs(divF(i1).e*100))/100;
    divF(i1).j=sign(divF(i1).j)*ceil(abs(divF(i1).j*100))/100;
    divF(i1).o=sign(divF(i1).o)*ceil(abs(divF(i1).o*100))/100;
    err_divF(i1).e=ceil(abs(err_divF(i1).e*100))/100;
    err_divF(i1).j=ceil(abs(err_divF(i1).j*100))/100;
    err_divF(i1).o=ceil(abs(err_divF(i1).o*100))/100;
end




for i1=1:7
    %%%%%%%%%%%%% ENERO   %%%%%%%%%%%%%%%%%%%%%%%%%
    P_prom(i1).e=round(P_prom(i1).e);
    P_std(i1).e=round(P_std(i1).e);
    Rrho_GE(i1).e=round(Rrho_GE(i1).e*100)/100;
    Err_Rrho_GE(i1).e=round(Err_Rrho_GE(i1).e*100)/100;
    N2_GE(i1).e=round(N2_GE(i1).e*1e7)/100;
    Err_N2_GE(i1).e=round(Err_N2_GE(i1).e*1e7)/100;
    dTCdP(i1).e=round(dTCdP(i1).e*10000)/10000;
    Err_TC(i1).e=round(Err_TC(i1).e*10000)/10000;
    dOdP(i1).e=round(dOdP(i1).e*10000)/10000;
    Err_O(i1).e=round(Err_O(i1).e*10000)/10000;
    et_prom(i1).e=round(et_prom(i1).e*1e10)/100;
    et_std(i1).e=round(et_std(i1).e*1e10)/100;
    try
    Chif_prom(i1).e=round(Chif_prom(i1).e*1e10)/100;
    end
    try
    Chif_std(i1).e=round(Chif_std(i1).e*1e10)/100;
    end
    %Peso_t(i1).e=round(
    %Peso_f(i1).e=round(
    Kst(i1).e=round(Kst(i1).e*1e7)/100;
    Err_Kst(i1).e=round(Err_Kst(i1).e*1e7)/100;
    Ksf(i1).e=round(Ksf(i1).e*1e7)/100;
    Err_Ksf(i1).e=round(Err_Ksf(i1).e*1e7)/100;
    K(i1).e=round(K(i1).e*1e7)/100;
    Err_K(i1).e=round(Err_K(i1).e*1e7)/100;
    %%%%%%%%%%%%% JULIO   %%%%%%%%%%%%%%%%%%%%%%%%%
    P_prom(i1).j=round(P_prom(i1).j);
    P_std(i1).j=round(P_std(i1).j);
    Rrho_GE(i1).j=round(Rrho_GE(i1).j*100)/100;
    Err_Rrho_GE(i1).j=round(Err_Rrho_GE(i1).j*100)/100;
    N2_GE(i1).j=round(N2_GE(i1).j*1e7)/100;
    Err_N2_GE(i1).j=round(Err_N2_GE(i1).j*1e7)/100;
    dTCdP(i1).j=round(dTCdP(i1).j*10000)/10000;
    Err_TC(i1).j=round(Err_TC(i1).j*10000)/10000;
    dOdP(i1).j=round(dOdP(i1).j*10000)/10000;
    Err_O(i1).j=round(Err_O(i1).j*10000)/10000;
    et_prom(i1).j=round(et_prom(i1).j*1e10)/100;
    et_std(i1).j=round(et_std(i1).j*1e10)/100;
    try
    Chif_prom(i1).j=round(Chif_prom(i1).j*1e10)/100;
    end
    try
    Chif_std(i1).j=round(Chif_std(i1).j*1e10)/100;
    end
    %Peso_t(i1).j=round(
    %Peso_f(i1).j=round(
    Kst(i1).j=round(Kst(i1).j*1e7)/100;
    Err_Kst(i1).j=round(Err_Kst(i1).j*1e7)/100;
    Ksf(i1).j=round(Ksf(i1).j*1e7)/100;
    Err_Ksf(i1).j=round(Err_Ksf(i1).j*1e7)/100;
    K(i1).j=round(K(i1).j*1e7)/100;
    Err_K(i1).j=round(Err_K(i1).j*1e7)/100;
    %%%%%%%%%%%%% OCTUBRE   %%%%%%%%%%%%%%%%%%%%%%%%%
    P_prom(i1).o=round(P_prom(i1).o);
    P_std(i1).o=round(P_std(i1).o);
    Rrho_GE(i1).o=round(Rrho_GE(i1).o*100)/100;
    Err_Rrho_GE(i1).o=round(Err_Rrho_GE(i1).o*100)/100;
    N2_GE(i1).o=round(N2_GE(i1).o*1e7)/100;
    Err_N2_GE(i1).o=round(Err_N2_GE(i1).o*1e7)/100;
    dTCdP(i1).o=round(dTCdP(i1).o*10000)/10000;
    Err_TC(i1).o=round(Err_TC(i1).o*10000)/10000;
    dOdP(i1).o=round(dOdP(i1).o*10000)/10000;
    Err_O(i1).o=round(Err_O(i1).o*10000)/10000;
    et_prom(i1).o=round(et_prom(i1).o*1e10)/100;
    et_std(i1).o=round(et_std(i1).o*1e10)/100;
    try
    Chif_prom(i1).o=round(Chif_prom(i1).o*1e10)/100;
    end
    try
    Chif_std(i1).o=round(Chif_std(i1).o*1e10)/100;
    end
    %Peso_t(i1).o=round(
    %Peso_f(i1).o=round(
    Kst(i1).o=round(Kst(i1).o*1e7)/100;
    Err_Kst(i1).o=round(Err_Kst(i1).o*1e7)/100;
    Ksf(i1).o=round(Ksf(i1).o*1e7)/100;
    Err_Ksf(i1).o=round(Err_Ksf(i1).o*1e7)/100;
    K(i1).o=round(K(i1).o*1e7)/100;
    Err_K(i1).o=round(Err_K(i1).o*1e7)/100;
end


%% SAVING IN TO TABLES
table_name='finaltable_I_7dens.xlsx';
table_name=fullfile(figure_dir,table_name);
if st 
    yvalues=["<-25.8[";"]25.80-26.10]";"]26.10-26.30]";"]26.30-26.55]";"]26.55-26.70]";"]26.70-26.80]";"]26.80->]"];
    % 
    writetable(table(yvalues),table_name,'Sheet',1,'Range','A1');
    writetable(struct2table(P_prom),table_name,'Sheet',1,'Range','C1');
    writetable(struct2table(N2_GE),table_name,'Sheet',1,'Range','G1');
    writetable(struct2table(dTCdP),table_name,'Sheet',1,'Range','K1');
    writetable(struct2table(Rrho_GE),table_name,'Sheet',1,'Range','O1');
    writetable(struct2table(et_prom),table_name,'Sheet',1,'Range','S1');
    writetable(struct2table(Chif_prom),table_name,'Sheet',1,'Range','W1');
    
    writetable(table(yvalues),table_name,'Sheet',2,'Range','A1');
    writetable(struct2table(P_std),table_name,'Sheet',2,'Range','C1');
    writetable(struct2table(Err_N2_GE),table_name,'Sheet',2,'Range','G1');
    writetable(struct2table(Err_TC),table_name,'Sheet',2,'Range','K1');
    writetable(struct2table(Err_Rrho_GE),table_name,'Sheet',2,'Range','O1');
    writetable(struct2table(et_std),table_name,'Sheet',2,'Range','S1');
    writetable(struct2table(Chif_std),table_name,'Sheet',2,'Range','W1');
end

table_name='finaltable_II_7dens.xlsx';
table_name=fullfile(figure_dir,table_name);
if st 
    yvalues=["<-25.8[";"]25.80-26.10]";"]26.10-26.30]";"]26.30-26.55]";"]26.55-26.70]";"]26.70-26.80]";"]26.80->]"];
    % 
    writetable(table(yvalues),table_name,'Sheet',1,'Range','A1');
    writetable(struct2table(P_prom),table_name,'Sheet',1,'Range','C1');
    writetable(struct2table(Kst),table_name,'Sheet',1,'Range','G1');
    writetable(struct2table(Ksf),table_name,'Sheet',1,'Range','K1');
    writetable(struct2table(K),table_name,'Sheet',1,'Range','O1');
    writetable(struct2table(dOdP),table_name,'Sheet',1,'Range','S1');
    writetable(struct2table(flujo),table_name,'Sheet',1,'Range','W1');
    writetable(struct2table(divF),table_name,'Sheet',1,'Range','AA1');
    writetable(struct2table(Peso_t),table_name,'Sheet',1,'Range','AE1');
    writetable(struct2table(Peso_f),table_name,'Sheet',1,'Range','AI1');

    writetable(table(yvalues),table_name,'Sheet',2,'Range','A1');
    writetable(struct2table(P_std),table_name,'Sheet',2,'Range','C1');
    writetable(struct2table(Err_Kst),table_name,'Sheet',2,'Range','G1');
    writetable(struct2table(Err_Ksf),table_name,'Sheet',2,'Range','K1');
    writetable(struct2table(Err_K),table_name,'Sheet',2,'Range','O1');
    writetable(struct2table(Err_O),table_name,'Sheet',2,'Range','S1');
    writetable(struct2table(err_Flujo),table_name,'Sheet',2,'Range','W1');
    writetable(struct2table(err_divF),table_name,'Sheet',2,'Range','AA1');
    writetable(struct2table(Peso_t),table_name,'Sheet',2,'Range','AE1');
    writetable(struct2table(Peso_f),table_name,'Sheet',2,'Range','AI1');

end
%%
% # New data provided by user corresponds to diapycnal O2 fluxes (not divergence)
% # Values are in µmol m⁻² day⁻¹
% 
% flux_data = {
%     "Interval": ["(1)", "(2)", "(3)", "(4)", "(5)", "(6)", "(7)"],
%     "January 2020": [-1.581, -3.468, -22.261, -4.033, 7.245, 0.771, 8.654],
%     "July 2021": [-7.188, -5.211, -13.962, -2.342, 4.019, 4.413, 17.742],
%     "October 2022": [-0.203, -1.479, -1.732, -1.120, -0.617, 5.857, 1.617]
% }
% 
% df_flux = pd.DataFrame(flux_data)
% 
% # Apply user-defined groupings
% upper_jan_flux = df_flux.loc[df_flux["Interval"].isin(["(2)", "(3)", "(4)"]), "January 2020"]
% lower_jan_flux = df_flux.loc[df_flux["Interval"].isin(["(5)", "(6)", "(7)"]), "January 2020"]
% 
% upper_jul_flux = df_flux.loc[df_flux["Interval"].isin(["(2)", "(3)", "(4)"]), "July 2021"]
% lower_jul_flux = df_flux.loc[df_flux["Interval"].isin(["(5)", "(6)", "(7)"]), "July 2021"]
% 
% upper_oct_flux = df_flux.loc[df_flux["Interval"].isin(["(2)", "(3)", "(4)", "(5)"]), "October 2022"]
% lower_oct_flux = df_flux.loc[df_flux["Interval"].isin(["(6)", "(7)"]), "October 2022"]
% 
% # Compute means
% mean_fluxes = {
%     "Upper Oxycline": [
%         upper_jan_flux.mean(), 
%         upper_jul_flux.mean(), 
%         upper_oct_flux.mean()
%     ],
%     "Lower Oxycline": [
%         lower_jan_flux.mean(), 
%         lower_jul_flux.mean(), 
%         lower_oct_flux.mean()
%     ]
% }
% 
% mean_flux_df = pd.DataFrame(mean_fluxes, index=["January 2020", "July 2021", "October 2022"])
% df_flux_values = df_flux.set_index("Interval")
% 
% tools.display_dataframe_to_user(name="Diapycnal Oxygen Flux and Campaign Means", dataframe=mean_flux_df)
% 
% df_flux_values

% # Create DataFrames for each dataset using the user-provided values
% index = ["(1)", "(2)", "(3)", "(4)", "(5)", "(6)", "(7)"]
% 
% Pt = pd.DataFrame({
%     "January 2020": [1, 1, 1, 1, 0.74, 0.74, 0.73],
%     "July 2021":    [1, 1, 1, 1, 0.83, 0.81, 0.81],
%     "October 2022": [1, 1, 1, 1, 1.00, 0.85, 0.82]
% }, index=index)
% 
% Pf = pd.DataFrame({
%     "January 2020": [0, 0, 0, 0, 0.26, 0.26, 0.27],
%     "July 2021":    [0, 0, 0, 0, 0.17, 0.19, 0.19],
%     "October 2022": [0, 0, 0, 0, 0.00, 0.15, 0.18]
% }, index=index)
% 
% Kst = pd.DataFrame({
%     "January 2020": [1.58, 3.25, 7.69, 8.27, 117.48, 3.45, 13.03],
%     "July 2021":    [5.14, 2.33, 6.86, 5.64, 204.22, 25.61, 28.97],
%     "October 2022": [0.79, 0.73, 0.68, 1.17, 2.17, 37.32, 2.65]
% }, index=index)
% 
% Ksf = pd.DataFrame({
%     "January 2020": [0, 0, 0, 0, 439.79, 8.47, 40.96],
%     "July 2021":    [0, 0, 0, 0, 539.66, 87.29, 24.94],
%     "October 2022": [0, 0, 0, 0, 0.00, 107.72, 7.14]
% }, index=index)
% 
% # Compute weighted diffusivity contributions for each layer and campaign
% K_total = Pt * Kst + Pf * Ksf
% 
% # Calculate relative contribution of salt fingers
% Ksf_contribution = (Pf * Ksf) / K_total
% 
% # Average contributions across lower oxycline intervals (5,6,7)
% sf_contribution_means = Ksf_contribution.loc[["(5)", "(6)", "(7)"]].mean()
% 
% tools.display_dataframe_to_user(name="Relative Contribution of Salt Fingering to Diapycnal Diffusivity", dataframe=Ksf_contribution)
% 
% sf_contribution_means
