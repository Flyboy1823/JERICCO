function plot_velocity(t,xya)

% T=params.T;
t_for_plot = t;
figure
% hold on
% if isfield(params,'timevec')
%     t_for_plot = t/T;
%     xlabel('# of revolutions')
%     xticks(params.timevec)
% else
%     t_for_plot = t;
%     xlabel('Time [s]')
% end
plot(t_for_plot, xya(:,4),'-','linewidth',1.5,'displayname','v_x(t)')
plot(t_for_plot, xya(:,5),'-','linewidth',1.5,'displayname','v_y(t)')
plot(t_for_plot, xya(:,6),'-','linewidth',1.5,'displayname','v_z(t)')
ylabel('v_x, v_y, v_z [km/s]')
title('The Relative Velocity of the Satellite')
legend show
general_settings
hold off

end