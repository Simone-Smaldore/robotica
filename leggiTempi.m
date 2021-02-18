function [tempi] = leggiTempi(n, string)
    tempi = [0];
    for i = 2 : n
        formato = 'Inserisci %s tra il punto %d e il punto %d: ';
        stringa = sprintf(formato, string ,i-1, i);
        intervallo = input(stringa);
        if intervallo < 0
            intervallo = input('Inserire un tempo positivo: ');
        end
        tempi(i) = tempi(i-1) + intervallo;
    end
end

