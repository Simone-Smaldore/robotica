function [tempi] = leggiTempi(n)
    tempi = [0];
    for i = 2 : n
        tempi(i) = input('Inserisci tempi: ');
    end
end

