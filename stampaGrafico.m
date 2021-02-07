function [] = stampaGrafico(parametri, tempi)
    for i = 1: size(tempi, 2) - 1
        t = linspace(tempi(i), tempi(i + 1));      
        subplot(3,1,1);
        plot(t, polyval(parametri(i, :), t));  
        hold on;
        subplot(3,1,2);
        plot(t, polyval(polyder(parametri(i, :)), t));
        hold on;
        subplot(3,1,3);      
        plot(t, polyval(polyder(polyder(parametri(i, :))), t));
        hold on;
    end 
end

