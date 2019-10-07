%% Set Python3 on MATLAB (maxOS uses by default Python2.7)
% In Matlab the system PATH unix('echo $PATH') is different than the system
% PATH in Bash $ echo $PATH
% We can change it by coping the Bash system PATH in setenv('PATH',' copied
% Bash PATH') to make Matlab work with Python3 each time we run the file.

!echo $PATH
[status, result] = system('echo $PATH'); % output = Matlab PATH
% Path to paste from terminal!
pathOK = strcat('/Library/Frameworks/Python.framework/Versions/3.7/bin:', result);
setenv('PATH',pathOK);
!echo $PATH

%% 0
close all
clear all
clc

% Set mainPath !!!
mainPath = '/Users/meg/Desktop/MSc thesis/Moveshelf/CODE/matlabAPI_1/matlab-api-example'; % !!!!!!!!!!!!!!!!!!
% Go to main folder with all the files
if strcmp(pwd, mainPath) == 0
    cd(mainPath);
end
% Select apiKEY file !!!
mvshlfapi = selectApiKey();
% Create PROJECT Project
cd(mainPath);

Project = CreateSession(mvshlfapi);
% with by default 15 clips per project
disp('Ready to start!')


%% 1 - Display clips of all projects
cd(mainPath)
DisplayProjects(Project);
%num = input('Enter the number of clips you want to display: ');
num = 5;
DisplayProjectsClips(Project, num);


%% 2 - Select projectID and Upload project
cd(mainPath)
DisplayProjects(Project)
pn = input('Enter project number: ');
Project = UploadFile(mvshlfapi, pn, Project, mainPath);


%% 3 - Enter clipID to download .json data locally from Moveshelf
clipID = {"TW9jYXBDbGlwJHvLUj32RlWXsLymeiTIjA","TW9jYXBDbGlwEZomv7OBSEGJD7MtQ7YHbw"};
DownloadData(mvshlfapi, clipID)
% Create and save .mat structure files from .json data
CreateMATstruct(clipID, pwd)


%% 4 - Modify Clip Info
% change Clip title and/or description and/or clip location
% if you want to leave the old one put []
clipID = "TW9jYXBDbGlwIwRpQzMUSlSx-m6QHY4EQg";
name = "NewFileName";
proj = [];
%if you don't want to change the project, leave []
Project = ClipUpdate(mvshlfapi, clipID, name, proj, Project);


%% 5 - Eliminate Clip 
clipID = {"TW9jYXBDbGlwIwRpQzMUSlSx-m6QHY4EQg","TW9jYXBDbGlwz6Kmb5-cT6iDh4aj-qZ1Aw",...
    "TW9jYXBDbGlwHKvGrrMbSdy20j1znE4Ndw", "TW9jYXBDbGlwEDsM7e4LQACjDhvkESl1EA"};
Project = DeleteClip(mvshlfapi, clipID);


%% A1 -- Data Analysis (only angles and gait_params fro data saved in local!!)
%[structfile, pathname] = uigetfile('*.mat');
cd(mainPath)
%cID = input('Enter clip ID for analysis: ');
ANALpath = strcat(mainPath, '/', char(string(clipID(1))));
DataAnalysis_02('ClipStruct.mat', ANALpath)


%% A2 -- Compare two trials
% Download two datasets, create .mat structures and compare before and
% after whatever intervention (only angles and gait_params)
if strcmp(pwd, mainPath) == 0
    cd(mainPath)
end
clipID = {"TW9jYXBDbGlwJHvLUj32RlWXsLymeiTIjA","TW9jYXBDbGlwB2CxcyUZTeK1kfVhwCqtsg"};
DownloadData(mvshlfapi, clipID)
CreateMATstruct(clipID, pwd)
cd(mainPath)
GaitCompare

