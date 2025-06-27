function yf=filtermgap(y,p,cdnv)
% Filter a time series with gaps. Leaving the gaps as they are
% and removing tails of the filter to both sides of the all gaps
% yf = filtermgap(y,p,cdnv);
%
%    y can be a matrix in that case each column will be filtered
%
%    y = original time series with gaps indicated with code given in 
%        cndv (code for data no valid if cdnv is not especified cndv=NaN)
%    p = filter weights

[nf, nc] = size(y);
yf = zeros(nf,nc);
if nargin ==3
   for i = 1:nc
      yf(:,i) = filtergap(y(:,i),p,cdnv);
   end
else   % if code no valid data is NaN cdnv can be no indicated
   for i =1:nc
      yf(:,i) = filtergap(y(:,i),p);
   end
end

return