function [] = animazioneGUI(parametri, tempi, tipologie, riferimenti, uiaxes, salvaVideo)
    disp('Animazione in esecuzione...')
    if (salvaVideo)
        count = 1;
        num_frames = size(tempi, 2) * 100 * size(parametri, 1); % 100 viene da linspace
        frames = struct('cdata', cell(1,num_frames), 'colormap', cell(1,num_frames));
    end
    for i = 1 : size(tempi, 2) - 1
        t = linspace(tempi(i), tempi(i + 1));
        for j = 1 : size(t, 2)
            q = zeros(size(parametri, 1));
            x = [0];
            y = [0];
            z = [0];
            for k = 1 : size(parametri, 1)            
                poly = parametri(k, i, :);
                polyVec = reshape(poly, [1,4]);
                q(k) = polyval(polyVec, t(j));
                tipo = tipologie{k};
                ref = riferimenti{k};
                if strcmp(tipo, 'Rotoidale')
                    if strcmp(ref, 'x')
                        x(k+1) = x(k);
                        y(k+1) = y(k) + cosd(q(k));
                        z(k+1) = z(k) + sind(q(k));
                    elseif strcmp(ref, 'y')
                        x(k+1) = x(k) + sind(q(k));
                        y(k+1) = y(k);
                        z(k+1) = z(k) + cosd(q(k));
                    else
                        x(k+1) = x(k) + cosd(q(k));
                        y(k+1) = y(k) + sind(q(k));
                        z(k+1) = z(k);
                    end
                else
                   if strcmp(ref, 'x')
                        x(k+1) = q(k) + x(k);
                        y(k+1) = y(k);
                        z(k+1) = z(k);
                    elseif strcmp(ref, 'y')
                        x(k+1) = x(k);
                        y(k+1) = q(k) + y(k);
                        z(k+1) = z(k);
                   else
                        x(k+1) = x(k);
                        y(k+1) = y(k);
                        z(k+1) = q(k) + z(k);
                   end
                end
            end
            
      
         
            P0 = zeros(size(parametri, 1), 3);
            P1 = zeros(size(parametri, 1), 3);
            for k = 1 : size(parametri, 1) + 1
                if k > 1 
                    P0(k ,1) = x(k-1);
                    P0(k ,2) = y(k-1);
                    P0(k ,3) = z(k-1);
                P1(k ,1) = x(k);
                P1(k ,2) = y(k);
                P1(k ,3) = z(k);
                end
            end
            X = [P0(:,1) P1(:,1)];
            Y = [P0(:,2) P1(:,2)];
            Z = [P0(:,3) P1(:,3)];
            plot3(uiaxes,X',Y',Z','linewidth', 2)
            
            grid on
%             pause(0.01)
            pause(tempi(i+1) / size(t, 2));
            if (salvaVideo)
                frames(count) = getframe(gcf);
                count = count + 1;
            end
        end
    end
    
    if (salvaVideo)
        disp('Esportando il file video...')
        movie(frames);
        videoFile = VideoWriter('animazione', 'MPEG-4');
        open(videoFile);
        writeVideo(videoFile, frames);
        close(videoFile);
        disp('Fatto!')
    end
end
