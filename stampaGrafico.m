function [] = stampaGrafico(parametri, tempi)
    for i = 1: size(tempi, 2) - 1
        t = linspace(tempi(i), tempi(i + 1));
        for j = 1 : size(parametri, 1)
            figure(j)
            formato = 'Giunto %d';
            stringa = sprintf(formato, j);
            sgtitle(stringa, 'Color','red');
            poly = parametri(j, i, :);
            polyVec = reshape(poly, [1,4]);
            subplot(3,1,1);
            title('Posizione');
            plot(t, polyval(polyVec, t));  
            hold on;
            subplot(3,1,2);
            title('Velocità');
            plot(t, polyval(polyder(polyVec), t));
            hold on
            subplot(3,1,3);    
            title('Accelerazione');
            plot(t, polyval(polyder(polyder(polyVec)), t));
            hold on
        end
    end 
end

