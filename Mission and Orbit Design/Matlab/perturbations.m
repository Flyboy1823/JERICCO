%% sun pressure

Gs_over_c=4.55*10^-6; %constant of sun pressure, [N/m^2]
Asun=8; %average sun cross section area  [m^2]
CR=1; %solare reflectivity
delta=asin(0.39795*cosd(0.9856*(N-173)));%[rad]
r_s=[cos(delta)*cos(OMEGA_s),cos(delta)*sin(OMEGA_s),sin(delta)]; %unit vector pointing from earth to the sun

f_sun=-(CR*Asun*Gs_over_c/m); %acceleration due to sun pressure
f_sun_vec_real=f_sun*r_s;
%f_sun_vec=f_sun*ones(size(theta_star));


%shadow
h_hat=[sin(OMEGA)*sin(inc), -cos(OMEGA)*sin(inc), cos(inc)]; %direction of angular momentum
sin_beta=h_hat*r_s';
x=sqrt(((R_E/sin_beta)^2-(a/sin_beta)^2)/(1-1/sin_beta^2))*[1,-1];
y=sqrt(a^2-x.^2).*[1,-1];

for i=1:length(x)
    for j=1:length(y)
        theta(i,j)=atan2(y(j),x(i));
        if theta(i,j)<0
            theta(i,j)=theta(i,j)+2*pi;
        end
        if theta(i,j)>pi/2 && theta(i,j)<pi
            theta_in=theta(i,j);
        elseif theta(i,j)>pi && theta(i,j)<1.5*pi
            theta_out=theta(i,j);
        end
    end
end


%% Luni- Solar effect

moon_const=8.63*10^-14; %mu_moon/r_moon^3 [1/s^2]
sun_const=3.96*10^-14; %mu_sun/r_sun^3 [1/s^2]
RA_moon=deg2rad(-43.6123);
DEC_moon=deg2rad(-22.0040);
r_moon=4*10^8; %[m]
r_moon_unit=[cos(DEC_moon)*cos(RA_moon),cos(DEC_moon)*sin(RA_moon),sin(DEC_moon)];
r_moon_vec=r_moon*r_moon_unit; %[m]

for k=1:length(theta_star)
r_peri=a*[cos(theta_star(k)), sin(theta_star(k)), 0];
r_ECI(k,:)=peri2ECI(OMEGA,0,inc,r_peri);
f_Lsun_vec(k,:)=sun_const*(-r_ECI(k,:)+3*(r_s*r_ECI(k,:)')*r_s);
f_Lsun(k,:)=norm(f_Lsun_vec(k,:));
f_moon_vec(k,:)=moon_const*(-r_ECI(k,:)+3*(r_moon_unit*r_ECI(k,:)')*r_moon_unit);
f_moon(k,:)=norm(f_moon_vec(k,:));
f_luni_solar_tot_vec(k,:)=f_Lsun_vec(k,:)+f_moon_vec(k,:);
f_luni_solar_tot(k)=norm(f_luni_solar_tot_vec(k,:));
end