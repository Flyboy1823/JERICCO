function [time_mat25,perilune25,apolune25,time_mat0,perilune0,apolune0] = load_data()

data = load('peri_apo_RAAN25.txt');
time_mat25 = data(:,3:5);
perilune25 = data(:,2);
apolune25 = data(:,1);

data = load('peri_apo_RAAN0.txt');
time_mat0 = data(:,3:5);
perilune0 = data(:,2);
apolune0 = data(:,1);



end