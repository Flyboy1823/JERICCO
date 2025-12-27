% estimate propellant
clear
clc
close all

const.alpha = 1737; %mean equatorial radius of the moon [km]
% const.Isp = 1000; %[s]
const.m0 = 16; %Initial Mass[kg]
const.g0 = (9.81)*10^(-3);
% const.Ve = const.Isp*const.g0;
Isp_vec = 100:100:600; %[s]


alt = 200; %Altitude [km]
step = 10; %[km]
h_p_min = 160; %[km]
h_a_max = 240; %[km]

% r_p_min = h_p_min + const.alpha;
% r_a_max = h_a_max + const.alpha;
% nom_r = alt + const.alpha;

tol_for_corr_vec = [1:2:20,20:1:40];
% tol_for_corr_vec = 5:1:40;
 
figure
hold on
% r_p = [h_p_min:step:alt] + const.alpha;
% r_a = [h_a_max:(-step):alt] + const.alpha;

inc = 86; %inclination [deg]
RAAN = 25; %right ascension of the ascending node [deg]
omega = 0; %argument of perigee [deg]
f = 0.05; %true anomaly [deg]

mission_duration = 18; %mission duration in months

km_months_short = [20,1]; %drift of 30 km in 4 months, assuming constant drifting rate
km_months_long = [25,2; 30,3; 35,5; 40,6]; %drift of 30 km in 4 months, assuming constant drifting rate
[m,n] = size(km_months_long);

for k=1:length(Isp_vec)
    Isp = Isp_vec(k);
    Ve = Isp*const.g0;
    for j=1:length(tol_for_corr_vec)
        
        tol_for_corr = tol_for_corr_vec(j);    %we assume linear rate of change in this drift!
        
        if tol_for_corr <= km_months_short(1)
            km_months = km_months_short;
        else
            
            for pp = 1:m
                if tol_for_corr <= km_months_long(pp,1)
                    km_months = km_months_long(pp,:);
                    break
                end
            end
        end
        dritf_in_year_and_a_half = km_months(1)*mission_duration/km_months(2);

        
        h_a = alt + tol_for_corr;
        h_p = alt - tol_for_corr;
        r_a = h_a + const.alpha;
        r_p = h_p + const.alpha;
        
        ecc = (r_a-r_p)./(r_a+r_p);
        a = (r_a+r_p)/2;
        
        delta_v(j) = MIND_calc_deltaV(a, ecc, inc, RAAN, omega, f);
        number_of_corrections(j) = floor(dritf_in_year_and_a_half/tol_for_corr);
        total_delta_v(j) = number_of_corrections(j)*delta_v(j);
        m_f(j) = const.m0*exp(-total_delta_v(j)/Ve);
        m_p(j) = const.m0-m_f(j);
        
    end
    
    plot(tol_for_corr_vec, m_p*1000,'o','linewidth',3,'markersize',5,'displayname',['I_{sp} = ',num2str(Isp),' [s]'])

end

xlabel('Tolerance [km]')
ylabel('Propellant Mass [g]')
legend show
general_settings
hold off

figure
plot(tol_for_corr_vec, total_delta_v*1000,'o','linewidth',3,'markersize',5,'color',[163 73 163]/255)
xlabel('Tolerance [km]')
ylabel('Total \Delta v [m/s]')
set(gcf,'color','w');%white background
box on
grid on
set(gca,'FontSize',21);

