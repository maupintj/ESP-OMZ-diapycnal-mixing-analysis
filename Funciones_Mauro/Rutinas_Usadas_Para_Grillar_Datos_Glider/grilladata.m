function [zi, nd]=grilladata(x,y,z,xi,yi,dx,dy,op)
%
% Función para grillar datos usando función de interpolación 
% simple creada por ORPA. Esta función simplemente promedia los valores
% observados dentro de un radio dado usando inverso de distancia o inverso
% del cuadrado de la distancia (si op=2).
%
%     [zi, nd] =grilladata(x,y,z,xi,yi,dx,dy,op)
%  zi es la grilla con datos interpolados y tiene igual tamaño que xi y yi
%  x,y son las coordenadas de los datos dados en z
%  xi y yi son las grillas donde se evaluarán los datos
%  dx y dy son los radios (distancias correspondientes donde busacr datos)
%
% ORPA Octubre 2016

[nf1, nc1] = size(xi);
[nf2, nc2] = size(yi);
if nf1 ~= nf2 || nc1 ~=nc2
   disp('Los tamaños de vectores xi e yi deben ser iguales') 
   return
end

% itera para repetir la interpolación
zi = zeros(nf1,nc1);
nd = zi;
for i = 1:nf1
    for j = 1:nc1
        [zi(i,j),nd(i,j)] = interpola(x,y,z,xi(i,j),yi(i,j),dx,dy,op);
    end
end

return


