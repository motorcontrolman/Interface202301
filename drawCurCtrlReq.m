function drawCurCtrlReq()
    figure();
    x1 = [0.05 1 1 0.05];
    y1 = [0 0 0.9 0.9];
    patch(x1, y1, 'black','EdgeColor','none','FaceAlpha',.3);
    hold on; grid on;
    x2_l = [0.3 1 1 0.3];
    y2_l = [0.9 0.9 0.99 0.99];
    patch(x2_l, y2_l, 'black','EdgeColor','none','FaceAlpha',.3);
    x2_u = [0.3 1 1 0.3];
    y2_u = [1.01 1.01 1.2 1.2];
    patch(x2_u, y2_u, 'black','EdgeColor','none','FaceAlpha',.3);
    x3 = [0 0.3 0.3 0];
    y3 = [1.05 1.05 1.2 1.2];
    patch(x3, y3, 'black','EdgeColor','none','FaceAlpha',.3);
    axis([0, 0.4, 0, 1.1]);
    xlabel("時間[s]");
    ylabel("電流[A]");
    
end
