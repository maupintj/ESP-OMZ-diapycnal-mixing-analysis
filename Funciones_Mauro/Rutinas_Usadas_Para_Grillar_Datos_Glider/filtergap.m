function yf = filtergap(y,p,cdnv)
% Filtering time series with gaps. Leaving the gaps as it is
% and removing tails of the filter to both sides of the gap
% yf = filtergap(y,p,cdnv);
%    y = original time series with gaps indicated with code given in 
%        cndv (code for no valid  data if cdnv is not especified cndv=NaN)
%    p = filter weights
%   ORPA 02/08/1996

nd = length(y(:,1)); % numero de datos
lp = length(p);
lpm = (lp-1)/2; % length of the tail

% find gaps
if nargin == 2
   ind = find(isnan(y));  
   else
   ind = find(y==cdnv);
end
% caso en que todos los datos son NO validos (NANs)
if length(ind) == nd
   yf=y;
   return
end
    

% replace index of gaps by zeros and filter
y2 = y;
y2(ind) = zeros(length(ind),1);
% filtra timeseries
yf = filter(p,1,y2);

% replace values in gaps and tails for NaN 
yf(ind) = NaN;
% do convolution between filtered vector with NaN and v 
% (Por ej.: v=[0 0 0 1 0 0 0] for 7 weigth)
% to propagate gaps to the tails
vc = zeros(lp,1);
vc(lpm+1) = 1;
yf = conv(yf,vc);
%remueve cola de la convolucion
yf([1:lpm length(yf)-lpm+1:length(yf)])=[]; 
%yf = yf(lpm+1:nd+lpm);

% Remueve colas de datos filtrados al comienzo y final de la serie
yf(1:lpm) = NaN;
yf(end-lpm+1:end) = NaN;

% if code for no valid data is different from NaN put cdnv instead of NaN
if nargin == 3
    ind = find(isnan(yf));
    yf(ind) = zeros(length(ind),1)+cdnv;
end
return
