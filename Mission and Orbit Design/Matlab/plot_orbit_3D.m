function plot_orbit_3D(xa)

global flags
% plot the orbit of the satellite in 3D
% plot3(xa(:,1),xa(:,2),xa(:,3),'-','linewidth',1.5,'displayname','trajectory','color',[255,174,201]/255)
if flags.maneuver == 2
    plot3(xa(:,1),xa(:,2),xa(:,3),'--','linewidth',1.5)
else
    plot3(xa(:,1),xa(:,2),xa(:,3),'-','linewidth',1.5)
end
plot3(xa(1,1),xa(1,2),xa(1,3),'*','linewidth',1.5,'markersize',10)
% position at t0 can be added
axis equal
xlabel('x(km)','interpreter', 'latex', 'fontsize', 21)
ylabel('y(km)','interpreter', 'latex','fontsize', 21)
zlabel('z(km)','interpreter', 'latex','fontsize', 21)
general_settings
legend show
end