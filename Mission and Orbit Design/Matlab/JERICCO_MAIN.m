% JERICCO
% MIND tool = maneuvers initial design tool

clc; clear; close all;
global tol flags const

flags.maneuver = 1;
flags.compare = 1; %compare the simulation results with the results from STK
const.alpha = 1737; %mean equatorial radius of the moon [km]
const.mu = 4.9048695*10^3 ;%standard gravitatinal parameter [km^3/s^2]
const.J2 = 0; warning('temp')

%----------------------------------------------------------------------%

%~~~~~This Is Where You Define Your Input~~~~~%

flags.showExtremeCase = 0;

r_p = const.alpha + 180; %180
r_a = const.alpha + 220; %220

if flags.showExtremeCase
    r_p = const.alpha + 140;
    r_a = const.alpha + 260;
end

ecc = (r_a-r_p)/(r_a+r_p);
a = (r_a+r_p)/2;

% a = 1937;%semi-major axis [km]
% ecc = 0.01; %eccentricity
inc = 86; %inclination [deg] --86
RAAN = 25; %right ascension of the ascending node [deg]
omega = 0; %argument of perigee [deg]
f = 0.05; %true anomaly [deg]

tf = 5*60*60; % propagation time is 3 hr [s]
dt = 5; %step size
tol = 0.05;
tol_num = 1e-7;

if flags.showExtremeCase
    dt = 1; %step size
    tol = 0.07;
    tol_num = 1e-8;
end

%-----------------------------------------------------------------------%
plot_moon
hold on
mu = const.mu;

inc = deg2rad(inc);
RAAN = deg2rad(RAAN);
omega = deg2rad(omega);
f = deg2rad(f);

initial_state = OrbitalElements2StateVec([a, ecc, inc, RAAN, omega, f], const);

disp('-----1-----')
opts = odeset('Reltol',tol_num,'AbsTol',tol_num,'Stats','on','Events',@myEventsFcn);
tspan=linspace(0,tf,tf/dt);%seconds
[t,y] = ode113(@(t,y) JeriProp(t,y,const), tspan, initial_state, opts);
y1 = y;
t1 = t;
plot_orbit_3D(y(:,1:3))
% xarrow=y1((length(t1)/2),1); yarrow=y1((length(t1)/2),2);zarrow=y1((length(t1)/2),3);
% plot3(xarrow,yarrow,zarrow,'<','markersize',15,'linewidth',2,'color','black')
v_end = y(end,4:6);
flags.maneuver = 2;

elements_vec_end = StateVec2OrbitalElements(y(end,:),const);
% Vpulse_vec = peri2ECI([0, 1, 0],elements_vec_end(3),elements_vec_end(5),elements_vec_end(4));

r0_vec = y(end,1:3);
% v0 = y(end,4:6)+ Vpulse_vec;
r1 = norm(r0_vec);
r2 = a;
a_trans = (r1 +r2)/2; 
v0 = sqrt(mu*(2/r1-1/a_trans));
v0_vec = v0*y(end,4:6)./norm(y(end,4:6));
deltaV1 = norm(v0_vec-y(end,4:6));
disp(['deltaV1 = ', num2str(deltaV1),' [km/s]'])
clear t y

disp('-----2-----')
opts = odeset('Reltol',tol_num,'AbsTol',tol_num,'Stats','on','Events',@myEventsFcn);
tspan=linspace(0,tf,tf/dt);%seconds
[t,y] = ode113(@(t,y) JeriProp(t,y,const), tspan, [r0_vec,v0_vec]', opts);
plot_orbit_3D(y(:,1:3))
flags.maneuver = 3;
y2 = y;
t2 = t;

r0_vec = y(end,1:3);
v0 = sqrt(mu/a);
v0_vec = v0*y(end,4:6)./norm(y(end,4:6));
deltaV2 = norm(v0_vec-y(end,4:6));
disp(['deltaV2 = ', num2str(deltaV2),' [km/s]'])
clear t y

disp('-----3-----')
tf = 6500; dt = 20;
opts = odeset('Reltol',1e-5,'AbsTol',1e-5,'Stats','on');
tspan=linspace(0,tf,tf/dt);%seconds
[t,y] = ode113(@(t,y) JeriProp(t,y,const), tspan, [r0_vec,v0_vec]', opts);
plot_orbit_3D(y(:,1:3))
y3 = y;
t3 = t;
axis equal

xarrow=y1(floor((length(t1)/2)),1); yarrow=y1(floor((length(t1)/2)),2);zarrow=y1(floor((length(t1)/2)),3);
plot3(xarrow,yarrow,zarrow,'<','markersize',15,'linewidth',2,'color','black')
hold off

legend('The Moon','Initial Orbit','Initial Position','Trans. Orbit','Pulse #1','Desired Orbit','Pulse #2','Direction of Motion')

tot_y = [y1; y2; y3];
t_tot = [t1; t1(end)+t2; t1(end)+t2(end)+t3];

plot_altitude(t_tot,tot_y,const)

for j=1:length(t_tot)
   elements_vec(j,:) = StateVec2OrbitalElements(tot_y(j,:),const);
end

plot_peri_apo(t_tot,elements_vec,const)
plot_eccentricity(t_tot,elements_vec)

clc
disp([newline,'---- e = ',num2str(ecc),'----',newline])
disp(['Total Delta V is = ', num2str((deltaV1+deltaV2)*10^3),' [m/s]'])
disp([newline,'----------  End of Simulation  ----------',newline])
close all
%{
% OrbitProp(initial_state,const)
initial_state_polar_nodal = OrbitalElement2PolarNodal(initial_state, const);
opts = odeset('Reltol',1e-7,'AbsTol',1e-7,'Stats','on');%tolerance
tspan=linspace(0,tf,tf/dt);%seconds
[t,y] = ode45(@(t,y) OrbitProp(t,y,const), tspan, initial_state_polar_nodal, opts);

for j = 1:length(t)
    current_time = t(j);
    vec_ECI(j,:) = PolarNodal2Cart(y(j,:));
    if norm(vec_ECI(j,1:3))<const.alpha
        error('CRASH!')
    end
    all_orbital_elements(j,:)=Cart2OrbitalElements(current_time,vec_ECI(j,:),const);
    if all_orbital_elements(j,6)-0<=tol
        
    end
end
%}










