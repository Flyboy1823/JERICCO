function deltaV = MIND_calc_deltaV(a, ecc, inc, RAAN, omega, f)
% simulation only for calculations, no plots here

global tol flags const

tf = 5*60*60; % propagation time is 3 hr [s]
dt = 5; %step size
tol = 0.05;
tol_num = 1e-7;

%-----------------------------------------------------------------------%

inc = deg2rad(inc);
RAAN = deg2rad(RAAN);
omega = deg2rad(omega);
f = deg2rad(f);

flags.maneuver = 1;
flags.compare = 1; %compare the simulation results with the results from STK
const.alpha = 1737; %mean equatorial radius of the moon [km]
const.mu = 4.9048695*10^3 ;%standard gravitatinal parameter [km^3/s^2]
const.J2 = 0; warning('temp')

mu = const.mu;
initial_state = OrbitalElements2StateVec([a, ecc, inc, RAAN, omega, f], const);

% disp('-----1-----')
opts = odeset('Reltol',tol_num,'AbsTol',tol_num,'Stats','on','Events',@myEventsFcn);
tspan=linspace(0,tf,tf/dt);%seconds
[~,y] = ode113(@(t,y) JeriProp(t,y,const), tspan, initial_state, opts);
% y1 = y;
% t1 = t;
% v_end = y(end,4:6);
flags.maneuver = 2;

% elements_vec_end = StateVec2OrbitalElements(y(end,:),const);

r0_vec = y(end,1:3);
r1 = norm(r0_vec);
r2 = a;
a_trans = (r1 +r2)/2; 
v0 = sqrt(mu*(2./r1-1./a_trans));
v0_vec = v0*y(end,4:6)./norm(y(end,4:6));
deltaV1 = norm(v0_vec-y(end,4:6));
% disp(['deltaV1 = ', num2str(deltaV1),' [km/s]'])
clear t y

% disp('-----2-----')
opts = odeset('Reltol',tol_num,'AbsTol',tol_num,'Stats','on','Events',@myEventsFcn);
tspan=linspace(0,tf,tf/dt);%seconds
[~,y] = ode113(@(t,y) JeriProp(t,y,const), tspan, [r0_vec,v0_vec]', opts);
flags.maneuver = 3;
% y2 = y;
% t2 = t;

% r0_vec = y(end,1:3);
v0 = sqrt(mu/a);
v0_vec = v0*y(end,4:6)./norm(y(end,4:6));
deltaV2 = norm(v0_vec-y(end,4:6));
% disp(['deltaV2 = ', num2str(deltaV2),' [km/s]'])
% clear t y

deltaV = deltaV1 +deltaV2;



end