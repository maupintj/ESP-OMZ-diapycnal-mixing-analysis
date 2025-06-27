function [drhodP, rhoprom, pprom, ind] = calc_pend(x,y,information)
x=x(:);
y=y(:);
% x=rho_E02_01_1;
% y=P_E02_01_1;
% x=ones(16,1);
ql_info=information;
l=ql_info.diss_length;
m=ql_info.overlap;
n=size(x,1);
l=l*64;
m=m*64;
%m=ql_info_1.overlap;
%l=ql_info_1.diss_length;
num_of_segments = floor((n- m) / (l - m));
increment = l - m; % the shift from one segment to the next
select = 1:l; % the range of indices that are selected for a segment

for i1=1:num_of_segments
    xx = x(select,:); %extract the selected range
    yy = y(select,:);
    xx=xx-mean(xx);
    yy=yy-mean(yy);
    p_rho=polyfit(yy,xx,1);
    %p_rho(1)*(P_a7)+p_rho(2)
    drhodP(i1,1)=p_rho(1);
    rhoprom(i1,1)=mean(x(select,:));
    pprom(i1,1)=mean(y(select,:));
    %N2(i1)=9.8.*drhodP./(rhoprom+1000);
    ind(i1,1:2)=[select(1) select(end)];
    xx=[];
    yy=[];
    p_rho=[];
    select = select + increment;
end


