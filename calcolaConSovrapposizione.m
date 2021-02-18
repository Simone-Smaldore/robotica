function sovrapp = calcolaConSovrapposizione(matriceSpazio)
    sovrapp = zeros(1, size(matriceSpazio, 2));
    for i = 1: size(matriceSpazio, 2)
        temp = matriceSpazio(:,i);
        sovrapp(i) = sum(matriceSpazio(:,i));
        if numel(temp(temp ~= 0)) == 2
            j = find(temp); 
            posizioni = matriceSpazio(j(1), :); 
            posNonNulle = posizioni(posizioni ~= 0);
            qf = posNonNulle(end); 
            sovrapp(i) = sovrapp(i) - qf;
        end
    end
end

