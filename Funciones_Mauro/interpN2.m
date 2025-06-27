function [xx] = interpN2(x,y);
%E02_01_N2
%E02_01_P
%y=E02_01_P;
%x=E02_01_N2;
ind=x<0;
%x(ind)=0;
xx=interp1(y(~ind),x(~ind),y);

end




