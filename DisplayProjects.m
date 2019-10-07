function [] = DisplayProjects(session)
% Display projects only (name and ID) function
% Output: project id and name in "session" struct
%       session.project{1,2,3 etc}.id
%       session.project{1,2,3 etc}.name
  
disp('Projects List:')
for i = 1:length(session)
    name = session(i).name;
    id = session(i).id;
    fprintf('%i - name: %s,   id: %s \n', i, name, id)
end