function [] = CreateMATstruct(cID, currentPath)

%% json2mat
for index = 1:length(cID)

clear fileContent fileName listF sessionContent SessionData
newPath = strcat(currentPath, '/', string(cID(index)));
cd(newPath) % go inside the DownloadedData folder

% Check json-files in current folder
listF = dir(fullfile(newPath, '/*.json'));

% Import names of data file
del = '.';
for i = 1:length(listF)
    fileName(i) = {listF(i).name(1:(find(listF(i).name == del))-1)};
end

%% All json data files in one sessionData structure

for i = 1:length(fileName)
    fid = fopen(listF(i).name);
    raw = fread(fid,inf);
    str = char(raw');
    fclose(fid);
    SessionData.(char(fileName(i))) = jsondecode(str);
end
    % Save data in mat file
    save('ClipStruct.mat', 'SessionData')
    if isfile('ClipStruct.mat')
        fprintf('Matlab struct created of clipID: %s \n', string(cID(index)))
        clear fileName sessionData
    end

end


