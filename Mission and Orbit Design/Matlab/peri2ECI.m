function v_ECI=peri2ECI(v_peri,inc,omega,RA)
%transformation from perifocal frame to ECI
%@May Alon

[m, ~] = size(v_peri);
if m<3
v_peri = v_peri';
end

Q = [ -sin(RA)*cos(inc)*sin(omega)+cos(RA)*cos(omega), -sin(RA)*cos(inc)*cos(omega)-cos(RA)*sin(omega), sin(RA)*sin(inc);...
    cos(RA)*cos(inc)*sin(omega)+sin(RA)*cos(omega),  cos(RA)*cos(inc)*cos(omega)-sin(RA)*sin(omega), -cos(RA)*sin(inc);...
    sin(inc)*sin(omega),                               sin(inc)*cos(omega),                                 cos(inc)];

v_ECI = Q*v_peri;

end