function [] = stampaGraficoTrapezi(q2c, tc, percorso, tempi, anticipi)
    [m, n] = size(percorso);
    [qspazio, qvelocita, qaccelerazione] = calcolaValoriGiunti(q2c, tc, percorso, tempi);
    tmax =  tempi(n) - sum(anticipi);
    passo = 100 * tmax;
    intervalloTroncato = linspace(0, tmax, passo);
    for j = 1: m   
        figure(j)
        formato = 'Giunto %d';
        stringa = sprintf(formato, j);
        sgtitle(stringa, 'Color','red');
        matriceSpazio = [];
        matriceVelocita = [];
        matriceAccelerazione = [];
        for k = 1 : n - 1
            numTimestamp = 100 * (tempi(k+1) - tempi(k));
            spazio = reshape(qspazio(j,k,:), [1 numTimestamp]);
            velocita = reshape(qvelocita(j,k,:), [1 numTimestamp]);
            accelerazione = reshape(qaccelerazione(j,k,:), [1 numTimestamp]);
            anticipo = -anticipi(k) * 100;
            matriceSpazio(k,:) = circshift([repmat(zeros(size(spazio)), 1, k-1), spazio, repmat(zeros(size(spazio)),1 , n-1-k)], anticipo);
            matriceVelocita(k,:) = circshift([repmat(zeros(size(velocita)), 1, k-1), velocita, repmat(zeros(size(velocita)),1 , n-1-k)], anticipo);
            matriceAccelerazione(k,:) = circshift([repmat(zeros(size(accelerazione)), 1, k-1), accelerazione, repmat(zeros(size(accelerazione)),1 , n-1-k)], anticipo);
            if k == n - 1
                subplot(3,2,2);
                title('Somma dei grafici di posizione');
                sovrapposizione = calcolaConSovrapposizione(matriceSpazio);
                plot(intervalloTroncato, sovrapposizione(1 : passo));
                hold on;
                subplot(3,2,4);
                title('Somma dei grafici di velocità');
                plot(intervalloTroncato, sum(matriceVelocita(:, 1 : passo)));
                hold on;
                subplot(3,2,6);
                title('Somma dei grafici di accelerazione');
                plot(intervalloTroncato, sum(matriceAccelerazione(:, 1 : passo)));
                hold on;
            end
            subplot(3,2,2);
            title('Somma dei grafici di posizione');
            subplot(3,2,4);
            title('Somma dei grafici di velocità');
            subplot(3,2,6);
            title('Somma dei grafici di accelerazione');
            t = linspace(tempi(k) - anticipi(k), tempi(k + 1) - anticipi(k), numTimestamp);
            subplot(3,2,1);
            title('Posizione');
            plot(t, reshape(qspazio(j,k,:), [1 numTimestamp]));  
            hold on;
            subplot(3,2,3);
            title('Velocità');
            plot(t, reshape(qvelocita(j,k,:), [1 numTimestamp]));
            hold on
            subplot(3,2,5);   
            title('Accelerazione');
            plot(t, reshape(qaccelerazione(j,k,:), [1 numTimestamp]));
            hold on
        end
    end
    
end

