function [velocita] = calcolaVelocita(percorso, tempi)
    numeroGiunti = size(percorso,1);
    v = zeros(numeroGiunti, size(percorso, 2) - 1);
    velocita = zeros(numeroGiunti, size(percorso, 2));
    for j = 1: size(v, 1)
       for k = 1: size(v,2)
            v(j, k) = (percorso(j, k + 1) - percorso(j, k))/ (tempi(k + 1) - tempi(k));
       end
    end
    
    for j = 1: size(velocita, 1)
       for k = 1: size(velocita,2)
            if k ~= 1 && k ~= size(velocita,2)
                if(sign(v(j,k-1)) == sign(v(j, k)))
                    velocita(k) = 0.5*(v(j,k-1) + v(j, k));
                end
            end
       end
    end
    
end

