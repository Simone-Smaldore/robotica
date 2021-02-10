function [] = animazioneGUI(parametri, tempi, tipologie, uiaxes, salvaVideo)
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
           for k = 1 : size(parametri, 1)
               poly = parametri(k, i, :);
               polyVec = reshape(poly, [1,4]);
               q(k) = polyval(polyVec, t(j));
               if (k == 1)
                   x(k) = 0;
                   y(k) = cosd(q(k));
                   z(k) = sind(q(k));
               else
                   x(k) = x(k-1) + cosd(q(k));
                   y(k) = y(k-1) + sind(q(k));
                   z(k) = z(k-1);
               end
           end
           
           for k = 1 : size(parametri, 1) - 1
               plot3(uiaxes, [0, x(k), x(k+1)], [0, y(k), y(k+1)], [0, z(k), z(k+1)], 'linewidth', 2);
               hold(uiaxes, 'on');
               shadeColor = [.85,.85,.85];
               plot3(uiaxes, [0, x(k), x(k+1)], [0, y(k), y(k+1)], [0, 0, 0],'-','Color',shadeColor,'LineWidth',2); 
               plot3(uiaxes, [0, x(k), x(k+1)], [2, 2, 2], [0, z(k), z(k+1)],'-','Color',shadeColor,'LineWidth',2); 
               plot3(uiaxes, [2, 2, 2], [0, y(k), y(k+1)], [0, z(k), z(k+1)],'-','Color',shadeColor,'LineWidth',2);
               hold(uiaxes, 'off');
           end
           axis([-2 2 -2 2 0 4]);
           grid on
           %pause(0.01)
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
