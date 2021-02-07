function [] = animazione(parametri, tempi)
    count = 1;
    for i = 1 : size(tempi, 2) - 1
       t = linspace(tempi(i), tempi(i + 1));
       for j = 1 : size(t, 2)
           q = polyval(parametri(i, :), t(j));
           x = cos(q);
           y = sin(q);
           plot([0, x], [0, y], 'linewidth', 2);
           axis([-2 2 -2 2]);
           pause(tempi(i) / size(t, 2));
           frames(count) = getframe(gcf);
           count = count + 1;
       end
    end
    
    movie(frames);
    videoFile = VideoWriter('animazione', 'MPEG-4');
    open(videoFile);
    writeVideo(videoFile, frames);
    close(videoFile);
end

