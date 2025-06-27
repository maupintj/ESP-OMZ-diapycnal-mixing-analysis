function x= plotsturbulencia(Data,ql_info,E02)
%function x= plotsturbulencia(Data,ql_info,Latlon)

diss_041_01= quick_look(Data,[],[],ql_info,'make_figures',false);
E02_01_e1=diss_041_01.e(1,:)';
E02_01_e2=diss_041_01.e(2,:)';
E02_01_ShHP=diss_041_01.SH_HP;
E02_01_ShBP=diss_041_01.SH_BP;
E02_01_Pfast=diss_041_01.P_fast;
E02_01_nu=diss_041_01.nu;
[~, ~, E02_01_C, ~, E02_01_T, ~, E02_01_P] = offsets_CTD(Data,ql_info);
E02_01_SP=gsw_SP_from_C(E02_01_C,E02_01_T,E02_01_P);
E02_01_SA=gsw_SA_from_SP(E02_01_SP,E02_01_P,E02(1),E02(2));
E02_01_TC=gsw_CT_from_t(E02_01_SA,E02_01_T,E02_01_P);
%[~, E02_01_alpha, E02_01_beta] = gsw_specvol_alpha_beta(E02_01_SA,E02_01_TC,E02_01_P);
E02_01_rho=gsw_rho(E02_01_SA,E02_01_TC,0)-1000;
[E02_01_drhodP, E02_01_rho, ~,E02_01_ind] = calc_pend(E02_01_rho,E02_01_P,ql_info);
[E02_01_dT,E02_01_TC,~,~] = calc_diff(E02_01_TC,E02_01_P,ql_info);
[E02_01_dSA,E02_01_SA,E02_01_P,~] = calc_diff(E02_01_SA,E02_01_P,ql_info);
[~, E02_01_alpha, E02_01_beta] = gsw_specvol_alpha_beta(E02_01_SA,E02_01_TC,E02_01_P);
E02_01_N2=9.8.*E02_01_drhodP./(E02_01_rho+1000);
E02_01_N2=interpN2(E02_01_N2,E02_01_P);
E02_01_Tu = atan2((E02_01_alpha.*E02_01_dT + E02_01_beta.*E02_01_dSA),(E02_01_alpha.*E02_01_dT - E02_01_beta.*E02_01_dSA));
E02_01_Tu = E02_01_Tu.*(180/pi);
E02_01_Lo1 = sqrt(E02_01_e1)./(sqrt(E02_01_N2).^(3/2));
E02_01_Lo2 = sqrt(E02_01_e2)./(sqrt(E02_01_N2).^(3/2));
E02_01_Kl1 = (E02_01_nu.^3./E02_01_e1).^(1/4);
E02_01_Kl2 = (E02_01_nu.^3./E02_01_e2).^(1/4);
E02_01_iso1= (E02_01_e1./(E02_01_nu.*E02_01_N2)); 
E02_01_iso2= (E02_01_e2./(E02_01_nu.*E02_01_N2)); 
% 
% figure()
% set(gcf,'position',[10,10,1200,800])
% subplot 161
% pos1=gca;
% pos1=pos1.Position;
% subplot 162
% pos2=gca;
% pos2=pos2.Position
% subplot 163
% pos3=gca;
% pos3=pos3.Position
% subplot 164
% pos4=gca;
% pos4=pos4.Position
% subplot 165
% pos5=gca;
% pos5=pos5.Position
% subplot 166
% pos6=gca;
% pos6=pos6.Position
% close 


pos1=[0.1300    0.1100    0.1023    0.8150];
pos2=[0.2645    0.1100    0.1023    0.8150];
pos3=[0.3991    0.1100    0.1023    0.8150];
pos4=[0.5336    0.1100    0.1023    0.8150];
pos5=[0.6682    0.1100    0.1023    0.8150];
pos6=[0.8027    0.1100    0.1023    0.8150];

%%

font=10;
hf=figure;
set(gcf,'position',[10,10,1200,800])
% Panel 1
%pos1(1)=pos1(1)-0.08
%pos1(2)=pos1(2)+0.05
h=axes('position',pos1);
hp=semilogx([E02_01_e1],E02_01_P,'LineStyle','-','Marker','.','color','#6495ED','MarkerSize',18,'LineWidth',0.5);
hold on
hp=semilogx([E02_01_e2],E02_01_P,'LineStyle','-','Marker','.','color','#6495ED','MarkerSize',18,'LineWidth',0.5);
ylim([20 600]);;
xlim([1e-10 1e-6]);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',11);
ylabel('Presión [dbar]','FontSize',14);
title(['DS=',num2str(ql_info.diss_length),' OL=',num2str(ql_info.overlap),' fft=',num2str(ql_info.fft_length)]);
col=get(hp,'color');  %Extraigo el color de la línea del plot 
set(hp,'markerfacecolor',col); 
set(h,'color','none','xcolor','k',...
    'tickdir','in','fontsize',font,'xtick',[1e-10 1e-8 1e-6]);
xlim([1e-10 1e-6]);
ylim([20 600]);;
set(gca,'Ydir','reverse');

h=axes('position',pos1);
hp=plot(E02_01_ShBP(:,1),E02_01_Pfast,'color',[.7 .7 .7]);
hold on
xlim([-0.5 0.5]);
ylim([20 600]);;
hp=plot(E02_01_ShBP(:,2),E02_01_Pfast,'color',[.7 .7 .7]);
xlim([-0.6 0.6]);
ylim([20 600]);;
col=get(hp,'color');
set(hp,'markerfacecolor',col);
set(h,'color','none','tickdir','in','fontsize',font);
axis off
set(gca,'Ydir','reverse');
h=axes('position',[pos1(1) pos1(2)-.038 pos1(3) .01],'fontsize',font);
set(h,'color','none','xcolor',[.7 .7 .7],'ycolor',[get(hf,'color')],...
    'tickdir','in','xtick',[-0.6 0 0.6])
xlim([-0.6 0.6]);
ylim([20 600]);;

subplot 162
plot(E02_01_rho,E02_01_P,'LineStyle','-','color','#6495ED','LineWidth',2);
set(gca,'Ydir','reverse')
axis tight
grid on
title('\rho')
ylim([20 600]);;

subplot 163
semilogx(E02_01_N2,E02_01_P,'LineStyle','-','color','#6495ED','LineWidth',2);
set(gca,'Ydir','reverse')
axis tight
grid on
title('N2')
ylim([20 600]);

subplot 164
plot([E02_01_Lo1 E02_01_Lo2],E02_01_P,'LineStyle','-','Marker','.','color','#6495ED','MarkerSize',18,'LineWidth',0.5);
set(gca,'Ydir','reverse')
axis tight
grid on
title('Lo')
ylim([20 600]);
xlim([0 4])
subplot 165
y = [E02_01_P(end) E02_01_P(end) E02_01_P(1) E02_01_P(1)];
x = [-90 -45 -45 -90];
patch(x,y,[1 0 0]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
hold on
y = [E02_01_P(end) E02_01_P(end) E02_01_P(1) E02_01_P(1)];
x = [45 90 90 45];
patch(x,y,[0 0 1]*0.8,'EdgeColor','none', 'FaceAlpha',0.2)
plot(E02_01_Tu,E02_01_P,'LineStyle','none','Marker','.','color','blue','MarkerSize',18)
set(gca,'Ydir','reverse')
%ylabel('Presión [dbar]')
grid on
hold on
h=plot([45 45],[E02_01_P(1) E02_01_P(end)],'k','LineWidth',2)
h=plot([-45 -45],[E02_01_P(1) E02_01_P(end)],'k','LineWidth',2)
ylim([20 600]);
xlim([-90 90])
xticks([-45 0 45])
a = get(gca,'XTickLabel');
%set(gca,'XTickLabel',a,'fontsize',12)
title('Turner')

subplot 166
plot(E02_01_Lo1./E02_01_Kl1,E02_01_P,'LineStyle','none','Marker','.','color','blue','MarkerSize',18)
hold on
plot(E02_01_Lo2./E02_01_Kl2,E02_01_P,'LineStyle','none','Marker','.','color','blue','MarkerSize',18)

set(gca,'Ydir','reverse')
axis tight
grid on
title('L0/ \eta')
ylim([20 600]);
xlim([0 100])
Titulo=[Data ' Perfil ' num2str(ql_info.profile_num)];
axes( 'Position', [0, 0.95, 1, 0.05] ) ;
set( gca, 'Color', 'None', 'XColor', 'none', 'YColor', 'none' ) ;
text( 0.5, 0, Titulo , 'FontSize', 14', 'FontWeight', 'Bold', ...
      'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Bottom' ) ;

end