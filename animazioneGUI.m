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
                        x(k+1) = x(k) + cosd(q(k));
                        y(k+1) = y(k);
                        z(k+1) = z(k) + sind(q(k));
                    else
                        x(k+1) = x(k) + cosd(q(k));
                        y(k+1) = y(k) + sind(q(k));
                        z(k+1) = z(k);
                    end
                else
                   if strcmp(ref, 'x')
                        x(k+1) = q(k) + x(k);
                    elseif strcmp(ref, 'y')
                        y(k+1) = q(k) + y(k);
                   else
                        z(k+1) = q(k) + z(k);
                   end
                end
            end
           
            for k = 1 : size(parametri, 1) - 1
                plot3(uiaxes, [x(k), x(k+1)], [y(k), y(k+1)], [z(k), z(k+1)], 'linewidth', 2);
                hold(uiaxes, 'on');
                shadeColor = [.85,.85,.85];
                plot3(uiaxes, [x(k), x(k+1)], [y(k), y(k+1)], [0, 0],'-','Color',shadeColor,'LineWidth',2); 
                plot3(uiaxes, [x(k), x(k+1)], [2, 2], [z(k), z(k+1)],'-','Color',shadeColor,'LineWidth',2); 
                plot3(uiaxes, [2, 2], [y(k), y(k+1)], [z(k), z(k+1)],'-','Color',shadeColor,'LineWidth',2);
                hold(uiaxes, 'off');
            end
            
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
