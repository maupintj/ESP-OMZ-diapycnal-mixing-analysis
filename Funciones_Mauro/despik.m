function [X, ind] = despik(x,a,information)
x=x(:);
%a=7;
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
select=select(:);
ind=[];
for i1=1:num_of_segments
    xx = x(select,:); %extract the selected range
    xx2=detrend(xx);
    xxstd=std(xx2);
    indx=(xx2>(a*xxstd) | xx2<(-a*xxstd));
    if ~isempty(select(indx))
        xx(indx)=mean(x(select,:));
        ind=[ind; select(indx)];    
    end
    x(select,:)=xx;
    ind=unique(ind);
    select = select + increment;
end
X=x;
end 
