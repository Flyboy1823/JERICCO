function plot_peri_apo(t_tot,elements_vec,const)

global flags
figure
hold on
a = elements_vec(:,1);
ecc = elements_vec(:,2);

peri = a.*(1-ecc);
apo = a.*(1+ecc);

peri_altitude = peri - const.alpha;
apo_altitude = apo - const.alpha;

plot(t_tot/60, peri_altitude,'-','linewidth',3,'displayname','Perilune - MIND','color','#4DBEEE')
plot(t_tot/60, apo_altitude,'-','linewidth',3,'displayname','Apolune - MIND','color','#EDB120')

if flags.compare
data = load('HPOP_DATA_FOR_MIND.txt');
peri_STK = data(:,2);
apo_STK = data(:,3);
% t_dates = datetime([data(:,7:9),data(:,6),data(:,5),zeros([length(data(:,5)),1])]);
hours = data(:,6)-data(1,6);
minutes = data(:,5)-data(1,5);
t_vec = hours*60+minutes;
plot(t_vec, peri_STK,'--','linewidth',3,'displayname','Perilune - STK','color','#0072BD')
plot(t_vec, apo_STK,'--','linewidth',3,'displayname','Apolune - STK','color','#D95319')
end

xlabel('Time [min]')
ylabel('Altitude [km]')
legend show
general_settings
hold off

end
