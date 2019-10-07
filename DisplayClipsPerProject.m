function  [] = DisplayClipsPerProject(pn, num, Project)

% Display Clips per project (pID)
pID = Project(pn).id;
count = 0;
fprintf('Project ID: %s \n', pID)
for c = 1:length(Project(pn).clip)
    if count <= num
        fprintf('Clip title: %s   Clip ID: %s \n', Project(pn).clip(c).title, Project(pn).clip(c).id)
        count = count + 1;
    end
end
if count < num
    disp('There are no more clips')
    disp('All clips displayed')
    if count == 0
        disp('The project is empty')
    end
else
    disp('All clips displayed')
end