function [percorso] = immettiPercorso()
    numGiunti = input('Quanti giunti vuoi considerare? ');
    numIntervalli = input('Quanti valori di variabili di giunto vuoi considerare? ');
    percorso = [];
    for i = 1: numGiunti
        for j = 1: numIntervalli
            formato = 'Inserisci variabile di giunto %d per il giunto %d : ';
            stringa = sprintf(formato ,j, i);
            percorso(i, j) = input(stringa);
        end
    end
end

