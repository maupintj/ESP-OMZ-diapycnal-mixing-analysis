close all; clear;

data_dir = '/Volumes/SSDext/Tesis_Master_respaldo/Tesis Magister/DATOS/';
load(fullfile(data_dir,'CTD','All_CTD_data.mat'));
sds=false;
%% CAlCULO FLUJOS DE OXIGENO
O_CTD2020; %(\mu mol/L)./((sigmat_CTD2020+1000)/1000);
O_CTD2021;%./((sigmat_CTD2021+1000)/1000);
O_CTD2022;%./((sigmat_CTD2022+1000)/1000);

O_CTD2020=nanmean(O_CTD2020,2);
AOU_CTD2020=nanmean(AOU_CTD2020,2);
sigmat_CTD2020=nanmean(sigmat_CTD2020,2);
P_CTD2020=nanmean(P_CTD2020,2);

O_CTD2021=nanmean(O_CTD2021,2);
AOU_CTD2021=nanmean(AOU_CTD2021,2);
sigmat_CTD2021=nanmean(sigmat_CTD2021,2);
P_CTD2021=nanmean(P_CTD2021,2);

O_CTD2022=nanmean(O_CTD2022,2);
AOU_CTD2022=nanmean(AOU_CTD2022,2);
sigmat_CTD2022=nanmean(sigmat_CTD2022,2);
P_CTD2022=nanmean(P_CTD2022,2);
l(1)=25.80;
l(2)=26.10;
l(3)=26.30;
l(4)=26.55;
l(5)=26.70;
l(6)=26.80;



% INTERVALOS DE DENSIDAD ENERO 2020
I(1).e=sigmat_CTD2020<=l(1);
I(2).e=sigmat_CTD2020<=l(2) & sigmat_CTD2020>l(1);
I(3).e=sigmat_CTD2020<=l(3) & sigmat_CTD2020>l(2);
I(4).e=sigmat_CTD2020<=l(4) & sigmat_CTD2020>l(3);%
I(5).e=sigmat_CTD2020<=l(5) & sigmat_CTD2020>l(4);
I(6).e=sigmat_CTD2020<=l(6) & sigmat_CTD2020>l(5);
I(7).e=sigmat_CTD2020<=max(max(sigmat_CTD2020)) & sigmat_CTD2020>l(6);
% INTERVALOS DE DENSIDAD JULIO 2021
I(1).j=sigmat_CTD2021<=l(1);
I(2).j=sigmat_CTD2021<=l(2) & sigmat_CTD2021>l(1);
I(3).j=sigmat_CTD2021<=l(3) & sigmat_CTD2021>l(2);
I(4).j=sigmat_CTD2021<=l(4) & sigmat_CTD2021>l(3);%
I(5).j=sigmat_CTD2021<=l(5) & sigmat_CTD2021>l(4);
I(6).j=sigmat_CTD2021<=l(6) & sigmat_CTD2021>l(5);
I(7).j=sigmat_CTD2021<=max(max(sigmat_CTD2021)) & sigmat_CTD2021>l(6);
% INTERVALOS DE DENSIDAD OCTUBRE 2022
I(1).o=sigmat_CTD2022<=l(1);
I(2).o=sigmat_CTD2022<=l(2) & sigmat_CTD2022>l(1);
I(3).o=sigmat_CTD2022<=l(3) & sigmat_CTD2022>l(2);
I(4).o=sigmat_CTD2022<=l(4) & sigmat_CTD2022>l(3);%
I(5).o=sigmat_CTD2022<=l(5) & sigmat_CTD2022>l(4);
I(6).o=sigmat_CTD2022<=l(6) & sigmat_CTD2022>l(5);
I(7).o=sigmat_CTD2022<=max(max(sigmat_CTD2022)) & sigmat_CTD2022>l(6);


%%
figure()
set(gcf,'position',[10,10,700,600])
subplot 131
hold on
for i1=1:7
plot(O_CTD2020(I(i1).e),P_CTD2020(I(i1).e),'LineWidth',2)
grid on
set(gca,'YDir','reverse')
end
subplot 132
hold on
for i1=1:7
plot(O_CTD2021(I(i1).j),P_CTD2021(I(i1).j),'LineWidth',2)
grid on
set(gca,'YDir','reverse')
end
subplot 133
hold on
for i1=1:7
plot(O_CTD2022(I(i1).o),P_CTD2022(I(i1).o),'LineWidth',2)
grid on
set(gca,'YDir','reverse')
end
f=gcf;
%exportgraphics(f,fullfile(FolderName,['Oxi_sections.png']),'Resolution',400,'BackgroundColor','white')

%%%%% AOU %%%%%
figure()
set(gcf,'position',[10,10,700,600])
subplot 131
hold on
for i1=1:7
plot(AOU_CTD2020(I(i1).e),P_CTD2020(I(i1).e),'LineWidth',2)
grid on
set(gca,'YDir','reverse')
end
subplot 132
hold on
for i1=1:7
plot(AOU_CTD2021(I(i1).j),P_CTD2021(I(i1).j),'LineWidth',2)
grid on
set(gca,'YDir','reverse')
end
subplot 133
hold on
for i1=1:7
plot(AOU_CTD2022(I(i1).o),P_CTD2022(I(i1).o),'LineWidth',2)
grid on
set(gca,'YDir','reverse')
end
f=gcf;
%exportgraphics(f,fullfile(FolderName,['AOU_sections.png']),'Resolution',400,'BackgroundColor','white')
%%%%%



figure()
set(gcf,'position',[10,10,700,600])
subplot 131
hold on
for i1=1:7
plot(gradient(O_CTD2020(I(i1).e)),P_CTD2020(I(i1).e),'LineWidth',2)
grid on
set(gca,'YDir','reverse')
end
subplot 132
hold on
for i1=1:7
plot(gradient(O_CTD2021(I(i1).j)),P_CTD2021(I(i1).j),'LineWidth',2)
grid on
set(gca,'YDir','reverse')
end
subplot 133
hold on
for i1=1:7
plot(gradient(O_CTD2022(I(i1).o)),P_CTD2022(I(i1).o),'LineWidth',2)
grid on
set(gca,'YDir','reverse')
end
f=gcf;
%exportgraphics(f,fullfile(FolderName,['Oxi_sections_gradient.png']),'Resolution',400,'BackgroundColor','white')


%%%%%%%%%%%%%%%% QUITO MEDIA VARIABLES 2020 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_CTD2020sm=nan(size(O_CTD2020));%sm_sin media)
O_CTD2020sm=nan(size(O_CTD2020));%sm_sin media
dOdP_2020=nan(9,1);
S_O_2020=nan(9,1);
Err_O_2020=nan(9,1);
dOdP2_2020=nan(9,1);
S2_O_2020=nan(9,1);
Err2_O_2020=nan(9,1);
for i2=1:size(I,2)
    for i1=1:size(O_CTD2020,2)
        P_CTD2020sm(I(i2).e(:,i1),i1)=P_CTD2020(I(i2).e(:,i1),i1)-mean(P_CTD2020(I(i2).e(:,i1),i1),'omitnan');
        O_CTD2020sm(I(i2).e(:,i1),i1)=O_CTD2020(I(i2).e(:,i1),i1)-mean(O_CTD2020(I(i2).e(:,i1),i1),'omitnan');
        auxO=O_CTD2020sm(I(i2).e(:,i1),i1);
        auxP=P_CTD2020sm(I(i2).e(:,i1),i1);
        %AJUSTE LINEAL
        if ~isempty(auxP)
        %forma 1
        p_O=polyfit(auxP,auxO,1);
        dOdP_2020(i2,i1)=p_O(1);
        S_O_2020(i2,i1)=sqrt(sum((auxO-(p_O(1)*(auxP)+p_O(2))).^2)/(length(auxO)-2));
        Err_O_2020(i2,i1)=S_O_2020(i2,i1)/sqrt(sum((auxP-mean(auxP)).^2));
        %forma 2
        auxP2=[auxP(1:5);auxP(end-4:end)];
        auxO2=[auxO(1:5);auxO(end-4:end)];
        p2_O=polyfit(auxP2,auxO2,1);
        dOdP2_2020(i2,i1)=p2_O(1);
        S2_O_2020(i2,i1)=sqrt(sum((auxO2-(p2_O(1)*(auxP2)+p2_O(2))).^2)/(length(auxO2)-2));
        Err2_O_2020(i2,i1)=S2_O_2020(i2,i1)/sqrt(sum((auxP2-mean(auxP2)).^2));
        
        figure()
        set(gcf,'position',[200,100,400,200])
        plot(auxP,auxO,'-.','LineWidth',2)
        grid on
        hold on
        %forma 1
        plot(auxP,p_O(1)*(auxP)+p_O(2),'-r','LineWidth',2)
        %forma 2
        plot(auxP,p2_O(1)*(auxP)+p2_O(2),'-g','LineWidth',2)
        tit=strcat(["Intervalo: "],string(i2),[" Perfil: "],string(i1));
        legend("O",strcat("M1: ",string(p_O(1)),"+-",string(Err_O_2020(i2,i1))) ,strcat("M2: ",string(p2_O(1)),"+-",string(Err2_O_2020(i2,i1))))
        title(tit)
        f=gcf;
%         exportgraphics(f,fullfile(FolderName,strcat(['Oxi_sections_pendiente_',char(string(i2)),'.png'])),'Resolution',400,'BackgroundColor','white')
%         pause(1)
        else
            figure()
            set(gcf,'position',[200,100,400,200])
            tit=strcat(["Intervalo: "],string(i2),[" Perfil: "],string(i1)," Sin Data");
            title(tit)
            %f=gcf;
            %exportgraphics(f,fullfile(FolderName,strcat(['Oxi_sections_pendiente_',char(string(i2)),'.png'])),'Resolution',400,'BackgroundColor','white')
            %pause(1)
        end
    end
end

%%%%%%%%%%%%%%%% QUITO MEDIA VARIABLES 2021 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_CTD2021sm=nan(size(O_CTD2021));%sm_sin media)
O_CTD2021sm=nan(size(O_CTD2021));%sm_sin media
dOdP_2021=nan(9,1);
S_O_2021=nan(9,1);
Err_O_2021=nan(9,1);
dOdP2_2021=nan(9,1);
S2_O_2021=nan(9,1);
Err2_O_2021=nan(9,1);
for i2=1:size(I,2)
    for i1=1:size(O_CTD2021,2)
        P_CTD2021sm(I(i2).j(:,i1),i1)=P_CTD2021(I(i2).j(:,i1),i1)-mean(P_CTD2021(I(i2).j(:,i1),i1),'omitnan');
        O_CTD2021sm(I(i2).j(:,i1),i1)=O_CTD2021(I(i2).j(:,i1),i1)-mean(O_CTD2021(I(i2).j(:,i1),i1),'omitnan');
        auxO=O_CTD2021sm(I(i2).j(:,i1),i1);
        auxP=P_CTD2021sm(I(i2).j(:,i1),i1);
        %AJUSTE LINEAL
        if ~isempty(auxP)
        %forma 1
        p_O=polyfit(auxP,auxO,1);
        dOdP_2021(i2,i1)=p_O(1);
        S_O_2021(i2,i1)=sqrt(sum((auxO-(p_O(1)*(auxP)+p_O(2))).^2)/(length(auxO)-2));
        Err_O_2021(i2,i1)=S_O_2021(i2,i1)/sqrt(sum((auxP-mean(auxP)).^2));
        %forma 2
        auxP2=[auxP(1:5);auxP(end-4:end)];
        auxO2=[auxO(1:5);auxO(end-4:end)];
        p2_O=polyfit(auxP2,auxO2,1);
        dOdP2_2021(i2,i1)=p2_O(1);
        S2_O_2021(i2,i1)=sqrt(sum((auxO2-(p2_O(1)*(auxP2)+p2_O(2))).^2)/(length(auxO2)-2));
        Err2_O_2021(i2,i1)=S2_O_2021(i2,i1)/sqrt(sum((auxP2-mean(auxP2)).^2));
               
        figure()
        set(gcf,'position',[200,100,400,200])
        plot(auxP,auxO,'-.','LineWidth',2)
        grid on
        hold on
        %forma 1
        plot(auxP,p_O(1)*(auxP)+p_O(2),'-r','LineWidth',2)
        %forma 2
        plot(auxP,p2_O(1)*(auxP)+p2_O(2),'-g','LineWidth',2)
        tit=strcat(["Intervalo: "],string(i2),[" Perfil: "],string(i1));
        legend("O",strcat("M1: ",string(p_O(1)),"+-",string(Err_O_2021(i2,i1))) ,strcat("M2: ",string(p2_O(1)),"+-",string(Err2_O_2021(i2,i1))))
        title(tit)
        else
            figure()
            set(gcf,'position',[200,100,400,200])
            tit=strcat(["Intervalo: "],string(i2),[" Perfil: "],string(i1)," Sin Data");
            title(tit)
        end
    end
end

%%%%%%%%%%%%%%%% QUITO MEDIA VARIABLES 2022 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_CTD2022sm=nan(size(O_CTD2022));%sm_sin media)
O_CTD2022sm=nan(size(O_CTD2022));%sm_sin media
dOdP_2022=nan(9,1);
S_O_2022=nan(9,1);
Err_O_2022=nan(9,1);
dOdP2_2022=nan(9,1);
S2_O_2022=nan(9,1);
Err2_O_2022=nan(9,1);
for i2=1:size(I,2)
    for i1=1:size(O_CTD2022,2)
        P_CTD2022sm(I(i2).o(:,i1),i1)=P_CTD2022(I(i2).o(:,i1),i1)-mean(P_CTD2022(I(i2).o(:,i1),i1),'omitnan');
        O_CTD2022sm(I(i2).o(:,i1),i1)=O_CTD2022(I(i2).o(:,i1),i1)-mean(O_CTD2022(I(i2).o(:,i1),i1),'omitnan');
        auxO=O_CTD2022sm(I(i2).o(:,i1),i1);
        auxP=P_CTD2022sm(I(i2).o(:,i1),i1);
        %AJUSTE LINEAL
        if ~isempty(auxP)
        %forma 1
        p_O=polyfit(auxP,auxO,1);
        dOdP_2022(i2,i1)=p_O(1);
        S_O_2022(i2,i1)=sqrt(sum((auxO-(p_O(1)*(auxP)+p_O(2))).^2)/(length(auxO)-2));
        Err_O_2022(i2,i1)=S_O_2022(i2,i1)/sqrt(sum((auxP-mean(auxP)).^2));
        %forma 2
        auxP2=[auxP(1:5);auxP(end-4:end)];
        auxO2=[auxO(1:5);auxO(end-4:end)];
        p2_O=polyfit(auxP2,auxO2,1);
        dOdP2_2022(i2,i1)=p2_O(1);
        S2_O_2022(i2,i1)=sqrt(sum((auxO2-(p2_O(1)*(auxP2)+p2_O(2))).^2)/(length(auxO2)-2));
        Err2_O_2022(i2,i1)=S2_O_2022(i2,i1)/sqrt(sum((auxP2-mean(auxP2)).^2));
               
        figure()
        set(gcf,'position',[200,100,400,200])
        plot(auxP,auxO,'-.','LineWidth',2)
        grid on
        hold on
        %forma 1
        plot(auxP,p_O(1)*(auxP)+p_O(2),'-r','LineWidth',2)
        %forma 2
        plot(auxP,p2_O(1)*(auxP)+p2_O(2),'-g','LineWidth',2)
        tit=strcat(["Intervalo: "],string(i2),[" Perfil: "],string(i1));
        legend("O",strcat("M1: ",string(p_O(1)),"+-",string(Err_O_2022(i2,i1))) ,strcat("M2: ",string(p2_O(1)),"+-",string(Err2_O_2022(i2,i1))))
        title(tit)
        else
            figure()
            set(gcf,'position',[200,100,400,200])
            tit=strcat(["Intervalo: "],string(i2),[" Perfil: "],string(i1)," Sin Data");
            title(tit)
        end
    end
end
for i1=1:7
    dOdP(i1).e=dOdP2_2020(i1);
    dOdP(i1).j=dOdP2_2021(i1);
    dOdP(i1).o=dOdP2_2022(i1);

    Err_O(i1).e=Err2_O_2020(i1);
    Err_O(i1).j=Err2_O_2021(i1);
    Err_O(i1).o=Err2_O_2022(i1);
end
if sds
    save(fullfile(data_dir,'CTD/','Oxi_grad_microMkg.mat'),'dOdP','Err_O', '-v7.3')
end
