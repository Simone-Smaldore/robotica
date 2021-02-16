function [] = stampaGraficoTrapezi(q2c, tc, percorso, tempi, anticipi)
    [m, n] = size(percorso);
    qspazio = [];
    qvelocita = [];
    qaccelerazione = [];
    for k = 1 : n - 1
        t = linspace(tempi(k), tempi(k+1), 1000);
        for j = 1 : m
            for dt = 1 : size(t, 2)
                if tempi(k) <= t(dt) && t(dt) <= tc(j,k) + tempi(k)
                    qspazio(j, k, dt) = percorso(j,k) + 0.5 * q2c(j,k) * (t(dt) - tempi(k))^2;
                    qvelocita(j,k, dt) = q2c(j,k) * (t(dt) - tempi(k));
                    qaccelerazione(j, k, dt) = q2c(j,k);
                elseif tc(j,k) + tempi(k) < t(dt) && t(dt) <= tempi(k+1) - tc(j,k)
                    qspazio(j,k,dt) = percorso(j,k) + q2c(j,k) * tc(j,k) * ((t(dt) - tempi(k)) - 0.5*tc(j,k));
                    qvelocita(j,k, dt) = q2c(j,k) * tc(j,k);
                    qaccelerazione(j,k,dt) = 0;
                else
                    qspazio(j,k,dt) = percorso(j,k+1) - 0.5 * q2c(j,k) * (tempi(k+1) -tempi(k) - (t(dt) - tempi(k)))^2;
                    qvelocita(j,k,dt) = q2c(j,k) * (tempi(k+1) - tempi(k) - (t(dt) - tempi(k)));
                    qaccelerazione(j,k,dt) = -q2c(j,k);
                end        
            end
        end
    end
%     s = zeros(size(qspazio));
%     v = zeros(size(qvelocita));
%     a = zeros(size(qaccelerazione));
%   for k = 1: n - 1
%         int(k) = linspace(tempi(k) - anticipi(k), tempi(k + 1) - anticipi(k), 1000);
% 
%   end 
%   for k = 1: n - 1
%       for j = 1:n
%           for i = 1 : size(int,2)
%             if int(k) < min(int(k+1))
%                 s = qspazio(j, k, i);
%             else
%                 
%                 s = qspazio(j, k, i) + qspazio(j, k + 1, i);
%           end
%           
%       end
% 
%   end
    for k = 1: n - 1
        t = linspace(tempi(k) - anticipi(k), tempi(k + 1) - anticipi(k), 1000);
        for j = 1 : m
            figure(j)
            subplot(3,1,1);
            plot(t, reshape(qspazio(j,k,:), [1 1000]));  
            hold on;
            subplot(3,1,2);
            plot(t, reshape(qvelocita(j,k,:), [1 1000]));
            hold on
            subplot(3,1,3);      
            plot(t, reshape(qaccelerazione(j,k,:), [1 1000]));
            hold on
        end
    end 

end

