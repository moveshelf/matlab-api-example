function Project = UploadFile(mvshlfapi, pn, Project, mainPath)

cd(mainPath)
%DisplayProjects;
fprintf('\n')

% Choose the desired projectID 
pID = Project(pn).id;

dataPath = strcat(mainPath, '/', 'Data2Upload');
cd(dataPath)
[fileN, fileP] = uigetfile('*.xlsx');
cd(mainPath)

% Upload project
p2p = strcat(fileP, fileN);
mod = py.importlib.import_module('PYinterface');
py.importlib.reload(mod);
mod = py.importlib.import_module('PYinterface');
mod.FileInfo(mvshlfapi ,p2p, pID, fileN);

Project = CreateSession(mvshlfapi); % update struct