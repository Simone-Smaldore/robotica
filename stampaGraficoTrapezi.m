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
            tempok = 100 * tempi(k);
            spazio = reshape(qspazio(j,k,1:numTimestamp), [1 numTimestamp]);
            velocita = reshape(qvelocita(j,k,1:numTimestamp), [1 numTimestamp]);
            accelerazione = reshape(qaccelerazione(j,k,1:numTimestamp), [1 numTimestamp]);
            anticipo = -anticipi(k) * 100;
            matriceSpazio(k,tempok +anticipo + 1: tempok + numTimestamp +anticipo) = spazio;
            matriceVelocita(k,tempok + anticipo + 1: tempok + numTimestamp+anticipo) = velocita;
            matriceAccelerazione(k,tempok+anticipo + 1: tempok + numTimestamp+anticipo) = accelerazione;
            numcolumn = 2;
            secondoElemento = 3;
            terzoElemento = 5;
            if n - 1 == 1
                numcolumn = 1;
                secondoElemento = 2;
                terzoElemento = 3;
            end
            if k == n - 1 && k ~= 1
                subplot(3,2,2);
                sovrapposizione = calcolaConSovrapposizione(matriceSpazio);
                plot(intervalloTroncato, sovrapposizione(1 : passo));
                title('Somma dei grafici di posizione');
                hold on;
                subplot(3,2,4);
                plot(intervalloTroncato, sum(matriceVelocita(:, 1 : passo)));
                title('Somma dei grafici di velocità');
                hold on;
                subplot(3,2,6);
                plot(intervalloTroncato, sum(matriceAccelerazione(:, 1 : passo)));
                title('Somma dei grafici di accelerazione');
                hold on;
            end
            t = linspace(tempi(k) - anticipi(k), tempi(k + 1) - anticipi(k), numTimestamp);
            subplot(3,numcolumn,1);
            plot(t, reshape(qspazio(j,k,1:numTimestamp), [1 numTimestamp]));  
            title('Posizione');
            hold on;
            subplot(3,numcolumn,secondoElemento);
            plot(t, reshape(qvelocita(j,k,1:numTimestamp), [1 numTimestamp]));
            title('Velocità');
            hold on
            subplot(3,numcolumn,terzoElemento);   
            plot(t, reshape(qaccelerazione(j,k,1:numTimestamp), [1 numTimestamp]));
            title('Accelerazione');
            hold on
        end
    end
    
end

