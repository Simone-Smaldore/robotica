percorso = [0, pi, 0.7*pi, 0.5*pi];
n = length(percorso);

while true 
    disp("                          MENU    ");
    disp("1. Sequenza di polinomi cubici con velocità assegnate");
    disp("2. Sequenza di polinomi cubici con velocità calcolate ");
    disp("3. sequenza di profili trapezoidali con anticipo temporale specificato  ");
    disp("0. Esci");
    scelta =  input('Fai la tua scelta:');
    while scelta > 3 || scelta < 0
        scelta = input('Fai una scelta corretta:');
    end
    if scelta == 0
        disp("Arrivederci");
        break
    end
    if scelta == 1
        velocita = leggiVelocita(n);
        tempi = leggiTempi(n);
        parametri = generaPolinomiCubici(percorso, velocita, tempi);
        disp(parametri);
        stampaGrafico(parametri, tempi);   
    end

    if scelta == 2

    end

    if scelta == 3

    end
end



