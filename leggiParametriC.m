function [valori, isVelocita] = leggiParametroC(m, n)
    disp("COSA VUOI INSERIRE ?");
    disp("1. Le Velocità C");
    disp("2. Le Accelerazioni C");
    scelta =  input('Fai la tua scelta: ');
    while scelta > 2 || scelta < 1
        scelta = input('Fai una scelta corretta: ');
    end
    valori = [];
    for i = 1 : m
        for j = 1 : n - 1
            if scelta == 1
                isVelocita = true;
                formato = 'Inserisci velocità C del giunto %d nell intervallo %d del percorso: ';
                stringa = sprintf(formato, i, j);
                valori(i, j) = input(stringa);
            else
                isVelocita = false;
                formato = 'Inserisci accelerazione C del giunto %d nell intervallo %d del percorso: ';
                stringa = sprintf(formato, i, j);
                valori(i, j) = input(stringa);
            end
        end
    end
end

