function Project = ClipUpdate(mvshlfapi, cID, title, proj, Project)

% first find the clip (if exists) 
% take also old names if the guy doesn't want to modify, you just modify
% putting the old one
for i = 1:length(Project)
    for j = 1:length(Project(i).clip)
        if (strcmp(cID, Project(i).clip(j).id)) == 1
            fprintf('%i -- Project title: %s \n', i, Project(i).name)
            prold = Project(i).name;
            fprintf('Clip title: %s \n', Project(i).clip(j).title)
            told = Project(i).clip(j).title;
        end
    end
end

if isempty(proj) == 1
    proj = prold;
end
if isempty(title) == 1
    title = Project(i).clip(j).title;
end

md = {title, proj};
mod = py.importlib.import_module('PYinterface');
mod.UpdateClipInfo(mvshlfapi,cID, md);
Project = CreateSession(mvshlfapi);