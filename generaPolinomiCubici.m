function [parametri] = generaPolinomiCubici(percorso, velocita, tempi)
    parametri = zeros(length(percorso) - 1, 4);
    for i = 1 : length(percorso) - 1
        Q = generaMatrice(tempi(i), tempi(i + 1));
        parametri(i, :) = ([percorso(i) velocita(i) percorso(i + 1) velocita(i + 1)] * inv(Q));
        parametri(i, :) = linsolve(Q, [percorso(i); velocita(i); percorso(i + 1); velocita(i + 1)]);
    end

end

function [Q] = generaMatrice(t1, t2)
    Q = zeros(4);
    Q(1,1) = t1^3;
    Q(1,2) = t1^2;
    Q(1,3) = t1;
    Q(1,4) = 1;
    Q(2,1) = 3*t1^2;
    Q(2,2) = 2*t1;
    Q(2,3) = 1;
    Q(2,4) = 0;
    Q(3,1) = t2^3;
    Q(3,2) = t2^2;
    Q(3,3) = t2;
    Q(3,4) = 1;
    Q(4,1) = 3*t2^2;
    Q(4,2) = 2*t2;
    Q(4,3) = 1;
    Q(4,4) = 0;  
end

