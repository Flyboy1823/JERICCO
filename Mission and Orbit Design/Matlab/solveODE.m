function dy = solveODE(t, y, const)

%---------------------- What Does This Function Do? ----------------------%
% This function gets as an input a structure of phisical constants and a
%vector of initial conditions (in polar- nodal coordinates) and solve
% Hamilton's equations in polar nodal coordinates:

%                PolarNodal_vec = [r, theta, nu, R, THETA, N];

% The functions returns time vector and all 6 variables in polar- nodal
% coordinates, according their variation in time.

%-----------------------------------------------------------------------%

mu = const.mu; %standard gravitational parameter

% definition of variables for the ODE function
r = y(1);
theta = y(2);
% nu =y(3);
R = y(4);
THETA = y(5);
N = y(6);

coef = 3*mu*const.J2*(const.alpha)^2; %coefficient defined for convenience



dy = [R; %dr/dt
    THETA/r^2 + coef*N^2*(sin(theta))^2/(r^3*THETA^3); %d_theta/dt
    -coef*N*(sin(theta))^2/(r^3*THETA^2); %d_nu/dt
    (THETA^2-mu*r)/r^3 + (0.5*coef/r^4)*(3*(sin(theta))^2*(1-N^2/THETA^2)-1); %dR/dt
    -(coef/r^3)*sin(theta)*cos(theta)*(1-N^2/THETA^2); %d_THETA/dt
    0]; %dN/dt

end







