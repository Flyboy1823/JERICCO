function vec_ECI = OrbitalElements2StateVec(elements_vec,const)

%------------------------------ WHAT DOES THIS FUNCTION DO? ------------------------------%

% This function gets the orbital elements:
% 1. eccentricity (ecc)
% 2. argument of perigee (omega)
% 3. right ascension of the the ascending node (RAAN)
% 4. semi major axis (a)
% 5. inclination (inc)
% 6. specific angular momentum (h)
% 7. true anomaly (theta)

% and returns the position vector (r_vec) and the velocity vector (v_vec) in ECI.


%------------------------------ EXAMPLE ------------------------------%

% >> Enter the following orbital elements:
% const.mu = 398600; %km^3/s^2
% elements.omega = deg2rad(62.24);
% elements.ecc = 0.1589;
% elements.inc = deg2rad(102.3);
% elements.RAAN = deg2rad(11.396);
% elements.a = 8059;
% elements.h = 55957;
% elements.theta = deg2rad(20);

% >> you suppose to get:
% r_vec = 1.0e+03 * [1.1898, -1.2319, 6.6169]; %[km]
% v_vec = [ -7.8381, -1.9035, 1.4548]; %[km/s]


%------------------------------ WARNINGS ------------------------------%
% All angles should be in [rad]!

%----------------------------------------------------------------------%

a = elements_vec(1);
ecc = elements_vec(2);
inc = elements_vec(3);
RAAN = elements_vec(4);
omega = elements_vec(5);
f = elements_vec(6);

mu = const.mu;

p = a*(1-ecc^2);
h = sqrt(p*mu);

r = a*(1-ecc^2)/(1+ecc*cos(f));
r_hat_vec = peri2ECI([cos(f),sin(f),0],inc,omega,RAAN);
r_vec = r*r_hat_vec;

v_vec = (mu/h)*peri2ECI([-sin(f) ,ecc+cos(f) ,0],inc,omega,RAAN);

vec_ECI = [r_vec,v_vec];

end


