function plot_moon()

close all
clc
clear
Rm = 1737; %[km]
[x, y, z] = sphere;
x = x*Rm;
y = y*Rm;
z = z*Rm;
globe=surf(x, y, z);
cdata = imread('moon_full.jpg');
set(globe,  'FaceColor',  'texturemap',  'CData', cdata,'EdgeColor',  'none');
axis equal

% light('Position',[-1 0 0],'Style','local')
general_settings
end


function general_settings()
%general settings
set(gcf,'color','w');%white background
box on
grid on
set(gca,'FontSize',13);
end