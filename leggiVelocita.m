function [velocita] = leggiVelocita(m, n)
    velocita = [];
    for i = 1 : m
        for j = 1 : n
            formato = 'Inserisci velocità del giunto %d nel punto %d del percorso: ';
            stringa = sprintf(formato, i, j);
            velocita(i, j) = input(stringa);
        end
    end
end

