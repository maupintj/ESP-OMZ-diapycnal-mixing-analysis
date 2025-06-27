function d = geodist(lat1,lon1,lat2,lon2)

% calcula distancia entre dos puntos geograficos dada su latitud y longitud
% tomando en cuenta la forma eliptica de la tierra
%    d = geodist(lat1,lon1,lat2,lon2)
% entrega distancia d en km.
% orpa 26/01/97

% radio polar

rp = 6356.8927; % km
% radio Equatorial  
re = 6378.1602; % km
% factor entre radios
fac = re/rp;

% convierte angulos a radianes
lat1 = lat1*pi/180;
lat2 = lat2*pi/180;
lon1 = lon1*pi/180;
lon2 = lon2*pi/180;
% distancia basada en la circunferencia polar
if (lat1 == lat2 && lon1 == lon2) % si la posición es la misma retorna 0
    d = 0;
else
    d = rp*acos((sin(lat1).*sin(lat2)) + ...
        cos(lat1).*cos(lat2).*cos(lon2*fac-lon1*fac));
end

% OBS: la distancia basada en la circ eq. es igual solo se usa re
%       y se invierte el factor
% por ejemplo:
% fac=rp/re;
% d= re* acos((sin(lat1).*sin(lat2)) + ...
%     (cos(lat1).*cos(lat2).*cos(lon2*fac-lon1*fac)));

