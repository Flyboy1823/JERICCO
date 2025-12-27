%inclination
close all
data = load('inclination.txt');
time_mat = data(:,2:4);
inc = data(:,1);

t_dates = datetime(time_mat);

figure
plot(t_dates,inc,'-','linewidth',2)
xtickformat('MMM-yy')
ylabel('inclination [deg]')
general_settings

%beta
clear t_dates data time_mat inc
data = load('Beta.txt');
time_mat = data(:,2:4);
Beta = data(:,1);

t_dates = datetime(time_mat);

figure
plot(t_dates,Beta,'-','linewidth',2)
xtickformat('MMM-yy')
ylabel('\beta [deg]')
general_settings

%SMA
clear t_dates data time_mat Beta
data = load('SMA.txt');
time_mat = data(:,2:4);
SMA = data(:,1);

t_dates = datetime(time_mat);

figure
plot(t_dates,SMA,'-','linewidth',2)
xtickformat('MMM-yy')
ylabel('semi major axis [km]')
general_settings

%eccentricity
clear t_dates data time_mat SMA
data = load('eccentricity.txt');
time_mat = data(:,2:4);
e = data(:,1);

t_dates = datetime(time_mat);

figure
plot(t_dates,e,'-','linewidth',2)
xtickformat('MMM-yy')
ylabel('eccentricity')
general_settings

%argument of perilune
clear t_dates data time_mat e
data = load('argument_of_perilune.txt');
time_mat = data(:,2:4);
omega = data(:,1);

t_dates = datetime(time_mat);

figure
plot(t_dates,omega,'-','linewidth',2)
xtickformat('MMM-yy')
ylabel('argument of perilune [deg]')
general_settings

%RAAN
clear t_dates data time_mat omega
data = load('RAAN.txt');
time_mat = data(:,2:4);
RAAN = data(:,1);

t_dates = datetime(time_mat);

figure
plot(t_dates,RAAN,'.','linewidth',2)
xtickformat('MMM-yy')
ylabel('RAAN [deg]')
general_settings

function general_settings()
%general settings
set(gcf,'color','w');%white background
box on
grid on
set(gca,'FontSize',21);
end

