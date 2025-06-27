function xi=interpola_1DNaN(x,metodo,lg)
% ------
% Funci�n 
%           yi=interpola_1DNaN(x,'metodo',lg);
% 
% Remueve los NaN Interpolando linealmente las columnas (vectores) de x
% Encuentra los NaN e interpola usand interp1 y el metodo dado
% ver interp1 para elejir metodo de interpolaci�n
%
% note que interpola solo entre el primer y �ltimo valor v�lido. 
% Es decir, si el primer o �ltimo son NaN los deja NaN (no extrapola)
% Si una columna no tiene NaN la salta (dejandola tal cual)
% 
% lg:  es el largo del gap a interpolar: Si hay una brecha con m�s de lg
% datos no la interpola si lg no es especificado interpola todas las
% brechas independiente del largo del gap
%
%   ORPA oct 2011
%       Agregue parte para volver a poner NaN a brechas mayores a lg
%       Oct 2013 (Orpa)
% -------

[~, nc] = size(x);
xi=x+NaN;
for i = 1:nc
    ind = find(~isnan(x(:,i)));
    if ~isempty(ind)
        % note que interpola solo entre el primer valor v�lido y el �ltimo
        % si el primer o �ltimo son NaN los deja NaN (no extrapola)
        auxind = (ind(1):ind(end))';
        if nargin > 1
            xi(auxind,i) = interp1(ind,x(ind,i),auxind,metodo);
        else
            xi(auxind,i) = interp1(ind,x(ind,i),auxind);
        end
    end
end

% Si solo quiere completar brechas menores a cierto valor
% vuelve a poner NaN en brechas largas (> que lg)
if nargin > 2
    for j = 1:nc
      % encuentra los indices de gaps valores con NaN que son m�s largos
      % que lg   NOTA encuentra en String usando funci�n "regexp"
      % ind contendra ceros y unos luego suma 'A' codigo aschii 65
      % y donde hay unos quedar� "B" (codigo ascii 66) por eso se buscan lg B
      % seguidas usando "regexp" en [a, b] estar�n donde parte el gap y donde
      % termina
      aux = ['B{' num2str(lg) ',}'];
      ind = isnan(x(:,j))'; % debe ser vector fila
      [a, b] = regexp( char(ind+'A'), aux, 'start', 'end' );
      % reconvierte a gaps las brechas m�s largas que lg
      if ~isempty(a)
        for i = 1:length(a)
          xi(a(i):b(i),j) = NaN;
        end
      end
    end
end
   
    