%% read the localisation file exported from the Nanoimager as a table
[file,path] = uigetfile('*.csv');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end
filename = fullfile(path,file);
T = readtable(filename);
%% modify table to be read by ThunderSTORM, id, frame, x, y, intensity and background
% frame x and y
T_matrix=T;

T_matrix(:,5) = [];% delete Z

%% separate channels, 
% choose channel 1, red, by just deleting channel 0
toDelete = T.Channel == 0; % change it to 1 to choose channel 0, green
T_matrix(toDelete,:) = [];
clear toDelete

%% Frame number starts from 0 but should be 1
T_matrix.Frame=T_matrix.Frame+1;
%% append id as the first column of the table, red
id=1:1:size(T_matrix,1);
id=id';
T2=array2table(id);
T_matrix=[T2 T_matrix];

%% choose the columns required by thunderSTORM
T_matrix= [T_matrix(:,1) T_matrix(:,3:5) T_matrix(:,8:9)];
%% edil the variable name or the first line of the csv and save it
filename_new=[filename(1:end-4) '_edited.csv'];
writetable(T_matrix,filename_new);
change_varname(filename_new) % function that edits the 1st line (very slow)
clear T2 id filename_new