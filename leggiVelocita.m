function [velocita] = leggiVelocita(n)
    velocita = [];
    for i = 1 : n
        velocita(i) = input('Inserisci velocita: ');
    end
end

