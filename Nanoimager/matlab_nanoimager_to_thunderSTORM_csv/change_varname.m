function  change_varname(filename)
% edit the 1st row of a file
% the variable names are edited to be read by ThunderSTORM
fid = fopen(filename,'r');
i = 1;
tline = fgetl(fid);
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgetl(fid);
    A{i} = tline;
end
fclose(fid);
% Change cell A
A{1} = ('id,frame,x [nm],y [nm],intensity [photon],bkgstd [photon]');
% Write cell A into txt
fid = fopen(filename, 'w');
for i = 1:numel(A)
    if A{i+1} == -1
        fprintf(fid,'%s', A{i});
        break
    else
        fprintf(fid,'%s\n', A{i});
    end
end
fclose(fid);
