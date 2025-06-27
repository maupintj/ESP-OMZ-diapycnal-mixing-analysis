function [zi,npu]=interpola(x,y,z,xi,yi,dx,dy,op)
% interpola la variable z en las posiciones xi, yi
% dado que z es conocida en las posiciones x, y
%      function zi=interpola(x,y,z,xi,yi,dx,dy,op)
% si op ~= 2: El metodo es lineal dentro del radio dado por dx y dy 
% es decir los pesos están dados por inverso de distancia al punto xi,yi
% Si op == 2: Usa inverso del cuadrado de la distancia (ver líne 49)
%
% Si no hay valores en torno a xi e yi en el radio dado retorna NaN
% dx y dy deben ser positivos
%
% Orpa 06 de mayo 2011  se  incluyó inverso distancia en Ago 2018


% Convierte todo a vector
x = x(:);
y = y(:);
z = z(:);
% Remueve NaN de los vectores
ind = find(~isnan(z));
z = z(ind); x=x(ind); y=y(ind);


nx = length(x);
ny = length(y);
nz = length(z);
nxi = length(xi);
nyi = length(yi);
if nx ~= ny || nx~=nz
    disp('Error: x, y, z deben ser de la misma longitud')
    return
end
if nxi ~= nyi
    disp('Error: xi e yi deben ser de la misma longitud')
    return
end

zi = zeros(nxi,1)+NaN;
npu = zi;
for i = 1:nxi
    % restringe x
    indx = x > xi(i)-dx & x < xi(i)+dx;
    zaux = z(indx);
    yaux = y(indx);
    xaux=x(indx);
    
    % Busca sólo en valores de y que ya cumplen criterio x
    ind = yaux > yi(i)-dy & yaux < yi(i)+dy;
    zaux = zaux(ind);
    xaux = xaux(ind);
    yaux = yaux(ind);
    
    % calcula distancias de puntos en rango dado (usa modulo complejo
    d = abs((xaux-xi(i))+sqrt(-1)*(yaux-yi(i)));
    % Si la distancia es cero 
    
    % Calcula distancias al cuadrado normalizada
    % si hay un solo punto y coincide con xi, yi d=0 luego sum(d=0)
    if sum(d) == 0 
        d1 = 1;
        d2 = 1;
    else
        d1 = (1./d)./sum(1./d);
        d2 = (1./(d.^2))./sum(1./(d.^2));
    end
    % Promedia los valores dentro del rango dx y dy
    % usando distancia proporcional
    npu(i) = length(zaux);
    if npu(i) > 0
        if op == 2
            % Promedio usando distancias al cuadrado puntos en rango dx y dy
            zi(i) = sum(zaux.*d2);
        else
            % Promedia pesando por la distancia dentro del rango dx y dy
            zi(i) = sum(zaux.*d1);
        end
    end
end

return