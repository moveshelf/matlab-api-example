function Project = CreateSession(mvshlfapi)
% Creates session struct with projects id and name

mod = py.importlib.import_module('PYinterface');
proj = mod.getProjects(mvshlfapi);
% Transform python-variables in matlab-loved variables
for i = 1:length(proj)
    ps = py2mat(proj);
    pID = ps(i).id;
    pName = ps(i).name;
    Project(i).id = py2mat(pID);
    Project(i).name = py2mat(pName);
end

% Add clips per project
mod = py.importlib.import_module('PYinterface');
num = 15;

for pn = 1:length(proj)
    pID = Project(pn).id; 
    clips = mod.ClipsInfo(mvshlfapi, pID, num);
    
    if length(clips) == 0
        Project(pn).clip = [];
    else
        % Attach clips (from list to stuct) in Project struct
        Project(pn).clip = py2mat(clips);
    end
    
    % Transform clip's fields (py.str) in matlab strings
    strFields = ["id","title","projectPath"];
    for i = 1:length(Project(pn).clip)
        for f = 1:length(strFields)
            sfield = strFields(f);
            Project(pn).clip(i).(sfield) = py2mat(Project(pn).clip(i).(sfield));
        end
    end
end
