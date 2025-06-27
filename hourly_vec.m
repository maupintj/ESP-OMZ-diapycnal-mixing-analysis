function [datetime,gregtime] = hourly_vec(y1,y2,h1,h2,dt)


c = 1;
c2 = 1;
fecha = NaN(1);
greg = NaN(1,6);

for i = y1:y2
    for j = 1:12
        if j == 1|| j==3 || j==5 || j==7 || j==8 || j==10 || j==12
            for k = 1:31
                for h=h1:dt:h2
                    fecha(c,1) = datenum(i,j,k,h,0,0);
                    greg(c,:) = [i ; j; k; h; 0; 0];
                    c=c+1;
                end
            end
        end
        if j == 4 || j==6 || j==9 || j==11
            for k = 1:30
                for h=h1:dt:h2
                    fecha(c,1) = datenum(i,j,k,h,0,0);
                    greg(c,:) = [i ; j; k; h; 0; 0];
                    c=c+1;
                end
            end
        end
        if j == 2
            if i == 2000 || i==2004 || i==2008 || i==2012 || i==2016 || i==2020
                for k =1:29 
                    for h=h1:dt:h2
                        fecha(c,1) = datenum(i,j,k,h,0,0);
                        greg(c,:) = [i ; j; k; h; 0; 0];
                        c=c+1;
                    end
                end
            else
                for k =1:28 
                    for h=h1:dt:h2
                        fecha(c,1) = datenum(i,j,k,h,0,0);
                        greg(c,:) = [i ; j; k; h; 0; 0];
                        c=c+1;
                    end
                end
            end
        end
    end
end

datetime = fecha;
gregtime = greg;