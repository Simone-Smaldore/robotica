percorso = [0 180 360;
            0 360 520];
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
    if scelta == 1
        tempi = leggiTempi(n);
        velocita = leggiVelocita(m, n);     
        parametri = generaPolinomiCubici(percorso, velocita, tempi);
        stampaGrafico(parametri, tempi);
%         animazione(parametri, tempi, [], false);
    end

    if scelta == 2
        tempi = leggiTempi(n);
        velocita = calcolaVelocita(percorso, tempi);
        parametri = generaPolinomiCubici(percorso, velocita, tempi);
        stampaGrafico(parametri, tempi);
%         animazione(parametri, tempi, [], false);
    end

    if scelta == 3
        tempi = leggiTempi(n);
        [valoriC, isVelocita] = leggiParametriC(m, n);
        [q1c, q2c, tc] = generaTrapezi(percorso, tempi, valoriC, isVelocita);
        stampaGraficoTrapezi(q2c, tc, percorso, tempi);
    end
end



