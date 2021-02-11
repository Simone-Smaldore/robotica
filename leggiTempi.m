function [tempi] = leggiTempi(n)
    tempi = [0];
    for i = 2 : n
        formato = 'Inserisci il tempo dal punto %d al punto %d: ';
        stringa = sprintf(formato, i-1, i);
        intervallo = input(stringa);
        tempi(i) = tempi(i-1) + intervallo;
    end
end

