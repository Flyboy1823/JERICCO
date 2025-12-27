function plot_eccentricity(t_tot,elements_vec)

global flags
figure
hold on
ecc = elements_vec(:,2);

plot(t_tot/60, ecc,'-','linewidth',3,'displayname','Eccentricity - MIND')

if flags.compare
data = load('HPOP_DATA_FOR_MIND.txt');
eccSTK = data(:,1);
hours = data(:,6)-data(1,6);
minutes = data(:,5)-data(1,5);
t_vec = hours*60+minutes;
plot(t_vec, eccSTK, '--','linewidth',3,'displayname','Eccentricity - STK')
end

xlabel('Time [min]')
ylabel('Eccentricity')
general_settings
hold off

end
