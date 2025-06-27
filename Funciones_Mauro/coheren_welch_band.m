function P = coheren_welch_band(x,y,gl,freq);
% function P = coheren_welch_band(x,y,gl,freq);
% Estimacion del espectro por bandas de frecuencia
% con distintos grados de libertad para cada una de ellas
%
% Input
%
%   x,y    vector column (time series)
%   gl     fredom of degree    (eg [30 20 10])
%   freq   range of frequency  (eg [0.5 0.1 0.01 0.001])
%
% Output
%
%         P = [Fs Pxx Pyy Cxy Fxy]
%
%  donde:
%         Fs        Frecuencia
%         Pxx       Densisdad espectral de x, Power spectral density of x
%         Pyy       Densisdad espectral de y, Power spectral density of y
%         Cxy       Coherencia cuadrada entre x e y, Coherence squared between x and y
%         Fxy       Diferencia de fase en grados, Phase in degree
%
%
% eg P = coheren_welch_band(x,y,[30 20 10 10],[0.5 0.1 0.01 0.001 0.0001]);
%
% SAM ECM 2020/07/22

% Prepara los datos y obtiene parametros
   gl   = gl(:);
   freq = freq(:);
   P = [];
   figure()
   % Calcula espectros usando distintos gl
   for i1=1:length(gl)
     k = fix(gl(i1)/2); %numero de trozos
     P1 = coheren_welch(x,y,k,10,0);
     
     a1 = find(P1(:,1) >= freq(i1+1) & P1(:,1) < freq(i1));
     if ~isempty(a1)
       if i1 == 1
          a1 = find(P1(:,1) >= freq(i1+1) & P1(:,1));
          P = [P1(a1,:)];
       elseif i1==length(gl)
          a1 = find(P1(:,1) < freq(i1));
          P = [P1(a1,:);P];  
       else
          P = [P1(a1,:);P];
       end
     end   
     loglog(P1(a1,1),P1(a1,2)), grid on, hold on
     clear a1
   end           
return

% % ** Ejemplo con una serie sintetica **
%    tt = [0:1:3200-1]'; % caso negativo 1200 1600; caso positivo 1000 1200
%    dt = 1;
%    s1 = 10 * cos(2*pi/10*tt-0) + 8 * cos(2*pi/25*tt-0*pi/180);
%    s2 = 12 * cos(2*pi/50*tt-45*pi/180) + 20 * cos(2*pi/80*tt-30*pi/180);
%    s3 = 28 * cos(2*pi/100*tt-120*pi/180) + 40 * cos(2*pi/160*tt-0*pi/180);
%    s4 = rand(length(tt),1)*5;
%    tl = 0.08 * tt;
%    s = s1 + s2 + s3 + s4; %+ tl;
%    clear s1 s2 s3 s4 tl
% 
% P = coheren_welch_band(s,s,[30 20 10 10],[0.5 0.1 0.01 0.001 0.0001]);
% grid
% loglog(P(:,1),P(:,2),'g-*')
