function [] = stampaGraficoTrapezi(q2c, tc, percorso, tempi, anticipi)
    [m, n] = size(percorso);
    qspazio = [];
    qvelocita = [];
    qaccelerazione = [];
    for k = 1 : n - 1
        t = linspace(tempi(k), tempi(k+1), 100 * (tempi(k+1) - tempi(k)));
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
    tmax =  tempi(n) - sum(anticipi);
    intervalloTroncato = linspace(0, tmax, 100*tmax);
    for j = 1: m   
        figure(j)
        formato = 'Giunto %d';
        stringa = sprintf(formato, j);
        sgtitle(stringa, 'Color','red');
        matriceSpazio = [];
        matriceVelocita = [];
        matriceAccelerazione = [];
        for k = 1 : n - 1       
            spazio = reshape(qspazio(j,k,:), [1 (100 * (tempi(k+1) - tempi(k)))]);
            velocita = reshape(qvelocita(j,k,:), [1 (100 * (tempi(k+1) - tempi(k)))]);
            accelerazione = reshape(qaccelerazione(j,k,:), [1 (100 * (tempi(k+1) - tempi(k)))]);
            matriceSpazio(k,:) = circshift([repmat(zeros(size(spazio)), 1, k-1), spazio, repmat(zeros(size(spazio)),1 , n-1-k)], -anticipi(k) * 100);
            matriceVelocita(k,:) = circshift([repmat(zeros(size(velocita)), 1, k-1), velocita, repmat(zeros(size(velocita)),1 , n-1-k)], -anticipi(k) * 100);
            matriceAccelerazione(k,:) = circshift([repmat(zeros(size(accelerazione)), 1, k-1), accelerazione, repmat(zeros(size(accelerazione)),1 , n-1-k)], -anticipi(k) * 100);
            numcolumn = 1;
            secondoElemento = 2;
            terzoElemento = 3;
            if k == n - 1 && k ~= 1
                numcolumn = 2;
                secondoElemento = 3;
                terzoElemento = 5;
                subplot(3,2,2);
%                 plot(intervalloTroncato, sum(matriceSpazio(:,1:tmax*100)));
                matriceMedia = calcolaMediaMatrice(matriceSpazio);
                plot(intervalloTroncato, matriceMedia(1:tmax*100));
                title('Somma dei grafici di posizione');
                hold on;
                subplot(3,2,4);
                plot(intervalloTroncato, sum(matriceVelocita(:,1:tmax*100)));
                title('Somma dei grafici di velocità');
                hold on;
                subplot(3,2,6);
                plot(intervalloTroncato, sum(matriceAccelerazione(:,1:tmax*100)));
                title('Somma dei grafici di accelerazione');
                hold on;
            end
            t = linspace(tempi(k) - anticipi(k), tempi(k + 1) - anticipi(k), 100 * (tempi(k+1) - tempi(k)));
            subplot(3,numcolumn,1);
            plot(t, reshape(qspazio(j,k,:), [1 100 * (tempi(k+1) - tempi(k))]));  
            title('Posizione');
            hold on;
            subplot(3,numcolumn,secondoElemento);
            plot(t, reshape(qvelocita(j,k,:), [1 100 * (tempi(k+1) - tempi(k))]));
            title('Velocità');
            hold on
            subplot(3,numcolumn,terzoElemento);   
            plot(t, reshape(qaccelerazione(j,k,:), [1 100 * (tempi(k+1) - tempi(k))]));
            title('Accelerazione');
            hold on
        end
    end
    
end

function matriceMedia = calcolaMediaMatrice(matriceSpazio)
    matriceMedia = [];
    for i = 1: size(matriceSpazio, 2)
        temp = matriceSpazio(:,i);
        matriceMedia(i) = sum(matriceSpazio(:,i));
        if numel(temp(temp ~= 0)) == 2
            j = find(temp); % trova gli indici dei non nulli in temp
            posizioni = matriceSpazio(j(1), :); % uso il primo non nullo in temp per individuare qf
            posNonNulle = posizioni(posizioni ~= 0);
            qf = posNonNulle(end); % qf è lultimo dei non nulli nelle posizioni
            matriceMedia(i) = matriceMedia(i) - qf;
        end
    end
end

