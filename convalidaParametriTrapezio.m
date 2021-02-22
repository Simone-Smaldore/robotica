function [convalida] = convalidaParametriTrapezio(percorso, tempi, q1c ,q2c, isVelocita)
    [m,n] = size(percorso);
    convalida = true;
    for k = 1: n - 1
       for j = 1: m 
           if isVelocita
               if abs(q1c(j, k)) <= abs(percorso(j,k+1) - percorso(j,k))/(tempi(k+1) - tempi(k)) || abs(q1c(j, k)) > 2 * abs(percorso(j,k+1) - percorso(j,k))/(tempi(k+1) - tempi(k))
                   convalida = false;
               end
           else
               if abs(q2c(j, k)) < 4*abs(percorso(j,k+1) - percorso(j,k))/(tempi(k+1) - tempi(k))^2 
                   convalida = false;
               end
               if sign(q2c(j, k)) ~= sign(percorso(j,k+1) - percorso(j,k))
                   convalida = false;
               end
           end
       end
    end
end

