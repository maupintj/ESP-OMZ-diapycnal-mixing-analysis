function dgts_tesis2(SA,CT,Rho_2020,p_ref,isopycs,limits,title_string)

% gsw_SA_CT_plot         plots Absolute Salinity - Conservative Temperature
%                   profiles on a SA-CT diagram including freezing line and
%                    selected potential density contours (75-term equation)
%==========================================================================
%
% USAGE:
%  gsw_SA_CT_plot(SA,CT,p_ref,isopycs,title_string)
%
% DESCRIPTION:
%  Produces a plot of Absolute Salinity - Conservative Temperature
%  profiles.  The diagram also plots the Conservative Temperature freezing 
%  point for p = 0 dbar assuming the seawater is completely saturated with
%  dissolved air and user defined potential density contours.  This 
%  function uses the computationally efficient 75-term expression for 
%  specific volume in terms of SA, CT and p (Roquet et al., 2015).  
%
%  Note that the 75-term equation has been fitted in a restricted range of 
%  parameter space, and is most accurate inside the "oceanographic funnel" 
%  described in McDougall et al. (2003).  The GSW library function 
%  "gsw_infunnel(SA,CT,p)" is avaialble to be used if one wants to test if 
%  some of one's data lies outside this "funnel".  
%
% INPUT:
%  SA  =  Absolute Salinity                                        [ g/kg ]
%  CT  =  Conservative Temperature (ITS-90)                       [ deg C ]
%
% Optional:
%  p_ref        = reference sea pressure for the isopycnals        [ dbar ]
%                 (i.e. absolute reference pressure - 10.1325 dbar) 
%                 If it is not suppled a default of 0 dbar is used.
%  isopycs      = isopycnals, can be either an array of isopynals or the
%                 number of isopynals to appear on the plot.  If it is not 
%                 supplied the programme defaults to 5 isopynals.
%  title_string = title text to appear at the top of the plot.
%
%  SA & CT need to have the same dimensions.
%  p_ref should be a scalar, (i.e. have dimensions 1x1).
%  isopycs can be either 1x1 or 1xN or Mx1
%
% AUTHOR: 
%  Rich Pawlowicz                                      [ help@teos-10.org ]
%  Note. This function was extracted and adapted from Rich Pawlowicz's 
%    ocean toolbox.
%
% MODIFIED:
%  Paul Barker & Trevor McDougall
%
% VERSION NUMBER: 3.05 (27th January 2015)
%
% REFERENCES:
%  McDougall, T.J., D.R. Jackett, D.G. Wright and R. Feistel, 2003: 
%   Accurate and computationally efficient algorithms for potential 
%   temperature and density of seawater.  J. Atmosph. Ocean. Tech., 20,
%   pp. 730-741.
%
%  Roquet, F., G. Madec, T.J. McDougall, P.M. Barker, 2014: Accurate
%   polynomial expressions for the density and specifc volume of seawater
%   using the TEOS-10 standard. Ocean Modelling.
%
%  The software is available from http://www.TEOS-10.org
%
%==========================================================================
SAmin=limits(1);
SAmax=limits(2);
TCmin=limits(3);
TCmax=limits(4);
if (nargin < 2),
    error('gsw_SA_CT_plot: You need to supply both Absolute Salinity and Conservative Temperature');
end

if ~exist('p_ref','var'),
    p_ref = 0;
    isopycs = 5;
end

if ischar(p_ref) == 1
    title_string = p_ref;
    p_ref = 0;
    isopycs = 5;
end

if ~isscalar(unique(p_ref))
    error('gsw_SA_CT_plot: Multiple reference pressures');
else
    p_ref = unique(p_ref);
end

if ~exist('isopycs','var'),
    isopycs = 5;
end

if ischar(isopycs) == 1
    title_string = isopycs;
    isopycs = 5;
end

isopycs = isopycs(:);
min_SA_data = SAmin;
max_SA_data = SAmax;
min_CT_data = TCmin;
max_CT_data = TCmax;

SA_min = min_SA_data - 0.1*(max_SA_data - min_SA_data);
SA_min(SA_min < 0) = 0;
SA_max = max_SA_data + 0.1*(max_SA_data - min_SA_data);
SA_axis = [SA_min:(SA_max-SA_min)/200:SA_max];

CT_freezing = gsw_CT_freezing(SA_axis,p_ref,0); 
CT_min = min_CT_data - 0.1*(max_CT_data - min_CT_data);
CT_max = max_CT_data + 0.1*(max_CT_data - min_CT_data);
if CT_min > min(CT_freezing) 
    CT_min = min_CT_data - 0.1*(max_CT_data - min(CT_freezing));
end
CT_axis = [CT_min:(CT_max-CT_min)/200:CT_max];

clear min_SA_data max_SA_data min_CT_data max_CT_data

SA_gridded = meshgrid(SA_axis,1:length(CT_axis));
CT_gridded = meshgrid(CT_axis,1:length(SA_axis))';

isopycs_gridded = gsw_rho(SA_gridded,CT_gridded,p_ref)-1000;
% figure
%scaling for macs
sz = 1;
try
    if ismac
        sz = sz*(96/72);
    end
end

if ~isempty(isopycs)
    [c1,h] = contour(SA_gridded,CT_gridded,isopycs_gridded,isopycs,':','Color',[.5 .5 .5]);
    xlim([SAmin SAmax])
    ylim([TCmin TCmax])
end
hold on;
% INTERVALOS
I(1).e=Rho_2020<=25.80;
I(2).e=Rho_2020<=26.10 & Rho_2020>25.80;
I(3).e=Rho_2020<=26.30 & Rho_2020>26.10;
I(4).e=Rho_2020<=26.45 & Rho_2020>26.30;%
I(5).e=Rho_2020<=26.55 & Rho_2020>26.45;%
I(6).e=Rho_2020<=26.60 & Rho_2020>26.55;
I(7).e=Rho_2020<=26.70 & Rho_2020>26.60;
I(8).e=Rho_2020<=26.80 & Rho_2020>26.70;
I(9).e=Rho_2020<=max(max(Rho_2020)) & Rho_2020>26.80;
ind1=(linspace(0,230,9)/255)';
ind2=zeros(9,1);
ind3=ones(9,1);
color=[ind1,ind1,ind1];
%color=[0,0,0;0,0,255;255,0,0;0,255,0;255, 51, 255;0,255,255;255,255,0;192,192,192;0,0,0]/255;
for i2=1:9%numero de intervalos
    clear aux*
    auxTC=CT(I(i2).e);
    %auxTC=auxTC-nanmean(auxTC);
    auxSA=SA(I(i2).e);
    for i1=1:size(auxTC,2)
        H=scatter(auxSA(:,i1),auxTC(:,i1),10,color(i2,:),'filled');
    end
end
%cmap=cmocean('oxy')
%colormap(cmap);
% c10 = colorbar;
% c10.Label.String = 'Presión [dbar]';
% c10.Limits=[20 550];
% %set(c2,'Marker','o','MarkerSize',5*sz,'MarkerEdgeColor','none', ...
%  % 'MarkerFaceColor','b');

if exist('c1','var')
    clabel(c1,h,'labelspacing',360,'fontsize',8*sz,'color',[.5 .5 .5]);
end

 axis('square');
% axis([SA_min SA_max CT_min CT_max]);
%xlabel('Absolute Salinity, \it{S}\rm_A (g kg^-^1) ','fontsize',10*sz);
%ylabel('Conservative Temperature,  {\Theta} ({\circ}C)','fontsize',10*sz);
if exist('title_string','var')
    title([title_string],'fontsize',10*sz);
else
    %title('\it{S}\rm_A - {\Theta}  diagram','fontsize',10*sz);
end
set(gca,'tickdir','out');

line(SA_axis,CT_freezing,'LineStyle','--');

txt = text(0.01,0.99,[' p_r_e_f = ' int2str(p_ref) ' dbar'], ...
    'horiz','left','Vert','top','units','normalized','color',[.3 .3 .3]);
txt_fs = get(txt,'fontsize');
set(txt,'fontsize',txt_fs*sz);

end