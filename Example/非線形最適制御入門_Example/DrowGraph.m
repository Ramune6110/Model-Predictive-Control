function [] = DrowGraph(result, endtime, t_vec)
    % Figure
    figure(1);
    subplot(3, 1, 1);
    plot(result.time, result.xTrue(:, 1),'k','Linewidth',1); hold on; grid on;
    xlim([0 endtime]);
    xlabel('{\ittime}','FontName','Times New Roman','Fontsize',10.5)
    ylabel('{\itx}_{1}({\itt})','FontName','Times New Roman','Fontsize',10.5)

    subplot(3, 1, 2);
    plot(result.time, result.xTrue(:, 2),'k','Linewidth',1); hold on; grid on;
    xlim([0 endtime]);
    xlabel('{\ittime}','FontName','Times New Roman','Fontsize',10.5)
    ylabel('{\itx}_{2}({\itt})','FontName','Times New Roman','Fontsize',10.5)

    subplot(3, 1, 3);
    plot(result.time, result.u,'k','Linewidth',1); hold on;
    plot(result.time, 0.5 * ones(t_vec(2), 1), '--r'); hold on;
    plot(result.time, -0.5 * ones(t_vec(2), 1), '--r'); hold on;
    xlim([0 endtime]); ylim([-1 1]); grid on;
    xlabel('{\ittime}','FontName','Times New Roman','Fontsize',10.5)
    ylabel('{\itu}({\itt})','FontName','Times New Roman','Fontsize',10.5)
end