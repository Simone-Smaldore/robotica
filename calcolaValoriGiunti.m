function [qspazio, qvelocita, qaccelerazione] = calcolaValoriGiunti(q2c, tc, percorso, tempi)
    [m, n] = size(percorso);
    qspazio = [];
    qvelocita = [];
    qaccelerazione = [];
    for k = 1 : n - 1
        passo = 100 * (tempi(k+1) - tempi(k));
        t = linspace(tempi(k), tempi(k+1), passo);
        for j = 1 : m
            for dt = 1 : size(t, 2)
                intervalloRel = t(dt) - tempi(k);
                intervalloLen = tempi(k+1) - tempi(k);
                if tempi(k) <= t(dt) && t(dt) <= tc(j,k) + tempi(k)
                    qspazio(j, k, dt) = percorso(j,k) + 0.5 * q2c(j,k) * (intervalloRel)^2;
                    qvelocita(j,k, dt) = q2c(j,k) * (intervalloRel);
                    qaccelerazione(j, k, dt) = q2c(j,k);
                elseif tc(j,k) + tempi(k) < t(dt) && t(dt) <= tempi(k+1) - tc(j,k)
                    qspazio(j,k,dt) = percorso(j,k) + q2c(j,k) * tc(j,k) * (intervalloRel - 0.5*tc(j,k));
                    qvelocita(j,k, dt) = q2c(j,k) * tc(j,k);
                    qaccelerazione(j,k,dt) = 0;
                else
                    qspazio(j,k,dt) = percorso(j,k+1) - 0.5 * q2c(j,k) * (intervalloLen - intervalloRel)^2;
                    qvelocita(j,k,dt) = q2c(j,k) * (intervalloLen - intervalloRel);
                    qaccelerazione(j,k,dt) = -q2c(j,k);
                end        
            end
        end
    end
end

