function [] = stampaGraficoTrapezi(q2c, tc, percorso, tempi)
    [m, n] = size(percorso);
    for k = 1 : n - 1
        t = linspace(tempi(k), tempi(k+1), 1000);
        qspazio = [];
        qvelocita = [];
        qaccelerazione = [];
        for dt = 1 : size(t, 2)
            if tempi(k) <= t(dt) && t(dt) <= tc + tempi(k)
                qspazio(dt) = percorso(1,1) + 0.5 * q2c * t(dt)^2;
                qvelocita(dt) = q2c * t(dt);
                qaccelerazione(dt) = q2c;
            elseif tc + tempi(k) < t(dt) && t(dt) <= tempi(k+1) - tc
                qspazio(dt) = percorso(1,1) + q2c * tc * (t(dt) - 0.5*tc);
                qvelocita(dt) = q2c * tc;
                qaccelerazione(dt) = 0;
            else
                qspazio(dt) = percorso(1,2) - 0.5 * q2c * (tempi(2) - t(dt))^2;
                qvelocita(dt) = q2c * (tempi(2) - t(dt));
                qaccelerazione(dt) = -q2c;
            end        
        end
    end
    subplot(3,1,1);
    plot(t, qspazio);  
    hold on;
    subplot(3,1,2);
    plot(t, qvelocita);
    hold on
    subplot(3,1,3);      
    plot(t, qaccelerazione);
    hold on
end

