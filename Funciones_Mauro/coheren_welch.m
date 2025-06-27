function P = coheren_welch(x,y,k,pover,p2);
% function P = coheren_welch(x,y,k,pover,p2);
%
% Estimación de la densidad espectral y los espectros de coherencia y fase
% entre dos pares de series de tiempo usando el metodo de Welch
% Analysis of the two sequences X and Y, using the Welch method of power
% spectrum densitie estimation.
%
%  Input:
%
%    x,y       vector con series de tiempo
%    k         numero de segmentos
%    pover     porcentage de datos a superponer para acercarse a la
%              potencia de dos mas cercana (e.g. 10%)
%    p2        define la potencia de 2 mas cerca
%              p2 = 0; usa la primera potencia de 2 mas cercana
%              p2 = 1; usa la segunda potencia de 2 mas cercana
%              p2 = 2; usa la tercera potencia de 2 mas cercana
%
%  Output:
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
%        Ejemplo   P = coheren_welch(x,y,5,10,0);
%
% SAM ECM 2020/07/14


  x = x(:);          % se asegura que x e y sean vectores columna
  y = y(:);
  n = max(size(x));  % longitud de la serie
  m = fix(n/k);      % largo de los segmentos
  if  p2 < 1 p2 = 0; elseif p2 > 3, p2 = 3; end
  if  k < 2, k = 2; end
  
% Determina el numero de datos a superponer considerando la potencia
% de dos mas cercana y el % de datos a superponer

    % numero de datos para llegar a la potencia de dos mas cercana 
      npadd = 2^(fix(log(m)/log(2) + 0.4999))-m;  
      p2c   = m + npadd; % potencia de 2 mas cercana
      
    % determina el numero de datos a superponer        
      if npadd < 0 & abs(npadd) <= fix(m*pover/100) % negativo
         nover = 0;     % numero de datos a superponer
         m = m + npadd; % acorta la longitud del trozo a la potencia de 2
      elseif npadd < 0 & abs(npadd) > fix(m*pover/100) % negativo
         nover = fix(m*pover/100);
         m = m + nover;
      end
 
      if npadd > 0 & abs(npadd) <= fix(m*pover/100) % positivo
         nover = npadd;
         m = m + nover;
      elseif npadd > 0 & abs(npadd) > fix(m*pover/100) % positivo
         nover = fix(m*pover/100);
         m = m + nover;
      end
      
% numero de datos para llegar a la potencia de dos "p2c" 
  npadd = 2^(fix(log(m+1)/log(2)+ 0.4999 + p2))-m;  
  p2c   = m + npadd; % potencia de 2 mas cercana

% define la ventana espectral 
  w = hanning(m);   % ventana espectral Hanning
  U = norm(w)^2/2;  % factor de normalización
  KMU = k*m*U;
     
% Determina los espectros de potencia
 Pxx = zeros(p2c,1);
 Pyy = Pxx; Pxy = Pxx;
 index = 1:m;
 for i1=1:k
	xw = w.*detrend(x(index),'omitnan');
	yw = w.*detrend(y(index),'omitnan');
	index = [[i1*m-(i1+1)*nover+1]:[(i1+1)*m-(i1+1)*nover]];
	Xx = fft(xw,p2c);
	Yy = fft(yw,p2c);
	Pxx = Pxx + abs(Xx).^2;
	Pyy = Pyy + abs(Yy).^2;
	Pxy = Pxy + Yy.*conj(Xx);
 end

   % determina las frecuencias obtenidas en la FFT
    nx = length(Pxx(:,1));
    k = [1:fix(nx/2)];
    k = [0., k, -k(fix((nx-1)/2):-1:1)]';
    Fs = k/nx; % Frecuencia

    Cxy = (abs(Pxy).^2)./(Pxx.*Pyy); % Coherencia cuadrada
    Fxy = angle(Pxy)*180/pi;         % Fase en grados

    PPxx = Pxx/(Fs(2)-Fs(1));        % Densidad espectral
    PPyy = Pyy/(Fs(2)-Fs(1));        % Densidad espectral
 
    P = [Fs [PPxx PPyy]/KMU Cxy Fxy];
    P = P(1:fix(nx/2)+1,:);           % Toma solo la mitad del espectro


% ** Ejemplo con una serie sintetica **
%    tt = [0:1:1600-1]'; % caso negativo 1200 1600; caso positivo 1000 1200
%    dt = 1;
%    s1 = 10 * cos(2*pi/10*tt-0) + 8 * cos(2*pi/25*tt-0*pi/180);
%    s2 = 12 * cos(2*pi/50*tt-45*pi/180) + 20 * cos(2*pi/80*tt-30*pi/180);
%    s3 = 28 * cos(2*pi/100*tt-120*pi/180) + 40 * cos(2*pi/160*tt-0*pi/180);
%    s4 = rand(length(tt),1)*5;
%    tl = 0.08 * tt;
%    s = s1 + s2 + s3 + s4; %+ tl;
%    clear s1 s2 s3 s4 tl
% 
%    P = coheren_welch(s,s,3,10,0);
%    clf
%    semilogy(1./P(:,1),P(:,2),'-*')
%    grid, hold on
%    
%    for i1=4:20
%    P = coheren_welch(s,s,i1,10,0);
%    semilogy(1./P(:,1),P(:,2),'-*')
%    end


 
 