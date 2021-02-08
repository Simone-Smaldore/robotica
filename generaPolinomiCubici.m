function [parametri] = generaPolinomiCubici(percorso, velocita, tempi)
    [m, n] = size(percorso);
    parametri = zeros(m, n, 4);
    for i = 1 : n - 1
        Q = generaMatrice(tempi(i), tempi(i + 1));
        for j = 1 : m
            %parametri(i, :) = [percorso(i) velocita(i) percorso(i + 1) velocita(i + 1)] / Q;
            parametri(j, i, :) = linsolve(Q, [percorso(j, i); velocita(j, i); percorso(j, i + 1); velocita(j, i + 1)]);
        end
    end

end

function [Q] = generaMatrice(t1, t2)
    Q = zeros(4);
    Q(1,:) = [t1^3, t1^2, t1, 1];
    Q(2,:) = [3*t1^2, 2*t1, 1, 0];
    Q(3,:) = [t2^3, t2^2, t2, 1];
    Q(4,:) = [3*t2^2, 2*t2, 1, 0];
end

