function [percorso] = immettiPercorso()
    disp("Inserimento percorso nello spazio dei giunti");
    i = 1;
    percorso = [];
    while true
       richiestaNumero = 'Inserisci variabile percorso: '; 
       variabile = input(richiestaNumero);
       if ~isnumeric(variabile)
           disp('Inserisci una variabile di giunto adeguata');
           continue;
       end
       percorso(i) = str2double(variabile);   
       altroPunto = 'Vuoi inserire altri punti nel percorso? [Y/N] ';
       str = input(altroPunto,'s');
       while str ~= 'Y' && str ~= 'y' && str ~= 'N' && str ~= 'n'
           rispostaAdeguata = 'Inserire una risposta adeguata [Y/N]: ';
           str = input(rispostaAdeguata,'s');
       end
       if str == 'N' || str == 'n'
           break
       end   
       i = i + 1;
    end
end

