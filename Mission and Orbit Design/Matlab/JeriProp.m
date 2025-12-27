function dy = JeriProp(t,y,const)

mu = const.mu;
R = const.alpha;
J2 = const.J2;

r_vec = [y(1), y(2), y(3)];
% v_vec = [y(4), y(5), y(6)];
r = norm(r_vec);

dy = [y(4); 
      y(5);
      y(6);
     -(mu*y(1)/r^3)*(1-1.5*J2*(R/r)^2*(5*(y(3)/r)^2-1));
     -(mu*y(2)/r^3)*(1-1.5*J2*(R/r)^2*(5*(y(3)/r)^2-1));
     -(mu*y(3)/r^3)*(1-1.5*J2*(R/r)^2*(5*(y(3)/r)^2-3))];

end