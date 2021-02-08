function [] = stampaGrafico(parametri, tempi)
    for i = 1: size(tempi, 2) - 1
        t = linspace(tempi(i), tempi(i + 1));
        for j = 1 : size(parametri, 1)
            figure(j)
            poly = parametri(j, i, :);
            polyVec = reshape(poly, [1,4]);
            subplot(3,1,1);
            plot(t, polyval(polyVec, t));  
            hold on;
            subplot(3,1,2);
            plot(t, polyval(polyder(polyVec), t));
            hold on
            subplot(3,1,3);      
            plot(t, polyval(polyder(polyder(polyVec)), t));
            hold on
        end
    end 
end

