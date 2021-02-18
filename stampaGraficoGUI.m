function [] = stampaGraficoGUI(tab, parametri, tempi, j)
    tabAxesPos = subplot(3, 1, 1);
    tabAxesPos.Parent = tab;
    tabAxesPos.Title.String = 'Posizione';
    hold(tabAxesPos, 'on');
    tabAxesVel = subplot(3, 1, 2);
    tabAxesVel.Parent = tab;
    tabAxesVel.Title.String = 'Velocità';
    hold(tabAxesVel, 'on');
    tabAxesAcc = subplot(3, 1, 3);
    tabAxesAcc.Parent = tab;
    tabAxesAcc.Title.String = 'Accelerazione';
    hold(tabAxesAcc, 'on');
    for i = 1: size(tempi, 2) - 1
        t = linspace(tempi(i), tempi(i + 1));
        poly = parametri(j, i, :);
        polyVec = reshape(poly, [1,4]);
        plot(tabAxesPos, t, polyval(polyVec, t));
        plot(tabAxesVel, t, polyval(polyder(polyVec), t));
        plot(tabAxesAcc, t, polyval(polyder(polyder(polyVec)), t));
    end 
end