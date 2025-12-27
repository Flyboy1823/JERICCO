function plot_altitude(t_tot,tot_y,const)

global flags
figure
altitude = (tot_y(:,1).^2+tot_y(:,2).^2+tot_y(:,3).^2).^0.5 -const.alpha;
hold on

plot(t_tot/60, altitude,'-','linewidth',3,'displayname','Altitude - MIND')

if flags.compare
data = load('HPOP_DATA_FOR_MIND.txt');
altitudeSTK = data(:,4)-const.alpha;
hours = data(:,6)-data(1,6);
minutes = data(:,5)-data(1,5);
t_vec = hours*60+minutes;
plot(t_vec, altitudeSTK, '--','linewidth',3,'displayname','Altitude - STK')
end

xlabel('Time [min]')
ylabel('Altitude [km]')
general_settings
hold off

end
