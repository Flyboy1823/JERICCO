function plot_Earth(const)

% This function plot Earth. The input is a structure of constants, which
% the only relevant constant here is the radius of the sphere. Note: We
% do not consider here the oblateness of the Earth.

R_E=const.alpha;
[P1,P2,P3] = sphere; %define a unit sphere
P1=P1*R_E;
P2=P2*R_E;
P3=P3*R_E;

% surf(P1,P2,P3,'facecolor',[177 226 239]./255,'displayname','planet')%
% simple Earth

load('topo.mat','topo','topomap1');
topo2 = [topo(:,181:360) topo(:,1:180)]; %#ok<NODEF>
props.FaceColor = 'texture';
props.EdgeColor = 'none';
props.FaceLighting = 'phong';
props.Cdata = topo2;
surface(P1,P2,P3,props,'displayname','Earth')%earth
colormap(topomap1)
view(127.5,30)
shading flat

axis equal
legend show
general_settings

end
