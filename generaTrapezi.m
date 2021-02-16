function [q1c, q2c, tc] = generaTrapezi(percorso, tempi, valoriC, isVelocita)
    [m, n] = size(percorso);
    tc = zeros(m, n - 1);
    q1c = zeros(m, n - 1);
    q2c = zeros(m, n - 1);
    for i = 1: n - 1
        for j = 1: m
            if isVelocita
                q1c(j, i) = valoriC(j, i);
                tc(j, i) = (percorso(j, i) - percorso(j, i + 1) + q1c(j, i) * (tempi(i + 1)-tempi(i))) / q1c(j, i);
                q2c(j, i) = q1c(j, i)^2/(percorso(j, i) - percorso(j, i + 1) + q1c(j, i) * (tempi(i + 1)-tempi(i)));
            else
               
                q2c(j, i) = valoriC(j, i);
%                 if q2c(j,i) >= 0
%                     sottrazione = percorso(j, i+1) - percorso(j, i);
%                 else
%                     sottrazione = percorso(j, i) - percorso(j, i+1);
%                 end
                sottrazione = percorso(j, i+1) - percorso(j, i);
                tc(j, i) = 0.5*(tempi(i + 1)-tempi(i))- 0.5*sqrt(((tempi(i + 1)-tempi(i))^2 * q2c(j,i) - 4*(sottrazione))/q2c(j, i));
                q1c(j, i) = q2c(j, i) * tc(j, i);
            end
        end
    end
end

