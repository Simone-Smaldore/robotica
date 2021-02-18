function [] = stampaGraficoTrapeziGUI(parent, q2c, tc, percorso, tempi, anticipi, j)
    [m, n] = size(percorso);
    [qspazio, qvelocita, qaccelerazione] = calcolaValoriGiunti(q2c, tc, percorso, tempi);
    tmax =  tempi(n) - sum(anticipi);
    passo = 100 * tmax;
    intervalloTroncato = linspace(0, tmax, passo);
    axesPos = subplot(6, 1, 1);
    axesPos.Parent = parent;
    axesPos.Title.String = 'Posizione';
    hold(axesPos, 'on');
    axesVel = subplot(6, 1, 2);
    axesVel.Parent = parent;
    axesVel.Title.String = 'Velocità';
    hold(axesVel, 'on');
    axesAcc = subplot(6, 1, 3);
    axesAcc.Parent = parent;
    axesAcc.Title.String = 'Accelerazione';
    hold(axesAcc, 'on');
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
        if k == n - 1 && k ~= 1
            axesSommaPos = subplot(6, 1, 4);
            axesSommaPos.Parent = parent;
            axesSommaPos.Title.String = 'Somma dei grafici di posizione';
            hold(axesSommaPos, 'on');
            sovrapposizione = calcolaConSovrapposizione(matriceSpazio);
            plot(axesSommaPos, intervalloTroncato, sovrapposizione(1 : passo));
            axesSommaVel = subplot(6, 1, 5);
            axesSommaVel.Parent = parent;
            axesSommaVel.Title.String = 'Somma dei grafici di velocità';
            hold(axesSommaVel, 'on');
            plot(axesSommaVel, intervalloTroncato, sum(matriceVelocita(:, 1 : passo)));
            axesSommaAcc = subplot(6, 1, 6);
            axesSommaAcc.Parent = parent;
            axesSommaAcc.Title.String = 'Somma dei grafici di accelerazione';
            hold(axesSommaAcc, 'on');
            plot(axesSommaAcc, intervalloTroncato, sum(matriceAccelerazione(:, 1 : passo)));
        end
        t = linspace(tempi(k) - anticipi(k), tempi(k + 1) - anticipi(k), numTimestamp);
        plot(axesPos, t, reshape(qspazio(j,k,1:numTimestamp), [1 numTimestamp]));
        plot(axesVel, t, reshape(qvelocita(j,k,1:numTimestamp), [1 numTimestamp]));
        plot(axesAcc, t, reshape(qaccelerazione(j,k,1:numTimestamp), [1 numTimestamp]));
    end
end