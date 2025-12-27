%night
close all
clear
clc

%----------------------------%


%beta
fig = figure;
hold on
data = load('Beta.txt');
time_mat = data(:,2:4);
Beta = data(:,1);
t_dates = datetime(time_mat);

left_color = [0.9290 0.6940 0.1250];
right_color= [0.3010 0.7450 0.9330];

yyaxis right
plot(t_dates,Beta,'-','linewidth',3,'color',right_color,'displayname','Beta')
ylabel('\beta [deg]')
ax = gca;
% ax.YColor = right_color;
ax.YColor = 'black';

%day
clear t_dates data time_mat
yyaxis left
data = load('day.txt');
time_mat = data(:,2:4);
day_data = data(:,1);
t_dates = datetime(time_mat);

ind = find(day_data>=10^5);
day_data(ind)=nan;

indd = find(day_data<((80.6)*60));
day_data(indd)=nan;

plot(t_dates,day_data/60,'o','linewidth',1.5,'color',left_color,'displayname','Daytime Duration')
xtickformat('MMM-yy')
ylabel('Duration [min]')
ax = gca;
% ax.YColor = left_color;
ax.YColor = 'black';


data2 = load('eclipse.txt');
time_mat2 = data2(:,2:4);
eclipse_data = data2(:,1);
t_dates2 = datetime(time_mat2);

ind2 = find(eclipse_data>=10^4);
eclipse_data(ind2)=nan;


for i=1:(length(ind2))
xline(t_dates2(ind2(i)),'--','linewidth',3,'displayname',['Eclipse #',num2str(i)]) 
end

for i=1:(length(ind)-1)
x1 = t_dates(ind(i));
x2 = t_dates(ind(i)+1);
yVal = ylim; %allows to fill all the y area
y1 = [yVal(1),yVal(2),yVal(2),yVal(1)];
fill_recx(i,:)=[x1 x1 x2 x2];
fill_recy(i,:)=y1;
end
vec_to_fillx = [fill_recx(1,:),fill_recx(2,:),fill_recx(3,:)];
vec_to_filly = [fill_recy(1,:),fill_recy(2,:),fill_recy(3,:)];
fill(vec_to_fillx,vec_to_filly, '','LineStyle','none','FaceColor','y','FaceAlpha',0.5,'displayname','Constantly Sunny')

general_settings
legend show
hold off

%----------------------------%

figure
hold on
% data2 = load('eclipse.txt');
% time_mat2 = data2(:,2:4);
% eclipse_data = data2(:,1);
% t_dates2 = datetime(time_mat2);
% 
% ind2 = find(eclipse_data>=10^4);
% eclipse_data(ind2)=nan;

plot(t_dates2,eclipse_data/60,'o','linewidth',2,'displayname','Nighttime Duration','color','#0072BD')

for i=1:(length(ind2))
xline(t_dates2(ind2(i)),'--','linewidth',3,'displayname',['Eclipse #',num2str(i)]) 
end


for i=1:(length(ind)-1)
x1 = t_dates(ind(i));
x2 = t_dates(ind(i)+1);
yVal = ylim; %allows to fill all the y area
y1 = [yVal(1),yVal(2),yVal(2),yVal(1)];
fill_recx(i,:)=[x1 x1 x2 x2];
fill_recy(i,:)=y1;
end
vec_to_fillx = [fill_recx(1,:),fill_recx(2,:),fill_recx(3,:)];
vec_to_filly = [fill_recy(1,:),fill_recy(2,:),fill_recy(3,:)];
fill(vec_to_fillx,vec_to_filly, '','LineStyle','none','FaceColor','y','FaceAlpha',0.5,'displayname','Constantly Sunny')


xtickformat('MMM-yy')
ylabel('Duration [min]')
general_settings
legend show
hold off


function general_settings()
%general settings
set(gcf,'color','w');%white background
box on
grid on
% legend show
set(gca,'FontSize',21);
end

