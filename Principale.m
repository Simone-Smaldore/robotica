percorso = [0 360, 90, 180];
[m, n] = size(percorso);

while true
    disp("                          MENU    ");
    disp("1. Sequenza di polinomi cubici con velocità assegnate");
    disp("2. Sequenza di polinomi cubici con velocità calcolate ");
    disp("3. sequenza di profili trapezoidali con anticipo temporale specificato  ");
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

    end
end



