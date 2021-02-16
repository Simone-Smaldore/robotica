percorso = [0 3/pi*180 5/pi*180];
[m, n] = size(percorso);

while true
    disp("                          MENU    ");
    disp("1. Sequenza di polinomi cubici con velocità assegnate");
    disp("2. Sequenza di polinomi cubici con velocità calcolate ");
    disp("3. Sequenza di profili trapezoidali con anticipo temporale specificato  ");
    disp("0. Esci ");
    scelta =  input('Fai la tua scelta: ');
    while scelta > 3 || scelta < 0
        scelta = input('Fai una scelta corretta: ');
    end
    if scelta == 0
        disp("Arrivederci");
        break
    end
    tempi = leggiTempi(n, 'tempi');
    if scelta == 1  
        velocita = leggiVelocita(m, n);     
        parametri = generaPolinomiCubici(percorso, velocita, tempi);
        stampaGrafico(parametri, tempi);
%         animazione(parametri, tempi, [], false);
    end

    if scelta == 2
        velocita = calcolaVelocita(percorso, tempi);
        parametri = generaPolinomiCubici(percorso, velocita, tempi);
        stampaGrafico(parametri, tempi);
%         animazione(parametri, tempi, [], false);
    end

    if scelta == 3
        [valoriC, isVelocita] = leggiParametriC(m, n);
        [q1c, q2c, tc] = generaTrapezi(percorso, tempi, valoriC, isVelocita);
        convalida = convalidaParametriTrapezio(percorso, tempi, q1c, q2c, isVelocita);
        if ~convalida
            disp("I parametri non sono validi inserisci dei valori adeguati.");
            continue;
        end
        anticipi = leggiTempi(n - 1 , 'anticipi');
        stampaGraficoTrapezi(q2c, tc, percorso, tempi, anticipi);
    end
end



