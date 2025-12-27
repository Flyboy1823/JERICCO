% plot - for PDR
close all
% clear
clc

[time_mat25,perilune25,apolune25,time_mat0,perilune0,apolune0] = load_data;
t_dates25 = datetime(time_mat25);
t_dates0 = datetime(time_mat0);
figure

plot(t_dates25,perilune25,'-','linewidth',2,'displayname','Perilune \Omega=25^\circ','color','#4DBEEE')
hold on

plot(t_dates25,apolune25,'-','linewidth',2,'displayname','Apolune \Omega=25^\circ','color','#EDB120')
plot(t_dates0,perilune0,'--','linewidth',2,'displayname','Perilune \Omega=0^\circ','color','#0072BD')
plot(t_dates0,apolune0,'--','linewidth',2,'displayname','Apolune \Omega=0^\circ','color','#D95319')


xtickformat('MMM-yy')
ylabel('Altitude [km]')
general_settings

for i=1:length(t_dates25)
    for j=1:length(t_dates0)
        if strcmp(char(t_dates25(i)),char(t_dates0(j)))
            delta_apo(i) = apolune0(j)-apolune25(i);
            delta_peri(i) = perilune0(j)-perilune25(i);
            break
        end
    end

end

figure
plot(t_dates25,abs(delta_peri),'--','linewidth',2,'displayname','\Delta h_p','color','#4DBEEE')
hold on
plot(t_dates25,delta_apo,'--','linewidth',2,'displayname','\Delta h_a','color','#EDB120')
xtickformat('MMM-yy')
ylabel('\Delta h [km]')
general_settings



function general_settings()
%general settings
set(gcf,'color','w');%white background
box on
grid on
set(gca,'FontSize',21);
legend show
end
