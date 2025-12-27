function [value, isterminal, direction] = myEventsFcn(t, y)

global tol flags const

switch flags.maneuver
    case 1 %reach to apo
        elements_vec = StateVec2OrbitalElements(y,const);
        value = (elements_vec(6)-pi) <= tol;
        
    case 2 %reach to peri
        elements_vec = StateVec2OrbitalElements([y(1),y(2),y(3),y(4),y(5),y(6)],const);
        value = elements_vec(6) <= tol;
        
    otherwise
        value = 0;
end

if (norm([y(1), y(2), y(3)])-const.alpha) <= 5 %[km]
    disp('CRASH!!') 
    value = 1; %stop simulation
end

isterminal = 1;   % Stop the integration
direction  = 0;

end