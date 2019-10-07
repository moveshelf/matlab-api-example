function [] = DisplayProjectsClips(session, num)
% Display all clips of all projects
% Input: project id and name in "session" struct (from DisplayProjects.m) 
%        num = number of clips you want to display for each project

fprintf('\n')
for i = 1:length(session)
    DisplayClipsPerProject(i, num, session);
    fprintf('\n')
end

